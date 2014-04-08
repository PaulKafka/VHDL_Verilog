LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Simon IS
	PORT 	( 	KEY0, KEY1, KEY2, KEY3 	  : IN STD_LOGIC ;
				LEDR0, LEDR1, LEDR2, LEDR3: OUT STD_LOGIC );
END Simon ;

ARCHITECTURE Behavior OF Simon IS
	
--	variable i : INTEGER RANGE 0 TO 7 :=0; 	 					-- For loop
	TYPE Stages IS ARRAY (7 DOWNTO 0) OF INTEGER;				-- 2d array for stage attempt and answer
	
	TYPE State_type IS (s1,s2,s3,s4,s5,s6,s7,s8,s9,s10) ;			-- FSM types of stages
	SIGNAL currentStage, nextStage 	: State_type ;					-- FSM stages
	
		-- Stages(1-10)
		-- 8 elements arrays of STD_LOGIC
		constant stage1: Stages :=(1,2,3,4,1,2,3,4);		-- Stage1 answer
		constant stage2: Stages :=(1,2,3,4,1,2,3,4);		-- Stage2 answer			
		constant stage3: Stages :=(1,2,3,4,1,2,3,4);		-- Stage3 answer
		constant stage4: Stages :=(1,2,3,4,1,2,3,4);		-- Stage4 answer
		constant stage5: Stages :=(1,2,3,4,1,2,3,4);		-- Stage5 answer
		constant stage6: Stages :=(1,2,3,4,1,2,3,4);		-- Stage6 answer
		constant stage7: Stages :=(1,2,3,4,1,2,3,4);		-- Stage7 answer
		constant stage8: Stages :=(1,2,3,4,1,2,3,4);		-- Stage8 answer
		constant stage9: Stages :=(1,2,3,4,1,2,3,4);		-- Stage9 answer
		constant stage10: Stages :=(1,2,3,4,1,2,3,4);		-- Stage10 answer
		Variable Attemptstage1: Stages;					-- Stage1 attempt
		Variable Attemptstage2: Stages;					-- Stage2 attempt
		Variable Attemptstage3: Stages;					-- Stage3 attempt
		Variable Attemptstage4: Stages;					-- Stage4 attempt
		Variable Attemptstage5: Stages;					-- Stage5 attempt
		Variable Attemptstage6: Stages;					-- Stage6 attempt
		Variable Attemptstage7: Stages;					-- Stage7 attempt	
		Variable Attemptstage8: Stages;					-- Stage8 attempt
		Variable Attemptstage9: Stages;					-- Stage9 attempt
		Variable Attemptstage10: Stages;				-- Stage10 attempt
