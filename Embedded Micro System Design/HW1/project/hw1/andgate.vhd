library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity andgate is

	port
	(
		SW0, SW1	 : in std_logic;
		LEDR1	     : out std_logic
		
	);

end entity;

architecture rtl of andgate is
begin

	LEDR1 <= SW0 AND SW1;
end rtl;
