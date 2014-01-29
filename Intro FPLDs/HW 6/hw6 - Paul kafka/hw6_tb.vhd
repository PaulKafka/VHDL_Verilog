Library ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
entity hw6_tb is
end;
---------------------------------------------
architecture testbench of hw6_tb is
-----DUT Declaration--------------
component hw6 is
	port (clk, rst: IN STD_LOGIC; 
				x: IN NATURAL RANGE 0 TO 1; 
				y: OUT STD_LOGIC);
end component;
----Signal Declaration-------------------------
SIGNAL clk_tb: STD_LOGIC :='1';
SIGNAL rst_tb: STD_LOGIC :='0';
SIGNAL x_tb: NATURAL RANGE 0 TO 3 :=0;
SIGNAL y_tb: STD_LOGIC;
BEGIN
-----DUT INSTAntiation----------------------------
dut: hw6
	PORT MAP (clk => clk_tb, rst=> rst_tb, x=>x_tb, y=>y_tb);
-----Stimuli generation-------------------------
clk_tb <=NOT clk_tb after 10ns;
rst_tb <=NOT rst_tb after 10ns;
x_tb <= 1 after 0 ns,
1 after 10 ns,
1 after 20 ns,
0 after 30 ns,
0 after 40 ns,
1 after 50 ns,
0 after 60 ns,
1 after 70 ns,
0 after 80 ns,
0 after 90 ns,
0 after 100 ns,
1 after 110 ns,
1 after 120 ns,
0 after 130 ns,
1 after 140 ns,
0 after 150 ns,
1 after 160 ns,
1 after 170 ns;

end testbench;
