-- Binary to Hex Display

LIBRARY ieee; USE ieee.std_logic_1164.all; 
					USE IEEE.NUMERIC_STD.ALL; use ieee.std_logic_unsigned.all;
---------------------------------
ENTITY output IS
	PORT(
	msb, lsb : IN STD_LOGIC_VECTOR (3 downto 0);
	seg1, seg2 : OUT STD_LOGIC_VECTOR (6 downto 0));
END output;
---------------------------------
ARCHITECTURE Behavior OF output IS
BEGIN
P1: PROCESS(msb)
BEGIN
CASE conv_integer(msb) IS
WHEN 0 => seg1 <= "1000000";
WHEN 1 => seg1 <= "1111001";
WHEN 2 => seg1 <= "0100100";
WHEN 3 => seg1 <= "0110000";
WHEN 4 => seg1 <= "0011001";
WHEN 5 => seg1 <= "0010010";
WHEN 6 => seg1 <= "0000010";
WHEN 7 => seg1 <= "1111000";
WHEN 8 => seg1 <= "0000000";
WHEN 9 => seg1 <= "0011000";
WHEN 10 => seg1 <= "0100011";
WHEN 11 => seg1 <= "0000011";
WHEN 12 => seg1 <= "0100111";
WHEN 13 => seg1 <= "0100001";
WHEN 14 => seg1 <= "0000100";
WHEN 15 => seg1 <= "0001110";
WHEN OTHERS => seg1 <= "1000000";
END CASE;
END PROCESS;

P2: PROCESS(lsb)
BEGIN
CASE conv_integer(lsb) IS
WHEN 0 => seg2 <= "1000000";
WHEN 1 => seg2 <= "1111001";
WHEN 2 => seg2 <= "0100100";
WHEN 3 => seg2 <= "0110000";
WHEN 4 => seg2 <= "0011001";
WHEN 5 => seg2 <= "0010010";
WHEN 6 => seg2 <= "0000010";
WHEN 7 => seg2 <= "1111000";
WHEN 8 => seg2 <= "0000000";
WHEN 9 => seg2 <= "0011000";
WHEN 10 => seg2 <= "0100011";
WHEN 11 => seg2 <= "0000011";
WHEN 12 => seg2 <= "0100111";
WHEN 13 => seg2 <= "0100001";
WHEN 14 => seg2 <= "0000100";
WHEN 15 => seg2 <= "0001110";
WHEN OTHERS => seg2 <= "1000000";
END CASE;
END PROCESS;
END Behavior;
