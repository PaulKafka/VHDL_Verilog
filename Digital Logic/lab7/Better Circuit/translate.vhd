LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY translate IS
PORT(	numin : IN INTEGER RANGE 0 TO 10;
		valout : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
END translate;

ARCHITECTURE behavior OF translate IS

BEGIN
PROCESS(numin)
BEGIN	
CASE numin IS
	WHEN 0 => valout <= "00110000";
	WHEN 1 => valout <= "00110001";
	WHEN 2 => valout <= "00110010";
	WHEN 3 => valout <= "00110011";
	WHEN 4 => valout <= "00110100";
	WHEN 5 => valout <= "00110101";
	WHEN 6 => valout <= "00110110";
	WHEN 7 => valout <= "00110111";
	WHEN 8 => valout <= "00111000";
	WHEN 9 => valout <= "00111001";
	WHEN OTHERS => valout <= "00111111";
END CASE;
END PROCESS;
END behavior;