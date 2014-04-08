Library ieee; USE ieee.std_logic_1164.all;
ENTITY dispout IS
	PORT (
	msbs, lsbs : IN STD_LOGIC_VECTOR (3 downto 0);
	lseg, rseg : OUT STD_LOGIC_VECTOR (6 downto 0)
	);
END dispout;

ARCHITECTURE behavior OF dispout IS
BEGIN
P1: PROCESS(msbs)
BEGIN
CASE msbs IS
	WHEN "0000" => lseg <= "1000000";
	WHEN "0001" => lseg <= "1111001"; 
	WHEN "0010" => lseg <= "0100100";
	WHEN "0011" => lseg <= "0110000";
	WHEN "0100" => lseg <= "0011001";
	WHEN "0101" => lseg <= "0010010";
	WHEN "0110" => lseg <= "0000010";
	WHEN "0111" => lseg <= "1111000";
	WHEN "1000" => lseg <= "0000000";
	WHEN "1001" => lseg <= "0010000";
	WHEN "1010" => lseg <= "0001000";
	WHEN "1011" => lseg <= "0000011";
	WHEN "1100" => lseg <= "1000110";
	WHEN "1101" => lseg <= "0100001";
	WHEN "1110" => lseg <= "0000110";
	WHEN "1111" => lseg <= "0001110";
	END CASE;
END PROCESS P1;

P2: PROCESS(lsbs)
BEGIN
CASE lsbs IS
	WHEN "0000" => rseg <= "1000000";
	WHEN "0001" => rseg <= "1111001"; 
	WHEN "0010" => rseg <= "0100100";
	WHEN "0011" => rseg <= "0110000";
	WHEN "0100" => rseg <= "0011001";
	WHEN "0101" => rseg <= "0010010";
	WHEN "0110" => rseg <= "0000010";
	WHEN "0111" => rseg <= "1111000";
	WHEN "1000" => rseg <= "0000000";
	WHEN "1001" => rseg <= "0010000";
	WHEN "1010" => rseg <= "0001000";
	WHEN "1011" => rseg <= "0000011";
	WHEN "1100" => rseg <= "1000110";
	WHEN "1101" => rseg <= "0100001";
	WHEN "1110" => rseg <= "0000110";
	WHEN "1111" => rseg <= "0001110";
	END CASE;
END PROCESS P2;
END behavior;
