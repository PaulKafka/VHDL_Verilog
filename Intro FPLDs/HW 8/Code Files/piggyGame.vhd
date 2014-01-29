--This is the VHDL for a Pig Game
--By Paul Kafka
------------------------------------------------------------
LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
------------------------------------------------------------ 
ENTITY piggyGame IS 
	PORT( 
	clk, rst	: IN STD_LOGIC; 
	diceNum		: IN NATURAL RANGE 1 TO 6; 
	player1		: IN STD_LOGIC;
	player2		: IN STD_LOGIC;
	winner      : OUT STD_LOGIC);
END ENTITY; 
------------------------------------------------------------ 
ARCHITECTURE structure OF piggyGame IS  
	TYPE state IS (player1_diceroll, player1_hold, 		-- 4 States
				   player2_diceroll, player2_hold);  
	SIGNAL pr_state, nx_state: state; 
	SIGNAL p1_total, p2_total : INTEGER RANGE 0 TO 100;
	SIGNAL p1_turn, p2_turn   : INTEGER RANGE 0 TO 100;
BEGIN 
 ----Lower section of FSM:--------- 
	 PROCESS (rst, clk) 
	 BEGIN 
	  IF (rst='1') THEN 
	   pr_state <= player1_diceroll; 
	  ELSIF (clk'EVENT AND clk='1') THEN 
		 pr_state <= nx_state; 
	  END IF; 
	 END PROCESS; 
	 
 ----Upper section of FSM:--------- 
	 PROCESS (pr_state, diceNum, player1, player2) 
	 BEGIN 
		CASE pr_state IS 
			-- PLAYER 1 TURN-----------------------------------------------------------
			WHEN player1_diceroll =>   
				IF (diceNum = 1) THEN
					p1_turn <= 0;							-- No points for this turn
					nx_state <= player1_hold;				-- Next player's turn
				ELSIF (diceNum >=2 AND diceNum <=6) THEN
					p1_turn <= diceNum + p1_turn; 
					nx_state <= player1_diceroll;
				ELSE
					nx_state <= player1_hold;
				END IF;
			WHEN player1_hold =>   
					p1_total <= p1_turn + p1_total;			-- Increment total
					p1_turn <= 0;							-- Reset turn total
					IF (p1_total >= 100) THEN
						winner <= player1;					-- Player 1 wins
						nx_state <= player1_diceroll; 		-- Start the game over
					ELSE
						nx_state <= player2_diceroll;
					END IF;
			--PLAYER 2 TURN--------------------------------------------------------------
			WHEN player2_diceroll =>   
				IF (diceNum = 1) THEN
					p2_turn <= 0;							-- No points for this turn
					nx_state <= player2_hold;				-- Next player's turn
				ELSIF (diceNum >=2 AND diceNum <=6) THEN
					p2_turn <= diceNum + p2_turn; 
					nx_state <= player2_diceroll;
				ELSE
					nx_state <= player2_hold;
				END IF;
			WHEN player2_hold =>   
				p2_total <= p2_turn + p2_total;				-- Increment total
				p1_turn <= 0;								-- Reset turn total
				IF (p2_total >= 100) THEN
					winner <= player2;						-- Player 2 wins
					nx_state <= player1_diceroll; 		 	-- Start the game over
				ELSE
					nx_state <= player1_diceroll;
				END IF;
		END CASE; 
	END PROCESS; 
END ARCHITECTURE;