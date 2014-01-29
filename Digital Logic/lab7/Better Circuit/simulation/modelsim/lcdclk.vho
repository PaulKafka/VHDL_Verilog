-- Copyright (C) 1991-2009 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II"
-- VERSION "Version 9.1 Build 222 10/21/2009 SJ Web Edition"

-- DATE "03/24/2011 17:25:41"

-- 
-- Device: Altera EP2C35F672C6 Package FBGA672
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEII;
LIBRARY IEEE;
USE CYCLONEII.CYCLONEII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	lcd_clock IS
    PORT (
	LCD_BLON : OUT std_logic;
	CLOCK_50 : IN std_logic;
	KEY : IN std_logic_vector(3 DOWNTO 1);
	SW : IN std_logic_vector(0 DOWNTO 0);
	LCD_ON : OUT std_logic;
	LCD_EN : OUT std_logic;
	LCD_RW : OUT std_logic;
	LCD_RS : OUT std_logic;
	HEX0 : OUT std_logic_vector(6 DOWNTO 0);
	HEX1 : OUT std_logic_vector(6 DOWNTO 0);
	HEX2 : OUT std_logic_vector(6 DOWNTO 0);
	HEX3 : OUT std_logic_vector(6 DOWNTO 0);
	HEX4 : OUT std_logic_vector(6 DOWNTO 0);
	HEX5 : OUT std_logic_vector(6 DOWNTO 0);
	HEX6 : OUT std_logic_vector(6 DOWNTO 0);
	HEX7 : OUT std_logic_vector(6 DOWNTO 0);
	LCD_DATA : OUT std_logic_vector(7 DOWNTO 0)
	);
END lcd_clock;

-- Design Ports Information
-- LCD_BLON	=>  Location: PIN_K2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LCD_ON	=>  Location: PIN_L4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LCD_EN	=>  Location: PIN_K3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LCD_RW	=>  Location: PIN_K4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LCD_RS	=>  Location: PIN_K1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[6]	=>  Location: PIN_V13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[5]	=>  Location: PIN_V14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[4]	=>  Location: PIN_AE11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[3]	=>  Location: PIN_AD11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[2]	=>  Location: PIN_AC12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[1]	=>  Location: PIN_AB12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX0[0]	=>  Location: PIN_AF10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[6]	=>  Location: PIN_AB24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[5]	=>  Location: PIN_AA23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[4]	=>  Location: PIN_AA24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[3]	=>  Location: PIN_Y22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[2]	=>  Location: PIN_W21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[1]	=>  Location: PIN_V21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX1[0]	=>  Location: PIN_V20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX2[6]	=>  Location: PIN_Y24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX2[5]	=>  Location: PIN_AB25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX2[4]	=>  Location: PIN_AB26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX2[3]	=>  Location: PIN_AC26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX2[2]	=>  Location: PIN_AC25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX2[1]	=>  Location: PIN_V22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX2[0]	=>  Location: PIN_AB23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX3[6]	=>  Location: PIN_W24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX3[5]	=>  Location: PIN_U22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX3[4]	=>  Location: PIN_Y25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX3[3]	=>  Location: PIN_Y26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX3[2]	=>  Location: PIN_AA26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX3[1]	=>  Location: PIN_AA25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX3[0]	=>  Location: PIN_Y23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX4[6]	=>  Location: PIN_T3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX4[5]	=>  Location: PIN_R6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX4[4]	=>  Location: PIN_R7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX4[3]	=>  Location: PIN_T4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX4[2]	=>  Location: PIN_U2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX4[1]	=>  Location: PIN_U1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX4[0]	=>  Location: PIN_U9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX5[6]	=>  Location: PIN_R3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX5[5]	=>  Location: PIN_R4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX5[4]	=>  Location: PIN_R5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX5[3]	=>  Location: PIN_T9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX5[2]	=>  Location: PIN_P7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX5[1]	=>  Location: PIN_P6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX5[0]	=>  Location: PIN_T2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX6[6]	=>  Location: PIN_M4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX6[5]	=>  Location: PIN_M5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX6[4]	=>  Location: PIN_M3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX6[3]	=>  Location: PIN_M2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX6[2]	=>  Location: PIN_P3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX6[1]	=>  Location: PIN_P4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX6[0]	=>  Location: PIN_R2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX7[6]	=>  Location: PIN_N9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX7[5]	=>  Location: PIN_P9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX7[4]	=>  Location: PIN_L7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX7[3]	=>  Location: PIN_L6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX7[2]	=>  Location: PIN_L9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX7[1]	=>  Location: PIN_L2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- HEX7[0]	=>  Location: PIN_L3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LCD_DATA[7]	=>  Location: PIN_H3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LCD_DATA[6]	=>  Location: PIN_H4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LCD_DATA[5]	=>  Location: PIN_J3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LCD_DATA[4]	=>  Location: PIN_J4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LCD_DATA[3]	=>  Location: PIN_H2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LCD_DATA[2]	=>  Location: PIN_H1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LCD_DATA[1]	=>  Location: PIN_J2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LCD_DATA[0]	=>  Location: PIN_J1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- CLOCK_50	=>  Location: PIN_N2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- KEY[1]	=>  Location: PIN_N23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- KEY[2]	=>  Location: PIN_P23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- KEY[3]	=>  Location: PIN_W26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[0]	=>  Location: PIN_N25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default

ARCHITECTURE structure OF lcd_clock IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_LCD_BLON : std_logic;
SIGNAL ww_CLOCK_50 : std_logic;
SIGNAL ww_KEY : std_logic_vector(3 DOWNTO 1);
SIGNAL ww_SW : std_logic_vector(0 DOWNTO 0);
SIGNAL ww_LCD_ON : std_logic;
SIGNAL ww_LCD_EN : std_logic;
SIGNAL ww_LCD_RW : std_logic;
SIGNAL ww_LCD_RS : std_logic;
SIGNAL ww_HEX0 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_HEX1 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_HEX2 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_HEX3 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_HEX4 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_HEX5 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_HEX6 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_HEX7 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_LCD_DATA : std_logic_vector(7 DOWNTO 0);
SIGNAL \inst|c1|divide_clock|clk_out~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \CLOCK_50~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \inst|Add0~6_combout\ : std_logic;
SIGNAL \inst|Add0~10_combout\ : std_logic;
SIGNAL \inst|Add0~12_combout\ : std_logic;
SIGNAL \inst|Add0~24_combout\ : std_logic;
SIGNAL \inst|Add0~36_combout\ : std_logic;
SIGNAL \inst|Add0~42_combout\ : std_logic;
SIGNAL \inst|Add0~44_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~0_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~1\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~2_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~3\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~4_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~5\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~6_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~7\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~8_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~9\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~10_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~11\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~12_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~13\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~14_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~15\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~16_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~17\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~18_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~19\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~20_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~21\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~22_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~23\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~24_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~25\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~26_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~27\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~28_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~29\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~30_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~31\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~32_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~33\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~34_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~35\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~36_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~37\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~38_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~39\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~40_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~41\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~42_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~43\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~44_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~45\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~46_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~47\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~48_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~49\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~50_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~51\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~52_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~53\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~54_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~55\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~56_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~57\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~58_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~59\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~60_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~61\ : std_logic;
SIGNAL \inst|c1|divide_clock|Add0~62_combout\ : std_logic;
SIGNAL \inst|now_state.INITIAL_3~regout\ : std_logic;
SIGNAL \inst|c1|divide_clock|clk_out~regout\ : std_logic;
SIGNAL \inst|c1|Add4~1_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_30~regout\ : std_logic;
SIGNAL \inst|Selector6~2_combout\ : std_logic;
SIGNAL \inst|Selector7~0_combout\ : std_logic;
SIGNAL \inst|Selector7~7_combout\ : std_logic;
SIGNAL \inst|Selector8~0_combout\ : std_logic;
SIGNAL \inst|Selector8~1_combout\ : std_logic;
SIGNAL \inst|Selector8~6_combout\ : std_logic;
SIGNAL \inst|t3|Mux2~0_combout\ : std_logic;
SIGNAL \inst|Selector9~1_combout\ : std_logic;
SIGNAL \inst|Selector9~5_combout\ : std_logic;
SIGNAL \inst|Selector9~6_combout\ : std_logic;
SIGNAL \inst|Equal0~1_combout\ : std_logic;
SIGNAL \inst|Equal0~6_combout\ : std_logic;
SIGNAL \inst|next_state.INITIAL_2~regout\ : std_logic;
SIGNAL \inst|next_state.INITIAL_3~regout\ : std_logic;
SIGNAL \inst|now_state~91_combout\ : std_logic;
SIGNAL \inst|next_state.CLEAR~regout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Equal0~0_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Equal0~1_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Equal0~2_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Equal0~3_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Equal0~4_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Equal0~5_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Equal0~6_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Equal0~7_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Equal0~8_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Equal0~9_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|Equal0~10_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|clk_out~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_30~regout\ : std_logic;
SIGNAL \inst|now_state~110_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_31~regout\ : std_logic;
SIGNAL \inst|next_state.STATE_12~regout\ : std_logic;
SIGNAL \inst|next_state.STATE_4~regout\ : std_logic;
SIGNAL \inst|count_clk~1_combout\ : std_logic;
SIGNAL \inst|count_clk~2_combout\ : std_logic;
SIGNAL \inst|Selector49~0_combout\ : std_logic;
SIGNAL \inst|Selector50~0_combout\ : std_logic;
SIGNAL \inst|Selector15~0_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~0_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~1_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~2_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~3_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~4_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~5_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~6_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~7_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~8_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~9_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~10_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~11_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count~12_combout\ : std_logic;
SIGNAL \inst|Selector45~0_combout\ : std_logic;
SIGNAL \inst|Selector46~0_combout\ : std_logic;
SIGNAL \inst|Selector27~0_combout\ : std_logic;
SIGNAL \inst|Selector19~0_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|clk_out~clkctrl_outclk\ : std_logic;
SIGNAL \CLOCK_50~combout\ : std_logic;
SIGNAL \CLOCK_50~clkctrl_outclk\ : std_logic;
SIGNAL \inst|count_clk~8_combout\ : std_logic;
SIGNAL \inst|Add0~0_combout\ : std_logic;
SIGNAL \inst|count_clk~0_combout\ : std_logic;
SIGNAL \inst|Add0~1\ : std_logic;
SIGNAL \inst|Add0~2_combout\ : std_logic;
SIGNAL \inst|Add0~3\ : std_logic;
SIGNAL \inst|Add0~4_combout\ : std_logic;
SIGNAL \inst|Add0~5\ : std_logic;
SIGNAL \inst|Add0~7\ : std_logic;
SIGNAL \inst|Add0~8_combout\ : std_logic;
SIGNAL \inst|Add0~9\ : std_logic;
SIGNAL \inst|Add0~11\ : std_logic;
SIGNAL \inst|Add0~13\ : std_logic;
SIGNAL \inst|Add0~14_combout\ : std_logic;
SIGNAL \inst|Add0~15\ : std_logic;
SIGNAL \inst|Add0~17\ : std_logic;
SIGNAL \inst|Add0~18_combout\ : std_logic;
SIGNAL \inst|Add0~19\ : std_logic;
SIGNAL \inst|Add0~21\ : std_logic;
SIGNAL \inst|Add0~22_combout\ : std_logic;
SIGNAL \inst|count_clk~4_combout\ : std_logic;
SIGNAL \inst|Add0~23\ : std_logic;
SIGNAL \inst|Add0~25\ : std_logic;
SIGNAL \inst|Add0~26_combout\ : std_logic;
SIGNAL \inst|Add0~27\ : std_logic;
SIGNAL \inst|Add0~28_combout\ : std_logic;
SIGNAL \inst|count_clk~5_combout\ : std_logic;
SIGNAL \inst|Add0~29\ : std_logic;
SIGNAL \inst|Add0~30_combout\ : std_logic;
SIGNAL \inst|count_clk~6_combout\ : std_logic;
SIGNAL \inst|Add0~31\ : std_logic;
SIGNAL \inst|Add0~32_combout\ : std_logic;
SIGNAL \inst|count_clk~7_combout\ : std_logic;
SIGNAL \inst|Add0~33\ : std_logic;
SIGNAL \inst|Add0~34_combout\ : std_logic;
SIGNAL \inst|Add0~35\ : std_logic;
SIGNAL \inst|Add0~37\ : std_logic;
SIGNAL \inst|Add0~39\ : std_logic;
SIGNAL \inst|Add0~40_combout\ : std_logic;
SIGNAL \inst|Add0~41\ : std_logic;
SIGNAL \inst|Add0~43\ : std_logic;
SIGNAL \inst|Add0~45\ : std_logic;
SIGNAL \inst|Add0~46_combout\ : std_logic;
SIGNAL \inst|Add0~47\ : std_logic;
SIGNAL \inst|Add0~49\ : std_logic;
SIGNAL \inst|Add0~50_combout\ : std_logic;
SIGNAL \inst|Add0~51\ : std_logic;
SIGNAL \inst|Add0~53\ : std_logic;
SIGNAL \inst|Add0~54_combout\ : std_logic;
SIGNAL \inst|Add0~55\ : std_logic;
SIGNAL \inst|Add0~57\ : std_logic;
SIGNAL \inst|Add0~58_combout\ : std_logic;
SIGNAL \inst|Add0~59\ : std_logic;
SIGNAL \inst|Add0~60_combout\ : std_logic;
SIGNAL \inst|Add0~61\ : std_logic;
SIGNAL \inst|Add0~62_combout\ : std_logic;
SIGNAL \inst|Add0~56_combout\ : std_logic;
SIGNAL \inst|Equal0~8_combout\ : std_logic;
SIGNAL \inst|Add0~48_combout\ : std_logic;
SIGNAL \inst|Add0~52_combout\ : std_logic;
SIGNAL \inst|Equal0~7_combout\ : std_logic;
SIGNAL \inst|Equal0~9_combout\ : std_logic;
SIGNAL \inst|Equal0~0_combout\ : std_logic;
SIGNAL \inst|Add0~16_combout\ : std_logic;
SIGNAL \inst|Add0~20_combout\ : std_logic;
SIGNAL \inst|count_clk~3_combout\ : std_logic;
SIGNAL \inst|Equal0~2_combout\ : std_logic;
SIGNAL \inst|Equal0~3_combout\ : std_logic;
SIGNAL \inst|Equal0~4_combout\ : std_logic;
SIGNAL \inst|Add0~38_combout\ : std_logic;
SIGNAL \inst|Equal0~5_combout\ : std_logic;
SIGNAL \inst|Equal0~10_combout\ : std_logic;
SIGNAL \inst|cntr_clk~regout\ : std_logic;
SIGNAL \inst|now_state.WAITUP~regout\ : std_logic;
SIGNAL \inst|WideOr2~5_combout\ : std_logic;
SIGNAL \inst|now_state.TOGGLE_E~regout\ : std_logic;
SIGNAL \inst|LCD_EN~0_combout\ : std_logic;
SIGNAL \inst|LCD_EN~regout\ : std_logic;
SIGNAL \inst|now_state~118_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_12~regout\ : std_logic;
SIGNAL \inst|Selector28~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_13~regout\ : std_logic;
SIGNAL \inst|now_state~103_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_13~regout\ : std_logic;
SIGNAL \inst|Selector29~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_14~regout\ : std_logic;
SIGNAL \inst|now_state~104_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_14~regout\ : std_logic;
SIGNAL \inst|Selector30~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_15~regout\ : std_logic;
SIGNAL \inst|now_state~105_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_15~regout\ : std_logic;
SIGNAL \inst|Selector31~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_16~regout\ : std_logic;
SIGNAL \inst|now_state~106_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_16~regout\ : std_logic;
SIGNAL \inst|Selector47~0_combout\ : std_logic;
SIGNAL \inst|next_state.LINE_2~regout\ : std_logic;
SIGNAL \inst|now_state~95_combout\ : std_logic;
SIGNAL \inst|now_state.LINE_2~regout\ : std_logic;
SIGNAL \inst|Selector13~0_combout\ : std_logic;
SIGNAL \inst|next_state.MODE_SET~regout\ : std_logic;
SIGNAL \inst|now_state~96_combout\ : std_logic;
SIGNAL \inst|now_state.MODE_SET~regout\ : std_logic;
SIGNAL \inst|now_state~97_combout\ : std_logic;
SIGNAL \inst|now_state.CLEAR~regout\ : std_logic;
SIGNAL \inst|WideOr2~4_combout\ : std_logic;
SIGNAL \inst|now_state~90_combout\ : std_logic;
SIGNAL \inst|now_state.INITIAL_2~regout\ : std_logic;
SIGNAL \inst|Selector12~0_combout\ : std_logic;
SIGNAL \inst|next_state.FUNC_SET~regout\ : std_logic;
SIGNAL \inst|now_state~89_combout\ : std_logic;
SIGNAL \inst|now_state.FUNC_SET~regout\ : std_logic;
SIGNAL \inst|next_state.INITIAL_START~0_combout\ : std_logic;
SIGNAL \inst|next_state.INITIAL_START~regout\ : std_logic;
SIGNAL \inst|now_state~88_combout\ : std_logic;
SIGNAL \inst|now_state.INITIAL_START~regout\ : std_logic;
SIGNAL \inst|WideOr2~2_combout\ : std_logic;
SIGNAL \inst|Selector48~0_combout\ : std_logic;
SIGNAL \inst|next_state.DISP_OFF~regout\ : std_logic;
SIGNAL \inst|now_state~92_combout\ : std_logic;
SIGNAL \inst|now_state.DISP_OFF~regout\ : std_logic;
SIGNAL \inst|WideOr2~6_combout\ : std_logic;
SIGNAL \inst|Selector1~0_combout\ : std_logic;
SIGNAL \inst|LCD_RS~regout\ : std_logic;
SIGNAL \inst|c1|seclsb[0]~0_combout\ : std_logic;
SIGNAL \inst|c1|seclsb[3]~3_combout\ : std_logic;
SIGNAL \inst|c1|Add0~0_combout\ : std_logic;
SIGNAL \inst|c1|seclsb[3]~4_combout\ : std_logic;
SIGNAL \inst|c1|Equal0~0_combout\ : std_logic;
SIGNAL \inst|c1|seclsb[1]~1_combout\ : std_logic;
SIGNAL \inst|c1|seclsb[2]~2_combout\ : std_logic;
SIGNAL \inst|c1|d1|Mux0~0_combout\ : std_logic;
SIGNAL \inst|c1|d1|Mux1~0_combout\ : std_logic;
SIGNAL \inst|c1|d1|Mux2~0_combout\ : std_logic;
SIGNAL \inst|c1|d1|Mux3~0_combout\ : std_logic;
SIGNAL \inst|c1|d1|Mux4~0_combout\ : std_logic;
SIGNAL \inst|c1|d1|Mux5~0_combout\ : std_logic;
SIGNAL \inst|c1|d1|Mux6~0_combout\ : std_logic;
SIGNAL \inst|c1|secmsb[0]~0_combout\ : std_logic;
SIGNAL \inst|c1|secmsb[2]~1_combout\ : std_logic;
SIGNAL \inst|c1|secmsb[1]~2_combout\ : std_logic;
SIGNAL \inst|c1|d2|Mux0~0_combout\ : std_logic;
SIGNAL \inst|c1|d2|Mux1~0_combout\ : std_logic;
SIGNAL \inst|c1|d2|Mux2~0_combout\ : std_logic;
SIGNAL \inst|c1|d2|Mux3~0_combout\ : std_logic;
SIGNAL \inst|c1|d2|Mux4~0_combout\ : std_logic;
SIGNAL \inst|c1|d2|Mux5~0_combout\ : std_logic;
SIGNAL \inst|c1|d2|Mux6~0_combout\ : std_logic;
SIGNAL \inst|c1|minlsb[0]~5_combout\ : std_logic;
SIGNAL \inst|c1|Equal1~0_combout\ : std_logic;
SIGNAL \inst|c1|minlsb[1]~0_combout\ : std_logic;
SIGNAL \inst|c1|minlsb[2]~2_combout\ : std_logic;
SIGNAL \inst|c1|minlsb[1]~1_combout\ : std_logic;
SIGNAL \inst|c1|minlsb[3]~3_combout\ : std_logic;
SIGNAL \inst|c1|d3|Mux0~0_combout\ : std_logic;
SIGNAL \inst|c1|d3|Mux1~0_combout\ : std_logic;
SIGNAL \inst|c1|d3|Mux2~0_combout\ : std_logic;
SIGNAL \inst|c1|d3|Mux3~0_combout\ : std_logic;
SIGNAL \inst|c1|d3|Mux4~0_combout\ : std_logic;
SIGNAL \inst|c1|d3|Mux5~0_combout\ : std_logic;
SIGNAL \inst|c1|d3|Mux6~0_combout\ : std_logic;
SIGNAL \inst|c1|minmsb[0]~3_combout\ : std_logic;
SIGNAL \inst|c1|Equal2~0_combout\ : std_logic;
SIGNAL \inst|c1|minmsb[0]~0_combout\ : std_logic;
SIGNAL \inst|c1|minmsb[1]~2_combout\ : std_logic;
SIGNAL \inst|c1|minmsb[2]~1_combout\ : std_logic;
SIGNAL \inst|c1|d4|Mux0~0_combout\ : std_logic;
SIGNAL \inst|c1|d4|Mux1~0_combout\ : std_logic;
SIGNAL \inst|c1|d4|Mux2~0_combout\ : std_logic;
SIGNAL \inst|c1|d4|Mux3~0_combout\ : std_logic;
SIGNAL \inst|c1|d4|Mux4~0_combout\ : std_logic;
SIGNAL \inst|c1|d4|Mux5~0_combout\ : std_logic;
SIGNAL \inst|c1|d4|Mux6~0_combout\ : std_logic;
SIGNAL \inst|c1|hrlsb[0]~7_combout\ : std_logic;
SIGNAL \inst|c1|hflag~0_combout\ : std_logic;
SIGNAL \inst|c1|hrlsb[1]~2_combout\ : std_logic;
SIGNAL \inst|c1|Equal6~0_combout\ : std_logic;
SIGNAL \inst|c1|hrlsb[1]~6_combout\ : std_logic;
SIGNAL \inst|c1|hrlsb[1]~3_combout\ : std_logic;
SIGNAL \inst|c1|process_0~3_combout\ : std_logic;
SIGNAL \inst|c1|Add4~0_combout\ : std_logic;
SIGNAL \inst|c1|hrlsb[2]~4_combout\ : std_logic;
SIGNAL \inst|c1|hrmsb[1]~0_combout\ : std_logic;
SIGNAL \inst|c1|process_0~2_combout\ : std_logic;
SIGNAL \inst|c1|hrlsb[3]~5_combout\ : std_logic;
SIGNAL \inst|c1|d5|Mux0~0_combout\ : std_logic;
SIGNAL \inst|c1|d5|Mux1~0_combout\ : std_logic;
SIGNAL \inst|c1|d5|Mux2~0_combout\ : std_logic;
SIGNAL \inst|c1|d5|Mux3~0_combout\ : std_logic;
SIGNAL \inst|c1|d5|Mux4~0_combout\ : std_logic;
SIGNAL \inst|c1|d5|Mux5~0_combout\ : std_logic;
SIGNAL \inst|c1|d5|Mux6~0_combout\ : std_logic;
SIGNAL \inst|c1|hrmsb[0]~1_combout\ : std_logic;
SIGNAL \inst|c1|d6|Mux1~0_combout\ : std_logic;
SIGNAL \inst|c1|d6|Mux1~1_combout\ : std_logic;
SIGNAL \inst|c1|d6|Mux1~2_combout\ : std_logic;
SIGNAL \inst|now_state~111_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_31~regout\ : std_logic;
SIGNAL \inst|Selector52~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_32~regout\ : std_logic;
SIGNAL \inst|now_state~101_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_32~regout\ : std_logic;
SIGNAL \inst|Selector14~0_combout\ : std_logic;
SIGNAL \inst|next_state.HOME~regout\ : std_logic;
SIGNAL \inst|now_state~94_combout\ : std_logic;
SIGNAL \inst|now_state.HOME~regout\ : std_logic;
SIGNAL \inst|Selector2~0_combout\ : std_logic;
SIGNAL \inst|Selector3~8_combout\ : std_logic;
SIGNAL \inst|Selector3~9_combout\ : std_logic;
SIGNAL \inst|Selector32~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_17~regout\ : std_logic;
SIGNAL \inst|now_state~112_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_17~regout\ : std_logic;
SIGNAL \inst|Selector33~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_18~regout\ : std_logic;
SIGNAL \inst|now_state~113_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_18~regout\ : std_logic;
SIGNAL \inst|Selector34~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_19~regout\ : std_logic;
SIGNAL \inst|now_state~99_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_19~regout\ : std_logic;
SIGNAL \inst|Selector35~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_20~regout\ : std_logic;
SIGNAL \inst|now_state~114_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_20~regout\ : std_logic;
SIGNAL \inst|Selector36~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_21~regout\ : std_logic;
SIGNAL \inst|now_state~115_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_21~regout\ : std_logic;
SIGNAL \inst|Selector3~6_combout\ : std_logic;
SIGNAL \inst|Selector39~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_24~regout\ : std_logic;
SIGNAL \inst|now_state~117_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_24~regout\ : std_logic;
SIGNAL \inst|Selector37~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_22~regout\ : std_logic;
SIGNAL \inst|now_state~100_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_22~regout\ : std_logic;
SIGNAL \inst|Selector38~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_23~regout\ : std_logic;
SIGNAL \inst|now_state~116_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_23~regout\ : std_logic;
SIGNAL \inst|Selector3~7_combout\ : std_logic;
SIGNAL \inst|Selector40~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_25~regout\ : std_logic;
SIGNAL \inst|now_state~107_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_25~regout\ : std_logic;
SIGNAL \inst|Selector41~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_26~regout\ : std_logic;
SIGNAL \inst|now_state~122_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_26~regout\ : std_logic;
SIGNAL \inst|Selector42~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_27~regout\ : std_logic;
SIGNAL \inst|now_state~120_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_27~regout\ : std_logic;
SIGNAL \inst|Selector43~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_28~regout\ : std_logic;
SIGNAL \inst|now_state~108_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_28~regout\ : std_logic;
SIGNAL \inst|Selector44~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_29~regout\ : std_logic;
SIGNAL \inst|now_state~109_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_29~regout\ : std_logic;
SIGNAL \inst|Selector3~4_combout\ : std_logic;
SIGNAL \inst|Selector3~3_combout\ : std_logic;
SIGNAL \inst|Selector3~5_combout\ : std_logic;
SIGNAL \inst|Selector3~10_combout\ : std_logic;
SIGNAL \inst|Selector4~0_combout\ : std_logic;
SIGNAL \inst|Selector21~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_6~regout\ : std_logic;
SIGNAL \inst|now_state~121_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_6~regout\ : std_logic;
SIGNAL \inst|Selector4~1_combout\ : std_logic;
SIGNAL \inst|Selector4~2_combout\ : std_logic;
SIGNAL \inst|Selector22~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_7~regout\ : std_logic;
SIGNAL \inst|now_state~125_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_7~regout\ : std_logic;
SIGNAL \inst|Selector23~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_8~regout\ : std_logic;
SIGNAL \inst|now_state~123_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_8~regout\ : std_logic;
SIGNAL \inst|Selector16~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_1~regout\ : std_logic;
SIGNAL \inst|now_state~119_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_1~regout\ : std_logic;
SIGNAL \inst|Selector17~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_2~regout\ : std_logic;
SIGNAL \inst|now_state~129_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_2~regout\ : std_logic;
SIGNAL \inst|Selector18~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_3~regout\ : std_logic;
SIGNAL \inst|now_state~124_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_3~regout\ : std_logic;
SIGNAL \inst|Selector5~2_combout\ : std_logic;
SIGNAL \inst|c1|process_0~4_combout\ : std_logic;
SIGNAL \inst|c1|minlsb[1]~4_combout\ : std_logic;
SIGNAL \inst|c1|hflag~1_combout\ : std_logic;
SIGNAL \inst|c1|hflag~regout\ : std_logic;
SIGNAL \inst|Selector5~3_combout\ : std_logic;
SIGNAL \inst|Selector5~5_combout\ : std_logic;
SIGNAL \inst|Selector5~4_combout\ : std_logic;
SIGNAL \inst|Selector6~0_combout\ : std_logic;
SIGNAL \inst|Selector6~1_combout\ : std_logic;
SIGNAL \inst|Selector6~4_combout\ : std_logic;
SIGNAL \inst|Selector6~3_combout\ : std_logic;
SIGNAL \inst|Selector6~5_combout\ : std_logic;
SIGNAL \inst|Selector6~6_combout\ : std_logic;
SIGNAL \inst|Selector7~5_combout\ : std_logic;
SIGNAL \inst|Selector7~6_combout\ : std_logic;
SIGNAL \inst|Selector7~2_combout\ : std_logic;
SIGNAL \inst|Selector7~1_combout\ : std_logic;
SIGNAL \inst|Selector7~3_combout\ : std_logic;
SIGNAL \inst|Selector7~4_combout\ : std_logic;
SIGNAL \inst|Selector7~8_combout\ : std_logic;
SIGNAL \inst|Selector8~7_combout\ : std_logic;
SIGNAL \inst|Selector8~8_combout\ : std_logic;
SIGNAL \inst|Selector8~9_combout\ : std_logic;
SIGNAL \inst|Selector8~2_combout\ : std_logic;
SIGNAL \inst|Selector8~3_combout\ : std_logic;
SIGNAL \inst|Selector8~4_combout\ : std_logic;
SIGNAL \inst|Selector8~5_combout\ : std_logic;
SIGNAL \inst|Selector8~10_combout\ : std_logic;
SIGNAL \inst|now_state~127_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_4~regout\ : std_logic;
SIGNAL \inst|Selector20~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_5~regout\ : std_logic;
SIGNAL \inst|now_state~102_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_5~regout\ : std_logic;
SIGNAL \inst|Selector3~1_combout\ : std_logic;
SIGNAL \inst|Selector51~0_combout\ : std_logic;
SIGNAL \inst|next_state.DISP_ON~regout\ : std_logic;
SIGNAL \inst|now_state~93_combout\ : std_logic;
SIGNAL \inst|now_state.DISP_ON~regout\ : std_logic;
SIGNAL \inst|WideOr2~3_combout\ : std_logic;
SIGNAL \inst|Selector24~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_9~regout\ : std_logic;
SIGNAL \inst|now_state~128_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_9~regout\ : std_logic;
SIGNAL \inst|Selector25~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_10~regout\ : std_logic;
SIGNAL \inst|now_state~126_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_10~regout\ : std_logic;
SIGNAL \inst|Selector26~0_combout\ : std_logic;
SIGNAL \inst|next_state.STATE_11~regout\ : std_logic;
SIGNAL \inst|now_state~98_combout\ : std_logic;
SIGNAL \inst|now_state.STATE_11~regout\ : std_logic;
SIGNAL \inst|Selector3~0_combout\ : std_logic;
SIGNAL \inst|Selector3~2_combout\ : std_logic;
SIGNAL \inst|Selector9~2_combout\ : std_logic;
SIGNAL \inst|t1|Mux2~0_combout\ : std_logic;
SIGNAL \inst|Selector9~0_combout\ : std_logic;
SIGNAL \inst|t5|Mux2~0_combout\ : std_logic;
SIGNAL \inst|Selector9~3_combout\ : std_logic;
SIGNAL \inst|Selector9~4_combout\ : std_logic;
SIGNAL \inst|Selector9~7_combout\ : std_logic;
SIGNAL \inst|c1|divide_clock|count\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \inst|c1|hrlsb\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \inst|c1|hrmsb\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \inst|c1|minlsb\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \inst|c1|minmsb\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \inst|c1|seclsb\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \inst|c1|secmsb\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \inst|LCD_DATA_VALUE\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \inst|count_clk\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \KEY~combout\ : std_logic_vector(3 DOWNTO 1);
SIGNAL \SW~combout\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \inst|c1|d1|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \inst|c1|d2|ALT_INV_Mux5~0_combout\ : std_logic;
SIGNAL \inst|c1|d3|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \inst|c1|d4|ALT_INV_Mux5~0_combout\ : std_logic;
SIGNAL \inst|c1|d5|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \inst|c1|ALT_INV_hrmsb\ : std_logic_vector(1 DOWNTO 0);

