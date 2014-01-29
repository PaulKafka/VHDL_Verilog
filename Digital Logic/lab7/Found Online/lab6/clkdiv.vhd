LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY clkdiv IS
PORT (clk : IN STD_LOGIC;
	clkout : OUT STD_LOGIC);
END clkdiv;

ARCHITECTURE behavior OF clkdiv IS
BEGIN
PROCESS (clk)
VARIABLE tmp : INTEGER RANGE 0 TO 27000000;
	BEGIN
	IF RISING_EDGE(clk) THEN
		IF (tmp=27000000) THEN
		tmp:=0;
		clkout<='1';
		ELSE
		tmp:= tmp + 1;
		clkout <= '0';
		END IF;
	END IF;
END PROCESS;
END behavior;
		