Library ieee; USE ieee.std_logic_1164.all;
ENTITY display IS
	PORT (
	input : IN INTEGER RANGE 0 TO 10;
	output : OUT STD_LOGIC_VECTOR (6 downto 0)
	);
END display;

ARCHITECTURE behavior OF display IS
BEGIN
PROCESS(input)
BEGIN
CASE input IS
	WHEN 0 => output <= "1000000";
	WHEN 1 => output <= "1111001"; 
	WHEN 2 => output <= "0100100";
	WHEN 3 => output <= "0110000";
	WHEN 4 => output <= "0011001";
	WHEN 5 => output <= "0010010";
	WHEN 6 => output <= "0000010";
	WHEN 7 => output <= "1111000";
	WHEN 8 => output <= "0000000";
	WHEN 9 => output <= "0010000";
	WHEN OTHERS => output <= "0000110";
END CASE;
END PROCESS;
END behavior;
