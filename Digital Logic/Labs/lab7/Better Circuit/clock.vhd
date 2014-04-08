LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_arith.all;

ENTITY clock IS
PORT(clk_in_50 : IN STD_LOGIC;
	hr_add : IN STD_LOGIC;
	min_add : IN STD_LOGIC;
	sec_zero : IN STD_LOGIC;
	disp0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";
	disp1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";
	disp2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	disp3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	disp4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	disp5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	disp6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	disp7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	sec1 : OUT INTEGER;
	sec2 : OUT INTEGER;
	min1 : OUT INTEGER;
	min2 : OUT INTEGER;
	hr1 : OUT INTEGER;
	hr2 : OUT INTEGER;
	hflag : BUFFER STD_LOGIC :='1'
	);
END clock;

ARCHITECTURE behavior OF clock IS

COMPONENT clk_div
	PORT(clk_in : IN STD_LOGIC;
		clk_out : BUFFER STD_LOGIC);
END COMPONENT;

COMPONENT display
	PORT(input : IN INTEGER RANGE 0 TO 10;
		output : OUT STD_LOGIC_VECTOR (6 downto 0));
END COMPONENT;

SIGNAL clk : STD_LOGIC :='0';
SIGNAL seclsb, minlsb : INTEGER RANGE 0 TO 10 :=0;
SIGNAL secmsb, minmsb : INTEGER RANGE 0 TO 6 :=0;
SIGNAL hours : INTEGER RANGE 0 TO 12 :=0;
SIGNAL hrlsb : INTEGER RANGE 0 TO 10 :=2;
SIGNAL hrmsb : INTEGER RANGE 0 TO 2 :=1;
BEGIN

divide_clock : clk_div
	PORT MAP(clk_in_50, clk);
	
PROCESS (clk, hr_add, min_add, sec_zero)
BEGIN
IF RISING_EDGE(clk) THEN
seclsb <= seclsb + 1;
	IF seclsb = 9 THEN
	seclsb <= 0;
	secmsb <= secmsb + 1;
		IF secmsb = 5 THEN
		secmsb <= 0;
		minlsb <= minlsb + 1;
			IF minlsb = 9 THEN
			minlsb <= 0;
			minmsb <= minmsb + 1;
				IF minmsb = 5 THEN
				minmsb <= 0;
				hrlsb <= hrlsb + 1;
					IF (hrmsb = 1 AND hrlsb = 2) THEN
					hflag <= NOT hflag;
					hrlsb <= 1;
					hrmsb <= 0;
					ELSIF hrlsb = 9 THEN
					hrlsb <= 0;
					hrmsb <= hrmsb + 1;
					END IF;
				END IF;
			END IF;
		END IF;
	END IF;
END IF;

IF (RISING_EDGE(clk) AND sec_zero = '0') THEN
seclsb <= 0;
secmsb <= 0;
END IF;

IF (RISING_EDGE(clk) AND min_add = '0') THEN
minlsb <= minlsb + 1;
	IF minlsb = 9 THEN
	minlsb <= 0;
	minmsb <= minmsb + 1;
		IF minmsb = 5 THEN
		minmsb <= 0;
		END IF;
	END IF;
END IF;

IF (RISING_EDGE(clk) AND hr_add = '0') THEN
hrlsb <= hrlsb + 1;
	IF (hrmsb = 1 AND hrlsb = 2) THEN
		hrlsb <= 1;
		hrmsb <= 0;
	ELSIF hrlsb = 9 THEN
		hrlsb <= 0;
		hrmsb <= hrmsb + 1;
	END IF;
END IF;
END PROCESS;

d1 : display
	PORT MAP(seclsb, disp2);
d2 : display
	PORT MAP(secmsb, disp3);
d3 : display
	PORT MAP(minlsb, disp4);
d4 : display
	PORT MAP(minmsb, disp5);
d5 : display
	PORT MAP(hrlsb, disp6);
d6 : display
	PORT MAP(hrmsb, disp7);
	
sec1 <= seclsb;
sec2 <= secmsb;
min1 <= minlsb;
min2 <= minmsb;
hr1 <= hrlsb;
hr2 <= hrmsb;

END behavior;