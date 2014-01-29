-- LCD Controller and output
-- by Paul Kafka
--///////////////////////////////
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--///////////////////////////////
ENTITY LCD_Controll IS		-- two l's because LCd_control is already a unit in library "work"
PORT (
	Clock_50 : IN STD_LOGIC;	-- inputs a clock
	reset: IN STD_LOGIC;  		-- change to KEY1. Resets
	LCD_D: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Outputs buss to lcd
	LCD_WR : OUT STD_LOGIC;  --output read when high. write when low
	LCD_EN : OUT STD_LOGIC;  -- chip enable signal
	LCD_RS : OUT STD_LOGIC;  -- Instruction code
	LCD_ON : OUT STD_LOGIC;  -- lcd on
	LCD_BLON: OUT STD_LOGIC); -- back light on
END LCD_Controll;
--////////////////////////////////////////////////
ARCHITECTURE FSMD OF LCD_Controll IS
	TYPE state_type IS (s1,s2,s3,s4,s10,s11,s12,s13,s20,s21,s22,s23,s24);
	SIGNAL state: state_type;

	CONSTANT max: INTEGER := 50000;
	CONSTANT half: INTEGER := max/2;
	SIGNAL clockticks: INTEGER RANGE 0 TO max;
	SIGNAL clock: STD_LOGIC;

	SUBTYPE ascii IS STD_LOGIC_VECTOR(7 DOWNTO 0);
	TYPE charArray IS array(1 to 16) OF ascii;
	TYPE initArray IS array(1 to 7) OF ascii;
	-- LCD initialization sequence codes
	-- 0x38 init four times
	-- 0x06 Entry mode set: Increment One; No Shift
	-- 0x0F Display control: Display ON; Cursor ON; Blink ON
	-- 0x01 Display clear
	CONSTANT initcode: initArray := (x"38",x"38",x"38",x"38",x"06",x"0F",x"01");
	-- Enoch's LCD
	CONSTANT line1: charArray := (x"20",x"20",x"20",x"45",x"6E",x"6F",x"63",x"68",x"27",x"73",x"20",x"4C",x"43",x"44",x"20",x"20");
	-- 1234567890123456
	CONSTANT line2: charArray := (x"31",x"32",x"33",x"34",x"35",x"36",x"37",x"38",x"39",x"30",x"31",x"32",x"33",x"34",x"35",x"36");
	SIGNAL count: INTEGER;

BEGIN
	
	LCD_ON <= '1';
	LCD_BLON <= '0';
	
	lcd_control: PROCESS(clock, reset)
	BEGIN
		IF(Reset = '1') THEN
			count <= 1;
			state <= s1;
		ELSIF(clock'EVENT AND clock = '1') THEN
			CASE state IS
			-- LCD initialization sequence
			-- The LCD_DATA is written to the LCD at the falling edge of the E line
			-- therefore we need to toggle the E line for each data write
			WHEN s1 =>
				LCD_D <= initcode(count);
				LCD_EN <= '1';	-- EN=1;
				LCD_RS <= '0';	-- RS=0; an instruction
				LCD_WR <= '0';	-- R/W'=0; write
				state <= s2;
			WHEN s2 =>
				LCD_EN <= '0';	-- set EN=0;
				count <= count + 1;
				IF count + 1 <= 7 THEN
					state <= s1;
				ELSE
					state <= s10;
				END IF;

			-- move cursor to first line of display
			WHEN s10 =>
				LCD_D <= x"80";	-- x80 is address of 1st position on first line
				LCD_EN <= '1';	-- EN=1;
				LCD_RS <= '0';	-- RS=0; an instruction
				LCD_WR <= '0';	-- R/W'=0; write
				state <= s11;
			WHEN s11 =>
				LCD_EN <= '0';	-- EN=0; toggle EN
				count <= 1;
				state <= s12;

			-- write 1st line text
			WHEN s12 =>
				LCD_D <= line1(count);
				LCD_EN <= '1';	-- EN=1;
				LCD_RS <= '1';	-- RS=1; data
				LCD_WR <= '0';	-- R/W'=0; write
				state <= s13;
			WHEN s13 =>
				LCD_EN <= '0';	-- EN=0; toggle EN
				count <= count + 1;
				IF count + 1 <= 16 THEN
					state <= s12;
				ELSE
					state <= s20;
				END IF;

			-- move cursor to second line of display
			WHEN s20 =>
				LCD_D <= x"BF";		-- xBF is address of 1st position on second line
				LCD_EN <= '1';	-- EN=1;
				LCD_RS <= '0';	-- RS=0; an instruction
				LCD_WR <= '0';	-- R/W'=0; write
				state <= s21;
			WHEN s21 =>
				LCD_EN <= '0';	-- EN=0; toggle EN
				count <= 1;
				state <= s22;

			-- write 2nd line text
			WHEN s22 =>
				LCD_D <= line2(count);
				LCD_EN <= '1';	-- EN=1;
				LCD_RS <= '1';	-- RS=1; data
				LCD_WR <= '0';	-- R/W'=0; write
				state <= s23;
			WHEN s23 =>
				LCD_EN <= '0';	-- set EN=0;
				count <= count + 1;
				IF count + 1 <= 16 THEN
					state <= s22;
				ELSE
					state <= s24;
				END IF;
			WHEN s24 =>
				state <= s24;
			WHEN OTHERS =>
				state <= s24;
			END CASE;
		END IF;
	END PROCESS;

	ClockDivide: PROCESS
	BEGIN
		WAIT UNTIL Clock_50'EVENT and Clock_50 = '1';
		IF clockticks < max THEN
			clockticks <= clockticks + 1;
		ELSE
			clockticks <= 0;
		END IF;
		IF clockticks < half THEN
			clock <= '0';
		ELSE
			clock <= '1';
		END IF;
	END PROCESS;

END FSMD;