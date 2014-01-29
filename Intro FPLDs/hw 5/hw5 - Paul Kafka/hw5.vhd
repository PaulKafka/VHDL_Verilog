Library ieee;
use ieee.STD_LOGIC_1164.all;
-- Example 6.4 Ripple Adder

Entity hw5 is
generic (N : integer := 8); -- number of bits
Port (a, b : in STD_LOGIC_VECTOR(N-1 downto 0);
		cin: in std_logic;
s: out std_logic_vector(n-1 downto 0);
cout: out std_logic);
end entity;
--------------------------------------------
Architecture structure of hw5 is
begin
process (a, b, cin)
	variable c: std_logic_vector(N downto 0);
begin
	c(0) := cin;
	For i in 0 to N-1 LOOP
		s(i) <= a(i) XOR b(i) XOR c(i);
		c(i+1) := (a(i) and b(i)) OR (a(i) and c(i)) or 
					(b(i) and c(i));
	end loop;
	cout <= c(N);
End process;
end Architecture;
--------------------------------------------------