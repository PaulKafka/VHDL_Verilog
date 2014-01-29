library ieee;
USE IEEE.NUMERIC_STD.ALL; USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL; USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--------------------------------------------------------------
ENTITY control IS
port (key1 : in std_logic;
      key2 : out std_logic);
      key3 : out std_logic
		);
end control;
-------------------------------------------------------------
architecture behavior of control is
	signal sec,min,hour : integer range 0 to 60 :=0;



 --
process(clk1)
begin

end process;



end behavior;