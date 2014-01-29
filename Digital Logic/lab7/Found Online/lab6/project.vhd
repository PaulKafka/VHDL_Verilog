LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY project6 IS
PORT(	CLOCK_27 : IN STD_LOGIC;--27MHz input clock
		KEY2 : IN STD_LOGIC;--Minute Edit
		KEY1 : IN STD_LOGIC;--Second reset
		HEX7 : OUT STD_LOGIC_VECTOR (6 downto 0);--Hour display 1
		HEX6 : OUT STD_LOGIC_VECTOR (6 downto 0);--Hour display 2
		HEX5 : OUT STD_LOGIC_VECTOR (6 downto 0);--Minute display 1
		HEX4 : OUT STD_LOGIC_VECTOR (6 downto 0);--Minute display 2
		HEX3 : OUT STD_LOGIC_VECTOR (6 downto 0);--Second display 1
		HEX2 : OUT STD_LOGIC_VECTOR (6 downto 0);--Second display 2
		HEX1 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
	);
END project6;

ARCHITECTURE behavior OF project6 IS
COMPONENT clkdiv
	PORT (	clk : IN STD_LOGIC;
			clkout : OUT STD_LOGIC);
END COMPONENT;
COMPONENT seconds
	PORT (	incnt : IN STD_LOGIC; --counter or clock going into circuit
			reset : IN STD_LOGIC; --resetter
			clkout : OUT STD_LOGIC; --counter/clock going out of circuit
			rdisp : OUT INTEGER RANGE 0 TO 6 ; --right display output 
			ldisp : OUT INTEGER RANGE 0 TO 10); --left display output 
END COMPONENT;
COMPONENT minutes
	PORT (	incnt : IN STD_LOGIC; --counter or clock going into circuit
			reset : IN STD_LOGIC; --resetter
			clkout : OUT STD_LOGIC; --counter/clock going out of circuit
			rdisp : OUT INTEGER RANGE 0 TO 6 ; --right display output 
			ldisp : OUT INTEGER RANGE 0 TO 10); --left display output
END COMPONENT;
COMPONENT dispout
	PORT (	input : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			output : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END COMPONENT;
COMPONENT hrcontrol
	PORT(	inclk : IN STD_LOGIC;--counter or clock going into circuit
			h1disp : OUT INTEGER RANGE 0 TO 2; --right display output 
			h2disp : OUT INTEGER RANGE 0 TO 10); --left display output 
END COMPONENT;
SHARED VARIABLE sin : STD_LOGIC;
SHARED VARIABLE min : STD_LOGIC;
SHARED VARIABLE sout1 : INTEGER RANGE 0 TO 6;
SHARED VARIABLE sout2 : INTEGER RANGE 0 TO 10;
SHARED VARIABLE hin : STD_LOGIC;
SHARED VARIABLE mout1 : INTEGER RANGE 0 TO 6;
SHARED VARIABLE mout2 : INTEGER RANGE 0 TO 10;
SHARED VARIABLE s1dispbus : STD_LOGIC_VECTOR(3 DOWNTO 0);
SHARED VARIABLE s2dispbus : STD_LOGIC_VECTOR(3 DOWNTO 0);
SHARED VARIABLE h1disp : INTEGER RANGE 0 TO 2;
SHARED VARIABLE h2disp : INTEGER RANGE 0 TO 10;
SHARED VARIABLE m1val : INTEGER RANGE 0 TO 6 :=0;
SHARED VARIABLE m2val : INTEGER RANGE 0 TO 10 :=0;
SHARED VARIABLE m1dispbus : STD_LOGIC_VECTOR(3 DOWNTO 0);
SHARED VARIABLE m2dispbus : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
c1 : clkdiv
	PORT MAP(CLOCK_27, sin);--input clock in, 1 Hz clock into second mod out
s1 : seconds
	PORT MAP(sin, KEY1, min, sout1, sout2);--clock into seconds in, clock into minutes out, displays for seconds out
s2 : minutes
	PORT MAP(min, KEY2, hin, mout1, mout2);--clock into minutes in, clock into hrs out, displays for mins out
h1 : hrcontrol
	PORT MAP(hin, h1disp, h2disp);
	
--m1dispbus := STD_LOGIC_VECTOR(TO_UNSIGNED(mout1, 4));
--m2dispbus := STD_LOGIC_VECTOR(TO_UNSIGNED(mout2, 4));
--s1dispbus := STD_LOGIC_VECTOR(TO_UNSIGNED(sout1, 4));
--s2dispbus := STD_LOGIC_VECTOR(TO_UNSIGNED(sout2, 4));

d1 : dispout
	PORT MAP(STD_LOGIC_VECTOR(TO_UNSIGNED(sout2, 4)), HEX2);
d2 : dispout
	PORT MAP(STD_LOGIC_VECTOR(TO_UNSIGNED(sout1, 4)), HEX3);
d3 : dispout
	PORT MAP(STD_LOGIC_VECTOR(TO_UNSIGNED(mout2, 4)), HEX4);
d4 : dispout
	PORT MAP(STD_LOGIC_VECTOR(TO_UNSIGNED(mout1, 4)), HEX5);
d5 : dispout
	PORT MAP(STD_LOGIC_VECTOR(TO_UNSIGNED(h2disp, 4)), HEX6);
d6 : dispout
	PORT MAP(STD_LOGIC_VECTOR(TO_UNSIGNED(h1disp, 4)), HEX7);
HEX1 <= "1111111";
HEX0 <="1111111";
END behavior;