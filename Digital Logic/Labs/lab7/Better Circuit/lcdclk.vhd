LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;

ENTITY lcdclk IS
PORT(CLOCK_50 : IN STD_LOGIC;
	KEY3 : IN STD_LOGIC;
	KEY2 : IN STD_LOGIC;
	KEY1 : IN STD_LOGIC;
	HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";
	HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";
	HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	LCD_BLON : OUT STD_LOGIC;
	LCD_ON : OUT STD_LOGIC;
	LCD_EN : OUT STD_LOGIC;
	LCD_RW : OUT STD_LOGIC;
	LCD_RS : OUT STD_LOGIC;
	LCD_DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	SW0 : IN STD_LOGIC
	);
END lcdclk;

ARCHITECTURE behavior OF lcdclk IS

TYPE STATE_TYPE IS (INITIAL_START, FUNC_SET, MODE_SET, WAITUP, TOGGLE_E, HOME, CLEAR, STATE_1, STATE_2, STATE_3, STATE_4, STATE_5,
STATE_6, STATE_7, STATE_8, STATE_9, STATE_10, STATE_11, STATE_12, STATE_13, STATE_14, STATE_15, STATE_16, STATE_17,
STATE_18, STATE_19, STATE_20, STATE_21, STATE_22, STATE_23, STATE_24, STATE_25, STATE_26, STATE_27, STATE_28, STATE_29,
STATE_30, STATE_31, LINE_2, DISP_OFF, INITIAL_2, INITIAL_3, DISP_ON, STATE_32);

COMPONENT clock
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
	hflag : BUFFER STD_LOGIC);
END COMPONENT;

