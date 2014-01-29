LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY hrcontrol IS
PORT(	inclk : IN STD_LOGIC;--counter or clock going into circuit
		h1disp : OUT INTEGER RANGE 0 TO 2; --right display output 
		h2disp : OUT INTEGER RANGE 0 TO 10); --left display output 
END hrcontrol;

ARCHITECTURE behavior OF hrcontrol IS
SHARED VARIABLE countmsb : INTEGER RANGE 0 TO 2 :=0;
SHARED VARIABLE countlsb : INTEGER RANGE 0 TO 10 :=0;
BEGIN
P1 : PROCESS (inclk)
VARIABLE count : INTEGER RANGE 0 TO 13 :=12;
BEGIN
	IF RISING_EDGE(inclk) THEN
	count := count + 1;
		IF (count = 13) THEN
		count := 1;
		END IF;
	END IF;
	IF (count >= 10) THEN
	countmsb := 1;
	countlsb := (count - 10);
	ELSE
	countmsb := 0;
	countlsb := count;
	END IF;
END PROCESS P1;
h1disp <= countmsb;
h2disp <= countlsb;
END behavior;