BEGIN
	PROCESS (KEY0, KEY1, KEY2, KEY3, currentStage)
	BEGIN
		CASE currentStage IS
			WHEN s1 =>		-- Input Answer								    -- STAGE1
							FOR i IN 0 to 7 LOOP
								IF KEY0 ='1' THEN
									attemptStage1(i) := 1; 
								ELSIF KEY1 ='1' THEN
									attemptStage1(i) := 2; 
								ELSIF KEY2 ='1' THEN
									attemptStage1(i) := 3; 
								ELSIF KEY3 ='1' THEN
									attemptStage1(i) := 4; 
							   END IF;
								--i := i+1;	-- Increment i
							END LOOP;
							--Check Answer
							IF (Attemptstage1 /= stage1) THEN				-- If input not equal to answer
								nextStage <= s1;						-- Go to first stage
							ElSE
								LEDR1 <= '1';  							-- Input is correct. Output to led
								nextStage <=  s2;						-- Proceed to next stage
							END IF;
							--i := 0;  									-- Put i back to 0.
							
			WHEN s2 =>		-- Input Answer								    -- STAGE2
							FOR i IN 0 to 7 LOOP
								IF KEY0 ='1' THEN
									attemptStage2(i) := 1; 
								ELSIF KEY1 ='1' THEN
									attemptStage2(i) := 2; 
								ELSIF KEY2 ='1' THEN
									attemptStage2(i) := 3; 
								ELSIF KEY3 ='1' THEN
									attemptStage2(i) := 4; 
							   END IF;
								--i := i+1;	-- Increment i
							END LOOP;
							--Check Answer
							IF Attemptstage2 /= stage2 THEN				-- If input not equal to answer
								nextStage <= s1;						-- Go to first stage
							ElSE
								LEDR1 <= '1';  							-- Input is correct. Output to led
								nextStage <=  s3;						-- Proceed to next stage
							END IF;
						--	i := 0;  									-- Put i back to 0.
							
			WHEN s3 =>		-- Input Answer								    -- STAGE3
							FOR i IN 0 to 7 LOOP
								IF KEY0 ='1' THEN
									attemptStage3(i) := 1; 
								ELSIF KEY1 ='1' THEN
									attemptStage3(i) := 2; 
								ELSIF KEY2 ='1' THEN
									attemptStage3(i) := 3; 
								ELSIF KEY3 ='1' THEN
									attemptStage3(i) := 4; 
							   END IF;
								--i := i+1;	-- Increment i
							END LOOP;
							--Check Answer
							IF Attemptstage3 /= stage3 THEN				-- If input not equal to answer
								nextStage <= s1;						-- Go to first stage
							ElSE
								LEDR1 <= '1';  							-- Input is correct. Output to led
								nextStage <=  s3;						-- Proceed to next stage
							END IF;
							--i := 0;  									-- Put i back to 0.
							
			WHEN s4 =>		-- Input Answer								    -- STAGE4
							FOR i IN 0 to 7 LOOP
								IF KEY0 ='1' THEN
									attemptStage4(i) := 1; 
								ELSIF KEY1 ='1' THEN
									attemptStage4(i) := 2; 
								ELSIF KEY2 ='1' THEN
									attemptStage4(i) := 3; 
								ELSIF KEY3 ='1' THEN
									attemptStage4(i) := 4; 
							   END IF;
								--i := i+1;	-- Increment i
							END LOOP;
							--Check Answer
							IF Attemptstage4 /= stage4 THEN				-- If input not equal to answer
								nextStage <= s1;						-- Go to first stage
							ElSE
								LEDR1 <= '1';  							-- Input is correct. Output to led
								nextStage <=  s5;						-- Proceed to next stage
							END IF;
							--i := 0;  									-- Put i back to 0.
							
			WHEN s5 =>		-- Input Answer								    -- STAGE5
							FOR i IN 0 to 7 LOOP
								IF KEY0 ='1' THEN
									attemptStage5(i) := 1; 
								ELSIF KEY1 ='1' THEN
									attemptStage5(i) := 2; 
								ELSIF KEY2 ='1' THEN
									attemptStage5(i) := 3; 
								ELSIF KEY3 ='1' THEN
									attemptStage5(i) := 4; 
							   END IF;
							--	i := i+1;	-- Increment i
							END LOOP;
							--Check Answer
							IF Attemptstage5 /= stage5 THEN				-- If input not equal to answer
								nextStage <= s1;						-- Go to first stage
							ElSE
								LEDR1 <= '1';  							-- Input is correct. Output to led
								nextStage <=  s6;						-- Proceed to next stage
							END IF;
							--i := 0;  									-- Put i back to 0.
							
			WHEN s6 =>		-- Input Answer								    -- STAGE6
							FOR i IN 0 to 7 LOOP
								IF KEY0 ='1' THEN
									attemptStage6(i) := 1; 
								ELSIF KEY1 ='1' THEN
									attemptStage6(i) := 2; 
								ELSIF KEY2 ='1' THEN
									attemptStage6(i) := 3; 
								ELSIF KEY3 ='1' THEN
									attemptStage6(i) := 4; 
							   END IF;
								--i := i+1;	-- Increment i
							END LOOP;
							--Check Answer
							IF Attemptstage6 /= stage6 THEN				-- If input not equal to answer
								nextStage <= s1;						-- Go to first stage
							ElSE
								LEDR1 <= '1';  							-- Input is correct. Output to led
								nextStage <=  s7;						-- Proceed to next stage
							END IF;
							--i := 0;  									-- Put i back to 0.
							
			WHEN s7 =>		-- Input Answer								    -- STAGE7
							FOR i IN 0 to 7 LOOP
								IF KEY0 ='1' THEN
									attemptStage7(i) := 1; 
								ELSIF KEY1 ='1' THEN
									attemptStage7(i) := 2; 
								ELSIF KEY2 ='1' THEN
									attemptStage7(i) := 3; 
								ELSIF KEY3 ='1' THEN
									attemptStage7(i) := 4; 
							   END IF;
								--i := i+1;	-- Increment i
							END LOOP;
							--Check Answer
							IF Attemptstage7 /= stage7 THEN				-- If input not equal to answer
								nextStage <= s1;						-- Go to first stage
							ElSE
								LEDR1 <= '1';  							-- Input is correct. Output to led
								nextStage <=  s8;						-- Proceed to next stage
							END IF;
						--	i := 0;  									-- Put i back to 0.
							
			WHEN s8 =>		-- Input Answer								    -- STAGE8
							FOR i IN 0 to 7 LOOP
								IF KEY0 ='1' THEN
									attemptStage8(i) := 1; 
								ELSIF KEY1 ='1' THEN
									attemptStage8(i) := 2; 
								ELSIF KEY2 ='1' THEN
									attemptStage8(i) := 3; 
								ELSIF KEY3 ='1' THEN
									attemptStage8(i) := 4; 
							   END IF;
							--	i := i+1;	-- Increment i
							END LOOP;
							--Check Answer
							IF Attemptstage8 /= stage8 THEN				-- If input not equal to answer
								nextStage <= s1;						-- Go to first stage
							ElSE
								LEDR1 <= '1';  							-- Input is correct. Output to led
								nextStage <=  s9;						-- Proceed to next stage
							END IF;
						--i := 0;  									-- Put i back to 0.
							
			WHEN s9 =>		-- Input Answer								    -- STAGE9
							FOR i IN 0 to 7 LOOP
								IF KEY0 ='1' THEN
									attemptStage9(i) := 1; 
								ELSIF KEY1 ='1' THEN
									attemptStage9(i) := 2; 
								ELSIF KEY2 ='1' THEN
									attemptStage9(i) := 3; 
								ELSIF KEY3 ='1' THEN
									attemptStage9(i) := 4; 
							   END IF;
								--i := i+1;	-- Increment i
							END LOOP;
							--Check Answer
							IF Attemptstage9 /= stage9 THEN				-- If input not equal to answer
								nextStage <= s1;						-- Go to first stage
							ElSE
								LEDR1 <= '1';  							-- Input is correct. Output to led
								nextStage <=  s10;						-- Proceed to next stage
							END IF;
							--i := 0;  									-- Put i back to 0.
							
			WHEN s10 =>		-- Input Answer								    -- STAGE10
							FOR i IN 0 to 7 LOOP
								IF KEY0 ='1' THEN
									attemptStage10(i) := 1; 
								ELSIF KEY1 ='1' THEN
									attemptStage10(i) := 2; 
								ELSIF KEY2 ='1' THEN
									attemptStage10(i) := 3; 
								ELSIF KEY3 ='1' THEN
									attemptStage10(i) := 4; 
							   END IF;
								--i := i+1;	-- Increment i
							END LOOP;
							--Check Answer
							IF Attemptstage10 /= stage10 THEN				-- If input not equal to answer
								nextStage <= s1;						-- Go to first stage
							ElSE
								LEDR1 <= '1';  							-- Input is correct. Output to led
								nextStage <=  s1;						-- Proceed to next stage
							END IF;
							--i := 0;  									-- Put i back to 0.
		END CASE ;
	END PROCESS ;	
END Behavior;