BEGIN

LCD_BLON <= ww_LCD_BLON;
ww_CLOCK_50 <= CLOCK_50;
ww_KEY <= KEY;
ww_SW <= SW;
LCD_ON <= ww_LCD_ON;
LCD_EN <= ww_LCD_EN;
LCD_RW <= ww_LCD_RW;
LCD_RS <= ww_LCD_RS;
HEX0 <= ww_HEX0;
HEX1 <= ww_HEX1;
HEX2 <= ww_HEX2;
HEX3 <= ww_HEX3;
HEX4 <= ww_HEX4;
HEX5 <= ww_HEX5;
HEX6 <= ww_HEX6;
HEX7 <= ww_HEX7;
LCD_DATA <= ww_LCD_DATA;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\inst|c1|divide_clock|clk_out~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \inst|c1|divide_clock|clk_out~regout\);

\CLOCK_50~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \CLOCK_50~combout\);
\inst|c1|d1|ALT_INV_Mux0~0_combout\ <= NOT \inst|c1|d1|Mux0~0_combout\;
\inst|c1|d2|ALT_INV_Mux5~0_combout\ <= NOT \inst|c1|d2|Mux5~0_combout\;
\inst|c1|d3|ALT_INV_Mux0~0_combout\ <= NOT \inst|c1|d3|Mux0~0_combout\;
\inst|c1|d4|ALT_INV_Mux5~0_combout\ <= NOT \inst|c1|d4|Mux5~0_combout\;
\inst|c1|d5|ALT_INV_Mux0~0_combout\ <= NOT \inst|c1|d5|Mux0~0_combout\;
\inst|c1|ALT_INV_hrmsb\(1) <= NOT \inst|c1|hrmsb\(1);
\inst|c1|ALT_INV_hrmsb\(0) <= NOT \inst|c1|hrmsb\(0);

-- Location: LCCOMB_X34_Y29_N6
\inst|Add0~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~6_combout\ = (\inst|count_clk\(3) & (!\inst|Add0~5\)) # (!\inst|count_clk\(3) & ((\inst|Add0~5\) # (GND)))
-- \inst|Add0~7\ = CARRY((!\inst|Add0~5\) # (!\inst|count_clk\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(3),
	datad => VCC,
	cin => \inst|Add0~5\,
	combout => \inst|Add0~6_combout\,
	cout => \inst|Add0~7\);

-- Location: LCCOMB_X34_Y29_N10
\inst|Add0~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~10_combout\ = (\inst|count_clk\(5) & (!\inst|Add0~9\)) # (!\inst|count_clk\(5) & ((\inst|Add0~9\) # (GND)))
-- \inst|Add0~11\ = CARRY((!\inst|Add0~9\) # (!\inst|count_clk\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(5),
	datad => VCC,
	cin => \inst|Add0~9\,
	combout => \inst|Add0~10_combout\,
	cout => \inst|Add0~11\);

