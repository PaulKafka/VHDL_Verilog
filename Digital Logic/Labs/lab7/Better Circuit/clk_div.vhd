LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY clk_div IS
PORT(	clk_in : IN STD_LOGIC;
		clk_out : BUFFER STD_LOGIC
	);
END clk_div;

ARCHITECTURE behavior OF clk_div IS
SIGNAL count : INTEGER :=0;
BEGIN
PROCESS (clk_in)
BEGIN
IF RISING_EDGE (clk_in) THEN
count <= count + 1;
	IF count = 25000000 THEN 
		clk_out <= NOT clk_out;
		count <= 0;
	END IF;
END IF;
END PROCESS;
END behavior;
	