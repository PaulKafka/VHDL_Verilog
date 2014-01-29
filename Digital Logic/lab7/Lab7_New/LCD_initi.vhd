-- initilization of LCD
-- by Paul Kafka
--///////////////////////////////
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;
--////////////////////////////////
ENTITY LCD_init IS	
PORT (
	Clock_50 : IN STD_LOGIC;	-- inputs a clock
	LCD_D: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Outputs buss to lcd
	LCD_WR : OUT STD_LOGIC;  --output read when high. write when low
	LCD_RS : OUT STD_LOGIC;  -- Instruction code
	LCD_ON : OUT STD_LOGIC);  -- lcd on
END LCD_init;

ARCHITECTURE Behavior OF LCD_init IS
	VARIABLE counter : INTEGER;
BEGIN
	Initi: PROCESS (Clock_50)
BEGIN		
	IF RISING_EDGE (clock_50) THEN		-- Tracks the clock
		counter := counter + 1;
	END IF;
		
		--step 1. Turn power on
		LCD_ON <= '1'; 	
		
		--step 2. wait 15 ms
		IF counter = 750000 THEN			-- 15x10^-3 / 20x10^-9
	
		--step 3. 
		LCD_RS <= '0'; 
		LCD_WR <= '0'; 
		LCD_D <= "0011ZZZZ";
		END IF;
		
		--step 4. wait more than 4.1 ms
		IF counter = 955000 THEN		-- (15+4.1)x10^-3 / 20x10^-9

		--step 5. 
		LCD_RS <= '0'; 
		LCD_WR <= '0'; 
		LCD_D <= "0011ZZZZ";
		END IF;
		
		--step 6. Wait for more than 100 µs
		IF counter = 960000 THEN		-- (19.2)x10^-3 / 20x10^-9

		--step 7. 
		LCD_RS <= '0'; 
		LCD_WR <= '0'; 
		
		--step8
		LCD_D <= "001110ZZ";
		--LCD_D <= "00001000";
		--LCD_D <= "00000001";
		LCD_D <= "00000110";
		
END PROCESS;
END Behavior;