-- Location: LCCOMB_X34_Y29_N12
\inst|Add0~12\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~12_combout\ = (\inst|count_clk\(6) & (\inst|Add0~11\ $ (GND))) # (!\inst|count_clk\(6) & (!\inst|Add0~11\ & VCC))
-- \inst|Add0~13\ = CARRY((\inst|count_clk\(6) & !\inst|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(6),
	datad => VCC,
	cin => \inst|Add0~11\,
	combout => \inst|Add0~12_combout\,
	cout => \inst|Add0~13\);

-- Location: LCCOMB_X34_Y29_N24
\inst|Add0~24\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~24_combout\ = (\inst|count_clk\(12) & (\inst|Add0~23\ $ (GND))) # (!\inst|count_clk\(12) & (!\inst|Add0~23\ & VCC))
-- \inst|Add0~25\ = CARRY((\inst|count_clk\(12) & !\inst|Add0~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(12),
	datad => VCC,
	cin => \inst|Add0~23\,
	combout => \inst|Add0~24_combout\,
	cout => \inst|Add0~25\);

-- Location: LCCOMB_X34_Y28_N4
\inst|Add0~36\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~36_combout\ = (\inst|count_clk\(18) & (\inst|Add0~35\ $ (GND))) # (!\inst|count_clk\(18) & (!\inst|Add0~35\ & VCC))
-- \inst|Add0~37\ = CARRY((\inst|count_clk\(18) & !\inst|Add0~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(18),
	datad => VCC,
	cin => \inst|Add0~35\,
	combout => \inst|Add0~36_combout\,
	cout => \inst|Add0~37\);

-- Location: LCCOMB_X34_Y28_N10
\inst|Add0~42\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~42_combout\ = (\inst|count_clk\(21) & (!\inst|Add0~41\)) # (!\inst|count_clk\(21) & ((\inst|Add0~41\) # (GND)))
-- \inst|Add0~43\ = CARRY((!\inst|Add0~41\) # (!\inst|count_clk\(21)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(21),
	datad => VCC,
	cin => \inst|Add0~41\,
	combout => \inst|Add0~42_combout\,
	cout => \inst|Add0~43\);

-- Location: LCCOMB_X34_Y28_N12
\inst|Add0~44\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~44_combout\ = (\inst|count_clk\(22) & (\inst|Add0~43\ $ (GND))) # (!\inst|count_clk\(22) & (!\inst|Add0~43\ & VCC))
-- \inst|Add0~45\ = CARRY((\inst|count_clk\(22) & !\inst|Add0~43\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(22),
	datad => VCC,
	cin => \inst|Add0~43\,
	combout => \inst|Add0~44_combout\,
	cout => \inst|Add0~45\);

-- Location: LCCOMB_X37_Y15_N0
\inst|c1|divide_clock|Add0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~0_combout\ = \inst|c1|divide_clock|count\(0) $ (VCC)
-- \inst|c1|divide_clock|Add0~1\ = CARRY(\inst|c1|divide_clock|count\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(0),
	datad => VCC,
	combout => \inst|c1|divide_clock|Add0~0_combout\,
	cout => \inst|c1|divide_clock|Add0~1\);

-- Location: LCCOMB_X37_Y15_N2
\inst|c1|divide_clock|Add0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~2_combout\ = (\inst|c1|divide_clock|count\(1) & (!\inst|c1|divide_clock|Add0~1\)) # (!\inst|c1|divide_clock|count\(1) & ((\inst|c1|divide_clock|Add0~1\) # (GND)))
-- \inst|c1|divide_clock|Add0~3\ = CARRY((!\inst|c1|divide_clock|Add0~1\) # (!\inst|c1|divide_clock|count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(1),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~1\,
	combout => \inst|c1|divide_clock|Add0~2_combout\,
	cout => \inst|c1|divide_clock|Add0~3\);

-- Location: LCCOMB_X37_Y15_N4
\inst|c1|divide_clock|Add0~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~4_combout\ = (\inst|c1|divide_clock|count\(2) & (\inst|c1|divide_clock|Add0~3\ $ (GND))) # (!\inst|c1|divide_clock|count\(2) & (!\inst|c1|divide_clock|Add0~3\ & VCC))
-- \inst|c1|divide_clock|Add0~5\ = CARRY((\inst|c1|divide_clock|count\(2) & !\inst|c1|divide_clock|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(2),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~3\,
	combout => \inst|c1|divide_clock|Add0~4_combout\,
	cout => \inst|c1|divide_clock|Add0~5\);

-- Location: LCCOMB_X37_Y15_N6
\inst|c1|divide_clock|Add0~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~6_combout\ = (\inst|c1|divide_clock|count\(3) & (!\inst|c1|divide_clock|Add0~5\)) # (!\inst|c1|divide_clock|count\(3) & ((\inst|c1|divide_clock|Add0~5\) # (GND)))
-- \inst|c1|divide_clock|Add0~7\ = CARRY((!\inst|c1|divide_clock|Add0~5\) # (!\inst|c1|divide_clock|count\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(3),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~5\,
	combout => \inst|c1|divide_clock|Add0~6_combout\,
	cout => \inst|c1|divide_clock|Add0~7\);

-- Location: LCCOMB_X37_Y15_N8
\inst|c1|divide_clock|Add0~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~8_combout\ = (\inst|c1|divide_clock|count\(4) & (\inst|c1|divide_clock|Add0~7\ $ (GND))) # (!\inst|c1|divide_clock|count\(4) & (!\inst|c1|divide_clock|Add0~7\ & VCC))
-- \inst|c1|divide_clock|Add0~9\ = CARRY((\inst|c1|divide_clock|count\(4) & !\inst|c1|divide_clock|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(4),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~7\,
	combout => \inst|c1|divide_clock|Add0~8_combout\,
	cout => \inst|c1|divide_clock|Add0~9\);

-- Location: LCCOMB_X37_Y15_N10
\inst|c1|divide_clock|Add0~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~10_combout\ = (\inst|c1|divide_clock|count\(5) & (!\inst|c1|divide_clock|Add0~9\)) # (!\inst|c1|divide_clock|count\(5) & ((\inst|c1|divide_clock|Add0~9\) # (GND)))
-- \inst|c1|divide_clock|Add0~11\ = CARRY((!\inst|c1|divide_clock|Add0~9\) # (!\inst|c1|divide_clock|count\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(5),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~9\,
	combout => \inst|c1|divide_clock|Add0~10_combout\,
	cout => \inst|c1|divide_clock|Add0~11\);

-- Location: LCCOMB_X37_Y15_N12
\inst|c1|divide_clock|Add0~12\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~12_combout\ = (\inst|c1|divide_clock|count\(6) & (\inst|c1|divide_clock|Add0~11\ $ (GND))) # (!\inst|c1|divide_clock|count\(6) & (!\inst|c1|divide_clock|Add0~11\ & VCC))
-- \inst|c1|divide_clock|Add0~13\ = CARRY((\inst|c1|divide_clock|count\(6) & !\inst|c1|divide_clock|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(6),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~11\,
	combout => \inst|c1|divide_clock|Add0~12_combout\,
	cout => \inst|c1|divide_clock|Add0~13\);

-- Location: LCCOMB_X37_Y15_N14
\inst|c1|divide_clock|Add0~14\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~14_combout\ = (\inst|c1|divide_clock|count\(7) & (!\inst|c1|divide_clock|Add0~13\)) # (!\inst|c1|divide_clock|count\(7) & ((\inst|c1|divide_clock|Add0~13\) # (GND)))
-- \inst|c1|divide_clock|Add0~15\ = CARRY((!\inst|c1|divide_clock|Add0~13\) # (!\inst|c1|divide_clock|count\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(7),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~13\,
	combout => \inst|c1|divide_clock|Add0~14_combout\,
	cout => \inst|c1|divide_clock|Add0~15\);

-- Location: LCCOMB_X37_Y15_N16
\inst|c1|divide_clock|Add0~16\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~16_combout\ = (\inst|c1|divide_clock|count\(8) & (\inst|c1|divide_clock|Add0~15\ $ (GND))) # (!\inst|c1|divide_clock|count\(8) & (!\inst|c1|divide_clock|Add0~15\ & VCC))
-- \inst|c1|divide_clock|Add0~17\ = CARRY((\inst|c1|divide_clock|count\(8) & !\inst|c1|divide_clock|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(8),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~15\,
	combout => \inst|c1|divide_clock|Add0~16_combout\,
	cout => \inst|c1|divide_clock|Add0~17\);

-- Location: LCCOMB_X37_Y15_N18
\inst|c1|divide_clock|Add0~18\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~18_combout\ = (\inst|c1|divide_clock|count\(9) & (!\inst|c1|divide_clock|Add0~17\)) # (!\inst|c1|divide_clock|count\(9) & ((\inst|c1|divide_clock|Add0~17\) # (GND)))
-- \inst|c1|divide_clock|Add0~19\ = CARRY((!\inst|c1|divide_clock|Add0~17\) # (!\inst|c1|divide_clock|count\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(9),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~17\,
	combout => \inst|c1|divide_clock|Add0~18_combout\,
	cout => \inst|c1|divide_clock|Add0~19\);

-- Location: LCCOMB_X37_Y15_N20
\inst|c1|divide_clock|Add0~20\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~20_combout\ = (\inst|c1|divide_clock|count\(10) & (\inst|c1|divide_clock|Add0~19\ $ (GND))) # (!\inst|c1|divide_clock|count\(10) & (!\inst|c1|divide_clock|Add0~19\ & VCC))
-- \inst|c1|divide_clock|Add0~21\ = CARRY((\inst|c1|divide_clock|count\(10) & !\inst|c1|divide_clock|Add0~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(10),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~19\,
	combout => \inst|c1|divide_clock|Add0~20_combout\,
	cout => \inst|c1|divide_clock|Add0~21\);

-- Location: LCCOMB_X37_Y15_N22
\inst|c1|divide_clock|Add0~22\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~22_combout\ = (\inst|c1|divide_clock|count\(11) & (!\inst|c1|divide_clock|Add0~21\)) # (!\inst|c1|divide_clock|count\(11) & ((\inst|c1|divide_clock|Add0~21\) # (GND)))
-- \inst|c1|divide_clock|Add0~23\ = CARRY((!\inst|c1|divide_clock|Add0~21\) # (!\inst|c1|divide_clock|count\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(11),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~21\,
	combout => \inst|c1|divide_clock|Add0~22_combout\,
	cout => \inst|c1|divide_clock|Add0~23\);

-- Location: LCCOMB_X37_Y15_N24
\inst|c1|divide_clock|Add0~24\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~24_combout\ = (\inst|c1|divide_clock|count\(12) & (\inst|c1|divide_clock|Add0~23\ $ (GND))) # (!\inst|c1|divide_clock|count\(12) & (!\inst|c1|divide_clock|Add0~23\ & VCC))
-- \inst|c1|divide_clock|Add0~25\ = CARRY((\inst|c1|divide_clock|count\(12) & !\inst|c1|divide_clock|Add0~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(12),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~23\,
	combout => \inst|c1|divide_clock|Add0~24_combout\,
	cout => \inst|c1|divide_clock|Add0~25\);

-- Location: LCCOMB_X37_Y15_N26
\inst|c1|divide_clock|Add0~26\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~26_combout\ = (\inst|c1|divide_clock|count\(13) & (!\inst|c1|divide_clock|Add0~25\)) # (!\inst|c1|divide_clock|count\(13) & ((\inst|c1|divide_clock|Add0~25\) # (GND)))
-- \inst|c1|divide_clock|Add0~27\ = CARRY((!\inst|c1|divide_clock|Add0~25\) # (!\inst|c1|divide_clock|count\(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(13),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~25\,
	combout => \inst|c1|divide_clock|Add0~26_combout\,
	cout => \inst|c1|divide_clock|Add0~27\);

-- Location: LCCOMB_X37_Y15_N28
\inst|c1|divide_clock|Add0~28\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~28_combout\ = (\inst|c1|divide_clock|count\(14) & (\inst|c1|divide_clock|Add0~27\ $ (GND))) # (!\inst|c1|divide_clock|count\(14) & (!\inst|c1|divide_clock|Add0~27\ & VCC))
-- \inst|c1|divide_clock|Add0~29\ = CARRY((\inst|c1|divide_clock|count\(14) & !\inst|c1|divide_clock|Add0~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(14),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~27\,
	combout => \inst|c1|divide_clock|Add0~28_combout\,
	cout => \inst|c1|divide_clock|Add0~29\);

-- Location: LCCOMB_X37_Y15_N30
\inst|c1|divide_clock|Add0~30\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~30_combout\ = (\inst|c1|divide_clock|count\(15) & (!\inst|c1|divide_clock|Add0~29\)) # (!\inst|c1|divide_clock|count\(15) & ((\inst|c1|divide_clock|Add0~29\) # (GND)))
-- \inst|c1|divide_clock|Add0~31\ = CARRY((!\inst|c1|divide_clock|Add0~29\) # (!\inst|c1|divide_clock|count\(15)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(15),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~29\,
	combout => \inst|c1|divide_clock|Add0~30_combout\,
	cout => \inst|c1|divide_clock|Add0~31\);

-- Location: LCCOMB_X37_Y14_N0
\inst|c1|divide_clock|Add0~32\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~32_combout\ = (\inst|c1|divide_clock|count\(16) & (\inst|c1|divide_clock|Add0~31\ $ (GND))) # (!\inst|c1|divide_clock|count\(16) & (!\inst|c1|divide_clock|Add0~31\ & VCC))
-- \inst|c1|divide_clock|Add0~33\ = CARRY((\inst|c1|divide_clock|count\(16) & !\inst|c1|divide_clock|Add0~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(16),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~31\,
	combout => \inst|c1|divide_clock|Add0~32_combout\,
	cout => \inst|c1|divide_clock|Add0~33\);

-- Location: LCCOMB_X37_Y14_N2
\inst|c1|divide_clock|Add0~34\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~34_combout\ = (\inst|c1|divide_clock|count\(17) & (!\inst|c1|divide_clock|Add0~33\)) # (!\inst|c1|divide_clock|count\(17) & ((\inst|c1|divide_clock|Add0~33\) # (GND)))
-- \inst|c1|divide_clock|Add0~35\ = CARRY((!\inst|c1|divide_clock|Add0~33\) # (!\inst|c1|divide_clock|count\(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(17),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~33\,
	combout => \inst|c1|divide_clock|Add0~34_combout\,
	cout => \inst|c1|divide_clock|Add0~35\);

-- Location: LCCOMB_X37_Y14_N4
\inst|c1|divide_clock|Add0~36\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~36_combout\ = (\inst|c1|divide_clock|count\(18) & (\inst|c1|divide_clock|Add0~35\ $ (GND))) # (!\inst|c1|divide_clock|count\(18) & (!\inst|c1|divide_clock|Add0~35\ & VCC))
-- \inst|c1|divide_clock|Add0~37\ = CARRY((\inst|c1|divide_clock|count\(18) & !\inst|c1|divide_clock|Add0~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(18),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~35\,
	combout => \inst|c1|divide_clock|Add0~36_combout\,
	cout => \inst|c1|divide_clock|Add0~37\);

-- Location: LCCOMB_X37_Y14_N6
\inst|c1|divide_clock|Add0~38\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~38_combout\ = (\inst|c1|divide_clock|count\(19) & (!\inst|c1|divide_clock|Add0~37\)) # (!\inst|c1|divide_clock|count\(19) & ((\inst|c1|divide_clock|Add0~37\) # (GND)))
-- \inst|c1|divide_clock|Add0~39\ = CARRY((!\inst|c1|divide_clock|Add0~37\) # (!\inst|c1|divide_clock|count\(19)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(19),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~37\,
	combout => \inst|c1|divide_clock|Add0~38_combout\,
	cout => \inst|c1|divide_clock|Add0~39\);

-- Location: LCCOMB_X37_Y14_N8
\inst|c1|divide_clock|Add0~40\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~40_combout\ = (\inst|c1|divide_clock|count\(20) & (\inst|c1|divide_clock|Add0~39\ $ (GND))) # (!\inst|c1|divide_clock|count\(20) & (!\inst|c1|divide_clock|Add0~39\ & VCC))
-- \inst|c1|divide_clock|Add0~41\ = CARRY((\inst|c1|divide_clock|count\(20) & !\inst|c1|divide_clock|Add0~39\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(20),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~39\,
	combout => \inst|c1|divide_clock|Add0~40_combout\,
	cout => \inst|c1|divide_clock|Add0~41\);

-- Location: LCCOMB_X37_Y14_N10
\inst|c1|divide_clock|Add0~42\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~42_combout\ = (\inst|c1|divide_clock|count\(21) & (!\inst|c1|divide_clock|Add0~41\)) # (!\inst|c1|divide_clock|count\(21) & ((\inst|c1|divide_clock|Add0~41\) # (GND)))
-- \inst|c1|divide_clock|Add0~43\ = CARRY((!\inst|c1|divide_clock|Add0~41\) # (!\inst|c1|divide_clock|count\(21)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(21),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~41\,
	combout => \inst|c1|divide_clock|Add0~42_combout\,
	cout => \inst|c1|divide_clock|Add0~43\);

-- Location: LCCOMB_X37_Y14_N12
\inst|c1|divide_clock|Add0~44\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~44_combout\ = (\inst|c1|divide_clock|count\(22) & (\inst|c1|divide_clock|Add0~43\ $ (GND))) # (!\inst|c1|divide_clock|count\(22) & (!\inst|c1|divide_clock|Add0~43\ & VCC))
-- \inst|c1|divide_clock|Add0~45\ = CARRY((\inst|c1|divide_clock|count\(22) & !\inst|c1|divide_clock|Add0~43\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(22),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~43\,
	combout => \inst|c1|divide_clock|Add0~44_combout\,
	cout => \inst|c1|divide_clock|Add0~45\);

-- Location: LCCOMB_X37_Y14_N14
\inst|c1|divide_clock|Add0~46\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~46_combout\ = (\inst|c1|divide_clock|count\(23) & (!\inst|c1|divide_clock|Add0~45\)) # (!\inst|c1|divide_clock|count\(23) & ((\inst|c1|divide_clock|Add0~45\) # (GND)))
-- \inst|c1|divide_clock|Add0~47\ = CARRY((!\inst|c1|divide_clock|Add0~45\) # (!\inst|c1|divide_clock|count\(23)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(23),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~45\,
	combout => \inst|c1|divide_clock|Add0~46_combout\,
	cout => \inst|c1|divide_clock|Add0~47\);

-- Location: LCCOMB_X37_Y14_N16
\inst|c1|divide_clock|Add0~48\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~48_combout\ = (\inst|c1|divide_clock|count\(24) & (\inst|c1|divide_clock|Add0~47\ $ (GND))) # (!\inst|c1|divide_clock|count\(24) & (!\inst|c1|divide_clock|Add0~47\ & VCC))
-- \inst|c1|divide_clock|Add0~49\ = CARRY((\inst|c1|divide_clock|count\(24) & !\inst|c1|divide_clock|Add0~47\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(24),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~47\,
	combout => \inst|c1|divide_clock|Add0~48_combout\,
	cout => \inst|c1|divide_clock|Add0~49\);

-- Location: LCCOMB_X37_Y14_N18
\inst|c1|divide_clock|Add0~50\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~50_combout\ = (\inst|c1|divide_clock|count\(25) & (!\inst|c1|divide_clock|Add0~49\)) # (!\inst|c1|divide_clock|count\(25) & ((\inst|c1|divide_clock|Add0~49\) # (GND)))
-- \inst|c1|divide_clock|Add0~51\ = CARRY((!\inst|c1|divide_clock|Add0~49\) # (!\inst|c1|divide_clock|count\(25)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(25),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~49\,
	combout => \inst|c1|divide_clock|Add0~50_combout\,
	cout => \inst|c1|divide_clock|Add0~51\);

-- Location: LCCOMB_X37_Y14_N20
\inst|c1|divide_clock|Add0~52\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~52_combout\ = (\inst|c1|divide_clock|count\(26) & (\inst|c1|divide_clock|Add0~51\ $ (GND))) # (!\inst|c1|divide_clock|count\(26) & (!\inst|c1|divide_clock|Add0~51\ & VCC))
-- \inst|c1|divide_clock|Add0~53\ = CARRY((\inst|c1|divide_clock|count\(26) & !\inst|c1|divide_clock|Add0~51\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(26),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~51\,
	combout => \inst|c1|divide_clock|Add0~52_combout\,
	cout => \inst|c1|divide_clock|Add0~53\);

-- Location: LCCOMB_X37_Y14_N22
\inst|c1|divide_clock|Add0~54\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~54_combout\ = (\inst|c1|divide_clock|count\(27) & (!\inst|c1|divide_clock|Add0~53\)) # (!\inst|c1|divide_clock|count\(27) & ((\inst|c1|divide_clock|Add0~53\) # (GND)))
-- \inst|c1|divide_clock|Add0~55\ = CARRY((!\inst|c1|divide_clock|Add0~53\) # (!\inst|c1|divide_clock|count\(27)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(27),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~53\,
	combout => \inst|c1|divide_clock|Add0~54_combout\,
	cout => \inst|c1|divide_clock|Add0~55\);

-- Location: LCCOMB_X37_Y14_N24
\inst|c1|divide_clock|Add0~56\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~56_combout\ = (\inst|c1|divide_clock|count\(28) & (\inst|c1|divide_clock|Add0~55\ $ (GND))) # (!\inst|c1|divide_clock|count\(28) & (!\inst|c1|divide_clock|Add0~55\ & VCC))
-- \inst|c1|divide_clock|Add0~57\ = CARRY((\inst|c1|divide_clock|count\(28) & !\inst|c1|divide_clock|Add0~55\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(28),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~55\,
	combout => \inst|c1|divide_clock|Add0~56_combout\,
	cout => \inst|c1|divide_clock|Add0~57\);

-- Location: LCCOMB_X37_Y14_N26
\inst|c1|divide_clock|Add0~58\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~58_combout\ = (\inst|c1|divide_clock|count\(29) & (!\inst|c1|divide_clock|Add0~57\)) # (!\inst|c1|divide_clock|count\(29) & ((\inst|c1|divide_clock|Add0~57\) # (GND)))
-- \inst|c1|divide_clock|Add0~59\ = CARRY((!\inst|c1|divide_clock|Add0~57\) # (!\inst|c1|divide_clock|count\(29)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(29),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~57\,
	combout => \inst|c1|divide_clock|Add0~58_combout\,
	cout => \inst|c1|divide_clock|Add0~59\);

-- Location: LCCOMB_X37_Y14_N28
\inst|c1|divide_clock|Add0~60\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~60_combout\ = (\inst|c1|divide_clock|count\(30) & (\inst|c1|divide_clock|Add0~59\ $ (GND))) # (!\inst|c1|divide_clock|count\(30) & (!\inst|c1|divide_clock|Add0~59\ & VCC))
-- \inst|c1|divide_clock|Add0~61\ = CARRY((\inst|c1|divide_clock|count\(30) & !\inst|c1|divide_clock|Add0~59\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|count\(30),
	datad => VCC,
	cin => \inst|c1|divide_clock|Add0~59\,
	combout => \inst|c1|divide_clock|Add0~60_combout\,
	cout => \inst|c1|divide_clock|Add0~61\);

-- Location: LCCOMB_X37_Y14_N30
\inst|c1|divide_clock|Add0~62\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Add0~62_combout\ = \inst|c1|divide_clock|Add0~61\ $ (\inst|c1|divide_clock|count\(31))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \inst|c1|divide_clock|count\(31),
	cin => \inst|c1|divide_clock|Add0~61\,
	combout => \inst|c1|divide_clock|Add0~62_combout\);

-- Location: LCFF_X46_Y27_N31
\inst|now_state.INITIAL_3\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~91_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.INITIAL_3~regout\);

-- Location: LCFF_X36_Y14_N3
\inst|c1|divide_clock|clk_out\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~combout\,
	datain => \inst|c1|divide_clock|clk_out~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|clk_out~regout\);

-- Location: LCCOMB_X48_Y28_N10
\inst|c1|Add4~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|Add4~1_combout\ = \inst|c1|hrlsb\(3) $ (((\inst|c1|hrlsb\(2) & (!\inst|c1|hrlsb\(1) & \inst|c1|hrlsb\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101001011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb\(2),
	datab => \inst|c1|hrlsb\(1),
	datac => \inst|c1|hrlsb\(3),
	datad => \inst|c1|hrlsb\(0),
	combout => \inst|c1|Add4~1_combout\);

-- Location: LCFF_X44_Y27_N11
\inst|now_state.STATE_30\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~110_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_30~regout\);

-- Location: LCCOMB_X49_Y27_N16
\inst|Selector6~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector6~2_combout\ = (\SW~combout\(0) & ((\inst|now_state.STATE_4~regout\) # ((\inst|now_state.STATE_9~regout\)))) # (!\SW~combout\(0) & (((\inst|now_state.STATE_10~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_4~regout\,
	datab => \inst|now_state.STATE_10~regout\,
	datac => \inst|now_state.STATE_9~regout\,
	datad => \SW~combout\(0),
	combout => \inst|Selector6~2_combout\);

-- Location: LCCOMB_X47_Y26_N8
\inst|Selector7~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector7~0_combout\ = (!\SW~combout\(0) & ((\inst|now_state.STATE_11~regout\) # ((\inst|now_state.STATE_2~regout\) # (\inst|now_state.STATE_12~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_11~regout\,
	datab => \inst|now_state.STATE_2~regout\,
	datac => \inst|now_state.STATE_12~regout\,
	datad => \SW~combout\(0),
	combout => \inst|Selector7~0_combout\);

-- Location: LCCOMB_X49_Y27_N22
\inst|Selector7~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector7~7_combout\ = (\inst|now_state.STATE_4~regout\) # ((\inst|now_state.STATE_3~regout\) # ((\inst|now_state.DISP_ON~regout\) # (\inst|now_state.STATE_27~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_4~regout\,
	datab => \inst|now_state.STATE_3~regout\,
	datac => \inst|now_state.DISP_ON~regout\,
	datad => \inst|now_state.STATE_27~regout\,
	combout => \inst|Selector7~7_combout\);

-- Location: LCCOMB_X46_Y28_N10
\inst|Selector8~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector8~0_combout\ = (\inst|now_state.STATE_23~regout\ & ((\inst|c1|secmsb\(1)) # ((\inst|now_state.STATE_20~regout\ & \inst|c1|minmsb\(1))))) # (!\inst|now_state.STATE_23~regout\ & (\inst|now_state.STATE_20~regout\ & ((\inst|c1|minmsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_23~regout\,
	datab => \inst|now_state.STATE_20~regout\,
	datac => \inst|c1|secmsb\(1),
	datad => \inst|c1|minmsb\(1),
	combout => \inst|Selector8~0_combout\);

-- Location: LCCOMB_X46_Y28_N20
\inst|Selector8~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector8~1_combout\ = (!\SW~combout\(0) & ((\inst|now_state.STATE_1~regout\) # ((\inst|now_state.STATE_12~regout\) # (\inst|now_state.STATE_4~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_1~regout\,
	datab => \inst|now_state.STATE_12~regout\,
	datac => \SW~combout\(0),
	datad => \inst|now_state.STATE_4~regout\,
	combout => \inst|Selector8~1_combout\);

-- Location: LCCOMB_X49_Y27_N0
\inst|Selector8~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector8~6_combout\ = (\inst|now_state.STATE_22~regout\) # ((\inst|now_state.STATE_6~regout\) # ((\inst|now_state.STATE_9~regout\) # (\inst|now_state.STATE_19~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_22~regout\,
	datab => \inst|now_state.STATE_6~regout\,
	datac => \inst|now_state.STATE_9~regout\,
	datad => \inst|now_state.STATE_19~regout\,
	combout => \inst|Selector8~6_combout\);

-- Location: LCCOMB_X48_Y28_N30
\inst|t3|Mux2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|t3|Mux2~0_combout\ = (\inst|c1|minlsb\(0)) # ((\inst|c1|minlsb\(3) & ((\inst|c1|minlsb\(2)) # (\inst|c1|minlsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minlsb\(3),
	datab => \inst|c1|minlsb\(2),
	datac => \inst|c1|minlsb\(0),
	datad => \inst|c1|minlsb\(1),
	combout => \inst|t3|Mux2~0_combout\);

-- Location: LCCOMB_X48_Y28_N24
\inst|Selector9~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector9~1_combout\ = (\inst|c1|minmsb\(0) & (((\inst|t3|Mux2~0_combout\) # (!\inst|now_state.STATE_21~regout\)))) # (!\inst|c1|minmsb\(0) & (!\inst|now_state.STATE_20~regout\ & ((\inst|t3|Mux2~0_combout\) # (!\inst|now_state.STATE_21~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101100001011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minmsb\(0),
	datab => \inst|now_state.STATE_20~regout\,
	datac => \inst|now_state.STATE_21~regout\,
	datad => \inst|t3|Mux2~0_combout\,
	combout => \inst|Selector9~1_combout\);

-- Location: LCCOMB_X48_Y27_N8
\inst|Selector9~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector9~5_combout\ = (!\inst|now_state.STATE_1~regout\ & (!\inst|now_state.LINE_2~regout\ & (!\inst|now_state.STATE_12~regout\ & !\inst|now_state.STATE_4~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_1~regout\,
	datab => \inst|now_state.LINE_2~regout\,
	datac => \inst|now_state.STATE_12~regout\,
	datad => \inst|now_state.STATE_4~regout\,
	combout => \inst|Selector9~5_combout\);

-- Location: LCCOMB_X48_Y27_N10
\inst|Selector9~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector9~6_combout\ = (\inst|Selector9~5_combout\ & ((\SW~combout\(0)) # ((!\inst|now_state.STATE_10~regout\ & !\inst|now_state.STATE_3~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_10~regout\,
	datab => \inst|Selector9~5_combout\,
	datac => \inst|now_state.STATE_3~regout\,
	datad => \SW~combout\(0),
	combout => \inst|Selector9~6_combout\);

-- Location: LCFF_X34_Y29_N7
\inst|count_clk[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(3));

-- Location: LCFF_X35_Y28_N13
\inst|count_clk[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|count_clk~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(5));

-- Location: LCFF_X35_Y28_N7
\inst|count_clk[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|count_clk~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(6));

-- Location: LCCOMB_X35_Y28_N16
\inst|Equal0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Equal0~1_combout\ = (\inst|count_clk\(6) & (!\inst|count_clk\(4) & (!\inst|count_clk\(7) & \inst|count_clk\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(6),
	datab => \inst|count_clk\(4),
	datac => \inst|count_clk\(7),
	datad => \inst|count_clk\(5),
	combout => \inst|Equal0~1_combout\);

-- Location: LCFF_X34_Y29_N25
\inst|count_clk[12]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(12));

-- Location: LCFF_X34_Y28_N11
\inst|count_clk[21]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~42_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(21));

-- Location: LCFF_X34_Y28_N13
\inst|count_clk[22]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~44_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(22));

-- Location: LCCOMB_X35_Y28_N24
\inst|Equal0~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Equal0~6_combout\ = (!\inst|count_clk\(22) & (!\inst|count_clk\(21) & (!\inst|count_clk\(20) & !\inst|count_clk\(23))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(22),
	datab => \inst|count_clk\(21),
	datac => \inst|count_clk\(20),
	datad => \inst|count_clk\(23),
	combout => \inst|Equal0~6_combout\);

-- Location: LCFF_X46_Y27_N11
\inst|next_state.INITIAL_2\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector49~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.INITIAL_2~regout\);

-- Location: LCFF_X46_Y27_N5
\inst|next_state.INITIAL_3\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector50~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.INITIAL_3~regout\);

-- Location: LCCOMB_X46_Y27_N30
\inst|now_state~91\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~91_combout\ = (\inst|next_state.INITIAL_3~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.INITIAL_3~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~91_combout\);

-- Location: LCFF_X45_Y27_N15
\inst|next_state.CLEAR\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector15~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.CLEAR~regout\);

-- Location: LCFF_X36_Y15_N9
\inst|c1|divide_clock|count[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(6));

-- Location: LCFF_X37_Y15_N17
\inst|c1|divide_clock|count[8]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(8));

-- Location: LCFF_X37_Y15_N15
\inst|c1|divide_clock|count[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(7));

-- Location: LCFF_X37_Y15_N11
\inst|c1|divide_clock|count[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(5));

-- Location: LCCOMB_X36_Y15_N18
\inst|c1|divide_clock|Equal0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Equal0~0_combout\ = (!\inst|c1|divide_clock|count\(8) & (\inst|c1|divide_clock|count\(6) & (!\inst|c1|divide_clock|count\(7) & !\inst|c1|divide_clock|count\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(8),
	datab => \inst|c1|divide_clock|count\(6),
	datac => \inst|c1|divide_clock|count\(7),
	datad => \inst|c1|divide_clock|count\(5),
	combout => \inst|c1|divide_clock|Equal0~0_combout\);

-- Location: LCFF_X37_Y15_N9
\inst|c1|divide_clock|count[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(4));

-- Location: LCFF_X37_Y15_N7
\inst|c1|divide_clock|count[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(3));

-- Location: LCFF_X37_Y15_N5
\inst|c1|divide_clock|count[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(2));

-- Location: LCFF_X37_Y15_N3
\inst|c1|divide_clock|count[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(1));

-- Location: LCCOMB_X36_Y15_N20
\inst|c1|divide_clock|Equal0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Equal0~1_combout\ = (!\inst|c1|divide_clock|count\(1) & (!\inst|c1|divide_clock|count\(4) & (!\inst|c1|divide_clock|count\(2) & !\inst|c1|divide_clock|count\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(1),
	datab => \inst|c1|divide_clock|count\(4),
	datac => \inst|c1|divide_clock|count\(2),
	datad => \inst|c1|divide_clock|count\(3),
	combout => \inst|c1|divide_clock|Equal0~1_combout\);

-- Location: LCFF_X36_Y15_N15
\inst|c1|divide_clock|count[11]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(11));

-- Location: LCFF_X36_Y15_N25
\inst|c1|divide_clock|count[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(0));

-- Location: LCFF_X37_Y15_N19
\inst|c1|divide_clock|count[9]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(9));

-- Location: LCFF_X37_Y15_N21
\inst|c1|divide_clock|count[10]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(10));

-- Location: LCCOMB_X36_Y15_N2
\inst|c1|divide_clock|Equal0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Equal0~2_combout\ = (!\inst|c1|divide_clock|count\(0) & (!\inst|c1|divide_clock|count\(9) & (\inst|c1|divide_clock|count\(11) & !\inst|c1|divide_clock|count\(10))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(0),
	datab => \inst|c1|divide_clock|count\(9),
	datac => \inst|c1|divide_clock|count\(11),
	datad => \inst|c1|divide_clock|count\(10),
	combout => \inst|c1|divide_clock|Equal0~2_combout\);

-- Location: LCFF_X36_Y15_N13
\inst|c1|divide_clock|count[12]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(12));

-- Location: LCFF_X36_Y15_N31
\inst|c1|divide_clock|count[13]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(13));

-- Location: LCFF_X36_Y15_N1
\inst|c1|divide_clock|count[14]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(14));

-- Location: LCFF_X37_Y15_N31
\inst|c1|divide_clock|count[15]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(15));

-- Location: LCCOMB_X36_Y15_N10
\inst|c1|divide_clock|Equal0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Equal0~3_combout\ = (\inst|c1|divide_clock|count\(12) & (\inst|c1|divide_clock|count\(14) & (\inst|c1|divide_clock|count\(13) & !\inst|c1|divide_clock|count\(15))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(12),
	datab => \inst|c1|divide_clock|count\(14),
	datac => \inst|c1|divide_clock|count\(13),
	datad => \inst|c1|divide_clock|count\(15),
	combout => \inst|c1|divide_clock|Equal0~3_combout\);

-- Location: LCCOMB_X36_Y15_N4
\inst|c1|divide_clock|Equal0~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Equal0~4_combout\ = (\inst|c1|divide_clock|Equal0~3_combout\ & (\inst|c1|divide_clock|Equal0~2_combout\ & (\inst|c1|divide_clock|Equal0~1_combout\ & \inst|c1|divide_clock|Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|Equal0~3_combout\,
	datab => \inst|c1|divide_clock|Equal0~2_combout\,
	datac => \inst|c1|divide_clock|Equal0~1_combout\,
	datad => \inst|c1|divide_clock|Equal0~0_combout\,
	combout => \inst|c1|divide_clock|Equal0~4_combout\);

-- Location: LCFF_X36_Y14_N7
\inst|c1|divide_clock|count[16]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(16));

-- Location: LCFF_X36_Y14_N25
\inst|c1|divide_clock|count[18]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(18));

-- Location: LCFF_X36_Y14_N13
\inst|c1|divide_clock|count[19]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(19));

-- Location: LCFF_X37_Y14_N3
\inst|c1|divide_clock|count[17]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~34_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(17));

-- Location: LCCOMB_X36_Y14_N0
\inst|c1|divide_clock|Equal0~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Equal0~5_combout\ = (\inst|c1|divide_clock|count\(19) & (\inst|c1|divide_clock|count\(16) & (\inst|c1|divide_clock|count\(18) & !\inst|c1|divide_clock|count\(17))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(19),
	datab => \inst|c1|divide_clock|count\(16),
	datac => \inst|c1|divide_clock|count\(18),
	datad => \inst|c1|divide_clock|count\(17),
	combout => \inst|c1|divide_clock|Equal0~5_combout\);

-- Location: LCFF_X36_Y14_N19
\inst|c1|divide_clock|count[20]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(20));

-- Location: LCFF_X36_Y14_N29
\inst|c1|divide_clock|count[21]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(21));

-- Location: LCFF_X36_Y14_N23
\inst|c1|divide_clock|count[22]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(22));

-- Location: LCFF_X37_Y14_N15
\inst|c1|divide_clock|count[23]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(23));

-- Location: LCCOMB_X36_Y14_N8
\inst|c1|divide_clock|Equal0~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Equal0~6_combout\ = (\inst|c1|divide_clock|count\(21) & (\inst|c1|divide_clock|count\(22) & (!\inst|c1|divide_clock|count\(23) & \inst|c1|divide_clock|count\(20))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(21),
	datab => \inst|c1|divide_clock|count\(22),
	datac => \inst|c1|divide_clock|count\(23),
	datad => \inst|c1|divide_clock|count\(20),
	combout => \inst|c1|divide_clock|Equal0~6_combout\);

-- Location: LCFF_X36_Y15_N7
\inst|c1|divide_clock|count[24]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|count~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(24));

-- Location: LCFF_X37_Y14_N19
\inst|c1|divide_clock|count[25]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~50_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(25));

-- Location: LCFF_X37_Y14_N21
\inst|c1|divide_clock|count[26]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~52_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(26));

-- Location: LCFF_X37_Y14_N23
\inst|c1|divide_clock|count[27]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~54_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(27));

-- Location: LCCOMB_X36_Y15_N16
\inst|c1|divide_clock|Equal0~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Equal0~7_combout\ = (\inst|c1|divide_clock|count\(24) & (!\inst|c1|divide_clock|count\(25) & (!\inst|c1|divide_clock|count\(26) & !\inst|c1|divide_clock|count\(27))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(24),
	datab => \inst|c1|divide_clock|count\(25),
	datac => \inst|c1|divide_clock|count\(26),
	datad => \inst|c1|divide_clock|count\(27),
	combout => \inst|c1|divide_clock|Equal0~7_combout\);

-- Location: LCFF_X37_Y14_N29
\inst|c1|divide_clock|count[30]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~60_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(30));

-- Location: LCFF_X37_Y14_N31
\inst|c1|divide_clock|count[31]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~62_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(31));

-- Location: LCCOMB_X36_Y15_N26
\inst|c1|divide_clock|Equal0~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Equal0~8_combout\ = (!\inst|c1|divide_clock|count\(31) & !\inst|c1|divide_clock|count\(30))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|divide_clock|count\(31),
	datad => \inst|c1|divide_clock|count\(30),
	combout => \inst|c1|divide_clock|Equal0~8_combout\);

-- Location: LCFF_X37_Y14_N25
\inst|c1|divide_clock|count[28]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~56_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(28));

-- Location: LCFF_X37_Y14_N27
\inst|c1|divide_clock|count[29]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|c1|divide_clock|Add0~58_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|divide_clock|count\(29));

-- Location: LCCOMB_X36_Y15_N28
\inst|c1|divide_clock|Equal0~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Equal0~9_combout\ = (!\inst|c1|divide_clock|count\(28) & (!\inst|c1|divide_clock|count\(29) & (\inst|c1|divide_clock|Equal0~7_combout\ & \inst|c1|divide_clock|Equal0~8_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|count\(28),
	datab => \inst|c1|divide_clock|count\(29),
	datac => \inst|c1|divide_clock|Equal0~7_combout\,
	datad => \inst|c1|divide_clock|Equal0~8_combout\,
	combout => \inst|c1|divide_clock|Equal0~9_combout\);

-- Location: LCCOMB_X36_Y15_N22
\inst|c1|divide_clock|Equal0~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|Equal0~10_combout\ = (\inst|c1|divide_clock|Equal0~6_combout\ & (\inst|c1|divide_clock|Equal0~5_combout\ & (\inst|c1|divide_clock|Equal0~4_combout\ & \inst|c1|divide_clock|Equal0~9_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|divide_clock|Equal0~6_combout\,
	datab => \inst|c1|divide_clock|Equal0~5_combout\,
	datac => \inst|c1|divide_clock|Equal0~4_combout\,
	datad => \inst|c1|divide_clock|Equal0~9_combout\,
	combout => \inst|c1|divide_clock|Equal0~10_combout\);

-- Location: LCCOMB_X36_Y14_N2
\inst|c1|divide_clock|clk_out~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|clk_out~0_combout\ = \inst|c1|divide_clock|clk_out~regout\ $ (\inst|c1|divide_clock|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|divide_clock|clk_out~regout\,
	datad => \inst|c1|divide_clock|Equal0~10_combout\,
	combout => \inst|c1|divide_clock|clk_out~0_combout\);

-- Location: LCFF_X44_Y27_N19
\inst|next_state.STATE_30\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector45~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_30~regout\);

-- Location: LCCOMB_X44_Y27_N10
\inst|now_state~110\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~110_combout\ = (\inst|next_state.STATE_30~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.STATE_30~regout\,
	datac => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~110_combout\);

-- Location: LCFF_X44_Y27_N13
\inst|next_state.STATE_31\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector46~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_31~regout\);

-- Location: LCFF_X47_Y26_N7
\inst|next_state.STATE_12\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector27~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_12~regout\);

-- Location: LCFF_X47_Y26_N13
\inst|next_state.STATE_4\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector19~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_4~regout\);

-- Location: LCCOMB_X35_Y28_N12
\inst|count_clk~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|count_clk~1_combout\ = (\inst|Add0~10_combout\ & !\inst|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|Add0~10_combout\,
	datad => \inst|Equal0~10_combout\,
	combout => \inst|count_clk~1_combout\);

-- Location: LCCOMB_X35_Y28_N6
\inst|count_clk~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|count_clk~2_combout\ = (\inst|Add0~12_combout\ & !\inst|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|Add0~12_combout\,
	datad => \inst|Equal0~10_combout\,
	combout => \inst|count_clk~2_combout\);

-- Location: LCCOMB_X46_Y27_N10
\inst|Selector49~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector49~0_combout\ = ((\inst|next_state.INITIAL_2~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\)))) # (!\inst|now_state.INITIAL_START~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.INITIAL_START~regout\,
	datac => \inst|next_state.INITIAL_2~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector49~0_combout\);

-- Location: LCCOMB_X46_Y27_N4
\inst|Selector50~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector50~0_combout\ = (\inst|now_state.INITIAL_2~regout\) # ((\inst|next_state.INITIAL_3~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.INITIAL_2~regout\,
	datab => \inst|now_state.TOGGLE_E~regout\,
	datac => \inst|next_state.INITIAL_3~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector50~0_combout\);

-- Location: LCCOMB_X45_Y27_N14
\inst|Selector15~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector15~0_combout\ = (\inst|now_state.DISP_OFF~regout\) # ((\inst|next_state.CLEAR~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.DISP_OFF~regout\,
	datab => \inst|now_state.WAITUP~regout\,
	datac => \inst|next_state.CLEAR~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector15~0_combout\);

-- Location: LCCOMB_X36_Y15_N8
\inst|c1|divide_clock|count~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~0_combout\ = (\inst|c1|divide_clock|Add0~12_combout\ & !\inst|c1|divide_clock|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|divide_clock|Add0~12_combout\,
	datad => \inst|c1|divide_clock|Equal0~10_combout\,
	combout => \inst|c1|divide_clock|count~0_combout\);

-- Location: LCCOMB_X36_Y15_N14
\inst|c1|divide_clock|count~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~1_combout\ = (!\inst|c1|divide_clock|Equal0~10_combout\ & \inst|c1|divide_clock|Add0~22_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|Equal0~10_combout\,
	datad => \inst|c1|divide_clock|Add0~22_combout\,
	combout => \inst|c1|divide_clock|count~1_combout\);

-- Location: LCCOMB_X36_Y15_N24
\inst|c1|divide_clock|count~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~2_combout\ = (\inst|c1|divide_clock|Add0~0_combout\ & !\inst|c1|divide_clock|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|divide_clock|Add0~0_combout\,
	datad => \inst|c1|divide_clock|Equal0~10_combout\,
	combout => \inst|c1|divide_clock|count~2_combout\);

-- Location: LCCOMB_X36_Y15_N12
\inst|c1|divide_clock|count~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~3_combout\ = (!\inst|c1|divide_clock|Equal0~10_combout\ & \inst|c1|divide_clock|Add0~24_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|Equal0~10_combout\,
	datad => \inst|c1|divide_clock|Add0~24_combout\,
	combout => \inst|c1|divide_clock|count~3_combout\);

-- Location: LCCOMB_X36_Y15_N30
\inst|c1|divide_clock|count~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~4_combout\ = (\inst|c1|divide_clock|Add0~26_combout\ & !\inst|c1|divide_clock|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|divide_clock|Add0~26_combout\,
	datad => \inst|c1|divide_clock|Equal0~10_combout\,
	combout => \inst|c1|divide_clock|count~4_combout\);

-- Location: LCCOMB_X36_Y15_N0
\inst|c1|divide_clock|count~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~5_combout\ = (!\inst|c1|divide_clock|Equal0~10_combout\ & \inst|c1|divide_clock|Add0~28_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|Equal0~10_combout\,
	datad => \inst|c1|divide_clock|Add0~28_combout\,
	combout => \inst|c1|divide_clock|count~5_combout\);

-- Location: LCCOMB_X36_Y14_N6
\inst|c1|divide_clock|count~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~6_combout\ = (\inst|c1|divide_clock|Add0~32_combout\ & !\inst|c1|divide_clock|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|divide_clock|Add0~32_combout\,
	datad => \inst|c1|divide_clock|Equal0~10_combout\,
	combout => \inst|c1|divide_clock|count~6_combout\);

-- Location: LCCOMB_X36_Y14_N24
\inst|c1|divide_clock|count~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~7_combout\ = (!\inst|c1|divide_clock|Equal0~10_combout\ & \inst|c1|divide_clock|Add0~36_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|Equal0~10_combout\,
	datad => \inst|c1|divide_clock|Add0~36_combout\,
	combout => \inst|c1|divide_clock|count~7_combout\);

-- Location: LCCOMB_X36_Y14_N12
\inst|c1|divide_clock|count~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~8_combout\ = (!\inst|c1|divide_clock|Equal0~10_combout\ & \inst|c1|divide_clock|Add0~38_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|divide_clock|Equal0~10_combout\,
	datad => \inst|c1|divide_clock|Add0~38_combout\,
	combout => \inst|c1|divide_clock|count~8_combout\);

-- Location: LCCOMB_X36_Y14_N18
\inst|c1|divide_clock|count~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~9_combout\ = (\inst|c1|divide_clock|Add0~40_combout\ & !\inst|c1|divide_clock|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|divide_clock|Add0~40_combout\,
	datad => \inst|c1|divide_clock|Equal0~10_combout\,
	combout => \inst|c1|divide_clock|count~9_combout\);

-- Location: LCCOMB_X36_Y14_N28
\inst|c1|divide_clock|count~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~10_combout\ = (\inst|c1|divide_clock|Add0~42_combout\ & !\inst|c1|divide_clock|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|divide_clock|Add0~42_combout\,
	datad => \inst|c1|divide_clock|Equal0~10_combout\,
	combout => \inst|c1|divide_clock|count~10_combout\);

-- Location: LCCOMB_X36_Y14_N22
\inst|c1|divide_clock|count~11\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~11_combout\ = (\inst|c1|divide_clock|Add0~44_combout\ & !\inst|c1|divide_clock|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|divide_clock|Add0~44_combout\,
	datad => \inst|c1|divide_clock|Equal0~10_combout\,
	combout => \inst|c1|divide_clock|count~11_combout\);

-- Location: LCCOMB_X36_Y15_N6
\inst|c1|divide_clock|count~12\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|divide_clock|count~12_combout\ = (\inst|c1|divide_clock|Add0~48_combout\ & !\inst|c1|divide_clock|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|divide_clock|Add0~48_combout\,
	datad => \inst|c1|divide_clock|Equal0~10_combout\,
	combout => \inst|c1|divide_clock|count~12_combout\);

-- Location: LCCOMB_X44_Y27_N18
\inst|Selector45~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector45~0_combout\ = (\inst|now_state.STATE_29~regout\) # ((\inst|next_state.STATE_30~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_29~regout\,
	datac => \inst|next_state.STATE_30~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector45~0_combout\);

-- Location: LCCOMB_X44_Y27_N12
\inst|Selector46~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector46~0_combout\ = (\inst|now_state.STATE_30~regout\) # ((\inst|next_state.STATE_31~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_30~regout\,
	datac => \inst|next_state.STATE_31~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector46~0_combout\);

