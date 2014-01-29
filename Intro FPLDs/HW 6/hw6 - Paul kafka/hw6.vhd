LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
------------------------------------------------------------ 
ENTITY hw6 IS 
 GENERIC ( 
  time1: NATURAL := 3;  
  time2: NATURAL := 5); 
 PORT ( 
  clk, rst: IN STD_LOGIC; 
  x: IN NATURAL RANGE 0 TO 1; 
  y: OUT STD_LOGIC); 
END ENTITY; 
------------------------------------------------------------ 
ARCHITECTURE structure OF hw6 IS  
 TYPE state IS (A, B, C, D);  
 SIGNAL pr_state, nx_state: state; 
 ATTRIBUTE enum_encoding: STRING; 
 ATTRIBUTE enum_encoding OF state: TYPE IS "sequential"; 
 SIGNAL T: NATURAL RANGE 0 TO time2; 
 SIGNAL input1, input2: NATURAL RANGE x'RANGE; 
BEGIN 
 ----Lower section of FSM:--------- 
 PROCESS (rst, clk) 
  VARIABLE count: NATURAL RANGE 0 TO time2; 
 BEGIN 
  IF (rst='1') THEN 
   pr_state <= A; 
  ELSIF (clk'EVENT AND clk='1') THEN 
   IF (x=input1) THEN 
    count := count + 1; 
    IF (count=T) THEN 
     count := 0; 
     pr_state <= nx_state; 
    END IF; 
   ELSE 
    count := 0; 
   END IF; 
  END IF; 
 END PROCESS; 
 ----Upper section of FSM:--------- 
 PROCESS (pr_state, x) 
 BEGIN 
  CASE pr_state IS 
   WHEN A =>   
    y <= '0'; 
    T <= 1; 
    input1<=1; 
    nx_state <= B; 
   WHEN B =>   
    y <= '0'; 
    T <= time1;
    nx_state <= C; 
   WHEN C =>   
    y <= '1'; 
    T <= 2; 
    input1<=0;
    nx_state <= D; 
   WHEN D =>   
    y <= '1'; 
    T <= time2; 
    nx_state <= A; 
  END CASE; 
 END PROCESS; 
END ARCHITECTURE;