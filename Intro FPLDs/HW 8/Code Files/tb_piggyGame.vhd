--This is the VHDL testbench for a Pig Game
--By Paul Kafka
------------------------------------------------------------
LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
------------------------------------------------------------ 
ENTITY tb_piggyGame IS
END tb_piggyGame;
-------------------------------
ARCHITECTURE Test OF tb_piggyGame IS
-------------------------------
	COMPONENT piggyGame
		PORT( 
			clk, rst	: IN STD_LOGIC; 
			diceNum		: IN NATURAL RANGE 1 TO 6; 
			player1		: IN STD_LOGIC;
			player2		: IN STD_LOGIC;
			winner      : OUT STD_LOGIC);
	END COMPONENT;
---------------------------------------------
	SIGNAL clk_tb, rst_tb	: STD_LOGIC :='0'; 
	SIGNAL diceNum_tb	    : NATURAL RANGE 1 TO 6 :=1; 
	SIGNAL player1_tb		: STD_LOGIC :='0';	-- One hot
	SIGNAL player2_tb		: STD_LOGIC :='1';	-- One hot
	SIGNAL winner_tb    	: STD_LOGIC :='0';	-- Initilaized to player1
	
	CONSTANT N: INTEGER := 500;					-- Tests more than one round
	TYPE tb_arr is array(1 to 6) of NATURAL RANGE 1 TO 6;
	CONSTANT diceNum_array: tb_arr := (1, 2, 3, 4, 5, 6);
--------------------------------------------
  BEGIN
		DUT: piggyGame
			PORT MAP( clk_tb, rst_tb, diceNum_tb, player1_tb, 
					  player2_tb, winner_tb);
------------------------------------------------
  PROCESS
	  BEGIN
		FOR i IN 1 TO N LOOP			-- Play 500 turns
			FOR i IN 1 TO 6 LOOP		-- Test each dice number each turn
				diceNum_tb <= i;
				WAIT FOR 15 ns;
				assert (diceNum_tb = diceNum_array(i));
				report "Error" severity error;
			END LOOP;
		END LOOP;
		REPORT "Test Finished";
  END PROCESS;
END Test;