LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.ALL;
USE  IEEE.STD_LOGIC_ARITH.ALL;
USE  IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY SCOMP IS
PORT(	clock, reset 				: IN STD_LOGIC;
        program_counter_out 		: OUT STD_LOGIC_VECTOR( 7 DOWNTO 0 );
        register_AC_out 			: OUT STD_LOGIC_VECTOR(15 DOWNTO 0 );
		memory_data_register_out	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0 );
		memory_address_register_out	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0 ));
END SCOMP;

ARCHITECTURE a OF scomp IS
TYPE STATE_TYPE IS ( 
		             ------------ADDED-----------------------------------------------
		             execute_subt, execute_xor, execute_or, execute_and, execute_addi, 
		             -----------------------------------------------------------------
		             reset_pc, fetch, decode, execute_add, execute_load, 
		             execute_store, execute_store3, execute_store2, execute_jump );
		             
SIGNAL state: STATE_TYPE;
SIGNAL instruction_register, memory_data_register 	: STD_LOGIC_VECTOR(15 DOWNTO 0 );
SIGNAL register_AC 				: STD_LOGIC_VECTOR(15 DOWNTO 0 );
SIGNAL program_counter 			: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
SIGNAL memory_address_register	: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
SIGNAL memory_write 			: STD_LOGIC;

BEGIN
			-- Use Altsyncram function for computer's memory (256 16-bit words)
  memory: altsyncram
      GENERIC MAP (
		operation_mode => "SINGLE_PORT",
		width_a => 16,
		widthad_a => 8,
		lpm_type => "altsyncram",
		outdata_reg_a => "UNREGISTERED",
			-- Reads in mif file for initial program and data values
		init_file => "program.mif",
		intended_device_family => "Cyclone")
		
	PORT MAP (	wren_a => memory_write, clock0 => clock, 
				address_a => memory_address_register, data_a => Register_AC, 
                q_a => memory_data_register );
			-- Output major signals for simulation
     	program_counter_out 		<= program_counter;
     	register_AC_out 			<= register_AC;
     	memory_data_register_out 	<= memory_data_register; 
     	memory_address_register_out <= memory_address_register; 
     	
PROCESS ( CLOCK, RESET )
	BEGIN
	IF reset = '1' THEN
		state <= reset_pc;
	ELSIF clock'EVENT AND clock = '1' THEN
		CASE state IS
					-- reset the computer, need to clear some registers
		WHEN reset_pc =>
			program_counter 		<= "00000000";
--			memory_address_register <= "00000000";
			register_AC				<= "0000000000000000";
			memory_write 			<= '0';
			state 					<= fetch;
					-- Fetch instruction from memory and add 1 to PC
		WHEN fetch =>
			instruction_register 	<= memory_data_register;
			program_counter 		<= program_counter + 1;
			memory_write 			<= '0';
			state 					<= decode;
					-- Decode instruction and send out address of any data operands
		WHEN decode =>
			CASE instruction_register( 15 DOWNTO 8 ) IS
				WHEN X"00" =>
				    state 	<= execute_add;
				WHEN X"01" =>
				    state 	<= execute_store;
				WHEN X"02" =>
				    state 	<= execute_load;		
				WHEN X"03" =>
				    state 	<= execute_jump;
				----------Added--------------------------
				WHEN X"05" =>
				    state 	<= execute_subt; 
				WHEN X"06" =>
				    state 	<= execute_xor;
				WHEN X"07" =>
				    state 	<= execute_or;
				WHEN X"08" =>
				    state 	<= execute_and;
				WHEN X"0B" =>
				    state 	<= execute_addi;
				-----------------------------------------
				WHEN OTHERS =>
				    state 	<= fetch;
			END CASE;
					
		
		-----------------ADDED------------------------------------------------
		WHEN execute_subt=> 
			register_ac 				<= register_ac - memory_data_register;				
			state 						<= fetch;
		WHEN execute_xor=> 
			register_ac 				<= register_ac XOR memory_data_register;				
			state 						<= fetch;
		WHEN execute_or=> 
			register_ac 				<= register_ac OR memory_data_register;				
			state 						<= fetch;
		WHEN execute_and=> 
			register_ac 				<= register_ac AND memory_data_register;				
			state 						<= fetch;
		WHEN execute_addi=> 
			if memory_data_register =X"FF" THEN
				register_ac 				<= register_ac - 1;	
			else
				register_ac 				<= register_ac + memory_data_register;				
			state 						<= fetch;
			END IF;
		---------------------------------------------------------------------
		
		-- Execute the ADD instruction
		WHEN execute_add =>
			register_ac 				<= register_ac + memory_data_register;				
			state 						<= fetch;
					-- Execute the STORE instruction
					-- (needs three clock cycles for memory write)
		WHEN execute_store =>
					-- write register_AC to memory
			memory_write 				<= '1';
 			state 						<= execute_store2;
					-- This state ensures that the memory address is
					--  valid until after memory_write goes inactive
		WHEN execute_store2 =>
			memory_write				<= '0';
			state 						<= execute_store3;
		WHEN execute_store3 =>
			state 						<= fetch;
					-- Execute the LOAD instruction
		WHEN execute_load =>
			register_ac 				<= memory_data_register;
			state <= fetch;
					-- Execute the JUMP instruction
		WHEN execute_jump =>
			program_counter 			<= instruction_register( 7 DOWNTO 0 );
			state 						<= fetch;
		WHEN OTHERS =>
			state <= fetch;
		END CASE;
	END IF;
   END PROCESS;
   
-- memory address register is stored inside synchronous memory unit 
-- need to send it's outputs based on current state
   WITH state SELECT
		memory_address_register <= "00000000" 					WHEN reset_pc,
							 program_counter					WHEN fetch,
						     instruction_register(7 DOWNTO 0) 	WHEN decode,
							 program_counter					WHEN execute_add,
							 ---------------ADDED--------------------------------
							 program_counter					WHEN execute_subt,
							 program_counter					WHEN execute_xor,
							 program_counter					WHEN execute_or,
							 program_counter					WHEN execute_and,
							 program_counter					WHEN execute_addi,
							 ----------------------------------------------------
							 instruction_register(7 DOWNTO 0) 	WHEN execute_store,
							 instruction_register(7 DOWNTO 0) 	WHEN execute_store2,
							 program_counter					WHEN execute_store3,
							 program_counter					WHEN execute_load,
							 instruction_register(7 DOWNTO 0) 	WHEN execute_jump;
				
END a;