COMPONENT translate
PORT(numin : IN INTEGER RANGE 0 TO 10;
	valout : OUT STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

SIGNAL now_state : STATE_TYPE := INITIAL_START;
SIGNAL next_state : STATE_TYPE;

SIGNAL count_clk : INTEGER :=0;
SIGNAL cntr_clk, LCD_RW_INT : STD_LOGIC :='0';
SIGNAL slsb_val, smsb_val, mlsb_val, mmsb_val, hlsb_val, hmsb_val : INTEGER;
SIGNAL s1_ascii, s2_ascii, m1_ascii, m2_ascii, h1_ascii, h2_ascii, LCD_DATA_VALUE, am_or_pm : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL hflag : STD_LOGIC;
SIGNAL name1, name2, name3, name4, name5, name6, name7, name8, name9, name10, name11 : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

LCD_ON <= '1';
LCD_BLON <= '1';

c1 : clock
	PORT MAP(CLOCK_50, KEY3, KEY2, KEY1, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
			HEX6, HEX7, slsb_val, smsb_val, mlsb_val, mmsb_val, hlsb_val, hmsb_val, hflag);
			
t1 : translate
	PORT MAP(slsb_val, s1_ascii);
t2 : translate
	PORT MAP(smsb_val, s2_ascii);
t3 : translate
	PORT MAP(mlsb_val, m1_ascii);
t4 : translate
	PORT MAP(mmsb_val, m2_ascii);
t5 : translate
	PORT MAP(hlsb_val, h1_ascii);
t6 : translate
	PORT MAP(hmsb_val, h2_ascii);

LCD_RW <= LCD_RW_INT;
LCD_DATA <= LCD_DATA_VALUE WHEN LCD_RW_INT = '0' ELSE "ZZZZZZZZ";

PROCESS (hflag)
BEGIN
IF hflag = '0' THEN
am_or_pm <= X"41";
ELSE
am_or_pm <= X"51";
END IF;
END PROCESS;

PROCESS(SW0)
BEGIN
IF SW0 = '0' THEN
name1 <= X"4A"; --J
name2 <= X"65";--e
name3 <= X"66";--f
name4 <= X"66";--f
name5 <= X"4B";--K
name6 <= X"69";--i
name7 <= X"74";--t
name8 <= X"63";--c
name9 <= X"68";--h
name10 <= X"65";--e
name11 <= X"6E";--n
ELSE
name1 <= X"50"; --P
name2 <= X"61";--a
name3 <= X"75";--u
name4 <= X"6C";--l
name5 <= X"4B";--K
name6 <= X"61";--a
name7 <= X"66";--f
name8 <= X"6B";--k
name9 <= X"61";--a
name10 <= X"20";
name11 <= X"20";
END IF;
END PROCESS;

PROCESS(CLOCK_50, cntr_clk)
BEGIN
	IF RISING_EDGE(CLOCK_50) THEN
	count_clk <= count_clk + 1;
		IF count_clk = 380000 THEN  --approx. 15ms 769230
		count_clk <= 0;
		cntr_clk <= '1';
		ELSE
		cntr_clk <= '0';
		END IF;
	END IF;
END PROCESS;

PROCESS(CLOCK_50)
BEGIN
IF RISING_EDGE(CLOCK_50) THEN
	IF cntr_clk = '1' THEN
	CASE now_state IS
		WHEN INITIAL_START =>
								LCD_EN <= '1';
								LCD_RS <= '0';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"38";
								now_state <= TOGGLE_E;
								next_state <= INITIAL_2;
								
		WHEN INITIAL_2 =>
								LCD_EN <= '1';
								LCD_RS <= '0';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"38";
								now_state <= TOGGLE_E;
								next_state <= INITIAL_3;
								
		WHEN INITIAL_3 =>
								LCD_EN <= '1';
								LCD_RS <= '0';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"38";
								now_state <= TOGGLE_E;
								next_state <= FUNC_SET;
		
		WHEN FUNC_SET =>		
								LCD_EN <= '1';
								LCD_RS <= '0';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"38";
								now_state <= TOGGLE_E;
								next_state <= DISP_OFF;
								
		WHEN DISP_OFF =>
								LCD_EN <= '1';
								LCD_RS <= '0';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"08";
								now_state <= TOGGLE_E;
								next_state <= CLEAR;
								
		WHEN CLEAR =>
								LCD_EN <= '1';
								LCD_RS <= '0';
								LCD_RW_INT	<= '0';
								LCD_DATA_VALUE <= X"01";
								now_state <= TOGGLE_E;
								next_state <= DISP_ON;
								
		WHEN DISP_ON =>
								LCD_EN <= '1';
								LCD_RS <= '0';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"0C";
								now_state <= TOGGLE_E;
								next_state <= MODE_SET;

								
		WHEN MODE_SET =>
								LCD_EN <= '1';
								LCD_RS <= '0';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"06";
								now_state <= TOGGLE_E;
								next_state <= HOME;
								
		
								
		WHEN HOME =>			
								LCD_EN <= '1';
								LCD_RS <= '0';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= "10000000"; --Back to first position
								now_state <= TOGGLE_E;
								next_state <= STATE_1;
								
		WHEN TOGGLE_E =>
								LCD_EN <= '0';
								now_state <= WAITUP;
								
		WHEN WAITUP =>
								now_state <= next_state;
								
		WHEN STATE_1 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= name1;
								now_state <= TOGGLE_E;
								next_state <= STATE_2;
								
		WHEN STATE_2 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= name2; 
								now_state <= TOGGLE_E;
								next_state <= STATE_3;
								
		WHEN STATE_3 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= name3; 
								now_state <= TOGGLE_E;
								next_state <= STATE_4;
								
		WHEN STATE_4 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= name4; 
								now_state <= TOGGLE_E;
								next_state <= STATE_5;
								
		WHEN STATE_5 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"20"; --space ASCII character
								now_state <= TOGGLE_E;
								next_state <= STATE_6;
								
		WHEN STATE_6 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= name5; 
								now_state <= TOGGLE_E;
								next_state <= STATE_7;
								
		WHEN STATE_7 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= name6; 
								now_state <= TOGGLE_E;
								next_state <= STATE_8;
								
		WHEN STATE_8 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= name7; 
								now_state <= TOGGLE_E;
								next_state <= STATE_9;
								
		WHEN STATE_9 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= name8; 
								now_state <= TOGGLE_E;
								next_state <= STATE_10;
								
		WHEN STATE_10 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= name9; 
								now_state <= TOGGLE_E;
								next_state <= STATE_11;
								
		WHEN STATE_11 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= name10; 
								now_state <= TOGGLE_E;
								next_state <= STATE_12;
								
		WHEN STATE_12 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= name11; 
								now_state <= TOGGLE_E;
								next_state <= STATE_13;
								
		WHEN STATE_13 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"20"; --space ASCII character
								now_state <= TOGGLE_E;
								next_state <= STATE_14;
								
		WHEN STATE_14 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"20"; --space ASCII character
								now_state <= TOGGLE_E;
								next_state <= STATE_15;
								
		WHEN STATE_15 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"20"; --space ASCII character
								now_state <= TOGGLE_E;
								next_state <= STATE_16;
								
		WHEN STATE_16 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"20"; --space ASCII character
								now_state <= TOGGLE_E;
								next_state <= LINE_2;
								
		WHEN LINE_2 =>
								LCD_EN <= '1';
								LCD_RS <= '0';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"C0";--write to second line
								now_state <= TOGGLE_E;
								next_state <= STATE_17;
								
		WHEN STATE_17 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= h2_ascii;
								now_state <= TOGGLE_E;
								next_state <= STATE_18;
								
		WHEN STATE_18 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= h1_ascii;
								now_state <= TOGGLE_E;
								next_state <= STATE_19;
								
		WHEN STATE_19 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= "00111010";--colon ASCII character
								now_state <= TOGGLE_E;
								next_state <= STATE_20;
								
		WHEN STATE_20 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= m2_ascii;
								now_state <= TOGGLE_E;
								next_state <= STATE_21;
								
		WHEN STATE_21 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= m1_ascii;
								now_state <= TOGGLE_E;
								next_state <= STATE_22;
								
		WHEN STATE_22 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= "00111010";--colon ASCII character
								now_state <= TOGGLE_E;
								next_state <= STATE_23;
								
		WHEN STATE_23 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= s2_ascii;
								now_state <= TOGGLE_E;
								next_state <= STATE_24;
								
		WHEN STATE_24 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= s1_ascii;
								now_state <= TOGGLE_E;
								next_state <= STATE_25;
								
		WHEN STATE_25 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"20"; --space ASCII character
								now_state <= TOGGLE_E;
								next_state <= STATE_26;
								
		WHEN STATE_26 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= am_or_pm;   -- AM/PM variable
								now_state <= TOGGLE_E;
								next_state <= STATE_27;
								
		WHEN STATE_27 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= "01001101";   -- M for time
								now_state <= TOGGLE_E;
								next_state <= STATE_28;
								
		WHEN STATE_28 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"20"; --space ASCII character
								now_state <= TOGGLE_E;
								next_state <= STATE_29;
								
		WHEN STATE_29 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"20"; --space ASCII character
								now_state <= TOGGLE_E;
								next_state <= STATE_30;
								
		WHEN STATE_30 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"20"; --space ASCII character
								now_state <= TOGGLE_E;
								next_state <= STATE_31;
								
		WHEN STATE_31 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"20"; --space ASCII character
								now_state <= TOGGLE_E;
								next_state <= STATE_32;
								
		WHEN STATE_32 =>
								LCD_EN <= '1';
								LCD_RS <= '1';
								LCD_RW_INT <= '0';
								LCD_DATA_VALUE <= X"20"; --space ASCII character
								now_state <= TOGGLE_E;
								next_state <= HOME;
	END CASE;
	END IF;
END IF;
END PROCESS;

END behavior;