library ieee;
use ieee.std_logic_1164.all;

entity hw3b is
	port 
	(
		a	   : in std_logic;
		b	   : in std_logic;
		s      : in std_logic_vector (3 downto 0);
		
		f       : out std_logic
	);

end entity;

architecture logic of hw3b is
begin

process(a,b,s)
    
    begin
        case s is
		    when "0000" =>
		        f <= NOT a;
		    when "0001" =>
		        f <= NOT (a and b);
		    when "0010" =>
		        f <= NOT a or b;
		    when "0011" =>
		        f <= '1';
		    when "0100" =>
		        f <= NOT (a or b);
		    when "0101" =>
		        f <= NOT b;
		    when "0110" =>
		        f <= NOT (a xor b);
		    when "0111" =>
		        f <= a or NOT b;
		    when "1000" =>
		        f <= not a and b;
		    when "1001" =>
		        f <= a xor b;
		    when "1010" =>
		        f <= b;
		    when "1011" =>
		        f <= a or b;
		    when "1100" =>
		        f <= '0';
		    when "1101" =>
		        f <= a and not b;
		    when "1110" =>
		        f <= a and b;
		    when "1111" =>
		        f <= a;
		end case;
    end process;

end logic;