-- Location: LCCOMB_X47_Y26_N6
\inst|Selector27~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector27~0_combout\ = (\inst|now_state.STATE_11~regout\) # ((\inst|next_state.STATE_12~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_11~regout\,
	datab => \inst|now_state.TOGGLE_E~regout\,
	datac => \inst|next_state.STATE_12~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector27~0_combout\);

-- Location: LCCOMB_X47_Y26_N12
\inst|Selector19~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector19~0_combout\ = (\inst|now_state.STATE_3~regout\) # ((\inst|next_state.STATE_4~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.STATE_3~regout\,
	datac => \inst|next_state.STATE_4~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector19~0_combout\);

-- Location: CLKCTRL_G12
\inst|c1|divide_clock|clk_out~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \inst|c1|divide_clock|clk_out~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\);

-- Location: PIN_N2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\CLOCK_50~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_CLOCK_50,
	combout => \CLOCK_50~combout\);

-- Location: CLKCTRL_G2
\CLOCK_50~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \CLOCK_50~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \CLOCK_50~clkctrl_outclk\);

-- Location: LCCOMB_X35_Y28_N28
\inst|count_clk~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|count_clk~8_combout\ = (\inst|Add0~36_combout\ & !\inst|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Add0~36_combout\,
	datad => \inst|Equal0~10_combout\,
	combout => \inst|count_clk~8_combout\);

-- Location: LCFF_X35_Y28_N29
\inst|count_clk[18]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|count_clk~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(18));

-- Location: LCCOMB_X34_Y29_N0
\inst|Add0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~0_combout\ = \inst|count_clk\(0) $ (VCC)
-- \inst|Add0~1\ = CARRY(\inst|count_clk\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(0),
	datad => VCC,
	combout => \inst|Add0~0_combout\,
	cout => \inst|Add0~1\);

-- Location: LCCOMB_X35_Y28_N10
\inst|count_clk~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|count_clk~0_combout\ = (\inst|Add0~0_combout\ & !\inst|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|Add0~0_combout\,
	datad => \inst|Equal0~10_combout\,
	combout => \inst|count_clk~0_combout\);

-- Location: LCFF_X35_Y28_N11
\inst|count_clk[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|count_clk~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(0));

-- Location: LCCOMB_X34_Y29_N2
\inst|Add0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~2_combout\ = (\inst|count_clk\(1) & (!\inst|Add0~1\)) # (!\inst|count_clk\(1) & ((\inst|Add0~1\) # (GND)))
-- \inst|Add0~3\ = CARRY((!\inst|Add0~1\) # (!\inst|count_clk\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(1),
	datad => VCC,
	cin => \inst|Add0~1\,
	combout => \inst|Add0~2_combout\,
	cout => \inst|Add0~3\);

-- Location: LCFF_X34_Y29_N3
\inst|count_clk[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(1));

-- Location: LCCOMB_X34_Y29_N4
\inst|Add0~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~4_combout\ = (\inst|count_clk\(2) & (\inst|Add0~3\ $ (GND))) # (!\inst|count_clk\(2) & (!\inst|Add0~3\ & VCC))
-- \inst|Add0~5\ = CARRY((\inst|count_clk\(2) & !\inst|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(2),
	datad => VCC,
	cin => \inst|Add0~3\,
	combout => \inst|Add0~4_combout\,
	cout => \inst|Add0~5\);

-- Location: LCFF_X34_Y29_N5
\inst|count_clk[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(2));

-- Location: LCCOMB_X34_Y29_N8
\inst|Add0~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~8_combout\ = (\inst|count_clk\(4) & (\inst|Add0~7\ $ (GND))) # (!\inst|count_clk\(4) & (!\inst|Add0~7\ & VCC))
-- \inst|Add0~9\ = CARRY((\inst|count_clk\(4) & !\inst|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(4),
	datad => VCC,
	cin => \inst|Add0~7\,
	combout => \inst|Add0~8_combout\,
	cout => \inst|Add0~9\);

-- Location: LCFF_X34_Y29_N9
\inst|count_clk[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(4));

-- Location: LCCOMB_X34_Y29_N14
\inst|Add0~14\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~14_combout\ = (\inst|count_clk\(7) & (!\inst|Add0~13\)) # (!\inst|count_clk\(7) & ((\inst|Add0~13\) # (GND)))
-- \inst|Add0~15\ = CARRY((!\inst|Add0~13\) # (!\inst|count_clk\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(7),
	datad => VCC,
	cin => \inst|Add0~13\,
	combout => \inst|Add0~14_combout\,
	cout => \inst|Add0~15\);

-- Location: LCFF_X34_Y29_N15
\inst|count_clk[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(7));

-- Location: LCCOMB_X34_Y29_N16
\inst|Add0~16\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~16_combout\ = (\inst|count_clk\(8) & (\inst|Add0~15\ $ (GND))) # (!\inst|count_clk\(8) & (!\inst|Add0~15\ & VCC))
-- \inst|Add0~17\ = CARRY((\inst|count_clk\(8) & !\inst|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(8),
	datad => VCC,
	cin => \inst|Add0~15\,
	combout => \inst|Add0~16_combout\,
	cout => \inst|Add0~17\);

-- Location: LCCOMB_X34_Y29_N18
\inst|Add0~18\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~18_combout\ = (\inst|count_clk\(9) & (!\inst|Add0~17\)) # (!\inst|count_clk\(9) & ((\inst|Add0~17\) # (GND)))
-- \inst|Add0~19\ = CARRY((!\inst|Add0~17\) # (!\inst|count_clk\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(9),
	datad => VCC,
	cin => \inst|Add0~17\,
	combout => \inst|Add0~18_combout\,
	cout => \inst|Add0~19\);

-- Location: LCFF_X34_Y29_N19
\inst|count_clk[9]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(9));

-- Location: LCCOMB_X34_Y29_N20
\inst|Add0~20\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~20_combout\ = (\inst|count_clk\(10) & (\inst|Add0~19\ $ (GND))) # (!\inst|count_clk\(10) & (!\inst|Add0~19\ & VCC))
-- \inst|Add0~21\ = CARRY((\inst|count_clk\(10) & !\inst|Add0~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(10),
	datad => VCC,
	cin => \inst|Add0~19\,
	combout => \inst|Add0~20_combout\,
	cout => \inst|Add0~21\);

-- Location: LCCOMB_X34_Y29_N22
\inst|Add0~22\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~22_combout\ = (\inst|count_clk\(11) & (!\inst|Add0~21\)) # (!\inst|count_clk\(11) & ((\inst|Add0~21\) # (GND)))
-- \inst|Add0~23\ = CARRY((!\inst|Add0~21\) # (!\inst|count_clk\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(11),
	datad => VCC,
	cin => \inst|Add0~21\,
	combout => \inst|Add0~22_combout\,
	cout => \inst|Add0~23\);

-- Location: LCCOMB_X35_Y29_N0
\inst|count_clk~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|count_clk~4_combout\ = (\inst|Add0~22_combout\ & !\inst|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|Add0~22_combout\,
	datad => \inst|Equal0~10_combout\,
	combout => \inst|count_clk~4_combout\);

-- Location: LCFF_X35_Y29_N1
\inst|count_clk[11]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|count_clk~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(11));

-- Location: LCCOMB_X34_Y29_N26
\inst|Add0~26\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~26_combout\ = (\inst|count_clk\(13) & (!\inst|Add0~25\)) # (!\inst|count_clk\(13) & ((\inst|Add0~25\) # (GND)))
-- \inst|Add0~27\ = CARRY((!\inst|Add0~25\) # (!\inst|count_clk\(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(13),
	datad => VCC,
	cin => \inst|Add0~25\,
	combout => \inst|Add0~26_combout\,
	cout => \inst|Add0~27\);

-- Location: LCFF_X34_Y29_N27
\inst|count_clk[13]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(13));

-- Location: LCCOMB_X34_Y29_N28
\inst|Add0~28\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~28_combout\ = (\inst|count_clk\(14) & (\inst|Add0~27\ $ (GND))) # (!\inst|count_clk\(14) & (!\inst|Add0~27\ & VCC))
-- \inst|Add0~29\ = CARRY((\inst|count_clk\(14) & !\inst|Add0~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(14),
	datad => VCC,
	cin => \inst|Add0~27\,
	combout => \inst|Add0~28_combout\,
	cout => \inst|Add0~29\);

-- Location: LCCOMB_X35_Y29_N18
\inst|count_clk~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|count_clk~5_combout\ = (\inst|Add0~28_combout\ & !\inst|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|Add0~28_combout\,
	datad => \inst|Equal0~10_combout\,
	combout => \inst|count_clk~5_combout\);

-- Location: LCFF_X35_Y29_N19
\inst|count_clk[14]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|count_clk~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(14));

-- Location: LCCOMB_X34_Y29_N30
\inst|Add0~30\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~30_combout\ = (\inst|count_clk\(15) & (!\inst|Add0~29\)) # (!\inst|count_clk\(15) & ((\inst|Add0~29\) # (GND)))
-- \inst|Add0~31\ = CARRY((!\inst|Add0~29\) # (!\inst|count_clk\(15)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(15),
	datad => VCC,
	cin => \inst|Add0~29\,
	combout => \inst|Add0~30_combout\,
	cout => \inst|Add0~31\);

-- Location: LCCOMB_X35_Y29_N28
\inst|count_clk~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|count_clk~6_combout\ = (\inst|Add0~30_combout\ & !\inst|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|Add0~30_combout\,
	datad => \inst|Equal0~10_combout\,
	combout => \inst|count_clk~6_combout\);

-- Location: LCFF_X35_Y29_N29
\inst|count_clk[15]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|count_clk~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(15));

-- Location: LCCOMB_X34_Y28_N0
\inst|Add0~32\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~32_combout\ = (\inst|count_clk\(16) & (\inst|Add0~31\ $ (GND))) # (!\inst|count_clk\(16) & (!\inst|Add0~31\ & VCC))
-- \inst|Add0~33\ = CARRY((\inst|count_clk\(16) & !\inst|Add0~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(16),
	datad => VCC,
	cin => \inst|Add0~31\,
	combout => \inst|Add0~32_combout\,
	cout => \inst|Add0~33\);

-- Location: LCCOMB_X35_Y28_N18
\inst|count_clk~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|count_clk~7_combout\ = (\inst|Add0~32_combout\ & !\inst|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|Add0~32_combout\,
	datad => \inst|Equal0~10_combout\,
	combout => \inst|count_clk~7_combout\);

-- Location: LCFF_X35_Y28_N19
\inst|count_clk[16]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|count_clk~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(16));

-- Location: LCCOMB_X34_Y28_N2
\inst|Add0~34\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~34_combout\ = (\inst|count_clk\(17) & (!\inst|Add0~33\)) # (!\inst|count_clk\(17) & ((\inst|Add0~33\) # (GND)))
-- \inst|Add0~35\ = CARRY((!\inst|Add0~33\) # (!\inst|count_clk\(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(17),
	datad => VCC,
	cin => \inst|Add0~33\,
	combout => \inst|Add0~34_combout\,
	cout => \inst|Add0~35\);

-- Location: LCFF_X34_Y28_N3
\inst|count_clk[17]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~34_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(17));

-- Location: LCCOMB_X34_Y28_N6
\inst|Add0~38\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~38_combout\ = (\inst|count_clk\(19) & (!\inst|Add0~37\)) # (!\inst|count_clk\(19) & ((\inst|Add0~37\) # (GND)))
-- \inst|Add0~39\ = CARRY((!\inst|Add0~37\) # (!\inst|count_clk\(19)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(19),
	datad => VCC,
	cin => \inst|Add0~37\,
	combout => \inst|Add0~38_combout\,
	cout => \inst|Add0~39\);

-- Location: LCCOMB_X34_Y28_N8
\inst|Add0~40\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~40_combout\ = (\inst|count_clk\(20) & (\inst|Add0~39\ $ (GND))) # (!\inst|count_clk\(20) & (!\inst|Add0~39\ & VCC))
-- \inst|Add0~41\ = CARRY((\inst|count_clk\(20) & !\inst|Add0~39\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(20),
	datad => VCC,
	cin => \inst|Add0~39\,
	combout => \inst|Add0~40_combout\,
	cout => \inst|Add0~41\);

-- Location: LCFF_X34_Y28_N9
\inst|count_clk[20]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~40_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(20));

-- Location: LCCOMB_X34_Y28_N14
\inst|Add0~46\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~46_combout\ = (\inst|count_clk\(23) & (!\inst|Add0~45\)) # (!\inst|count_clk\(23) & ((\inst|Add0~45\) # (GND)))
-- \inst|Add0~47\ = CARRY((!\inst|Add0~45\) # (!\inst|count_clk\(23)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(23),
	datad => VCC,
	cin => \inst|Add0~45\,
	combout => \inst|Add0~46_combout\,
	cout => \inst|Add0~47\);

-- Location: LCFF_X34_Y28_N15
\inst|count_clk[23]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~46_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(23));

-- Location: LCCOMB_X34_Y28_N16
\inst|Add0~48\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~48_combout\ = (\inst|count_clk\(24) & (\inst|Add0~47\ $ (GND))) # (!\inst|count_clk\(24) & (!\inst|Add0~47\ & VCC))
-- \inst|Add0~49\ = CARRY((\inst|count_clk\(24) & !\inst|Add0~47\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(24),
	datad => VCC,
	cin => \inst|Add0~47\,
	combout => \inst|Add0~48_combout\,
	cout => \inst|Add0~49\);

-- Location: LCCOMB_X34_Y28_N18
\inst|Add0~50\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~50_combout\ = (\inst|count_clk\(25) & (!\inst|Add0~49\)) # (!\inst|count_clk\(25) & ((\inst|Add0~49\) # (GND)))
-- \inst|Add0~51\ = CARRY((!\inst|Add0~49\) # (!\inst|count_clk\(25)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(25),
	datad => VCC,
	cin => \inst|Add0~49\,
	combout => \inst|Add0~50_combout\,
	cout => \inst|Add0~51\);

-- Location: LCFF_X34_Y28_N19
\inst|count_clk[25]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~50_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(25));

-- Location: LCCOMB_X34_Y28_N20
\inst|Add0~52\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~52_combout\ = (\inst|count_clk\(26) & (\inst|Add0~51\ $ (GND))) # (!\inst|count_clk\(26) & (!\inst|Add0~51\ & VCC))
-- \inst|Add0~53\ = CARRY((\inst|count_clk\(26) & !\inst|Add0~51\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(26),
	datad => VCC,
	cin => \inst|Add0~51\,
	combout => \inst|Add0~52_combout\,
	cout => \inst|Add0~53\);

-- Location: LCCOMB_X34_Y28_N22
\inst|Add0~54\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~54_combout\ = (\inst|count_clk\(27) & (!\inst|Add0~53\)) # (!\inst|count_clk\(27) & ((\inst|Add0~53\) # (GND)))
-- \inst|Add0~55\ = CARRY((!\inst|Add0~53\) # (!\inst|count_clk\(27)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(27),
	datad => VCC,
	cin => \inst|Add0~53\,
	combout => \inst|Add0~54_combout\,
	cout => \inst|Add0~55\);

-- Location: LCFF_X34_Y28_N23
\inst|count_clk[27]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~54_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(27));

-- Location: LCCOMB_X34_Y28_N24
\inst|Add0~56\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~56_combout\ = (\inst|count_clk\(28) & (\inst|Add0~55\ $ (GND))) # (!\inst|count_clk\(28) & (!\inst|Add0~55\ & VCC))
-- \inst|Add0~57\ = CARRY((\inst|count_clk\(28) & !\inst|Add0~55\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(28),
	datad => VCC,
	cin => \inst|Add0~55\,
	combout => \inst|Add0~56_combout\,
	cout => \inst|Add0~57\);

-- Location: LCCOMB_X34_Y28_N26
\inst|Add0~58\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~58_combout\ = (\inst|count_clk\(29) & (!\inst|Add0~57\)) # (!\inst|count_clk\(29) & ((\inst|Add0~57\) # (GND)))
-- \inst|Add0~59\ = CARRY((!\inst|Add0~57\) # (!\inst|count_clk\(29)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(29),
	datad => VCC,
	cin => \inst|Add0~57\,
	combout => \inst|Add0~58_combout\,
	cout => \inst|Add0~59\);

-- Location: LCFF_X34_Y28_N27
\inst|count_clk[29]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~58_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(29));

-- Location: LCCOMB_X34_Y28_N28
\inst|Add0~60\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~60_combout\ = (\inst|count_clk\(30) & (\inst|Add0~59\ $ (GND))) # (!\inst|count_clk\(30) & (!\inst|Add0~59\ & VCC))
-- \inst|Add0~61\ = CARRY((\inst|count_clk\(30) & !\inst|Add0~59\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|count_clk\(30),
	datad => VCC,
	cin => \inst|Add0~59\,
	combout => \inst|Add0~60_combout\,
	cout => \inst|Add0~61\);

-- Location: LCFF_X34_Y28_N29
\inst|count_clk[30]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~60_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(30));

-- Location: LCCOMB_X34_Y28_N30
\inst|Add0~62\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Add0~62_combout\ = \inst|Add0~61\ $ (\inst|count_clk\(31))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \inst|count_clk\(31),
	cin => \inst|Add0~61\,
	combout => \inst|Add0~62_combout\);

-- Location: LCFF_X34_Y28_N31
\inst|count_clk[31]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~62_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(31));

-- Location: LCFF_X34_Y28_N25
\inst|count_clk[28]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~56_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(28));

-- Location: LCCOMB_X35_Y28_N20
\inst|Equal0~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Equal0~8_combout\ = (!\inst|count_clk\(30) & (!\inst|count_clk\(29) & (!\inst|count_clk\(31) & !\inst|count_clk\(28))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(30),
	datab => \inst|count_clk\(29),
	datac => \inst|count_clk\(31),
	datad => \inst|count_clk\(28),
	combout => \inst|Equal0~8_combout\);

-- Location: LCFF_X34_Y28_N17
\inst|count_clk[24]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~48_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(24));

-- Location: LCFF_X34_Y28_N21
\inst|count_clk[26]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~52_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(26));

-- Location: LCCOMB_X35_Y28_N2
\inst|Equal0~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Equal0~7_combout\ = (!\inst|count_clk\(27) & (!\inst|count_clk\(24) & (!\inst|count_clk\(26) & !\inst|count_clk\(25))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(27),
	datab => \inst|count_clk\(24),
	datac => \inst|count_clk\(26),
	datad => \inst|count_clk\(25),
	combout => \inst|Equal0~7_combout\);

-- Location: LCCOMB_X35_Y28_N30
\inst|Equal0~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Equal0~9_combout\ = (\inst|Equal0~8_combout\ & \inst|Equal0~7_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|Equal0~8_combout\,
	datad => \inst|Equal0~7_combout\,
	combout => \inst|Equal0~9_combout\);

-- Location: LCCOMB_X33_Y29_N16
\inst|Equal0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Equal0~0_combout\ = (!\inst|count_clk\(3) & (!\inst|count_clk\(1) & (!\inst|count_clk\(0) & !\inst|count_clk\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(3),
	datab => \inst|count_clk\(1),
	datac => \inst|count_clk\(0),
	datad => \inst|count_clk\(2),
	combout => \inst|Equal0~0_combout\);

-- Location: LCFF_X34_Y29_N17
\inst|count_clk[8]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(8));

-- Location: LCCOMB_X35_Y28_N26
\inst|count_clk~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|count_clk~3_combout\ = (\inst|Add0~20_combout\ & !\inst|Equal0~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|Add0~20_combout\,
	datad => \inst|Equal0~10_combout\,
	combout => \inst|count_clk~3_combout\);

-- Location: LCFF_X35_Y28_N27
\inst|count_clk[10]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|count_clk~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(10));

-- Location: LCCOMB_X35_Y28_N4
\inst|Equal0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Equal0~2_combout\ = (!\inst|count_clk\(9) & (!\inst|count_clk\(8) & (\inst|count_clk\(11) & \inst|count_clk\(10))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(9),
	datab => \inst|count_clk\(8),
	datac => \inst|count_clk\(11),
	datad => \inst|count_clk\(10),
	combout => \inst|Equal0~2_combout\);

-- Location: LCCOMB_X35_Y28_N14
\inst|Equal0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Equal0~3_combout\ = (!\inst|count_clk\(12) & (!\inst|count_clk\(13) & (\inst|count_clk\(14) & \inst|count_clk\(15))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(12),
	datab => \inst|count_clk\(13),
	datac => \inst|count_clk\(14),
	datad => \inst|count_clk\(15),
	combout => \inst|Equal0~3_combout\);

-- Location: LCCOMB_X35_Y28_N8
\inst|Equal0~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Equal0~4_combout\ = (\inst|Equal0~1_combout\ & (\inst|Equal0~0_combout\ & (\inst|Equal0~2_combout\ & \inst|Equal0~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal0~1_combout\,
	datab => \inst|Equal0~0_combout\,
	datac => \inst|Equal0~2_combout\,
	datad => \inst|Equal0~3_combout\,
	combout => \inst|Equal0~4_combout\);

-- Location: LCFF_X34_Y28_N7
\inst|count_clk[19]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Add0~38_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|count_clk\(19));

-- Location: LCCOMB_X35_Y28_N22
\inst|Equal0~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Equal0~5_combout\ = (!\inst|count_clk\(17) & (\inst|count_clk\(18) & (!\inst|count_clk\(19) & \inst|count_clk\(16))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|count_clk\(17),
	datab => \inst|count_clk\(18),
	datac => \inst|count_clk\(19),
	datad => \inst|count_clk\(16),
	combout => \inst|Equal0~5_combout\);

-- Location: LCCOMB_X35_Y28_N0
\inst|Equal0~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Equal0~10_combout\ = (\inst|Equal0~6_combout\ & (\inst|Equal0~9_combout\ & (\inst|Equal0~4_combout\ & \inst|Equal0~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal0~6_combout\,
	datab => \inst|Equal0~9_combout\,
	datac => \inst|Equal0~4_combout\,
	datad => \inst|Equal0~5_combout\,
	combout => \inst|Equal0~10_combout\);

-- Location: LCFF_X35_Y28_N1
\inst|cntr_clk\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Equal0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|cntr_clk~regout\);

-- Location: LCFF_X48_Y28_N9
\inst|now_state.WAITUP\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	sdata => \inst|now_state.TOGGLE_E~regout\,
	sload => VCC,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.WAITUP~regout\);

-- Location: LCCOMB_X46_Y27_N6
\inst|WideOr2~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|WideOr2~5_combout\ = (!\inst|now_state.TOGGLE_E~regout\ & !\inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|now_state.TOGGLE_E~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|WideOr2~5_combout\);

-- Location: LCFF_X46_Y27_N7
\inst|now_state.TOGGLE_E\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|WideOr2~5_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.TOGGLE_E~regout\);

-- Location: LCCOMB_X44_Y27_N16
\inst|LCD_EN~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|LCD_EN~0_combout\ = (\inst|now_state.WAITUP~regout\ & (((\inst|LCD_EN~regout\)))) # (!\inst|now_state.WAITUP~regout\ & ((\inst|cntr_clk~regout\ & ((!\inst|now_state.TOGGLE_E~regout\))) # (!\inst|cntr_clk~regout\ & (\inst|LCD_EN~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|cntr_clk~regout\,
	datac => \inst|LCD_EN~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|LCD_EN~0_combout\);

-- Location: LCFF_X44_Y27_N17
\inst|LCD_EN\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|LCD_EN~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|LCD_EN~regout\);

-- Location: LCCOMB_X47_Y26_N28
\inst|now_state~118\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~118_combout\ = (\inst|next_state.STATE_12~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|next_state.STATE_12~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~118_combout\);

-- Location: LCFF_X47_Y26_N29
\inst|now_state.STATE_12\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~118_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_12~regout\);

-- Location: LCCOMB_X47_Y26_N20
\inst|Selector28~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector28~0_combout\ = (\inst|now_state.STATE_12~regout\) # ((\inst|next_state.STATE_13~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.STATE_12~regout\,
	datac => \inst|next_state.STATE_13~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector28~0_combout\);

