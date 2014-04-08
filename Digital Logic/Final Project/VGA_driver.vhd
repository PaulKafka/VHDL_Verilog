-- |*************************************************************************************************
-- |
-- |		FILE:		VGA_driver.vhd															[VHDL module source file]
-- |
-- |				This file defines a VHDL module (entity + architecture) that implements
-- |				a simple 640x480 pixel, 60 Hz VGA driver for the Altera/Terasic DE2
-- |				development board.
-- |
-- |				The philosophy of this VGA driver is that it provides the bare mechanism
-- |				for a computed display, one in which the color of each pixel is computed
-- |				from that pixel's (x,y) coordinates.
-- |
-- |				Someone could easily build a buffered VGA display on top of this, one
-- |				where the color of each pixel is obtained from a video memory.  But that
-- |				is not necessary for simple video demonstrations.
-- |
-- |		INPUTS:			  (bits)
-- |				clk_25MHz	 1		- A 25MHz clock.  This is the dot (pixel) clock.
-- |				
-- |		OUTPUTS:
-- |				vert_sync	 1		- Vertical-sync signal.  Active-low (0 during vertical sync periods).
-- |				horiz_sync	 1		- Horizontal-sync signal.  Active-low (0 during horizontal sync periods).
-- |				col(9:0)		 10	- Current X coordinate, 10 bits, 0-639.
-- |				row(8:0)		 9		- Current Y coordinate, 9 bits, 0-479.
-- |				valid			 1		- High if the current coordinates are valid (we are in frame).
-- |
-- |		AUTHOR:
-- |			Original code by Michael P. Frank, 3/25/2011.
-- |			(Based loosely on an earlier VGA driver for the UP2 board, done in Quartus schematics
-- |			in 2006-2007, also by M.P. Frank.)
-- |
-- |		VERSION HISTORY:
-- |			v0.0, 3/25/11 - Started initial version. -MPF
-- |			v0.1, 3/27/11 - Simplifications; now letting ADV7123 do the valid-region clipping. -MPF
-- |
-- |vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

library	ieee;
	use	ieee.std_logic_1164.all;
	use	ieee.numeric_std.all;

entity	VGA_driver	is
	port (
		clk_25MHz	:	in		std_logic;		-- This is the dot-clock.  Note period is 40 ns.
		
		vert_sync	:	out	std_logic;
		horiz_sync	:	out	std_logic;
		row			:	out	std_logic_vector(8 downto 0);		-- unsigned 0-479.
		col			:	out	std_logic_vector(9 downto 0);		-- unsigned 0-639.
		valid			:	buffer	std_logic
	);
end	entity	VGA_driver;

architecture	impl		of		VGA_driver	is

		-- First, we just define a bunch of constants, which set up the parameters for the
		-- VGA vertical & horizontal timing.

	constant		horiz_res:	integer	:= 640;	-- Horizontal resolution in columns (pixels, dot clocks).
	constant		vert_res	:	integer	:= 480;	-- Vertical resolution in rows (scan lines).
	
	constant		vs_rows	:	integer	:= 2;		-- Length of vertical sync interval in row periods.
	constant		hs_clks  :	integer	:= 95;	-- Length of horizontal sync interval in dot-clock periods.
	
	constant		v_fporch	:	integer	:= 33;	-- Length of vertical front (leading) porch in row periods.
	constant		h_fporch	:	integer	:= 47;	-- Length of horizontal front (leading) porch in dot clocks.
	
	constant		v_delay	:	integer	:=	(vs_rows + v_fporch);		-- Vert. delay before start of visible frame in vert. row periods.
	constant		h_delay	:	integer	:= (hs_clks + h_fporch);		-- Horiz. delay before start of visible frame in horiz. dot clocks.
	
	constant		v_end		:	integer	:= (v_delay + vert_res);	-- Just past end of visible frame in vert. row periods.
	constant		h_end		:	integer	:= (h_delay + horiz_res);	-- Just past end of visible scan line in horiz. dot clocks.
	
	constant		v_bporch	:	integer	:=	10;	-- Length of vertical back (trailing) porch in row periods.
	constant		h_bporch	:	integer	:= 15;	-- Length of horizontal back (trailing) porch in dot clocks.
	
	constant		v_period	:	integer	:=	v_end + v_bporch;		-- Entire length of vertical frame period in row periods.
	constant		h_period	:	integer	:= h_end + h_bporch;		-- Entire length of horizontal scan line in dot clocks.
	
		-- The entire state of the driver is in the below two variables.  (All other signals are derived from these.)
	
	shared variable 	raw_row	:	integer range 0 to (v_period-1) := 0;		-- Which scan line in whole frame, including vert. sync & porches.  (0-524.)
	shared variable	raw_col	:	integer range 0 to (h_period-1) := 0;		-- Which clock in whole scan line, including horiz. sync & porches.  (0-797.)
	
		-- A couple of 'temporary' signals, for internal use.
	
	signal	row_valid	:	std_logic;		-- '1' if row is within visible area
	signal	col_valid	:	std_logic;		-- '1' if column is within visible area
	
begin

		-- First we'll do our concurrent statements (pure combinational logic).
		-- Calculate vertical & horizontal sync signals.
		
	vert_sync 	<= '0' when raw_row < vs_rows else '1';	-- Blank the vertical-sync signal for 1st 2 row periods in each frame.
	horiz_sync	<= '0' when raw_col < hs_clks else '1';	-- Blank the horizontol-sync signal for 1st 95 dot-clocks (3.8 us) in each row.

		-- Calculate (row,col) coordinates (relative to upper-left corner of visible part of frame).
	
	row  <=  std_logic_vector(to_unsigned(raw_row	- v_delay, 9));	 -- Skips 2 for VS, 33 for front porch.
	col  <=  std_logic_vector(to_unsigned(raw_col	- h_delay, 10));	 -- Skips 3.8 us for HS, 1.9 for front porch.

		-- Determine whether the present pixel coordinates are valid (within the visible part of the frame).
	
	row_valid <= '1' when (raw_row >= v_delay and raw_row < v_end) else '0';
	col_valid <= '1' when (raw_col >= h_delay and raw_col < h_end) else '0';
	valid <= row_valid and col_valid;
	
		-- This process just implements a simple cascaded pair of modulo counters, 
		-- with the one for the rows triggered by rollover of the one for the columns.
	
	process is
	begin
		wait until rising_edge(clk_25MHz);		-- our registers are rising-edge triggered
		
		raw_col := raw_col + 1;			-- Increment column number counter.
		
		if raw_col = h_period then		-- At end of scan line, column counter wraps around & row counter increments.
			raw_col := 0;
			
			raw_row := raw_row + 1;			-- Increment row number counter.
			
			if raw_row = v_period then		-- At end of frame, row counter wraps around to 0.
				raw_row := 0;
			end if;
		end if;
		
	end	process;
	
end	architecture	impl;		-- of VGA_driver