LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY seconds IS
PORT (incnt : IN STD_LOGIC; --counter or clock going into circuit
	reset : IN STD_LOGIC; --resetter
	clkout : OUT STD_LOGIC; --counter/clock going out of circuit
	rdisp : OUT INTEGER RANGE 0 TO 6 ; --right display output 
	ldisp : OUT INTEGER RANGE 0 TO 10); --left display output 
END seconds;

ARCHITECTURE behavior OF seconds IS
SHARED VARIABLE countmsb : INTEGER RANGE 0 TO 6 :=0;
SHARED VARIABLE countlsb : INTEGER RANGE 0 TO 10 :=0;
BEGIN
PROCESS (incnt, reset)
VARIABLE tmp : INTEGER RANGE 0 TO 30;
BEGIN
	IF reset = '0' THEN
	countlsb := 0;
	countmsb := 0;
	ELSIF RISING_EDGE(incnt) THEN
		IF (countlsb = 9) THEN
		countlsb := 0;
		countmsb := countmsb + 1;
				IF (countmsb = 6) THEN
				countmsb := 0;
				END IF;
		ELSE 
		countlsb := countlsb +1;
		END IF;
	END IF;
	IF (countmsb = 0 AND reset = '1')THEN
	clkout <='1';
	ELSE
	clkout <= '0';
	END IF;
END PROCESS;

rdisp <= countmsb;
ldisp <= countlsb;
END behavior;