-- Location: LCFF_X47_Y26_N21
\inst|next_state.STATE_13\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector28~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_13~regout\);

-- Location: LCCOMB_X47_Y26_N10
\inst|now_state~103\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~103_combout\ = (\inst|next_state.STATE_13~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_13~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~103_combout\);

-- Location: LCFF_X47_Y26_N11
\inst|now_state.STATE_13\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~103_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_13~regout\);

-- Location: LCCOMB_X47_Y27_N22
\inst|Selector29~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector29~0_combout\ = (\inst|now_state.STATE_13~regout\) # ((\inst|next_state.STATE_14~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.STATE_13~regout\,
	datac => \inst|next_state.STATE_14~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector29~0_combout\);

-- Location: LCFF_X47_Y27_N23
\inst|next_state.STATE_14\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector29~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_14~regout\);

-- Location: LCCOMB_X47_Y27_N28
\inst|now_state~104\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~104_combout\ = (\inst|next_state.STATE_14~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.STATE_14~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~104_combout\);

-- Location: LCFF_X47_Y27_N29
\inst|now_state.STATE_14\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~104_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_14~regout\);

-- Location: LCCOMB_X47_Y27_N0
\inst|Selector30~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector30~0_combout\ = (\inst|now_state.STATE_14~regout\) # ((\inst|next_state.STATE_15~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.STATE_14~regout\,
	datac => \inst|next_state.STATE_15~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector30~0_combout\);

-- Location: LCFF_X47_Y27_N1
\inst|next_state.STATE_15\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector30~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_15~regout\);

-- Location: LCCOMB_X47_Y27_N30
\inst|now_state~105\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~105_combout\ = (\inst|next_state.STATE_15~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_15~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~105_combout\);

-- Location: LCFF_X47_Y27_N31
\inst|now_state.STATE_15\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~105_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_15~regout\);

-- Location: LCCOMB_X47_Y27_N2
\inst|Selector31~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector31~0_combout\ = (\inst|now_state.STATE_15~regout\) # ((\inst|next_state.STATE_16~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.STATE_15~regout\,
	datac => \inst|next_state.STATE_16~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector31~0_combout\);

-- Location: LCFF_X47_Y27_N3
\inst|next_state.STATE_16\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector31~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_16~regout\);

-- Location: LCCOMB_X47_Y27_N8
\inst|now_state~106\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~106_combout\ = (\inst|next_state.STATE_16~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.STATE_16~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~106_combout\);

-- Location: LCFF_X47_Y27_N9
\inst|now_state.STATE_16\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~106_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_16~regout\);

-- Location: LCCOMB_X47_Y27_N26
\inst|Selector47~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector47~0_combout\ = (\inst|now_state.STATE_16~regout\) # ((\inst|next_state.LINE_2~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.STATE_16~regout\,
	datac => \inst|next_state.LINE_2~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector47~0_combout\);

-- Location: LCFF_X47_Y27_N27
\inst|next_state.LINE_2\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector47~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.LINE_2~regout\);

-- Location: LCCOMB_X47_Y27_N16
\inst|now_state~95\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~95_combout\ = (\inst|next_state.LINE_2~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.LINE_2~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~95_combout\);

-- Location: LCFF_X47_Y27_N17
\inst|now_state.LINE_2\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~95_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.LINE_2~regout\);

-- Location: LCCOMB_X45_Y27_N20
\inst|Selector13~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector13~0_combout\ = (\inst|now_state.DISP_ON~regout\) # ((\inst|next_state.MODE_SET~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.DISP_ON~regout\,
	datab => \inst|now_state.WAITUP~regout\,
	datac => \inst|next_state.MODE_SET~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector13~0_combout\);

-- Location: LCFF_X45_Y27_N21
\inst|next_state.MODE_SET\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector13~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.MODE_SET~regout\);

-- Location: LCCOMB_X45_Y27_N6
\inst|now_state~96\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~96_combout\ = (\inst|next_state.MODE_SET~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.MODE_SET~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~96_combout\);

-- Location: LCFF_X45_Y27_N7
\inst|now_state.MODE_SET\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~96_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.MODE_SET~regout\);

-- Location: LCCOMB_X48_Y27_N22
\inst|now_state~97\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~97_combout\ = (\inst|next_state.CLEAR~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|next_state.CLEAR~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~97_combout\);

-- Location: LCFF_X48_Y27_N23
\inst|now_state.CLEAR\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~97_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.CLEAR~regout\);

-- Location: LCCOMB_X48_Y27_N16
\inst|WideOr2~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|WideOr2~4_combout\ = (!\inst|now_state.HOME~regout\ & (!\inst|now_state.LINE_2~regout\ & (!\inst|now_state.MODE_SET~regout\ & !\inst|now_state.CLEAR~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.HOME~regout\,
	datab => \inst|now_state.LINE_2~regout\,
	datac => \inst|now_state.MODE_SET~regout\,
	datad => \inst|now_state.CLEAR~regout\,
	combout => \inst|WideOr2~4_combout\);

-- Location: LCCOMB_X46_Y27_N28
\inst|now_state~90\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~90_combout\ = (\inst|next_state.INITIAL_2~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|next_state.INITIAL_2~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~90_combout\);

-- Location: LCFF_X46_Y27_N29
\inst|now_state.INITIAL_2\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~90_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.INITIAL_2~regout\);

-- Location: LCCOMB_X46_Y27_N24
\inst|Selector12~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector12~0_combout\ = (\inst|now_state.INITIAL_3~regout\) # ((\inst|next_state.FUNC_SET~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.INITIAL_3~regout\,
	datab => \inst|now_state.TOGGLE_E~regout\,
	datac => \inst|next_state.FUNC_SET~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector12~0_combout\);

-- Location: LCFF_X46_Y27_N25
\inst|next_state.FUNC_SET\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector12~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.FUNC_SET~regout\);

-- Location: LCCOMB_X46_Y27_N26
\inst|now_state~89\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~89_combout\ = (\inst|next_state.FUNC_SET~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.FUNC_SET~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~89_combout\);

-- Location: LCFF_X46_Y27_N27
\inst|now_state.FUNC_SET\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~89_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.FUNC_SET~regout\);

-- Location: LCCOMB_X46_Y27_N22
\inst|next_state.INITIAL_START~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|next_state.INITIAL_START~0_combout\ = (\inst|next_state.INITIAL_START~regout\) # ((\inst|cntr_clk~regout\ & (!\inst|now_state.TOGGLE_E~regout\ & !\inst|now_state.WAITUP~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|cntr_clk~regout\,
	datab => \inst|now_state.TOGGLE_E~regout\,
	datac => \inst|next_state.INITIAL_START~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|next_state.INITIAL_START~0_combout\);

-- Location: LCFF_X46_Y27_N23
\inst|next_state.INITIAL_START\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|next_state.INITIAL_START~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.INITIAL_START~regout\);

-- Location: LCCOMB_X46_Y27_N0
\inst|now_state~88\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~88_combout\ = (\inst|next_state.INITIAL_START~regout\) # (!\inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.INITIAL_START~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~88_combout\);

-- Location: LCFF_X46_Y27_N1
\inst|now_state.INITIAL_START\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~88_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.INITIAL_START~regout\);

-- Location: LCCOMB_X46_Y27_N16
\inst|WideOr2~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|WideOr2~2_combout\ = (!\inst|now_state.INITIAL_3~regout\ & (!\inst|now_state.INITIAL_2~regout\ & (!\inst|now_state.FUNC_SET~regout\ & \inst|now_state.INITIAL_START~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.INITIAL_3~regout\,
	datab => \inst|now_state.INITIAL_2~regout\,
	datac => \inst|now_state.FUNC_SET~regout\,
	datad => \inst|now_state.INITIAL_START~regout\,
	combout => \inst|WideOr2~2_combout\);

-- Location: LCCOMB_X46_Y27_N14
\inst|Selector48~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector48~0_combout\ = (\inst|now_state.FUNC_SET~regout\) # ((\inst|next_state.DISP_OFF~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.FUNC_SET~regout\,
	datab => \inst|now_state.TOGGLE_E~regout\,
	datac => \inst|next_state.DISP_OFF~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector48~0_combout\);

-- Location: LCFF_X46_Y27_N15
\inst|next_state.DISP_OFF\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector48~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.DISP_OFF~regout\);

-- Location: LCCOMB_X46_Y27_N2
\inst|now_state~92\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~92_combout\ = (\inst|next_state.DISP_OFF~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.DISP_OFF~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~92_combout\);

-- Location: LCFF_X46_Y27_N3
\inst|now_state.DISP_OFF\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~92_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.DISP_OFF~regout\);

-- Location: LCCOMB_X48_Y27_N6
\inst|WideOr2~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|WideOr2~6_combout\ = (!\inst|now_state.DISP_ON~regout\ & (\inst|WideOr2~2_combout\ & !\inst|now_state.DISP_OFF~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.DISP_ON~regout\,
	datab => \inst|WideOr2~2_combout\,
	datac => \inst|now_state.DISP_OFF~regout\,
	combout => \inst|WideOr2~6_combout\);

-- Location: LCCOMB_X46_Y27_N8
\inst|Selector1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector1~0_combout\ = (\inst|WideOr2~5_combout\ & (\inst|WideOr2~4_combout\ & ((\inst|WideOr2~6_combout\)))) # (!\inst|WideOr2~5_combout\ & (((\inst|LCD_RS~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|WideOr2~5_combout\,
	datab => \inst|WideOr2~4_combout\,
	datac => \inst|LCD_RS~regout\,
	datad => \inst|WideOr2~6_combout\,
	combout => \inst|Selector1~0_combout\);

-- Location: LCFF_X46_Y27_N9
\inst|LCD_RS\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector1~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|LCD_RS~regout\);

