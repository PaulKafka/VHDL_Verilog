Library ieee; USE ieee.std_logic_1164.all;
ENTITY output IS
	PORT (
	hours: IN STD_LOGIC_VECTOR (3 downto 0);
	stuff : OUT STD_LOGIC_VECTOR (6 downto 0)
	);
END output;

ARCHITECTURE behavior OF output IS
BEGIN
P1: PROCESS(hours)
BEGIN
CASE hours IS
	WHEN "0000" => stuff <= "1000000"; 	--0
	WHEN "0001" => stuff <= "1111001";  --1
	WHEN "0010" => stuff <= "0100100";	--2
	WHEN "0011" => stuff <= "0110000";  --3
	WHEN "0100" => stuff <= "0011001";  --4
	WHEN "0101" => stuff <= "0010010";  --5
	WHEN "0110" => stuff <= "0000010";  --6
	WHEN "0111" => stuff <= "1111000";  --7
	WHEN "1000" => stuff <= "0000000";  --8
	WHEN "1001" => stuff <= "0010000";  --9
	END CASE;
END PROCESS P1;

END behavior;