-- Location: LCCOMB_X49_Y28_N0
\inst|c1|seclsb[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|seclsb[0]~0_combout\ = (\KEY~combout\(1) & !\inst|c1|seclsb\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KEY~combout\(1),
	datac => \inst|c1|seclsb\(0),
	combout => \inst|c1|seclsb[0]~0_combout\);

-- Location: LCFF_X49_Y28_N1
\inst|c1|seclsb[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|seclsb[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|seclsb\(0));

-- Location: PIN_N23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\KEY[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_KEY(1),
	combout => \KEY~combout\(1));

-- Location: LCCOMB_X50_Y28_N14
\inst|c1|seclsb[3]~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|seclsb[3]~3_combout\ = (!\KEY~combout\(1)) # (!\inst|c1|Equal0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|Equal0~0_combout\,
	datad => \KEY~combout\(1),
	combout => \inst|c1|seclsb[3]~3_combout\);

-- Location: LCCOMB_X49_Y28_N14
\inst|c1|Add0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|Add0~0_combout\ = (\inst|c1|seclsb\(0) & \inst|c1|seclsb\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|seclsb\(0),
	datad => \inst|c1|seclsb\(1),
	combout => \inst|c1|Add0~0_combout\);

-- Location: LCCOMB_X50_Y28_N24
\inst|c1|seclsb[3]~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|seclsb[3]~4_combout\ = (!\inst|c1|seclsb[3]~3_combout\ & (\inst|c1|seclsb\(3) $ (((\inst|c1|seclsb\(2) & \inst|c1|Add0~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|seclsb\(2),
	datab => \inst|c1|seclsb[3]~3_combout\,
	datac => \inst|c1|seclsb\(3),
	datad => \inst|c1|Add0~0_combout\,
	combout => \inst|c1|seclsb[3]~4_combout\);

-- Location: LCFF_X50_Y28_N25
\inst|c1|seclsb[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|seclsb[3]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|seclsb\(3));

-- Location: LCCOMB_X49_Y28_N4
\inst|c1|Equal0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|Equal0~0_combout\ = (\inst|c1|seclsb\(2)) # ((\inst|c1|seclsb\(1)) # ((!\inst|c1|seclsb\(0)) # (!\inst|c1|seclsb\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|seclsb\(2),
	datab => \inst|c1|seclsb\(1),
	datac => \inst|c1|seclsb\(3),
	datad => \inst|c1|seclsb\(0),
	combout => \inst|c1|Equal0~0_combout\);

-- Location: LCCOMB_X49_Y28_N26
\inst|c1|seclsb[1]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|seclsb[1]~1_combout\ = (\KEY~combout\(1) & (\inst|c1|Equal0~0_combout\ & (\inst|c1|seclsb\(0) $ (\inst|c1|seclsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KEY~combout\(1),
	datab => \inst|c1|seclsb\(0),
	datac => \inst|c1|seclsb\(1),
	datad => \inst|c1|Equal0~0_combout\,
	combout => \inst|c1|seclsb[1]~1_combout\);

-- Location: LCFF_X49_Y28_N27
\inst|c1|seclsb[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|seclsb[1]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|seclsb\(1));

-- Location: LCCOMB_X49_Y28_N12
\inst|c1|seclsb[2]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|seclsb[2]~2_combout\ = (\KEY~combout\(1) & (\inst|c1|Equal0~0_combout\ & (\inst|c1|Add0~0_combout\ $ (\inst|c1|seclsb\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KEY~combout\(1),
	datab => \inst|c1|Add0~0_combout\,
	datac => \inst|c1|seclsb\(2),
	datad => \inst|c1|Equal0~0_combout\,
	combout => \inst|c1|seclsb[2]~2_combout\);

-- Location: LCFF_X49_Y28_N13
\inst|c1|seclsb[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|seclsb[2]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|seclsb\(2));

-- Location: LCCOMB_X49_Y28_N22
\inst|c1|d1|Mux0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d1|Mux0~0_combout\ = (\inst|c1|seclsb\(3)) # ((\inst|c1|seclsb\(1) & ((!\inst|c1|seclsb\(2)) # (!\inst|c1|seclsb\(0)))) # (!\inst|c1|seclsb\(1) & ((\inst|c1|seclsb\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011111111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|seclsb\(0),
	datab => \inst|c1|seclsb\(1),
	datac => \inst|c1|seclsb\(3),
	datad => \inst|c1|seclsb\(2),
	combout => \inst|c1|d1|Mux0~0_combout\);

-- Location: LCCOMB_X49_Y28_N24
\inst|c1|d1|Mux1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d1|Mux1~0_combout\ = (!\inst|c1|seclsb\(3) & ((\inst|c1|seclsb\(0) & ((\inst|c1|seclsb\(1)) # (!\inst|c1|seclsb\(2)))) # (!\inst|c1|seclsb\(0) & (\inst|c1|seclsb\(1) & !\inst|c1|seclsb\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|seclsb\(0),
	datab => \inst|c1|seclsb\(1),
	datac => \inst|c1|seclsb\(3),
	datad => \inst|c1|seclsb\(2),
	combout => \inst|c1|d1|Mux1~0_combout\);

-- Location: LCCOMB_X49_Y28_N10
\inst|c1|d1|Mux2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d1|Mux2~0_combout\ = (\inst|c1|seclsb\(1) & (\inst|c1|seclsb\(0) & (!\inst|c1|seclsb\(3)))) # (!\inst|c1|seclsb\(1) & ((\inst|c1|seclsb\(2) & ((!\inst|c1|seclsb\(3)))) # (!\inst|c1|seclsb\(2) & (\inst|c1|seclsb\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101100101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|seclsb\(0),
	datab => \inst|c1|seclsb\(1),
	datac => \inst|c1|seclsb\(3),
	datad => \inst|c1|seclsb\(2),
	combout => \inst|c1|d1|Mux2~0_combout\);

-- Location: LCCOMB_X49_Y28_N28
\inst|c1|d1|Mux3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d1|Mux3~0_combout\ = (!\inst|c1|seclsb\(3) & ((\inst|c1|seclsb\(0) & (\inst|c1|seclsb\(1) $ (!\inst|c1|seclsb\(2)))) # (!\inst|c1|seclsb\(0) & (!\inst|c1|seclsb\(1) & \inst|c1|seclsb\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100100000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|seclsb\(0),
	datab => \inst|c1|seclsb\(1),
	datac => \inst|c1|seclsb\(3),
	datad => \inst|c1|seclsb\(2),
	combout => \inst|c1|d1|Mux3~0_combout\);

-- Location: LCCOMB_X49_Y28_N6
\inst|c1|d1|Mux4~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d1|Mux4~0_combout\ = (\inst|c1|seclsb\(2) & (((\inst|c1|seclsb\(3))))) # (!\inst|c1|seclsb\(2) & (\inst|c1|seclsb\(1) & ((\inst|c1|seclsb\(3)) # (!\inst|c1|seclsb\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|seclsb\(0),
	datab => \inst|c1|seclsb\(1),
	datac => \inst|c1|seclsb\(3),
	datad => \inst|c1|seclsb\(2),
	combout => \inst|c1|d1|Mux4~0_combout\);

-- Location: LCCOMB_X49_Y28_N8
\inst|c1|d1|Mux5~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d1|Mux5~0_combout\ = (\inst|c1|seclsb\(3) & (((\inst|c1|seclsb\(1)) # (\inst|c1|seclsb\(2))))) # (!\inst|c1|seclsb\(3) & (\inst|c1|seclsb\(2) & (\inst|c1|seclsb\(0) $ (\inst|c1|seclsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|seclsb\(0),
	datab => \inst|c1|seclsb\(1),
	datac => \inst|c1|seclsb\(3),
	datad => \inst|c1|seclsb\(2),
	combout => \inst|c1|d1|Mux5~0_combout\);

-- Location: LCCOMB_X49_Y28_N18
\inst|c1|d1|Mux6~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d1|Mux6~0_combout\ = (!\inst|c1|seclsb\(1) & (!\inst|c1|seclsb\(3) & (\inst|c1|seclsb\(0) $ (\inst|c1|seclsb\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|seclsb\(0),
	datab => \inst|c1|seclsb\(1),
	datac => \inst|c1|seclsb\(3),
	datad => \inst|c1|seclsb\(2),
	combout => \inst|c1|d1|Mux6~0_combout\);

-- Location: LCCOMB_X50_Y28_N2
\inst|c1|secmsb[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|secmsb[0]~0_combout\ = (!\inst|c1|secmsb\(0) & \KEY~combout\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|secmsb\(0),
	datad => \KEY~combout\(1),
	combout => \inst|c1|secmsb[0]~0_combout\);

-- Location: LCFF_X50_Y28_N3
\inst|c1|secmsb[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|secmsb[0]~0_combout\,
	ena => \inst|c1|seclsb[3]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|secmsb\(0));

-- Location: LCCOMB_X50_Y28_N20
\inst|c1|secmsb[2]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|secmsb[2]~1_combout\ = (\KEY~combout\(1) & ((\inst|c1|secmsb\(0) & (\inst|c1|secmsb\(1) & !\inst|c1|secmsb\(2))) # (!\inst|c1|secmsb\(0) & ((\inst|c1|secmsb\(2))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|secmsb\(1),
	datab => \inst|c1|secmsb\(0),
	datac => \inst|c1|secmsb\(2),
	datad => \KEY~combout\(1),
	combout => \inst|c1|secmsb[2]~1_combout\);

-- Location: LCFF_X50_Y28_N21
\inst|c1|secmsb[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|secmsb[2]~1_combout\,
	ena => \inst|c1|seclsb[3]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|secmsb\(2));

-- Location: LCCOMB_X50_Y28_N6
\inst|c1|secmsb[1]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|secmsb[1]~2_combout\ = (\KEY~combout\(1) & ((\inst|c1|secmsb\(1) & ((!\inst|c1|secmsb\(0)))) # (!\inst|c1|secmsb\(1) & (!\inst|c1|secmsb\(2) & \inst|c1|secmsb\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|secmsb\(2),
	datab => \KEY~combout\(1),
	datac => \inst|c1|secmsb\(1),
	datad => \inst|c1|secmsb\(0),
	combout => \inst|c1|secmsb[1]~2_combout\);

-- Location: LCFF_X50_Y28_N7
\inst|c1|secmsb[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|secmsb[1]~2_combout\,
	ena => \inst|c1|seclsb[3]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|secmsb\(1));

-- Location: LCCOMB_X50_Y28_N8
\inst|c1|d2|Mux0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d2|Mux0~0_combout\ = (\inst|c1|secmsb\(2) & (\inst|c1|secmsb\(0) & \inst|c1|secmsb\(1))) # (!\inst|c1|secmsb\(2) & ((!\inst|c1|secmsb\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|secmsb\(0),
	datac => \inst|c1|secmsb\(2),
	datad => \inst|c1|secmsb\(1),
	combout => \inst|c1|d2|Mux0~0_combout\);

-- Location: LCCOMB_X50_Y28_N18
\inst|c1|d2|Mux1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d2|Mux1~0_combout\ = (\inst|c1|secmsb\(0) & ((\inst|c1|secmsb\(1)) # (!\inst|c1|secmsb\(2)))) # (!\inst|c1|secmsb\(0) & (!\inst|c1|secmsb\(2) & \inst|c1|secmsb\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111100001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|secmsb\(0),
	datac => \inst|c1|secmsb\(2),
	datad => \inst|c1|secmsb\(1),
	combout => \inst|c1|d2|Mux1~0_combout\);

-- Location: LCCOMB_X50_Y28_N12
\inst|c1|d2|Mux2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d2|Mux2~0_combout\ = (\inst|c1|secmsb\(0)) # ((\inst|c1|secmsb\(2) & !\inst|c1|secmsb\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|secmsb\(0),
	datac => \inst|c1|secmsb\(2),
	datad => \inst|c1|secmsb\(1),
	combout => \inst|c1|d2|Mux2~0_combout\);

-- Location: LCCOMB_X50_Y28_N22
\inst|c1|d2|Mux3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d2|Mux3~0_combout\ = (\inst|c1|secmsb\(0) & (\inst|c1|secmsb\(2) $ (!\inst|c1|secmsb\(1)))) # (!\inst|c1|secmsb\(0) & (\inst|c1|secmsb\(2) & !\inst|c1|secmsb\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|secmsb\(0),
	datac => \inst|c1|secmsb\(2),
	datad => \inst|c1|secmsb\(1),
	combout => \inst|c1|d2|Mux3~0_combout\);

-- Location: LCCOMB_X50_Y28_N0
\inst|c1|d2|Mux4~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d2|Mux4~0_combout\ = (!\inst|c1|secmsb\(0) & (!\inst|c1|secmsb\(2) & \inst|c1|secmsb\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|secmsb\(0),
	datac => \inst|c1|secmsb\(2),
	datad => \inst|c1|secmsb\(1),
	combout => \inst|c1|d2|Mux4~0_combout\);

-- Location: LCCOMB_X50_Y28_N26
\inst|c1|d2|Mux5~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d2|Mux5~0_combout\ = (\inst|c1|secmsb\(0) $ (!\inst|c1|secmsb\(1))) # (!\inst|c1|secmsb\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|secmsb\(0),
	datac => \inst|c1|secmsb\(2),
	datad => \inst|c1|secmsb\(1),
	combout => \inst|c1|d2|Mux5~0_combout\);

-- Location: LCCOMB_X50_Y28_N4
\inst|c1|d2|Mux6~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d2|Mux6~0_combout\ = (!\inst|c1|secmsb\(1) & (\inst|c1|secmsb\(0) $ (\inst|c1|secmsb\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|secmsb\(0),
	datac => \inst|c1|secmsb\(2),
	datad => \inst|c1|secmsb\(1),
	combout => \inst|c1|d2|Mux6~0_combout\);

-- Location: LCCOMB_X47_Y28_N0
\inst|c1|minlsb[0]~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|minlsb[0]~5_combout\ = !\inst|c1|minlsb\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|minlsb\(0),
	combout => \inst|c1|minlsb[0]~5_combout\);

-- Location: LCCOMB_X50_Y28_N16
\inst|c1|Equal1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|Equal1~0_combout\ = ((\inst|c1|secmsb\(1)) # (!\inst|c1|secmsb\(2))) # (!\inst|c1|secmsb\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|secmsb\(0),
	datac => \inst|c1|secmsb\(2),
	datad => \inst|c1|secmsb\(1),
	combout => \inst|c1|Equal1~0_combout\);

-- Location: PIN_P23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\KEY[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_KEY(2),
	combout => \KEY~combout\(2));

-- Location: LCCOMB_X47_Y28_N6
\inst|c1|minlsb[1]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|minlsb[1]~0_combout\ = ((!\inst|c1|Equal0~0_combout\ & !\inst|c1|Equal1~0_combout\)) # (!\KEY~combout\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|Equal0~0_combout\,
	datac => \inst|c1|Equal1~0_combout\,
	datad => \KEY~combout\(2),
	combout => \inst|c1|minlsb[1]~0_combout\);

-- Location: LCFF_X47_Y28_N1
\inst|c1|minlsb[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|minlsb[0]~5_combout\,
	ena => \inst|c1|minlsb[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|minlsb\(0));

-- Location: LCCOMB_X47_Y28_N28
\inst|c1|minlsb[2]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|minlsb[2]~2_combout\ = \inst|c1|minlsb\(2) $ (((\inst|c1|minlsb\(1) & (\inst|c1|minlsb\(0) & \inst|c1|minlsb[1]~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minlsb\(1),
	datab => \inst|c1|minlsb\(0),
	datac => \inst|c1|minlsb\(2),
	datad => \inst|c1|minlsb[1]~0_combout\,
	combout => \inst|c1|minlsb[2]~2_combout\);

-- Location: LCFF_X47_Y28_N29
\inst|c1|minlsb[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|minlsb[2]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|minlsb\(2));

-- Location: LCCOMB_X47_Y28_N10
\inst|c1|minlsb[1]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|minlsb[1]~1_combout\ = (\inst|c1|minlsb\(0) & (!\inst|c1|minlsb\(1) & ((\inst|c1|minlsb\(2)) # (!\inst|c1|minlsb\(3))))) # (!\inst|c1|minlsb\(0) & (((\inst|c1|minlsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011100000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minlsb\(2),
	datab => \inst|c1|minlsb\(0),
	datac => \inst|c1|minlsb\(1),
	datad => \inst|c1|minlsb\(3),
	combout => \inst|c1|minlsb[1]~1_combout\);

-- Location: LCFF_X47_Y28_N11
\inst|c1|minlsb[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|minlsb[1]~1_combout\,
	ena => \inst|c1|minlsb[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|minlsb\(1));

-- Location: LCCOMB_X47_Y28_N30
\inst|c1|minlsb[3]~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|minlsb[3]~3_combout\ = (\inst|c1|minlsb\(2) & (\inst|c1|minlsb\(3) $ (((\inst|c1|minlsb\(0) & \inst|c1|minlsb\(1)))))) # (!\inst|c1|minlsb\(2) & (\inst|c1|minlsb\(3) & ((\inst|c1|minlsb\(1)) # (!\inst|c1|minlsb\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100010110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minlsb\(2),
	datab => \inst|c1|minlsb\(0),
	datac => \inst|c1|minlsb\(3),
	datad => \inst|c1|minlsb\(1),
	combout => \inst|c1|minlsb[3]~3_combout\);

-- Location: LCFF_X47_Y28_N31
\inst|c1|minlsb[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|minlsb[3]~3_combout\,
	ena => \inst|c1|minlsb[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|minlsb\(3));

-- Location: LCCOMB_X47_Y28_N16
\inst|c1|d3|Mux0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d3|Mux0~0_combout\ = (\inst|c1|minlsb\(3)) # ((\inst|c1|minlsb\(2) & ((!\inst|c1|minlsb\(1)) # (!\inst|c1|minlsb\(0)))) # (!\inst|c1|minlsb\(2) & ((\inst|c1|minlsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111111101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minlsb\(2),
	datab => \inst|c1|minlsb\(3),
	datac => \inst|c1|minlsb\(0),
	datad => \inst|c1|minlsb\(1),
	combout => \inst|c1|d3|Mux0~0_combout\);

-- Location: LCCOMB_X47_Y28_N2
\inst|c1|d3|Mux1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d3|Mux1~0_combout\ = (!\inst|c1|minlsb\(3) & ((\inst|c1|minlsb\(2) & (\inst|c1|minlsb\(0) & \inst|c1|minlsb\(1))) # (!\inst|c1|minlsb\(2) & ((\inst|c1|minlsb\(0)) # (\inst|c1|minlsb\(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000100010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minlsb\(2),
	datab => \inst|c1|minlsb\(3),
	datac => \inst|c1|minlsb\(0),
	datad => \inst|c1|minlsb\(1),
	combout => \inst|c1|d3|Mux1~0_combout\);

-- Location: LCCOMB_X47_Y28_N12
\inst|c1|d3|Mux2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d3|Mux2~0_combout\ = (\inst|c1|minlsb\(1) & (((!\inst|c1|minlsb\(3) & \inst|c1|minlsb\(0))))) # (!\inst|c1|minlsb\(1) & ((\inst|c1|minlsb\(2) & (!\inst|c1|minlsb\(3))) # (!\inst|c1|minlsb\(2) & ((\inst|c1|minlsb\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000001110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minlsb\(2),
	datab => \inst|c1|minlsb\(3),
	datac => \inst|c1|minlsb\(0),
	datad => \inst|c1|minlsb\(1),
	combout => \inst|c1|d3|Mux2~0_combout\);

-- Location: LCCOMB_X47_Y28_N22
\inst|c1|d3|Mux3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d3|Mux3~0_combout\ = (!\inst|c1|minlsb\(3) & ((\inst|c1|minlsb\(2) & (\inst|c1|minlsb\(0) $ (!\inst|c1|minlsb\(1)))) # (!\inst|c1|minlsb\(2) & (\inst|c1|minlsb\(0) & !\inst|c1|minlsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minlsb\(2),
	datab => \inst|c1|minlsb\(3),
	datac => \inst|c1|minlsb\(0),
	datad => \inst|c1|minlsb\(1),
	combout => \inst|c1|d3|Mux3~0_combout\);

-- Location: LCCOMB_X47_Y28_N8
\inst|c1|d3|Mux4~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d3|Mux4~0_combout\ = (\inst|c1|minlsb\(2) & (\inst|c1|minlsb\(3))) # (!\inst|c1|minlsb\(2) & (\inst|c1|minlsb\(1) & ((\inst|c1|minlsb\(3)) # (!\inst|c1|minlsb\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minlsb\(2),
	datab => \inst|c1|minlsb\(3),
	datac => \inst|c1|minlsb\(0),
	datad => \inst|c1|minlsb\(1),
	combout => \inst|c1|d3|Mux4~0_combout\);

-- Location: LCCOMB_X47_Y28_N26
\inst|c1|d3|Mux5~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d3|Mux5~0_combout\ = (\inst|c1|minlsb\(2) & ((\inst|c1|minlsb\(3)) # (\inst|c1|minlsb\(0) $ (\inst|c1|minlsb\(1))))) # (!\inst|c1|minlsb\(2) & (\inst|c1|minlsb\(3) & ((\inst|c1|minlsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minlsb\(2),
	datab => \inst|c1|minlsb\(3),
	datac => \inst|c1|minlsb\(0),
	datad => \inst|c1|minlsb\(1),
	combout => \inst|c1|d3|Mux5~0_combout\);

-- Location: LCCOMB_X47_Y28_N20
\inst|c1|d3|Mux6~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d3|Mux6~0_combout\ = (!\inst|c1|minlsb\(3) & (!\inst|c1|minlsb\(1) & (\inst|c1|minlsb\(2) $ (\inst|c1|minlsb\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minlsb\(2),
	datab => \inst|c1|minlsb\(3),
	datac => \inst|c1|minlsb\(0),
	datad => \inst|c1|minlsb\(1),
	combout => \inst|c1|d3|Mux6~0_combout\);

-- Location: LCCOMB_X47_Y24_N8
\inst|c1|minmsb[0]~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|minmsb[0]~3_combout\ = !\inst|c1|minmsb\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|minmsb\(0),
	combout => \inst|c1|minmsb[0]~3_combout\);

-- Location: LCCOMB_X47_Y28_N24
\inst|c1|Equal2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|Equal2~0_combout\ = (!\inst|c1|minlsb\(2) & (\inst|c1|minlsb\(3) & (\inst|c1|minlsb\(0) & !\inst|c1|minlsb\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minlsb\(2),
	datab => \inst|c1|minlsb\(3),
	datac => \inst|c1|minlsb\(0),
	datad => \inst|c1|minlsb\(1),
	combout => \inst|c1|Equal2~0_combout\);

-- Location: LCCOMB_X47_Y28_N18
\inst|c1|minmsb[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|minmsb[0]~0_combout\ = (\inst|c1|Equal2~0_combout\ & (((!\inst|c1|Equal1~0_combout\ & !\inst|c1|Equal0~0_combout\)) # (!\KEY~combout\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|Equal1~0_combout\,
	datab => \inst|c1|Equal0~0_combout\,
	datac => \inst|c1|Equal2~0_combout\,
	datad => \KEY~combout\(2),
	combout => \inst|c1|minmsb[0]~0_combout\);

-- Location: LCFF_X47_Y24_N9
\inst|c1|minmsb[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|minmsb[0]~3_combout\,
	ena => \inst|c1|minmsb[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|minmsb\(0));

-- Location: LCCOMB_X47_Y24_N12
\inst|c1|minmsb[1]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|minmsb[1]~2_combout\ = (\inst|c1|minmsb\(0) & (!\inst|c1|minmsb\(1) & !\inst|c1|minmsb\(2))) # (!\inst|c1|minmsb\(0) & (\inst|c1|minmsb\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|minmsb\(0),
	datac => \inst|c1|minmsb\(1),
	datad => \inst|c1|minmsb\(2),
	combout => \inst|c1|minmsb[1]~2_combout\);

-- Location: LCFF_X47_Y24_N13
\inst|c1|minmsb[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|minmsb[1]~2_combout\,
	ena => \inst|c1|minmsb[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|minmsb\(1));

-- Location: LCCOMB_X47_Y24_N18
\inst|c1|minmsb[2]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|minmsb[2]~1_combout\ = (\inst|c1|minmsb\(0) & (!\inst|c1|minmsb\(2) & \inst|c1|minmsb\(1))) # (!\inst|c1|minmsb\(0) & (\inst|c1|minmsb\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|minmsb\(0),
	datac => \inst|c1|minmsb\(2),
	datad => \inst|c1|minmsb\(1),
	combout => \inst|c1|minmsb[2]~1_combout\);

-- Location: LCFF_X47_Y24_N19
\inst|c1|minmsb[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|minmsb[2]~1_combout\,
	ena => \inst|c1|minmsb[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|minmsb\(2));

-- Location: LCCOMB_X47_Y24_N6
\inst|c1|d4|Mux0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d4|Mux0~0_combout\ = (\inst|c1|minmsb\(2) & (\inst|c1|minmsb\(0) & \inst|c1|minmsb\(1))) # (!\inst|c1|minmsb\(2) & ((!\inst|c1|minmsb\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|minmsb\(2),
	datac => \inst|c1|minmsb\(0),
	datad => \inst|c1|minmsb\(1),
	combout => \inst|c1|d4|Mux0~0_combout\);

-- Location: LCCOMB_X47_Y24_N16
\inst|c1|d4|Mux1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d4|Mux1~0_combout\ = (\inst|c1|minmsb\(2) & (\inst|c1|minmsb\(0) & \inst|c1|minmsb\(1))) # (!\inst|c1|minmsb\(2) & ((\inst|c1|minmsb\(0)) # (\inst|c1|minmsb\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|minmsb\(2),
	datac => \inst|c1|minmsb\(0),
	datad => \inst|c1|minmsb\(1),
	combout => \inst|c1|d4|Mux1~0_combout\);

-- Location: LCCOMB_X47_Y24_N10
\inst|c1|d4|Mux2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d4|Mux2~0_combout\ = (\inst|c1|minmsb\(0)) # ((\inst|c1|minmsb\(2) & !\inst|c1|minmsb\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|minmsb\(2),
	datac => \inst|c1|minmsb\(0),
	datad => \inst|c1|minmsb\(1),
	combout => \inst|c1|d4|Mux2~0_combout\);

-- Location: LCCOMB_X47_Y24_N28
\inst|c1|d4|Mux3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d4|Mux3~0_combout\ = (\inst|c1|minmsb\(2) & (\inst|c1|minmsb\(0) $ (!\inst|c1|minmsb\(1)))) # (!\inst|c1|minmsb\(2) & (\inst|c1|minmsb\(0) & !\inst|c1|minmsb\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|minmsb\(2),
	datac => \inst|c1|minmsb\(0),
	datad => \inst|c1|minmsb\(1),
	combout => \inst|c1|d4|Mux3~0_combout\);

-- Location: LCCOMB_X47_Y24_N22
\inst|c1|d4|Mux4~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d4|Mux4~0_combout\ = (!\inst|c1|minmsb\(2) & (!\inst|c1|minmsb\(0) & \inst|c1|minmsb\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|minmsb\(2),
	datac => \inst|c1|minmsb\(0),
	datad => \inst|c1|minmsb\(1),
	combout => \inst|c1|d4|Mux4~0_combout\);

-- Location: LCCOMB_X47_Y24_N24
\inst|c1|d4|Mux5~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d4|Mux5~0_combout\ = (\inst|c1|minmsb\(0) $ (!\inst|c1|minmsb\(1))) # (!\inst|c1|minmsb\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|minmsb\(2),
	datac => \inst|c1|minmsb\(0),
	datad => \inst|c1|minmsb\(1),
	combout => \inst|c1|d4|Mux5~0_combout\);

-- Location: LCCOMB_X47_Y24_N26
\inst|c1|d4|Mux6~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d4|Mux6~0_combout\ = (!\inst|c1|minmsb\(1) & (\inst|c1|minmsb\(2) $ (\inst|c1|minmsb\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|minmsb\(2),
	datac => \inst|c1|minmsb\(0),
	datad => \inst|c1|minmsb\(1),
	combout => \inst|c1|d4|Mux6~0_combout\);

-- Location: LCCOMB_X48_Y28_N0
\inst|c1|hrlsb[0]~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|hrlsb[0]~7_combout\ = !\inst|c1|hrlsb\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|hrlsb\(0),
	combout => \inst|c1|hrlsb[0]~7_combout\);

-- Location: LCCOMB_X47_Y28_N4
\inst|c1|hflag~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|hflag~0_combout\ = (\inst|c1|minmsb\(2) & (!\inst|c1|minmsb\(1) & (\inst|c1|Equal2~0_combout\ & \inst|c1|minmsb\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|minmsb\(2),
	datab => \inst|c1|minmsb\(1),
	datac => \inst|c1|Equal2~0_combout\,
	datad => \inst|c1|minmsb\(0),
	combout => \inst|c1|hflag~0_combout\);

-- Location: PIN_W26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\KEY[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_KEY(3),
	combout => \KEY~combout\(3));

-- Location: LCCOMB_X47_Y28_N14
\inst|c1|hrlsb[1]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|hrlsb[1]~2_combout\ = ((!\inst|c1|Equal1~0_combout\ & (!\inst|c1|Equal0~0_combout\ & \inst|c1|hflag~0_combout\))) # (!\KEY~combout\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|Equal1~0_combout\,
	datab => \inst|c1|Equal0~0_combout\,
	datac => \inst|c1|hflag~0_combout\,
	datad => \KEY~combout\(3),
	combout => \inst|c1|hrlsb[1]~2_combout\);

-- Location: LCFF_X48_Y28_N1
\inst|c1|hrlsb[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|hrlsb[0]~7_combout\,
	ena => \inst|c1|hrlsb[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|hrlsb\(0));

-- Location: LCCOMB_X45_Y28_N0
\inst|c1|Equal6~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|Equal6~0_combout\ = (\inst|c1|hrlsb\(0) & (\inst|c1|hrlsb\(3) & (\inst|c1|hrlsb\(1) & !\inst|c1|hrlsb\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb\(0),
	datab => \inst|c1|hrlsb\(3),
	datac => \inst|c1|hrlsb\(1),
	datad => \inst|c1|hrlsb\(2),
	combout => \inst|c1|Equal6~0_combout\);

-- Location: LCCOMB_X45_Y28_N14
\inst|c1|hrlsb[1]~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|hrlsb[1]~6_combout\ = (!\inst|c1|Equal6~0_combout\ & ((\inst|c1|hrlsb\(0)) # ((\inst|c1|hrlsb\(1)) # (!\inst|c1|process_0~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb\(0),
	datab => \inst|c1|Equal6~0_combout\,
	datac => \inst|c1|hrlsb\(1),
	datad => \inst|c1|process_0~2_combout\,
	combout => \inst|c1|hrlsb[1]~6_combout\);

-- Location: LCCOMB_X45_Y28_N16
\inst|c1|hrlsb[1]~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|hrlsb[1]~3_combout\ = (\inst|c1|hrlsb[1]~2_combout\ & ((\inst|c1|hrlsb\(0) $ (\inst|c1|hrlsb\(1))) # (!\inst|c1|hrlsb[1]~6_combout\))) # (!\inst|c1|hrlsb[1]~2_combout\ & (((\inst|c1|hrlsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111101111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb\(0),
	datab => \inst|c1|hrlsb[1]~6_combout\,
	datac => \inst|c1|hrlsb\(1),
	datad => \inst|c1|hrlsb[1]~2_combout\,
	combout => \inst|c1|hrlsb[1]~3_combout\);

-- Location: LCFF_X45_Y28_N17
\inst|c1|hrlsb[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|hrlsb[1]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|hrlsb\(1));

-- Location: LCCOMB_X45_Y28_N30
\inst|c1|process_0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|process_0~3_combout\ = (!\inst|c1|hrlsb\(1) & !\inst|c1|hrlsb\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|hrlsb\(1),
	datad => \inst|c1|hrlsb\(0),
	combout => \inst|c1|process_0~3_combout\);

-- Location: LCCOMB_X45_Y28_N26
\inst|c1|Add4~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|Add4~0_combout\ = \inst|c1|hrlsb\(2) $ (((!\inst|c1|hrlsb\(1) & \inst|c1|hrlsb\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|hrlsb\(2),
	datac => \inst|c1|hrlsb\(1),
	datad => \inst|c1|hrlsb\(0),
	combout => \inst|c1|Add4~0_combout\);

-- Location: LCCOMB_X48_Y28_N18
\inst|c1|hrlsb[2]~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|hrlsb[2]~4_combout\ = (!\inst|c1|Equal6~0_combout\ & (\inst|c1|Add4~0_combout\ & ((!\inst|c1|process_0~2_combout\) # (!\inst|c1|process_0~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|Equal6~0_combout\,
	datab => \inst|c1|process_0~3_combout\,
	datac => \inst|c1|Add4~0_combout\,
	datad => \inst|c1|process_0~2_combout\,
	combout => \inst|c1|hrlsb[2]~4_combout\);

-- Location: LCFF_X48_Y28_N19
\inst|c1|hrlsb[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|hrlsb[2]~4_combout\,
	ena => \inst|c1|hrlsb[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|hrlsb\(2));

-- Location: LCCOMB_X45_Y28_N24
\inst|c1|hrmsb[1]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|hrmsb[1]~0_combout\ = \inst|c1|hrmsb\(1) $ (((!\inst|c1|hrmsb\(0) & (\inst|c1|Equal6~0_combout\ & \inst|c1|hrlsb[1]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011010011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrmsb\(0),
	datab => \inst|c1|Equal6~0_combout\,
	datac => \inst|c1|hrmsb\(1),
	datad => \inst|c1|hrlsb[1]~2_combout\,
	combout => \inst|c1|hrmsb[1]~0_combout\);

-- Location: LCFF_X45_Y28_N25
\inst|c1|hrmsb[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|hrmsb[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|hrmsb\(1));

-- Location: LCCOMB_X45_Y28_N28
\inst|c1|process_0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|process_0~2_combout\ = (!\inst|c1|hrmsb\(0) & (!\inst|c1|hrlsb\(2) & (!\inst|c1|hrlsb\(3) & !\inst|c1|hrmsb\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrmsb\(0),
	datab => \inst|c1|hrlsb\(2),
	datac => \inst|c1|hrlsb\(3),
	datad => \inst|c1|hrmsb\(1),
	combout => \inst|c1|process_0~2_combout\);

-- Location: LCCOMB_X48_Y28_N4
\inst|c1|hrlsb[3]~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|hrlsb[3]~5_combout\ = (\inst|c1|Add4~1_combout\ & (!\inst|c1|Equal6~0_combout\ & ((!\inst|c1|process_0~3_combout\) # (!\inst|c1|process_0~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|Add4~1_combout\,
	datab => \inst|c1|process_0~2_combout\,
	datac => \inst|c1|Equal6~0_combout\,
	datad => \inst|c1|process_0~3_combout\,
	combout => \inst|c1|hrlsb[3]~5_combout\);

-- Location: LCFF_X48_Y28_N5
\inst|c1|hrlsb[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|hrlsb[3]~5_combout\,
	ena => \inst|c1|hrlsb[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|hrlsb\(3));

-- Location: LCCOMB_X45_Y28_N18
\inst|c1|d5|Mux0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d5|Mux0~0_combout\ = (\inst|c1|hrlsb\(3)) # ((\inst|c1|hrlsb\(1) & ((\inst|c1|hrlsb\(2)))) # (!\inst|c1|hrlsb\(1) & ((!\inst|c1|hrlsb\(2)) # (!\inst|c1|hrlsb\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110111001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb\(0),
	datab => \inst|c1|hrlsb\(3),
	datac => \inst|c1|hrlsb\(1),
	datad => \inst|c1|hrlsb\(2),
	combout => \inst|c1|d5|Mux0~0_combout\);

-- Location: LCCOMB_X45_Y28_N20
\inst|c1|d5|Mux1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d5|Mux1~0_combout\ = (!\inst|c1|hrlsb\(3) & ((\inst|c1|hrlsb\(0) & ((!\inst|c1|hrlsb\(2)) # (!\inst|c1|hrlsb\(1)))) # (!\inst|c1|hrlsb\(0) & (!\inst|c1|hrlsb\(1) & !\inst|c1|hrlsb\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000100011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb\(0),
	datab => \inst|c1|hrlsb\(3),
	datac => \inst|c1|hrlsb\(1),
	datad => \inst|c1|hrlsb\(2),
	combout => \inst|c1|d5|Mux1~0_combout\);

-- Location: LCCOMB_X45_Y28_N6
\inst|c1|d5|Mux2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d5|Mux2~0_combout\ = (\inst|c1|hrlsb\(1) & ((\inst|c1|hrlsb\(2) & ((!\inst|c1|hrlsb\(3)))) # (!\inst|c1|hrlsb\(2) & (\inst|c1|hrlsb\(0))))) # (!\inst|c1|hrlsb\(1) & (\inst|c1|hrlsb\(0) & (!\inst|c1|hrlsb\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001010100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb\(0),
	datab => \inst|c1|hrlsb\(3),
	datac => \inst|c1|hrlsb\(1),
	datad => \inst|c1|hrlsb\(2),
	combout => \inst|c1|d5|Mux2~0_combout\);

-- Location: LCCOMB_X45_Y28_N8
\inst|c1|d5|Mux3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d5|Mux3~0_combout\ = (!\inst|c1|hrlsb\(3) & ((\inst|c1|hrlsb\(0) & (\inst|c1|hrlsb\(1) $ (\inst|c1|hrlsb\(2)))) # (!\inst|c1|hrlsb\(0) & (\inst|c1|hrlsb\(1) & \inst|c1|hrlsb\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb\(0),
	datab => \inst|c1|hrlsb\(3),
	datac => \inst|c1|hrlsb\(1),
	datad => \inst|c1|hrlsb\(2),
	combout => \inst|c1|d5|Mux3~0_combout\);

-- Location: LCCOMB_X45_Y28_N2
\inst|c1|d5|Mux4~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d5|Mux4~0_combout\ = (\inst|c1|hrlsb\(2) & (((\inst|c1|hrlsb\(3))))) # (!\inst|c1|hrlsb\(2) & (!\inst|c1|hrlsb\(1) & ((\inst|c1|hrlsb\(3)) # (!\inst|c1|hrlsb\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000001101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb\(0),
	datab => \inst|c1|hrlsb\(3),
	datac => \inst|c1|hrlsb\(1),
	datad => \inst|c1|hrlsb\(2),
	combout => \inst|c1|d5|Mux4~0_combout\);

-- Location: LCCOMB_X45_Y28_N4
\inst|c1|d5|Mux5~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d5|Mux5~0_combout\ = (\inst|c1|hrlsb\(3) & (((\inst|c1|hrlsb\(2)) # (!\inst|c1|hrlsb\(1))))) # (!\inst|c1|hrlsb\(3) & (\inst|c1|hrlsb\(2) & (\inst|c1|hrlsb\(0) $ (!\inst|c1|hrlsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110100001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb\(0),
	datab => \inst|c1|hrlsb\(3),
	datac => \inst|c1|hrlsb\(1),
	datad => \inst|c1|hrlsb\(2),
	combout => \inst|c1|d5|Mux5~0_combout\);

-- Location: LCCOMB_X45_Y28_N22
\inst|c1|d5|Mux6~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d5|Mux6~0_combout\ = (!\inst|c1|hrlsb\(3) & (\inst|c1|hrlsb\(1) & (\inst|c1|hrlsb\(0) $ (\inst|c1|hrlsb\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb\(0),
	datab => \inst|c1|hrlsb\(3),
	datac => \inst|c1|hrlsb\(1),
	datad => \inst|c1|hrlsb\(2),
	combout => \inst|c1|d5|Mux6~0_combout\);

-- Location: LCCOMB_X45_Y28_N10
\inst|c1|hrmsb[0]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|hrmsb[0]~1_combout\ = (\inst|c1|hrlsb[1]~2_combout\ & ((\inst|c1|hrmsb\(0) & ((!\inst|c1|Equal6~0_combout\))) # (!\inst|c1|hrmsb\(0) & (!\inst|c1|hrlsb[1]~6_combout\)))) # (!\inst|c1|hrlsb[1]~2_combout\ & (((\inst|c1|hrmsb\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101001011110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb[1]~2_combout\,
	datab => \inst|c1|hrlsb[1]~6_combout\,
	datac => \inst|c1|hrmsb\(0),
	datad => \inst|c1|Equal6~0_combout\,
	combout => \inst|c1|hrmsb[0]~1_combout\);

-- Location: LCFF_X45_Y28_N11
\inst|c1|hrmsb[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|hrmsb[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|hrmsb\(0));

-- Location: LCCOMB_X1_Y24_N0
\inst|c1|d6|Mux1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d6|Mux1~0_combout\ = (\inst|c1|hrmsb\(1)) # (!\inst|c1|hrmsb\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|hrmsb\(0),
	datad => \inst|c1|hrmsb\(1),
	combout => \inst|c1|d6|Mux1~0_combout\);

-- Location: LCCOMB_X1_Y24_N2
\inst|c1|d6|Mux1~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d6|Mux1~1_combout\ = (!\inst|c1|hrmsb\(0) & !\inst|c1|hrmsb\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|hrmsb\(0),
	datad => \inst|c1|hrmsb\(1),
	combout => \inst|c1|d6|Mux1~1_combout\);

-- Location: LCCOMB_X1_Y24_N20
\inst|c1|d6|Mux1~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|d6|Mux1~2_combout\ = (\inst|c1|hrmsb\(0) & \inst|c1|hrmsb\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|c1|hrmsb\(0),
	datad => \inst|c1|hrmsb\(1),
	combout => \inst|c1|d6|Mux1~2_combout\);

-- Location: LCCOMB_X44_Y27_N6
\inst|now_state~111\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~111_combout\ = (\inst|next_state.STATE_31~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|next_state.STATE_31~regout\,
	datac => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~111_combout\);

-- Location: LCFF_X44_Y27_N7
\inst|now_state.STATE_31\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~111_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_31~regout\);

-- Location: LCCOMB_X44_Y27_N28
\inst|Selector52~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector52~0_combout\ = (\inst|now_state.STATE_31~regout\) # ((\inst|next_state.STATE_32~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_31~regout\,
	datac => \inst|next_state.STATE_32~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector52~0_combout\);

-- Location: LCFF_X44_Y27_N29
\inst|next_state.STATE_32\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector52~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_32~regout\);

-- Location: LCCOMB_X44_Y27_N26
\inst|now_state~101\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~101_combout\ = (\inst|next_state.STATE_32~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.STATE_32~regout\,
	datac => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~101_combout\);

-- Location: LCFF_X44_Y27_N27
\inst|now_state.STATE_32\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~101_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_32~regout\);

-- Location: LCCOMB_X48_Y27_N12
\inst|Selector14~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector14~0_combout\ = (\inst|now_state.MODE_SET~regout\) # ((\inst|now_state.STATE_32~regout\) # ((!\inst|WideOr2~5_combout\ & \inst|next_state.HOME~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|WideOr2~5_combout\,
	datab => \inst|now_state.MODE_SET~regout\,
	datac => \inst|next_state.HOME~regout\,
	datad => \inst|now_state.STATE_32~regout\,
	combout => \inst|Selector14~0_combout\);

-- Location: LCFF_X48_Y27_N13
\inst|next_state.HOME\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector14~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.HOME~regout\);

-- Location: LCCOMB_X45_Y27_N12
\inst|now_state~94\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~94_combout\ = (\inst|next_state.HOME~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.HOME~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~94_combout\);

-- Location: LCFF_X45_Y27_N13
\inst|now_state.HOME\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~94_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.HOME~regout\);

-- Location: LCCOMB_X48_Y27_N0
\inst|Selector2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector2~0_combout\ = (\inst|now_state.LINE_2~regout\) # ((\inst|now_state.HOME~regout\) # ((!\inst|WideOr2~5_combout\ & \inst|LCD_DATA_VALUE\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|WideOr2~5_combout\,
	datab => \inst|now_state.LINE_2~regout\,
	datac => \inst|LCD_DATA_VALUE\(7),
	datad => \inst|now_state.HOME~regout\,
	combout => \inst|Selector2~0_combout\);

-- Location: LCFF_X48_Y27_N1
\inst|LCD_DATA_VALUE[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector2~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|LCD_DATA_VALUE\(7));

-- Location: PIN_N25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\SW[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_SW(0),
	combout => \SW~combout\(0));

-- Location: LCCOMB_X48_Y27_N18
\inst|Selector3~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector3~8_combout\ = (!\SW~combout\(0)) # (!\inst|now_state.STATE_12~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|now_state.STATE_12~regout\,
	datad => \SW~combout\(0),
	combout => \inst|Selector3~8_combout\);

-- Location: LCCOMB_X48_Y27_N4
\inst|Selector3~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector3~9_combout\ = (\inst|Selector3~8_combout\ & (!\inst|now_state.CLEAR~regout\ & ((\inst|LCD_DATA_VALUE\(6)) # (\inst|WideOr2~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LCD_DATA_VALUE\(6),
	datab => \inst|Selector3~8_combout\,
	datac => \inst|WideOr2~5_combout\,
	datad => \inst|now_state.CLEAR~regout\,
	combout => \inst|Selector3~9_combout\);

-- Location: LCCOMB_X47_Y27_N4
\inst|Selector32~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector32~0_combout\ = (\inst|now_state.LINE_2~regout\) # ((\inst|next_state.STATE_17~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.LINE_2~regout\,
	datac => \inst|next_state.STATE_17~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector32~0_combout\);

-- Location: LCFF_X47_Y27_N5
\inst|next_state.STATE_17\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector32~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_17~regout\);

-- Location: LCCOMB_X47_Y27_N12
\inst|now_state~112\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~112_combout\ = (\inst|next_state.STATE_17~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_17~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~112_combout\);

-- Location: LCFF_X47_Y27_N13
\inst|now_state.STATE_17\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~112_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_17~regout\);

-- Location: LCCOMB_X47_Y27_N14
\inst|Selector33~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector33~0_combout\ = (\inst|now_state.STATE_17~regout\) # ((\inst|next_state.STATE_18~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.WAITUP~regout\,
	datac => \inst|next_state.STATE_18~regout\,
	datad => \inst|now_state.STATE_17~regout\,
	combout => \inst|Selector33~0_combout\);

-- Location: LCFF_X47_Y27_N15
\inst|next_state.STATE_18\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector33~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_18~regout\);

-- Location: LCCOMB_X47_Y27_N6
\inst|now_state~113\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~113_combout\ = (\inst|next_state.STATE_18~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_18~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~113_combout\);

-- Location: LCFF_X47_Y27_N7
\inst|now_state.STATE_18\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~113_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_18~regout\);

-- Location: LCCOMB_X47_Y27_N20
\inst|Selector34~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector34~0_combout\ = (\inst|now_state.STATE_18~regout\) # ((\inst|next_state.STATE_19~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.WAITUP~regout\,
	datac => \inst|next_state.STATE_19~regout\,
	datad => \inst|now_state.STATE_18~regout\,
	combout => \inst|Selector34~0_combout\);

-- Location: LCFF_X47_Y27_N21
\inst|next_state.STATE_19\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector34~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_19~regout\);

-- Location: LCCOMB_X47_Y27_N10
\inst|now_state~99\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~99_combout\ = (\inst|next_state.STATE_19~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_19~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~99_combout\);

-- Location: LCFF_X47_Y27_N11
\inst|now_state.STATE_19\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~99_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_19~regout\);

-- Location: LCCOMB_X49_Y27_N28
\inst|Selector35~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector35~0_combout\ = (\inst|now_state.STATE_19~regout\) # ((\inst|next_state.STATE_20~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_19~regout\,
	datac => \inst|next_state.STATE_20~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector35~0_combout\);

-- Location: LCFF_X49_Y27_N29
\inst|next_state.STATE_20\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector35~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_20~regout\);

-- Location: LCCOMB_X45_Y26_N0
\inst|now_state~114\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~114_combout\ = (\inst|next_state.STATE_20~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_20~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~114_combout\);

-- Location: LCFF_X45_Y26_N1
\inst|now_state.STATE_20\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~114_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_20~regout\);

-- Location: LCCOMB_X45_Y26_N24
\inst|Selector36~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector36~0_combout\ = (\inst|now_state.STATE_20~regout\) # ((\inst|next_state.STATE_21~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_20~regout\,
	datac => \inst|next_state.STATE_21~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector36~0_combout\);

-- Location: LCFF_X45_Y26_N25
\inst|next_state.STATE_21\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector36~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_21~regout\);

-- Location: LCCOMB_X45_Y26_N26
\inst|now_state~115\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~115_combout\ = (\inst|next_state.STATE_21~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_21~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~115_combout\);

-- Location: LCFF_X45_Y26_N27
\inst|now_state.STATE_21\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~115_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_21~regout\);

-- Location: LCCOMB_X48_Y28_N28
\inst|Selector3~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector3~6_combout\ = (!\inst|now_state.STATE_18~regout\ & (!\inst|now_state.STATE_20~regout\ & (!\inst|now_state.STATE_21~regout\ & !\inst|now_state.STATE_17~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_18~regout\,
	datab => \inst|now_state.STATE_20~regout\,
	datac => \inst|now_state.STATE_21~regout\,
	datad => \inst|now_state.STATE_17~regout\,
	combout => \inst|Selector3~6_combout\);

-- Location: LCCOMB_X45_Y26_N2
\inst|Selector39~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector39~0_combout\ = (\inst|now_state.STATE_23~regout\) # ((\inst|next_state.STATE_24~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_23~regout\,
	datab => \inst|now_state.TOGGLE_E~regout\,
	datac => \inst|next_state.STATE_24~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector39~0_combout\);

-- Location: LCFF_X45_Y26_N3
\inst|next_state.STATE_24\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector39~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_24~regout\);

-- Location: LCCOMB_X44_Y27_N0
\inst|now_state~117\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~117_combout\ = (\inst|next_state.STATE_24~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.STATE_24~regout\,
	datac => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~117_combout\);

-- Location: LCFF_X44_Y27_N1
\inst|now_state.STATE_24\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~117_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_24~regout\);

-- Location: LCCOMB_X45_Y27_N16
\inst|Selector37~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector37~0_combout\ = (\inst|now_state.STATE_21~regout\) # ((\inst|next_state.STATE_22~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.STATE_21~regout\,
	datac => \inst|next_state.STATE_22~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector37~0_combout\);

-- Location: LCFF_X45_Y27_N17
\inst|next_state.STATE_22\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector37~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_22~regout\);

-- Location: LCCOMB_X45_Y27_N0
\inst|now_state~100\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~100_combout\ = (\inst|next_state.STATE_22~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_22~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~100_combout\);

-- Location: LCFF_X45_Y27_N1
\inst|now_state.STATE_22\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~100_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_22~regout\);

-- Location: LCCOMB_X49_Y27_N14
\inst|Selector38~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector38~0_combout\ = (\inst|now_state.STATE_22~regout\) # ((\inst|next_state.STATE_23~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_22~regout\,
	datac => \inst|next_state.STATE_23~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector38~0_combout\);

-- Location: LCFF_X49_Y27_N15
\inst|next_state.STATE_23\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector38~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_23~regout\);

-- Location: LCCOMB_X45_Y26_N12
\inst|now_state~116\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~116_combout\ = (\inst|now_state.WAITUP~regout\ & \inst|next_state.STATE_23~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datad => \inst|next_state.STATE_23~regout\,
	combout => \inst|now_state~116_combout\);

-- Location: LCFF_X45_Y26_N13
\inst|now_state.STATE_23\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~116_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_23~regout\);

-- Location: LCCOMB_X48_Y27_N24
\inst|Selector3~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector3~7_combout\ = (\inst|Selector3~6_combout\ & (!\inst|now_state.STATE_24~regout\ & !\inst|now_state.STATE_23~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|Selector3~6_combout\,
	datac => \inst|now_state.STATE_24~regout\,
	datad => \inst|now_state.STATE_23~regout\,
	combout => \inst|Selector3~7_combout\);

-- Location: LCCOMB_X44_Y27_N14
\inst|Selector40~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector40~0_combout\ = (\inst|now_state.STATE_24~regout\) # ((\inst|next_state.STATE_25~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_24~regout\,
	datac => \inst|next_state.STATE_25~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector40~0_combout\);

-- Location: LCFF_X44_Y27_N15
\inst|next_state.STATE_25\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector40~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_25~regout\);

-- Location: LCCOMB_X44_Y27_N4
\inst|now_state~107\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~107_combout\ = (\inst|now_state.WAITUP~regout\ & \inst|next_state.STATE_25~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datac => \inst|next_state.STATE_25~regout\,
	combout => \inst|now_state~107_combout\);

-- Location: LCFF_X44_Y27_N5
\inst|now_state.STATE_25\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~107_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_25~regout\);

-- Location: LCCOMB_X44_Y27_N30
\inst|Selector41~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector41~0_combout\ = (\inst|now_state.STATE_25~regout\) # ((\inst|next_state.STATE_26~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_25~regout\,
	datac => \inst|next_state.STATE_26~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector41~0_combout\);

-- Location: LCFF_X44_Y27_N31
\inst|next_state.STATE_26\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector41~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_26~regout\);

-- Location: LCCOMB_X44_Y27_N2
\inst|now_state~122\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~122_combout\ = (\inst|next_state.STATE_26~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.STATE_26~regout\,
	datac => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~122_combout\);

-- Location: LCFF_X44_Y27_N3
\inst|now_state.STATE_26\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~122_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_26~regout\);

-- Location: LCCOMB_X49_Y27_N8
\inst|Selector42~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector42~0_combout\ = (\inst|now_state.STATE_26~regout\) # ((\inst|next_state.STATE_27~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_26~regout\,
	datac => \inst|next_state.STATE_27~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector42~0_combout\);

-- Location: LCFF_X49_Y27_N9
\inst|next_state.STATE_27\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector42~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_27~regout\);

-- Location: LCCOMB_X49_Y27_N2
\inst|now_state~120\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~120_combout\ = (\inst|next_state.STATE_27~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.STATE_27~regout\,
	datac => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~120_combout\);

-- Location: LCFF_X49_Y27_N3
\inst|now_state.STATE_27\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~120_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_27~regout\);

-- Location: LCCOMB_X49_Y27_N26
\inst|Selector43~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector43~0_combout\ = (\inst|now_state.STATE_27~regout\) # ((\inst|next_state.STATE_28~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_27~regout\,
	datac => \inst|next_state.STATE_28~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector43~0_combout\);

-- Location: LCFF_X49_Y27_N27
\inst|next_state.STATE_28\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector43~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_28~regout\);

-- Location: LCCOMB_X44_Y27_N22
\inst|now_state~108\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~108_combout\ = (\inst|now_state.WAITUP~regout\ & \inst|next_state.STATE_28~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|now_state.WAITUP~regout\,
	datad => \inst|next_state.STATE_28~regout\,
	combout => \inst|now_state~108_combout\);

-- Location: LCFF_X44_Y27_N23
\inst|now_state.STATE_28\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~108_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_28~regout\);

-- Location: LCCOMB_X44_Y27_N24
\inst|Selector44~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector44~0_combout\ = (\inst|now_state.STATE_28~regout\) # ((\inst|next_state.STATE_29~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_28~regout\,
	datac => \inst|next_state.STATE_29~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector44~0_combout\);

-- Location: LCFF_X44_Y27_N25
\inst|next_state.STATE_29\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector44~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_29~regout\);

-- Location: LCCOMB_X44_Y27_N8
\inst|now_state~109\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~109_combout\ = (\inst|now_state.WAITUP~regout\ & \inst|next_state.STATE_29~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datac => \inst|next_state.STATE_29~regout\,
	combout => \inst|now_state~109_combout\);

-- Location: LCFF_X44_Y27_N9
\inst|now_state.STATE_29\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~109_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_29~regout\);

-- Location: LCCOMB_X44_Y27_N20
\inst|Selector3~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector3~4_combout\ = (!\inst|now_state.STATE_30~regout\ & (!\inst|now_state.STATE_25~regout\ & (!\inst|now_state.STATE_29~regout\ & !\inst|now_state.STATE_28~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_30~regout\,
	datab => \inst|now_state.STATE_25~regout\,
	datac => \inst|now_state.STATE_29~regout\,
	datad => \inst|now_state.STATE_28~regout\,
	combout => \inst|Selector3~4_combout\);

-- Location: LCCOMB_X47_Y27_N18
\inst|Selector3~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector3~3_combout\ = (!\inst|now_state.STATE_13~regout\ & (!\inst|now_state.STATE_15~regout\ & (!\inst|now_state.STATE_16~regout\ & !\inst|now_state.STATE_14~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_13~regout\,
	datab => \inst|now_state.STATE_15~regout\,
	datac => \inst|now_state.STATE_16~regout\,
	datad => \inst|now_state.STATE_14~regout\,
	combout => \inst|Selector3~3_combout\);

-- Location: LCCOMB_X48_Y27_N30
\inst|Selector3~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector3~5_combout\ = (\inst|Selector3~4_combout\ & (!\inst|now_state.STATE_31~regout\ & \inst|Selector3~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|Selector3~4_combout\,
	datac => \inst|now_state.STATE_31~regout\,
	datad => \inst|Selector3~3_combout\,
	combout => \inst|Selector3~5_combout\);

-- Location: LCCOMB_X48_Y27_N2
\inst|Selector3~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector3~10_combout\ = (\inst|Selector3~2_combout\ & (\inst|Selector3~9_combout\ & (\inst|Selector3~7_combout\ & \inst|Selector3~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Selector3~2_combout\,
	datab => \inst|Selector3~9_combout\,
	datac => \inst|Selector3~7_combout\,
	datad => \inst|Selector3~5_combout\,
	combout => \inst|Selector3~10_combout\);

-- Location: LCFF_X48_Y27_N3
\inst|LCD_DATA_VALUE[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector3~10_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|LCD_DATA_VALUE\(6));

-- Location: LCCOMB_X46_Y27_N20
\inst|Selector4~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector4~0_combout\ = (!\inst|now_state.STATE_1~regout\ & ((\inst|LCD_DATA_VALUE\(5)) # ((!\inst|now_state.TOGGLE_E~regout\ & !\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010001000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_1~regout\,
	datab => \inst|LCD_DATA_VALUE\(5),
	datac => \inst|now_state.TOGGLE_E~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector4~0_combout\);

-- Location: LCCOMB_X45_Y27_N4
\inst|Selector21~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector21~0_combout\ = (\inst|now_state.STATE_5~regout\) # ((\inst|next_state.STATE_6~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_5~regout\,
	datab => \inst|now_state.WAITUP~regout\,
	datac => \inst|next_state.STATE_6~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector21~0_combout\);

-- Location: LCFF_X45_Y27_N5
\inst|next_state.STATE_6\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector21~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_6~regout\);

-- Location: LCCOMB_X45_Y27_N28
\inst|now_state~121\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~121_combout\ = (\inst|next_state.STATE_6~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_6~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~121_combout\);

-- Location: LCFF_X45_Y27_N29
\inst|now_state.STATE_6\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~121_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_6~regout\);

-- Location: LCCOMB_X49_Y27_N12
\inst|Selector4~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector4~1_combout\ = (!\inst|now_state.DISP_ON~regout\ & (!\inst|now_state.STATE_6~regout\ & (!\inst|now_state.STATE_26~regout\ & !\inst|now_state.STATE_27~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.DISP_ON~regout\,
	datab => \inst|now_state.STATE_6~regout\,
	datac => \inst|now_state.STATE_26~regout\,
	datad => \inst|now_state.STATE_27~regout\,
	combout => \inst|Selector4~1_combout\);

-- Location: LCCOMB_X46_Y27_N18
\inst|Selector4~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector4~2_combout\ = (!\inst|now_state.DISP_OFF~regout\ & (\inst|WideOr2~4_combout\ & (\inst|Selector4~0_combout\ & \inst|Selector4~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.DISP_OFF~regout\,
	datab => \inst|WideOr2~4_combout\,
	datac => \inst|Selector4~0_combout\,
	datad => \inst|Selector4~1_combout\,
	combout => \inst|Selector4~2_combout\);

-- Location: LCFF_X46_Y27_N19
\inst|LCD_DATA_VALUE[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector4~2_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|LCD_DATA_VALUE\(5));

-- Location: LCCOMB_X49_Y27_N18
\inst|Selector22~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector22~0_combout\ = (\inst|now_state.STATE_6~regout\) # ((\inst|next_state.STATE_7~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_6~regout\,
	datac => \inst|next_state.STATE_7~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector22~0_combout\);

-- Location: LCFF_X49_Y27_N19
\inst|next_state.STATE_7\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector22~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_7~regout\);

-- Location: LCCOMB_X45_Y26_N22
\inst|now_state~125\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~125_combout\ = (\inst|next_state.STATE_7~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_7~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~125_combout\);

-- Location: LCFF_X45_Y26_N23
\inst|now_state.STATE_7\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~125_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_7~regout\);

-- Location: LCCOMB_X45_Y26_N28
\inst|Selector23~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector23~0_combout\ = (\inst|now_state.STATE_7~regout\) # ((\inst|next_state.STATE_8~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_7~regout\,
	datac => \inst|next_state.STATE_8~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector23~0_combout\);

-- Location: LCFF_X45_Y26_N29
\inst|next_state.STATE_8\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector23~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_8~regout\);

-- Location: LCCOMB_X45_Y27_N22
\inst|now_state~123\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~123_combout\ = (\inst|next_state.STATE_8~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_8~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~123_combout\);

-- Location: LCFF_X45_Y27_N23
\inst|now_state.STATE_8\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~123_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_8~regout\);

-- Location: LCCOMB_X47_Y26_N24
\inst|Selector16~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector16~0_combout\ = (\inst|now_state.HOME~regout\) # ((\inst|next_state.STATE_1~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.HOME~regout\,
	datac => \inst|next_state.STATE_1~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector16~0_combout\);

-- Location: LCFF_X47_Y26_N25
\inst|next_state.STATE_1\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector16~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_1~regout\);

-- Location: LCCOMB_X47_Y26_N30
\inst|now_state~119\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~119_combout\ = (\inst|next_state.STATE_1~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_1~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~119_combout\);

-- Location: LCFF_X47_Y26_N31
\inst|now_state.STATE_1\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~119_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_1~regout\);

-- Location: LCCOMB_X47_Y26_N14
\inst|Selector17~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector17~0_combout\ = (\inst|now_state.STATE_1~regout\) # ((\inst|next_state.STATE_2~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.STATE_1~regout\,
	datac => \inst|next_state.STATE_2~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector17~0_combout\);

-- Location: LCFF_X47_Y26_N15
\inst|next_state.STATE_2\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector17~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_2~regout\);

-- Location: LCCOMB_X47_Y26_N22
\inst|now_state~129\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~129_combout\ = (\inst|next_state.STATE_2~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|next_state.STATE_2~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~129_combout\);

-- Location: LCFF_X47_Y26_N23
\inst|now_state.STATE_2\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~129_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_2~regout\);

-- Location: LCCOMB_X47_Y26_N18
\inst|Selector18~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector18~0_combout\ = (\inst|now_state.STATE_2~regout\) # ((\inst|next_state.STATE_3~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.STATE_2~regout\,
	datac => \inst|next_state.STATE_3~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector18~0_combout\);

-- Location: LCFF_X47_Y26_N19
\inst|next_state.STATE_3\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector18~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_3~regout\);

-- Location: LCCOMB_X47_Y26_N0
\inst|now_state~124\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~124_combout\ = (\inst|next_state.STATE_3~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.STATE_3~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~124_combout\);

-- Location: LCFF_X47_Y26_N1
\inst|now_state.STATE_3\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~124_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_3~regout\);

-- Location: LCCOMB_X48_Y27_N14
\inst|Selector5~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector5~2_combout\ = (\SW~combout\(0) & ((\inst|now_state.STATE_1~regout\) # ((\inst|now_state.STATE_3~regout\)))) # (!\SW~combout\(0) & (((\inst|now_state.STATE_8~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_1~regout\,
	datab => \inst|now_state.STATE_8~regout\,
	datac => \inst|now_state.STATE_3~regout\,
	datad => \SW~combout\(0),
	combout => \inst|Selector5~2_combout\);

-- Location: LCCOMB_X50_Y28_N30
\inst|c1|process_0~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|process_0~4_combout\ = (!\inst|c1|hrlsb\(1) & (!\inst|c1|hrlsb\(0) & \inst|c1|process_0~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|c1|hrlsb\(1),
	datac => \inst|c1|hrlsb\(0),
	datad => \inst|c1|process_0~2_combout\,
	combout => \inst|c1|process_0~4_combout\);

-- Location: LCCOMB_X50_Y28_N28
\inst|c1|minlsb[1]~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|minlsb[1]~4_combout\ = (\inst|c1|secmsb\(2) & (\inst|c1|secmsb\(0) & (!\inst|c1|Equal0~0_combout\ & !\inst|c1|secmsb\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|secmsb\(2),
	datab => \inst|c1|secmsb\(0),
	datac => \inst|c1|Equal0~0_combout\,
	datad => \inst|c1|secmsb\(1),
	combout => \inst|c1|minlsb[1]~4_combout\);

-- Location: LCCOMB_X50_Y28_N10
\inst|c1|hflag~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|c1|hflag~1_combout\ = \inst|c1|hflag~regout\ $ (((\inst|c1|hflag~0_combout\ & (\inst|c1|process_0~4_combout\ & \inst|c1|minlsb[1]~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hflag~0_combout\,
	datab => \inst|c1|process_0~4_combout\,
	datac => \inst|c1|hflag~regout\,
	datad => \inst|c1|minlsb[1]~4_combout\,
	combout => \inst|c1|hflag~1_combout\);

-- Location: LCFF_X50_Y28_N11
\inst|c1|hflag\ : cycloneii_lcell_ff
PORT MAP (
	clk => \inst|c1|divide_clock|clk_out~clkctrl_outclk\,
	datain => \inst|c1|hflag~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|c1|hflag~regout\);

-- Location: LCCOMB_X49_Y27_N6
\inst|Selector5~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector5~3_combout\ = (\inst|now_state.STATE_22~regout\) # ((\inst|now_state.STATE_19~regout\) # ((\inst|now_state.STATE_26~regout\ & \inst|c1|hflag~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_22~regout\,
	datab => \inst|now_state.STATE_19~regout\,
	datac => \inst|now_state.STATE_26~regout\,
	datad => \inst|c1|hflag~regout\,
	combout => \inst|Selector5~3_combout\);

-- Location: LCCOMB_X49_Y27_N30
\inst|Selector5~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector5~5_combout\ = (\inst|Selector5~3_combout\) # ((\inst|LCD_DATA_VALUE\(4) & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|LCD_DATA_VALUE\(4),
	datac => \inst|now_state.WAITUP~regout\,
	datad => \inst|Selector5~3_combout\,
	combout => \inst|Selector5~5_combout\);

-- Location: LCCOMB_X48_Y27_N28
\inst|Selector5~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector5~4_combout\ = (((\inst|Selector5~2_combout\) # (\inst|Selector5~5_combout\)) # (!\inst|WideOr2~2_combout\)) # (!\inst|Selector3~7_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Selector3~7_combout\,
	datab => \inst|WideOr2~2_combout\,
	datac => \inst|Selector5~2_combout\,
	datad => \inst|Selector5~5_combout\,
	combout => \inst|Selector5~4_combout\);

-- Location: LCFF_X48_Y27_N29
\inst|LCD_DATA_VALUE[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector5~4_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|LCD_DATA_VALUE\(4));

-- Location: LCCOMB_X46_Y28_N12
\inst|Selector6~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector6~0_combout\ = (!\SW~combout\(0) & ((\inst|now_state.STATE_1~regout\) # ((\inst|now_state.STATE_7~regout\) # (\inst|now_state.STATE_12~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_1~regout\,
	datab => \inst|now_state.STATE_7~regout\,
	datac => \SW~combout\(0),
	datad => \inst|now_state.STATE_12~regout\,
	combout => \inst|Selector6~0_combout\);

-- Location: LCCOMB_X46_Y28_N6
\inst|Selector6~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector6~1_combout\ = (\inst|now_state.STATE_21~regout\ & ((\inst|c1|minlsb\(3)) # ((\inst|now_state.STATE_24~regout\ & \inst|c1|seclsb\(3))))) # (!\inst|now_state.STATE_21~regout\ & (\inst|now_state.STATE_24~regout\ & (\inst|c1|seclsb\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_21~regout\,
	datab => \inst|now_state.STATE_24~regout\,
	datac => \inst|c1|seclsb\(3),
	datad => \inst|c1|minlsb\(3),
	combout => \inst|Selector6~1_combout\);

-- Location: LCCOMB_X49_Y27_N4
\inst|Selector6~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector6~4_combout\ = (!\inst|now_state.STATE_6~regout\ & (!\inst|now_state.STATE_22~regout\ & !\inst|now_state.STATE_19~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|now_state.STATE_6~regout\,
	datac => \inst|now_state.STATE_22~regout\,
	datad => \inst|now_state.STATE_19~regout\,
	combout => \inst|Selector6~4_combout\);

-- Location: LCCOMB_X49_Y27_N10
\inst|Selector6~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector6~3_combout\ = (\inst|Selector6~2_combout\) # ((\inst|now_state.STATE_27~regout\) # ((!\inst|WideOr2~5_combout\ & \inst|LCD_DATA_VALUE\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Selector6~2_combout\,
	datab => \inst|WideOr2~5_combout\,
	datac => \inst|LCD_DATA_VALUE\(3),
	datad => \inst|now_state.STATE_27~regout\,
	combout => \inst|Selector6~3_combout\);

-- Location: LCCOMB_X47_Y27_N24
\inst|Selector6~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector6~5_combout\ = ((\inst|Selector6~3_combout\) # ((\inst|now_state.STATE_18~regout\ & \inst|c1|hrlsb\(3)))) # (!\inst|Selector6~4_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_18~regout\,
	datab => \inst|Selector6~4_combout\,
	datac => \inst|c1|hrlsb\(3),
	datad => \inst|Selector6~3_combout\,
	combout => \inst|Selector6~5_combout\);

-- Location: LCCOMB_X46_Y27_N12
\inst|Selector6~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector6~6_combout\ = ((\inst|Selector6~0_combout\) # ((\inst|Selector6~1_combout\) # (\inst|Selector6~5_combout\))) # (!\inst|WideOr2~6_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|WideOr2~6_combout\,
	datab => \inst|Selector6~0_combout\,
	datac => \inst|Selector6~1_combout\,
	datad => \inst|Selector6~5_combout\,
	combout => \inst|Selector6~6_combout\);

-- Location: LCFF_X46_Y27_N13
\inst|LCD_DATA_VALUE[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector6~6_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|LCD_DATA_VALUE\(3));

-- Location: LCCOMB_X46_Y28_N22
\inst|Selector7~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector7~5_combout\ = (\inst|now_state.STATE_23~regout\ & ((\inst|c1|secmsb\(2)) # ((\inst|now_state.STATE_20~regout\ & \inst|c1|minmsb\(2))))) # (!\inst|now_state.STATE_23~regout\ & (\inst|now_state.STATE_20~regout\ & ((\inst|c1|minmsb\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_23~regout\,
	datab => \inst|now_state.STATE_20~regout\,
	datac => \inst|c1|secmsb\(2),
	datad => \inst|c1|minmsb\(2),
	combout => \inst|Selector7~5_combout\);

-- Location: LCCOMB_X46_Y28_N24
\inst|Selector7~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector7~6_combout\ = (\inst|now_state.MODE_SET~regout\) # ((\inst|Selector7~5_combout\) # ((\inst|LCD_DATA_VALUE\(2) & !\inst|WideOr2~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LCD_DATA_VALUE\(2),
	datab => \inst|WideOr2~5_combout\,
	datac => \inst|now_state.MODE_SET~regout\,
	datad => \inst|Selector7~5_combout\,
	combout => \inst|Selector7~6_combout\);

-- Location: LCCOMB_X46_Y28_N2
\inst|Selector7~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector7~2_combout\ = (\inst|now_state.STATE_21~regout\ & ((\inst|c1|minlsb\(2)) # ((\inst|c1|minlsb\(1) & \inst|c1|minlsb\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_21~regout\,
	datab => \inst|c1|minlsb\(2),
	datac => \inst|c1|minlsb\(1),
	datad => \inst|c1|minlsb\(3),
	combout => \inst|Selector7~2_combout\);

-- Location: LCCOMB_X46_Y28_N8
\inst|Selector7~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector7~1_combout\ = (\inst|now_state.STATE_24~regout\ & ((\inst|c1|seclsb\(2)) # ((\inst|c1|seclsb\(3) & \inst|c1|seclsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|seclsb\(3),
	datab => \inst|now_state.STATE_24~regout\,
	datac => \inst|c1|seclsb\(1),
	datad => \inst|c1|seclsb\(2),
	combout => \inst|Selector7~1_combout\);

-- Location: LCCOMB_X48_Y28_N22
\inst|Selector7~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector7~3_combout\ = (\inst|now_state.STATE_18~regout\ & ((\inst|c1|hrlsb\(2)) # ((\inst|c1|hrlsb\(3) & !\inst|c1|hrlsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_18~regout\,
	datab => \inst|c1|hrlsb\(2),
	datac => \inst|c1|hrlsb\(3),
	datad => \inst|c1|hrlsb\(1),
	combout => \inst|Selector7~3_combout\);

-- Location: LCCOMB_X46_Y28_N28
\inst|Selector7~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector7~4_combout\ = (\inst|Selector7~0_combout\) # ((\inst|Selector7~2_combout\) # ((\inst|Selector7~1_combout\) # (\inst|Selector7~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Selector7~0_combout\,
	datab => \inst|Selector7~2_combout\,
	datac => \inst|Selector7~1_combout\,
	datad => \inst|Selector7~3_combout\,
	combout => \inst|Selector7~4_combout\);

-- Location: LCCOMB_X46_Y28_N0
\inst|Selector7~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector7~8_combout\ = (\inst|Selector7~7_combout\) # ((\inst|now_state.STATE_8~regout\) # ((\inst|Selector7~6_combout\) # (\inst|Selector7~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Selector7~7_combout\,
	datab => \inst|now_state.STATE_8~regout\,
	datac => \inst|Selector7~6_combout\,
	datad => \inst|Selector7~4_combout\,
	combout => \inst|Selector7~8_combout\);

-- Location: LCFF_X46_Y28_N1
\inst|LCD_DATA_VALUE[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector7~8_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|LCD_DATA_VALUE\(2));

-- Location: LCCOMB_X46_Y28_N4
\inst|Selector8~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector8~7_combout\ = (\inst|Selector8~6_combout\) # ((\inst|now_state.MODE_SET~regout\) # ((!\inst|WideOr2~5_combout\ & \inst|LCD_DATA_VALUE\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Selector8~6_combout\,
	datab => \inst|WideOr2~5_combout\,
	datac => \inst|now_state.MODE_SET~regout\,
	datad => \inst|LCD_DATA_VALUE\(1),
	combout => \inst|Selector8~7_combout\);

-- Location: LCCOMB_X45_Y28_N12
\inst|Selector8~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector8~8_combout\ = (\inst|now_state.STATE_8~regout\ & ((\SW~combout\(0)) # ((\inst|now_state.STATE_17~regout\ & \inst|c1|hrmsb\(1))))) # (!\inst|now_state.STATE_8~regout\ & (\inst|now_state.STATE_17~regout\ & (\inst|c1|hrmsb\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_8~regout\,
	datab => \inst|now_state.STATE_17~regout\,
	datac => \inst|c1|hrmsb\(1),
	datad => \SW~combout\(0),
	combout => \inst|Selector8~8_combout\);

-- Location: LCCOMB_X46_Y28_N14
\inst|Selector8~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector8~9_combout\ = (\inst|Selector8~8_combout\) # ((\inst|now_state.STATE_3~regout\ & !\SW~combout\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|now_state.STATE_3~regout\,
	datac => \SW~combout\(0),
	datad => \inst|Selector8~8_combout\,
	combout => \inst|Selector8~9_combout\);

-- Location: LCCOMB_X46_Y28_N30
\inst|Selector8~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector8~2_combout\ = (\inst|now_state.STATE_24~regout\ & ((\inst|c1|seclsb\(1)) # ((\inst|c1|seclsb\(3) & \inst|c1|seclsb\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|seclsb\(3),
	datab => \inst|now_state.STATE_24~regout\,
	datac => \inst|c1|seclsb\(1),
	datad => \inst|c1|seclsb\(2),
	combout => \inst|Selector8~2_combout\);

-- Location: LCCOMB_X46_Y28_N16
\inst|Selector8~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector8~3_combout\ = (\inst|now_state.STATE_21~regout\ & ((\inst|c1|minlsb\(1)) # ((\inst|c1|minlsb\(2) & \inst|c1|minlsb\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_21~regout\,
	datab => \inst|c1|minlsb\(2),
	datac => \inst|c1|minlsb\(1),
	datad => \inst|c1|minlsb\(3),
	combout => \inst|Selector8~3_combout\);

-- Location: LCCOMB_X48_Y28_N16
\inst|Selector8~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector8~4_combout\ = (\inst|now_state.STATE_18~regout\ & (((\inst|c1|hrlsb\(2) & \inst|c1|hrlsb\(3))) # (!\inst|c1|hrlsb\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_18~regout\,
	datab => \inst|c1|hrlsb\(2),
	datac => \inst|c1|hrlsb\(3),
	datad => \inst|c1|hrlsb\(1),
	combout => \inst|Selector8~4_combout\);

-- Location: LCCOMB_X46_Y28_N26
\inst|Selector8~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector8~5_combout\ = (\inst|Selector8~1_combout\) # ((\inst|Selector8~2_combout\) # ((\inst|Selector8~3_combout\) # (\inst|Selector8~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Selector8~1_combout\,
	datab => \inst|Selector8~2_combout\,
	datac => \inst|Selector8~3_combout\,
	datad => \inst|Selector8~4_combout\,
	combout => \inst|Selector8~5_combout\);

-- Location: LCCOMB_X46_Y28_N18
\inst|Selector8~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector8~10_combout\ = (\inst|Selector8~0_combout\) # ((\inst|Selector8~7_combout\) # ((\inst|Selector8~9_combout\) # (\inst|Selector8~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Selector8~0_combout\,
	datab => \inst|Selector8~7_combout\,
	datac => \inst|Selector8~9_combout\,
	datad => \inst|Selector8~5_combout\,
	combout => \inst|Selector8~10_combout\);

-- Location: LCFF_X46_Y28_N19
\inst|LCD_DATA_VALUE[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector8~10_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|LCD_DATA_VALUE\(1));

-- Location: LCCOMB_X47_Y26_N4
\inst|now_state~127\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~127_combout\ = (\inst|next_state.STATE_4~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|next_state.STATE_4~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~127_combout\);

-- Location: LCFF_X47_Y26_N5
\inst|now_state.STATE_4\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~127_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_4~regout\);

-- Location: LCCOMB_X45_Y27_N2
\inst|Selector20~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector20~0_combout\ = (\inst|now_state.STATE_4~regout\) # ((\inst|next_state.STATE_5~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.WAITUP~regout\,
	datac => \inst|next_state.STATE_5~regout\,
	datad => \inst|now_state.STATE_4~regout\,
	combout => \inst|Selector20~0_combout\);

-- Location: LCFF_X45_Y27_N3
\inst|next_state.STATE_5\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector20~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_5~regout\);

-- Location: LCCOMB_X45_Y27_N10
\inst|now_state~102\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~102_combout\ = (\inst|next_state.STATE_5~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.STATE_5~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~102_combout\);

-- Location: LCFF_X45_Y27_N11
\inst|now_state.STATE_5\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~102_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_5~regout\);

-- Location: LCCOMB_X48_Y27_N26
\inst|Selector3~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector3~1_combout\ = (!\inst|now_state.HOME~regout\ & (!\inst|now_state.MODE_SET~regout\ & (!\inst|now_state.STATE_5~regout\ & !\inst|now_state.STATE_32~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.HOME~regout\,
	datab => \inst|now_state.MODE_SET~regout\,
	datac => \inst|now_state.STATE_5~regout\,
	datad => \inst|now_state.STATE_32~regout\,
	combout => \inst|Selector3~1_combout\);

-- Location: LCCOMB_X45_Y27_N26
\inst|Selector51~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector51~0_combout\ = (\inst|now_state.CLEAR~regout\) # ((\inst|next_state.DISP_ON~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.CLEAR~regout\,
	datac => \inst|next_state.DISP_ON~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector51~0_combout\);

-- Location: LCFF_X45_Y27_N27
\inst|next_state.DISP_ON\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector51~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.DISP_ON~regout\);

-- Location: LCCOMB_X45_Y27_N24
\inst|now_state~93\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~93_combout\ = (\inst|next_state.DISP_ON~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.DISP_ON~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~93_combout\);

-- Location: LCFF_X45_Y27_N25
\inst|now_state.DISP_ON\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~93_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.DISP_ON~regout\);

-- Location: LCCOMB_X45_Y27_N18
\inst|WideOr2~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|WideOr2~3_combout\ = (!\inst|now_state.DISP_ON~regout\ & !\inst|now_state.DISP_OFF~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|now_state.DISP_ON~regout\,
	datad => \inst|now_state.DISP_OFF~regout\,
	combout => \inst|WideOr2~3_combout\);

-- Location: LCCOMB_X45_Y27_N30
\inst|Selector24~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector24~0_combout\ = (\inst|now_state.STATE_8~regout\) # ((\inst|next_state.STATE_9~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.STATE_8~regout\,
	datac => \inst|next_state.STATE_9~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector24~0_combout\);

-- Location: LCFF_X45_Y27_N31
\inst|next_state.STATE_9\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector24~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_9~regout\);

-- Location: LCCOMB_X45_Y27_N8
\inst|now_state~128\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~128_combout\ = (\inst|next_state.STATE_9~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.STATE_9~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~128_combout\);

-- Location: LCFF_X45_Y27_N9
\inst|now_state.STATE_9\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~128_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_9~regout\);

-- Location: LCCOMB_X49_Y27_N20
\inst|Selector25~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector25~0_combout\ = (\inst|now_state.STATE_9~regout\) # ((\inst|next_state.STATE_10~regout\ & ((\inst|now_state.WAITUP~regout\) # (\inst|now_state.TOGGLE_E~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.WAITUP~regout\,
	datab => \inst|now_state.STATE_9~regout\,
	datac => \inst|next_state.STATE_10~regout\,
	datad => \inst|now_state.TOGGLE_E~regout\,
	combout => \inst|Selector25~0_combout\);

-- Location: LCFF_X49_Y27_N21
\inst|next_state.STATE_10\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector25~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_10~regout\);

-- Location: LCCOMB_X47_Y26_N2
\inst|now_state~126\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~126_combout\ = (\inst|now_state.WAITUP~regout\ & \inst|next_state.STATE_10~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|now_state.WAITUP~regout\,
	datad => \inst|next_state.STATE_10~regout\,
	combout => \inst|now_state~126_combout\);

-- Location: LCFF_X47_Y26_N3
\inst|now_state.STATE_10\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~126_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_10~regout\);

-- Location: LCCOMB_X47_Y26_N26
\inst|Selector26~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector26~0_combout\ = (\inst|now_state.STATE_10~regout\) # ((\inst|next_state.STATE_11~regout\ & ((\inst|now_state.TOGGLE_E~regout\) # (\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.TOGGLE_E~regout\,
	datab => \inst|now_state.STATE_10~regout\,
	datac => \inst|next_state.STATE_11~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|Selector26~0_combout\);

-- Location: LCFF_X47_Y26_N27
\inst|next_state.STATE_11\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector26~0_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|next_state.STATE_11~regout\);

-- Location: LCCOMB_X47_Y26_N16
\inst|now_state~98\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|now_state~98_combout\ = (\inst|next_state.STATE_11~regout\ & \inst|now_state.WAITUP~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|next_state.STATE_11~regout\,
	datad => \inst|now_state.WAITUP~regout\,
	combout => \inst|now_state~98_combout\);

-- Location: LCFF_X47_Y26_N17
\inst|now_state.STATE_11\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|now_state~98_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|now_state.STATE_11~regout\);

-- Location: LCCOMB_X49_Y27_N24
\inst|Selector3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector3~0_combout\ = (!\inst|now_state.STATE_19~regout\ & (!\inst|now_state.STATE_22~regout\ & ((!\SW~combout\(0)) # (!\inst|now_state.STATE_11~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_19~regout\,
	datab => \inst|now_state.STATE_11~regout\,
	datac => \inst|now_state.STATE_22~regout\,
	datad => \SW~combout\(0),
	combout => \inst|Selector3~0_combout\);

-- Location: LCCOMB_X48_Y27_N20
\inst|Selector3~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector3~2_combout\ = (\inst|WideOr2~2_combout\ & (\inst|Selector3~1_combout\ & (\inst|WideOr2~3_combout\ & \inst|Selector3~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|WideOr2~2_combout\,
	datab => \inst|Selector3~1_combout\,
	datac => \inst|WideOr2~3_combout\,
	datad => \inst|Selector3~0_combout\,
	combout => \inst|Selector3~2_combout\);

-- Location: LCCOMB_X48_Y28_N8
\inst|Selector9~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector9~2_combout\ = (!\inst|now_state.STATE_8~regout\ & ((\inst|LCD_DATA_VALUE\(0)) # ((!\inst|now_state.TOGGLE_E~regout\ & !\inst|now_state.WAITUP~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_8~regout\,
	datab => \inst|now_state.TOGGLE_E~regout\,
	datac => \inst|now_state.WAITUP~regout\,
	datad => \inst|LCD_DATA_VALUE\(0),
	combout => \inst|Selector9~2_combout\);

-- Location: LCCOMB_X48_Y28_N2
\inst|t1|Mux2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|t1|Mux2~0_combout\ = (\inst|c1|seclsb\(0)) # ((\inst|c1|seclsb\(3) & ((\inst|c1|seclsb\(1)) # (\inst|c1|seclsb\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|seclsb\(1),
	datab => \inst|c1|seclsb\(2),
	datac => \inst|c1|seclsb\(0),
	datad => \inst|c1|seclsb\(3),
	combout => \inst|t1|Mux2~0_combout\);

-- Location: LCCOMB_X48_Y28_N20
\inst|Selector9~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector9~0_combout\ = (\inst|c1|secmsb\(0) & (((\inst|t1|Mux2~0_combout\) # (!\inst|now_state.STATE_24~regout\)))) # (!\inst|c1|secmsb\(0) & (!\inst|now_state.STATE_23~regout\ & ((\inst|t1|Mux2~0_combout\) # (!\inst|now_state.STATE_24~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101100001011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|secmsb\(0),
	datab => \inst|now_state.STATE_23~regout\,
	datac => \inst|now_state.STATE_24~regout\,
	datad => \inst|t1|Mux2~0_combout\,
	combout => \inst|Selector9~0_combout\);

-- Location: LCCOMB_X48_Y28_N26
\inst|t5|Mux2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|t5|Mux2~0_combout\ = (\inst|c1|hrlsb\(0)) # ((\inst|c1|hrlsb\(3) & ((\inst|c1|hrlsb\(2)) # (!\inst|c1|hrlsb\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|c1|hrlsb\(2),
	datab => \inst|c1|hrlsb\(0),
	datac => \inst|c1|hrlsb\(3),
	datad => \inst|c1|hrlsb\(1),
	combout => \inst|t5|Mux2~0_combout\);

-- Location: LCCOMB_X48_Y28_N12
\inst|Selector9~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector9~3_combout\ = (\inst|now_state.STATE_17~regout\ & (!\inst|c1|hrmsb\(0) & ((\inst|t5|Mux2~0_combout\) # (!\inst|now_state.STATE_18~regout\)))) # (!\inst|now_state.STATE_17~regout\ & (((\inst|t5|Mux2~0_combout\)) # 
-- (!\inst|now_state.STATE_18~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111100010011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|now_state.STATE_17~regout\,
	datab => \inst|now_state.STATE_18~regout\,
	datac => \inst|c1|hrmsb\(0),
	datad => \inst|t5|Mux2~0_combout\,
	combout => \inst|Selector9~3_combout\);

-- Location: LCCOMB_X48_Y28_N6
\inst|Selector9~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector9~4_combout\ = (\inst|Selector9~1_combout\ & (\inst|Selector9~2_combout\ & (\inst|Selector9~0_combout\ & \inst|Selector9~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Selector9~1_combout\,
	datab => \inst|Selector9~2_combout\,
	datac => \inst|Selector9~0_combout\,
	datad => \inst|Selector9~3_combout\,
	combout => \inst|Selector9~4_combout\);

-- Location: LCCOMB_X48_Y28_N14
\inst|Selector9~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \inst|Selector9~7_combout\ = (\inst|Selector9~6_combout\ & (\inst|Selector3~2_combout\ & (\inst|Selector3~5_combout\ & \inst|Selector9~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Selector9~6_combout\,
	datab => \inst|Selector3~2_combout\,
	datac => \inst|Selector3~5_combout\,
	datad => \inst|Selector9~4_combout\,
	combout => \inst|Selector9~7_combout\);

-- Location: LCFF_X48_Y28_N15
\inst|LCD_DATA_VALUE[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLOCK_50~clkctrl_outclk\,
	datain => \inst|Selector9~7_combout\,
	ena => \inst|cntr_clk~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \inst|LCD_DATA_VALUE\(0));

-- Location: PIN_K2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_BLON~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_BLON);

-- Location: PIN_L4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_ON~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_ON);

-- Location: PIN_K3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_EN~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|LCD_EN~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_EN);

-- Location: PIN_K4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_RW~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_RW);

-- Location: PIN_K1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_RS~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|LCD_RS~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_RS);

-- Location: PIN_V13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(6));

-- Location: PIN_V14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(5));

-- Location: PIN_AE11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(4));

-- Location: PIN_AD11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(3));

-- Location: PIN_AC12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(2));

-- Location: PIN_AB12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(1));

-- Location: PIN_AF10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX0[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX0(0));

-- Location: PIN_AB24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(6));

-- Location: PIN_AA23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(5));

-- Location: PIN_AA24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(4));

-- Location: PIN_Y22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(3));

-- Location: PIN_W21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(2));

-- Location: PIN_V21,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(1));

-- Location: PIN_V20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX1[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX1(0));

-- Location: PIN_Y24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX2[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d1|ALT_INV_Mux0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX2(6));

-- Location: PIN_AB25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX2[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d1|Mux1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX2(5));

-- Location: PIN_AB26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX2[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d1|Mux2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX2(4));

-- Location: PIN_AC26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX2[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d1|Mux3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX2(3));

-- Location: PIN_AC25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX2[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d1|Mux4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX2(2));

-- Location: PIN_V22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX2[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d1|Mux5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX2(1));

-- Location: PIN_AB23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX2[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d1|Mux6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX2(0));

-- Location: PIN_W24,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX3[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d2|Mux0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX3(6));

-- Location: PIN_U22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX3[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d2|Mux1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX3(5));

-- Location: PIN_Y25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX3[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d2|Mux2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX3(4));

-- Location: PIN_Y26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX3[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d2|Mux3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX3(3));

-- Location: PIN_AA26,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX3[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d2|Mux4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX3(2));

-- Location: PIN_AA25,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX3[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d2|ALT_INV_Mux5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX3(1));

-- Location: PIN_Y23,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX3[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d2|Mux6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX3(0));

-- Location: PIN_T3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX4[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d3|ALT_INV_Mux0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX4(6));

-- Location: PIN_R6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX4[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d3|Mux1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX4(5));

-- Location: PIN_R7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX4[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d3|Mux2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX4(4));

-- Location: PIN_T4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX4[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d3|Mux3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX4(3));

-- Location: PIN_U2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX4[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d3|Mux4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX4(2));

-- Location: PIN_U1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX4[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d3|Mux5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX4(1));

-- Location: PIN_U9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX4[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d3|Mux6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX4(0));

-- Location: PIN_R3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX5[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d4|Mux0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX5(6));

-- Location: PIN_R4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX5[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d4|Mux1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX5(5));

-- Location: PIN_R5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX5[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d4|Mux2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX5(4));

-- Location: PIN_T9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX5[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d4|Mux3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX5(3));

-- Location: PIN_P7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX5[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d4|Mux4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX5(2));

-- Location: PIN_P6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX5[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d4|ALT_INV_Mux5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX5(1));

-- Location: PIN_T2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX5[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d4|Mux6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX5(0));

-- Location: PIN_M4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX6[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d5|ALT_INV_Mux0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX6(6));

-- Location: PIN_M5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX6[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d5|Mux1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX6(5));

-- Location: PIN_M3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX6[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d5|Mux2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX6(4));

-- Location: PIN_M2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX6[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d5|Mux3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX6(3));

-- Location: PIN_P3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX6[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d5|Mux4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX6(2));

-- Location: PIN_P4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX6[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d5|Mux5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX6(1));

-- Location: PIN_R2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX6[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d5|Mux6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX6(0));

-- Location: PIN_N9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX7[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|ALT_INV_hrmsb\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX7(6));

-- Location: PIN_P9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX7[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d6|Mux1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX7(5));

-- Location: PIN_L7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX7[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|ALT_INV_hrmsb\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX7(4));

-- Location: PIN_L6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX7[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d6|Mux1~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX7(3));

-- Location: PIN_L9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX7[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d6|Mux1~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX7(2));

-- Location: PIN_L2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX7[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX7(1));

-- Location: PIN_L3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\HEX7[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|c1|d6|Mux1~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_HEX7(0));

-- Location: PIN_H3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_DATA[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|LCD_DATA_VALUE\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_DATA(7));

-- Location: PIN_H4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_DATA[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|LCD_DATA_VALUE\(6),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_DATA(6));

-- Location: PIN_J3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_DATA[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|LCD_DATA_VALUE\(5),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_DATA(5));

-- Location: PIN_J4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_DATA[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|LCD_DATA_VALUE\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_DATA(4));

-- Location: PIN_H2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_DATA[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|LCD_DATA_VALUE\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_DATA(3));

-- Location: PIN_H1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_DATA[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|LCD_DATA_VALUE\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_DATA(2));

-- Location: PIN_J2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_DATA[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|LCD_DATA_VALUE\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_DATA(1));

-- Location: PIN_J1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\LCD_DATA[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \inst|LCD_DATA_VALUE\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_LCD_DATA(0));
END structure;


