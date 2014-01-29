--megafunction wizard: %Altera SOPC Builder%
--GENERATION: STANDARD
--VERSION: WM1.0


--Legal Notice: (C)2010 Altera Corporation. All rights reserved.  Your
--use of Altera Corporation's design tools, logic functions and other
--software and tools, and its AMPP partner logic functions, and any
--output files any of the foregoing (including device programming or
--simulation files), and any associated documentation or information are
--expressly subject to the terms and conditions of the Altera Program
--License Subscription Agreement or other applicable license agreement,
--including, without limitation, that your use is for the sole purpose
--of programming logic devices manufactured by Altera and sold by Altera
--or its authorized distributors.  Please refer to the applicable
--agreement for further details.


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity CPU_jtag_debug_module_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_debugaccess : IN STD_LOGIC;
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CPU_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
                 signal CPU_instruction_master_latency_counter : IN STD_LOGIC;
                 signal CPU_instruction_master_read : IN STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register : IN STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : IN STD_LOGIC;
                 signal CPU_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CPU_jtag_debug_module_resetrequest : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_CPU_jtag_debug_module : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_CPU_jtag_debug_module : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_CPU_jtag_debug_module : OUT STD_LOGIC;
                 signal CPU_data_master_requests_CPU_jtag_debug_module : OUT STD_LOGIC;
                 signal CPU_instruction_master_granted_CPU_jtag_debug_module : OUT STD_LOGIC;
                 signal CPU_instruction_master_qualified_request_CPU_jtag_debug_module : OUT STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_CPU_jtag_debug_module : OUT STD_LOGIC;
                 signal CPU_instruction_master_requests_CPU_jtag_debug_module : OUT STD_LOGIC;
                 signal CPU_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal CPU_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                 signal CPU_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_jtag_debug_module_chipselect : OUT STD_LOGIC;
                 signal CPU_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                 signal CPU_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CPU_jtag_debug_module_reset_n : OUT STD_LOGIC;
                 signal CPU_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                 signal CPU_jtag_debug_module_write : OUT STD_LOGIC;
                 signal CPU_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_CPU_jtag_debug_module_end_xfer : OUT STD_LOGIC
              );
end entity CPU_jtag_debug_module_arbitrator;


architecture europa of CPU_jtag_debug_module_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_saved_grant_CPU_jtag_debug_module :  STD_LOGIC;
                signal CPU_instruction_master_arbiterlock :  STD_LOGIC;
                signal CPU_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_instruction_master_continuerequest :  STD_LOGIC;
                signal CPU_instruction_master_saved_grant_CPU_jtag_debug_module :  STD_LOGIC;
                signal CPU_jtag_debug_module_allgrants :  STD_LOGIC;
                signal CPU_jtag_debug_module_allow_new_arb_cycle :  STD_LOGIC;
                signal CPU_jtag_debug_module_any_bursting_master_saved_grant :  STD_LOGIC;
                signal CPU_jtag_debug_module_any_continuerequest :  STD_LOGIC;
                signal CPU_jtag_debug_module_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_jtag_debug_module_arb_counter_enable :  STD_LOGIC;
                signal CPU_jtag_debug_module_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_jtag_debug_module_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_jtag_debug_module_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_jtag_debug_module_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_jtag_debug_module_arbitration_holdoff_internal :  STD_LOGIC;
                signal CPU_jtag_debug_module_beginbursttransfer_internal :  STD_LOGIC;
                signal CPU_jtag_debug_module_begins_xfer :  STD_LOGIC;
                signal CPU_jtag_debug_module_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal CPU_jtag_debug_module_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal CPU_jtag_debug_module_firsttransfer :  STD_LOGIC;
                signal CPU_jtag_debug_module_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_jtag_debug_module_in_a_read_cycle :  STD_LOGIC;
                signal CPU_jtag_debug_module_in_a_write_cycle :  STD_LOGIC;
                signal CPU_jtag_debug_module_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_jtag_debug_module_non_bursting_master_requests :  STD_LOGIC;
                signal CPU_jtag_debug_module_reg_firsttransfer :  STD_LOGIC;
                signal CPU_jtag_debug_module_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_jtag_debug_module_slavearbiterlockenable :  STD_LOGIC;
                signal CPU_jtag_debug_module_slavearbiterlockenable2 :  STD_LOGIC;
                signal CPU_jtag_debug_module_unreg_firsttransfer :  STD_LOGIC;
                signal CPU_jtag_debug_module_waits_for_read :  STD_LOGIC;
                signal CPU_jtag_debug_module_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_CPU_jtag_debug_module :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_CPU_jtag_debug_module :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_CPU_jtag_debug_module :  STD_LOGIC;
                signal internal_CPU_data_master_requests_CPU_jtag_debug_module :  STD_LOGIC;
                signal internal_CPU_instruction_master_granted_CPU_jtag_debug_module :  STD_LOGIC;
                signal internal_CPU_instruction_master_qualified_request_CPU_jtag_debug_module :  STD_LOGIC;
                signal internal_CPU_instruction_master_requests_CPU_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_CPU_data_master_granted_slave_CPU_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_CPU_instruction_master_granted_slave_CPU_jtag_debug_module :  STD_LOGIC;
                signal shifted_address_to_CPU_jtag_debug_module_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal shifted_address_to_CPU_jtag_debug_module_from_CPU_instruction_master :  STD_LOGIC_VECTOR (27 DOWNTO 0);
                signal wait_for_CPU_jtag_debug_module_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT CPU_jtag_debug_module_end_xfer;
    end if;

  end process;

  CPU_jtag_debug_module_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_CPU_data_master_qualified_request_CPU_jtag_debug_module OR internal_CPU_instruction_master_qualified_request_CPU_jtag_debug_module));
  --assign CPU_jtag_debug_module_readdata_from_sa = CPU_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  CPU_jtag_debug_module_readdata_from_sa <= CPU_jtag_debug_module_readdata;
  internal_CPU_data_master_requests_CPU_jtag_debug_module <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("01010000000000000000000000000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --CPU_jtag_debug_module_arb_share_counter set values, which is an e_mux
  CPU_jtag_debug_module_arb_share_set_values <= std_logic_vector'("01");
  --CPU_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  CPU_jtag_debug_module_non_bursting_master_requests <= ((internal_CPU_data_master_requests_CPU_jtag_debug_module OR internal_CPU_instruction_master_requests_CPU_jtag_debug_module) OR internal_CPU_data_master_requests_CPU_jtag_debug_module) OR internal_CPU_instruction_master_requests_CPU_jtag_debug_module;
  --CPU_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  CPU_jtag_debug_module_any_bursting_master_saved_grant <= std_logic'('0');
  --CPU_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  CPU_jtag_debug_module_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(CPU_jtag_debug_module_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (CPU_jtag_debug_module_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(CPU_jtag_debug_module_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (CPU_jtag_debug_module_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --CPU_jtag_debug_module_allgrants all slave grants, which is an e_mux
  CPU_jtag_debug_module_allgrants <= (((or_reduce(CPU_jtag_debug_module_grant_vector)) OR (or_reduce(CPU_jtag_debug_module_grant_vector))) OR (or_reduce(CPU_jtag_debug_module_grant_vector))) OR (or_reduce(CPU_jtag_debug_module_grant_vector));
  --CPU_jtag_debug_module_end_xfer assignment, which is an e_assign
  CPU_jtag_debug_module_end_xfer <= NOT ((CPU_jtag_debug_module_waits_for_read OR CPU_jtag_debug_module_waits_for_write));
  --end_xfer_arb_share_counter_term_CPU_jtag_debug_module arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_CPU_jtag_debug_module <= CPU_jtag_debug_module_end_xfer AND (((NOT CPU_jtag_debug_module_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --CPU_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  CPU_jtag_debug_module_arb_counter_enable <= ((end_xfer_arb_share_counter_term_CPU_jtag_debug_module AND CPU_jtag_debug_module_allgrants)) OR ((end_xfer_arb_share_counter_term_CPU_jtag_debug_module AND NOT CPU_jtag_debug_module_non_bursting_master_requests));
  --CPU_jtag_debug_module_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_jtag_debug_module_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(CPU_jtag_debug_module_arb_counter_enable) = '1' then 
        CPU_jtag_debug_module_arb_share_counter <= CPU_jtag_debug_module_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --CPU_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_jtag_debug_module_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(CPU_jtag_debug_module_master_qreq_vector) AND end_xfer_arb_share_counter_term_CPU_jtag_debug_module)) OR ((end_xfer_arb_share_counter_term_CPU_jtag_debug_module AND NOT CPU_jtag_debug_module_non_bursting_master_requests)))) = '1' then 
        CPU_jtag_debug_module_slavearbiterlockenable <= or_reduce(CPU_jtag_debug_module_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master CPU/jtag_debug_module arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= CPU_jtag_debug_module_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --CPU_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  CPU_jtag_debug_module_slavearbiterlockenable2 <= or_reduce(CPU_jtag_debug_module_arb_share_counter_next_value);
  --CPU/data_master CPU/jtag_debug_module arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= CPU_jtag_debug_module_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --CPU/instruction_master CPU/jtag_debug_module arbiterlock, which is an e_assign
  CPU_instruction_master_arbiterlock <= CPU_jtag_debug_module_slavearbiterlockenable AND CPU_instruction_master_continuerequest;
  --CPU/instruction_master CPU/jtag_debug_module arbiterlock2, which is an e_assign
  CPU_instruction_master_arbiterlock2 <= CPU_jtag_debug_module_slavearbiterlockenable2 AND CPU_instruction_master_continuerequest;
  --CPU/instruction_master granted CPU/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_CPU_instruction_master_granted_slave_CPU_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_CPU_instruction_master_granted_slave_CPU_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(CPU_instruction_master_saved_grant_CPU_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((CPU_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_CPU_instruction_master_requests_CPU_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_CPU_instruction_master_granted_slave_CPU_jtag_debug_module))))));
    end if;

  end process;

  --CPU_instruction_master_continuerequest continued request, which is an e_mux
  CPU_instruction_master_continuerequest <= last_cycle_CPU_instruction_master_granted_slave_CPU_jtag_debug_module AND internal_CPU_instruction_master_requests_CPU_jtag_debug_module;
  --CPU_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  CPU_jtag_debug_module_any_continuerequest <= CPU_instruction_master_continuerequest OR CPU_data_master_continuerequest;
  internal_CPU_data_master_qualified_request_CPU_jtag_debug_module <= internal_CPU_data_master_requests_CPU_jtag_debug_module AND NOT (((((NOT CPU_data_master_waitrequest) AND CPU_data_master_write)) OR CPU_instruction_master_arbiterlock));
  --CPU_jtag_debug_module_writedata mux, which is an e_mux
  CPU_jtag_debug_module_writedata <= CPU_data_master_writedata;
  internal_CPU_instruction_master_requests_CPU_jtag_debug_module <= ((to_std_logic(((Std_Logic_Vector'(CPU_instruction_master_address_to_slave(27 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("1010000000000000000000000000")))) AND (CPU_instruction_master_read))) AND CPU_instruction_master_read;
  --CPU/data_master granted CPU/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_CPU_data_master_granted_slave_CPU_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_CPU_data_master_granted_slave_CPU_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(CPU_data_master_saved_grant_CPU_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((CPU_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_CPU_data_master_requests_CPU_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_CPU_data_master_granted_slave_CPU_jtag_debug_module))))));
    end if;

  end process;

  --CPU_data_master_continuerequest continued request, which is an e_mux
  CPU_data_master_continuerequest <= last_cycle_CPU_data_master_granted_slave_CPU_jtag_debug_module AND internal_CPU_data_master_requests_CPU_jtag_debug_module;
  internal_CPU_instruction_master_qualified_request_CPU_jtag_debug_module <= internal_CPU_instruction_master_requests_CPU_jtag_debug_module AND NOT ((((CPU_instruction_master_read AND (((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))) OR (CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register)) OR (CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register))))) OR CPU_data_master_arbiterlock));
  --local readdatavalid CPU_instruction_master_read_data_valid_CPU_jtag_debug_module, which is an e_mux
  CPU_instruction_master_read_data_valid_CPU_jtag_debug_module <= (internal_CPU_instruction_master_granted_CPU_jtag_debug_module AND CPU_instruction_master_read) AND NOT CPU_jtag_debug_module_waits_for_read;
  --allow new arb cycle for CPU/jtag_debug_module, which is an e_assign
  CPU_jtag_debug_module_allow_new_arb_cycle <= NOT CPU_data_master_arbiterlock AND NOT CPU_instruction_master_arbiterlock;
  --CPU/instruction_master assignment into master qualified-requests vector for CPU/jtag_debug_module, which is an e_assign
  CPU_jtag_debug_module_master_qreq_vector(0) <= internal_CPU_instruction_master_qualified_request_CPU_jtag_debug_module;
  --CPU/instruction_master grant CPU/jtag_debug_module, which is an e_assign
  internal_CPU_instruction_master_granted_CPU_jtag_debug_module <= CPU_jtag_debug_module_grant_vector(0);
  --CPU/instruction_master saved-grant CPU/jtag_debug_module, which is an e_assign
  CPU_instruction_master_saved_grant_CPU_jtag_debug_module <= CPU_jtag_debug_module_arb_winner(0) AND internal_CPU_instruction_master_requests_CPU_jtag_debug_module;
  --CPU/data_master assignment into master qualified-requests vector for CPU/jtag_debug_module, which is an e_assign
  CPU_jtag_debug_module_master_qreq_vector(1) <= internal_CPU_data_master_qualified_request_CPU_jtag_debug_module;
  --CPU/data_master grant CPU/jtag_debug_module, which is an e_assign
  internal_CPU_data_master_granted_CPU_jtag_debug_module <= CPU_jtag_debug_module_grant_vector(1);
  --CPU/data_master saved-grant CPU/jtag_debug_module, which is an e_assign
  CPU_data_master_saved_grant_CPU_jtag_debug_module <= CPU_jtag_debug_module_arb_winner(1) AND internal_CPU_data_master_requests_CPU_jtag_debug_module;
  --CPU/jtag_debug_module chosen-master double-vector, which is an e_assign
  CPU_jtag_debug_module_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((CPU_jtag_debug_module_master_qreq_vector & CPU_jtag_debug_module_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT CPU_jtag_debug_module_master_qreq_vector & NOT CPU_jtag_debug_module_master_qreq_vector))) + (std_logic_vector'("000") & (CPU_jtag_debug_module_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  CPU_jtag_debug_module_arb_winner <= A_WE_StdLogicVector((std_logic'(((CPU_jtag_debug_module_allow_new_arb_cycle AND or_reduce(CPU_jtag_debug_module_grant_vector)))) = '1'), CPU_jtag_debug_module_grant_vector, CPU_jtag_debug_module_saved_chosen_master_vector);
  --saved CPU_jtag_debug_module_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_jtag_debug_module_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(CPU_jtag_debug_module_allow_new_arb_cycle) = '1' then 
        CPU_jtag_debug_module_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(CPU_jtag_debug_module_grant_vector)) = '1'), CPU_jtag_debug_module_grant_vector, CPU_jtag_debug_module_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  CPU_jtag_debug_module_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((CPU_jtag_debug_module_chosen_master_double_vector(1) OR CPU_jtag_debug_module_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((CPU_jtag_debug_module_chosen_master_double_vector(0) OR CPU_jtag_debug_module_chosen_master_double_vector(2)))));
  --CPU/jtag_debug_module chosen master rotated left, which is an e_assign
  CPU_jtag_debug_module_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(CPU_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(CPU_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --CPU/jtag_debug_module's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_jtag_debug_module_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(CPU_jtag_debug_module_grant_vector)) = '1' then 
        CPU_jtag_debug_module_arb_addend <= A_WE_StdLogicVector((std_logic'(CPU_jtag_debug_module_end_xfer) = '1'), CPU_jtag_debug_module_chosen_master_rot_left, CPU_jtag_debug_module_grant_vector);
      end if;
    end if;

  end process;

  CPU_jtag_debug_module_begintransfer <= CPU_jtag_debug_module_begins_xfer;
  --CPU_jtag_debug_module_reset_n assignment, which is an e_assign
  CPU_jtag_debug_module_reset_n <= reset_n;
  --assign CPU_jtag_debug_module_resetrequest_from_sa = CPU_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  CPU_jtag_debug_module_resetrequest_from_sa <= CPU_jtag_debug_module_resetrequest;
  CPU_jtag_debug_module_chipselect <= internal_CPU_data_master_granted_CPU_jtag_debug_module OR internal_CPU_instruction_master_granted_CPU_jtag_debug_module;
  --CPU_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  CPU_jtag_debug_module_firsttransfer <= A_WE_StdLogic((std_logic'(CPU_jtag_debug_module_begins_xfer) = '1'), CPU_jtag_debug_module_unreg_firsttransfer, CPU_jtag_debug_module_reg_firsttransfer);
  --CPU_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  CPU_jtag_debug_module_unreg_firsttransfer <= NOT ((CPU_jtag_debug_module_slavearbiterlockenable AND CPU_jtag_debug_module_any_continuerequest));
  --CPU_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_jtag_debug_module_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(CPU_jtag_debug_module_begins_xfer) = '1' then 
        CPU_jtag_debug_module_reg_firsttransfer <= CPU_jtag_debug_module_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --CPU_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  CPU_jtag_debug_module_beginbursttransfer_internal <= CPU_jtag_debug_module_begins_xfer;
  --CPU_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  CPU_jtag_debug_module_arbitration_holdoff_internal <= CPU_jtag_debug_module_begins_xfer AND CPU_jtag_debug_module_firsttransfer;
  --CPU_jtag_debug_module_write assignment, which is an e_mux
  CPU_jtag_debug_module_write <= internal_CPU_data_master_granted_CPU_jtag_debug_module AND CPU_data_master_write;
  shifted_address_to_CPU_jtag_debug_module_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --CPU_jtag_debug_module_address mux, which is an e_mux
  CPU_jtag_debug_module_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_CPU_jtag_debug_module)) = '1'), (A_SRL(shifted_address_to_CPU_jtag_debug_module_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010"))), (std_logic_vector'("0") & ((A_SRL(shifted_address_to_CPU_jtag_debug_module_from_CPU_instruction_master,std_logic_vector'("00000000000000000000000000000010")))))), 9);
  shifted_address_to_CPU_jtag_debug_module_from_CPU_instruction_master <= CPU_instruction_master_address_to_slave;
  --d1_CPU_jtag_debug_module_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_CPU_jtag_debug_module_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_CPU_jtag_debug_module_end_xfer <= CPU_jtag_debug_module_end_xfer;
    end if;

  end process;

  --CPU_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  CPU_jtag_debug_module_waits_for_read <= CPU_jtag_debug_module_in_a_read_cycle AND CPU_jtag_debug_module_begins_xfer;
  --CPU_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  CPU_jtag_debug_module_in_a_read_cycle <= ((internal_CPU_data_master_granted_CPU_jtag_debug_module AND CPU_data_master_read)) OR ((internal_CPU_instruction_master_granted_CPU_jtag_debug_module AND CPU_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= CPU_jtag_debug_module_in_a_read_cycle;
  --CPU_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  CPU_jtag_debug_module_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_jtag_debug_module_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --CPU_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  CPU_jtag_debug_module_in_a_write_cycle <= internal_CPU_data_master_granted_CPU_jtag_debug_module AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= CPU_jtag_debug_module_in_a_write_cycle;
  wait_for_CPU_jtag_debug_module_counter <= std_logic'('0');
  --CPU_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  CPU_jtag_debug_module_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_CPU_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CPU_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --debugaccess mux, which is an e_mux
  CPU_jtag_debug_module_debugaccess <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_CPU_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_data_master_debugaccess))), std_logic_vector'("00000000000000000000000000000000")));
  --vhdl renameroo for output signals
  CPU_data_master_granted_CPU_jtag_debug_module <= internal_CPU_data_master_granted_CPU_jtag_debug_module;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_CPU_jtag_debug_module <= internal_CPU_data_master_qualified_request_CPU_jtag_debug_module;
  --vhdl renameroo for output signals
  CPU_data_master_requests_CPU_jtag_debug_module <= internal_CPU_data_master_requests_CPU_jtag_debug_module;
  --vhdl renameroo for output signals
  CPU_instruction_master_granted_CPU_jtag_debug_module <= internal_CPU_instruction_master_granted_CPU_jtag_debug_module;
  --vhdl renameroo for output signals
  CPU_instruction_master_qualified_request_CPU_jtag_debug_module <= internal_CPU_instruction_master_qualified_request_CPU_jtag_debug_module;
  --vhdl renameroo for output signals
  CPU_instruction_master_requests_CPU_jtag_debug_module <= internal_CPU_instruction_master_requests_CPU_jtag_debug_module;
--synthesis translate_off
    --CPU/jtag_debug_module enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_CPU_data_master_granted_CPU_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_CPU_instruction_master_granted_CPU_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line, now);
          write(write_line, string'(": "));
          write(write_line, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line.all);
          deallocate (write_line);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line1 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(CPU_data_master_saved_grant_CPU_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_saved_grant_CPU_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line1, now);
          write(write_line1, string'(": "));
          write(write_line1, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line1.all);
          deallocate (write_line1);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity CPU_data_master_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable_SDRAM_s1 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal CPU_data_master_byteenable_SRAM_avalon_sram_slave : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal CPU_data_master_granted_CPU_jtag_debug_module : IN STD_LOGIC;
                 signal CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_granted_Interval_timer_s1 : IN STD_LOGIC;
                 signal CPU_data_master_granted_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                 signal CPU_data_master_granted_Onchip_memory_s2 : IN STD_LOGIC;
                 signal CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_granted_SDRAM_s1 : IN STD_LOGIC;
                 signal CPU_data_master_granted_SRAM_avalon_sram_slave : IN STD_LOGIC;
                 signal CPU_data_master_granted_Serial_port_avalon_rs232_slave : IN STD_LOGIC;
                 signal CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_granted_sysid_control_slave : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_CPU_jtag_debug_module : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_Interval_timer_s1 : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_Onchip_memory_s2 : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_SDRAM_s1 : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_SRAM_avalon_sram_slave : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_qualified_request_sysid_control_slave : IN STD_LOGIC;
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_CPU_jtag_debug_module : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Interval_timer_s1 : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Onchip_memory_s2 : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_SDRAM_s1 : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_SDRAM_s1_shift_register : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_SRAM_avalon_sram_slave : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_read_data_valid_sysid_control_slave : IN STD_LOGIC;
                 signal CPU_data_master_requests_CPU_jtag_debug_module : IN STD_LOGIC;
                 signal CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_requests_Interval_timer_s1 : IN STD_LOGIC;
                 signal CPU_data_master_requests_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                 signal CPU_data_master_requests_Onchip_memory_s2 : IN STD_LOGIC;
                 signal CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_requests_SDRAM_s1 : IN STD_LOGIC;
                 signal CPU_data_master_requests_SRAM_avalon_sram_slave : IN STD_LOGIC;
                 signal CPU_data_master_requests_Serial_port_avalon_rs232_slave : IN STD_LOGIC;
                 signal CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal CPU_data_master_requests_sysid_control_slave : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CPU_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Expansion_JP1_avalon_parallel_port_slave_irq_from_sa : IN STD_LOGIC;
                 signal Expansion_JP1_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Expansion_JP2_avalon_parallel_port_slave_irq_from_sa : IN STD_LOGIC;
                 signal Expansion_JP2_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Green_LEDs_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal HEX3_HEX0_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal HEX7_HEX4_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Interval_timer_s1_irq_from_sa : IN STD_LOGIC;
                 signal Interval_timer_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal JTAG_UART_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal JTAG_UART_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                 signal Onchip_memory_s2_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Pushbuttons_avalon_parallel_port_slave_irq_from_sa : IN STD_LOGIC;
                 signal Pushbuttons_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Red_LEDs_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal SDRAM_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SDRAM_s1_waitrequest_from_sa : IN STD_LOGIC;
                 signal SRAM_avalon_sram_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal Serial_port_avalon_rs232_slave_irq_from_sa : IN STD_LOGIC;
                 signal Serial_port_avalon_rs232_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Slider_switches_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal d1_CPU_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_Expansion_JP1_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                 signal d1_Expansion_JP2_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                 signal d1_Green_LEDs_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                 signal d1_HEX3_HEX0_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                 signal d1_HEX7_HEX4_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                 signal d1_Interval_timer_s1_end_xfer : IN STD_LOGIC;
                 signal d1_JTAG_UART_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                 signal d1_Onchip_memory_s2_end_xfer : IN STD_LOGIC;
                 signal d1_Pushbuttons_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                 signal d1_Red_LEDs_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                 signal d1_SDRAM_s1_end_xfer : IN STD_LOGIC;
                 signal d1_SRAM_avalon_sram_slave_end_xfer : IN STD_LOGIC;
                 signal d1_Serial_port_avalon_rs232_slave_end_xfer : IN STD_LOGIC;
                 signal d1_Slider_switches_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                 signal d1_sysid_control_slave_end_xfer : IN STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Onchip_memory_s2 : IN STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave : IN STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sysid_control_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- outputs:
                 signal CPU_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal CPU_data_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal CPU_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CPU_data_master_no_byte_enables_and_last_term : OUT STD_LOGIC;
                 signal CPU_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CPU_data_master_waitrequest : OUT STD_LOGIC
              );
end entity CPU_data_master_arbitrator;


architecture europa of CPU_data_master_arbitrator is
                signal CPU_data_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_data_master_run :  STD_LOGIC;
                signal dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal internal_CPU_data_master_address_to_slave :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal internal_CPU_data_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_CPU_data_master_no_byte_enables_and_last_term :  STD_LOGIC;
                signal internal_CPU_data_master_waitrequest :  STD_LOGIC;
                signal last_dbs_term_and_run :  STD_LOGIC;
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal p1_registered_CPU_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;
                signal r_2 :  STD_LOGIC;
                signal r_3 :  STD_LOGIC;
                signal registered_CPU_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_qualified_request_CPU_jtag_debug_module OR NOT CPU_data_master_requests_CPU_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_granted_CPU_jtag_debug_module OR NOT CPU_data_master_qualified_request_CPU_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_CPU_jtag_debug_module OR NOT CPU_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_CPU_jtag_debug_module OR NOT CPU_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave OR registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave) OR NOT CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave OR NOT CPU_data_master_read) OR ((registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave AND CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave OR NOT ((CPU_data_master_read OR CPU_data_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_read OR CPU_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave OR registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave) OR NOT CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave OR NOT CPU_data_master_read) OR ((registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave AND CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave OR NOT ((CPU_data_master_read OR CPU_data_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_read OR CPU_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave OR registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave) OR NOT CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave OR NOT CPU_data_master_read) OR ((registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave AND CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave OR NOT ((CPU_data_master_read OR CPU_data_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_read OR CPU_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave OR registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave) OR NOT CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave OR NOT CPU_data_master_read) OR ((registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave AND CPU_data_master_read)))))))));
  --cascaded wait assignment, which is an e_assign
  CPU_data_master_run <= ((r_0 AND r_1) AND r_2) AND r_3;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic(((((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave OR NOT ((CPU_data_master_read OR CPU_data_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_read OR CPU_data_master_write))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave OR registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave) OR NOT CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave OR NOT CPU_data_master_read) OR ((registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave AND CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave OR NOT ((CPU_data_master_read OR CPU_data_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_read OR CPU_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_qualified_request_Interval_timer_s1 OR NOT CPU_data_master_requests_Interval_timer_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_Interval_timer_s1 OR NOT CPU_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_Interval_timer_s1 OR NOT CPU_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave OR NOT CPU_data_master_requests_JTAG_UART_avalon_jtag_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave OR NOT ((CPU_data_master_read OR CPU_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT JTAG_UART_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_read OR CPU_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave OR NOT ((CPU_data_master_read OR CPU_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT JTAG_UART_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_read OR CPU_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((CPU_data_master_qualified_request_Onchip_memory_s2 OR registered_CPU_data_master_read_data_valid_Onchip_memory_s2) OR NOT CPU_data_master_requests_Onchip_memory_s2)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CPU_data_master_qualified_request_Onchip_memory_s2 OR NOT CPU_data_master_read) OR ((registered_CPU_data_master_read_data_valid_Onchip_memory_s2 AND CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_Onchip_memory_s2 OR NOT ((CPU_data_master_read OR CPU_data_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_read OR CPU_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave OR registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave) OR NOT CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave OR NOT CPU_data_master_read) OR ((registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave AND CPU_data_master_read)))))))));
  --r_2 master_run cascaded wait assignment, which is an e_assign
  r_2 <= Vector_To_Std_Logic(((((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave OR NOT ((CPU_data_master_read OR CPU_data_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_read OR CPU_data_master_write))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave OR registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave) OR NOT CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave OR NOT CPU_data_master_read) OR ((registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave AND CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave OR NOT ((CPU_data_master_read OR CPU_data_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_read OR CPU_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((((CPU_data_master_qualified_request_SDRAM_s1 OR ((CPU_data_master_read_data_valid_SDRAM_s1 AND internal_CPU_data_master_dbs_address(1)))) OR (((CPU_data_master_write AND NOT(or_reduce(CPU_data_master_byteenable_SDRAM_s1))) AND internal_CPU_data_master_dbs_address(1)))) OR NOT CPU_data_master_requests_SDRAM_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_granted_SDRAM_s1 OR NOT CPU_data_master_qualified_request_SDRAM_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CPU_data_master_qualified_request_SDRAM_s1 OR NOT CPU_data_master_read) OR (((CPU_data_master_read_data_valid_SDRAM_s1 AND (internal_CPU_data_master_dbs_address(1))) AND CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_SDRAM_s1 OR NOT CPU_data_master_write)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT SDRAM_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_CPU_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((((CPU_data_master_qualified_request_SRAM_avalon_sram_slave OR ((CPU_data_master_read_data_valid_SRAM_avalon_sram_slave AND internal_CPU_data_master_dbs_address(1)))) OR (((CPU_data_master_write AND NOT(or_reduce(CPU_data_master_byteenable_SRAM_avalon_sram_slave))) AND internal_CPU_data_master_dbs_address(1)))) OR NOT CPU_data_master_requests_SRAM_avalon_sram_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_granted_SRAM_avalon_sram_slave OR NOT CPU_data_master_qualified_request_SRAM_avalon_sram_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CPU_data_master_qualified_request_SRAM_avalon_sram_slave OR NOT CPU_data_master_read) OR (((CPU_data_master_read_data_valid_SRAM_avalon_sram_slave AND (internal_CPU_data_master_dbs_address(1))) AND CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_SRAM_avalon_sram_slave OR NOT CPU_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_CPU_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave OR registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave) OR NOT CPU_data_master_requests_Serial_port_avalon_rs232_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave OR NOT CPU_data_master_read) OR ((registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave AND CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave OR NOT ((CPU_data_master_read OR CPU_data_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_read OR CPU_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")));
  --r_3 master_run cascaded wait assignment, which is an e_assign
  r_3 <= Vector_To_Std_Logic((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((((CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave OR registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave) OR NOT CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave)) AND (((NOT CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave OR NOT CPU_data_master_read) OR ((registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave AND CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave OR NOT ((CPU_data_master_read OR CPU_data_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_read OR CPU_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_sysid_control_slave OR NOT CPU_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_data_master_qualified_request_sysid_control_slave OR NOT CPU_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_data_master_write)))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_CPU_data_master_address_to_slave <= Std_Logic_Vector'(CPU_data_master_address(28 DOWNTO 27) & A_ToStdLogicVector(std_logic'('0')) & CPU_data_master_address(25 DOWNTO 24) & A_ToStdLogicVector(std_logic'('0')) & CPU_data_master_address(22 DOWNTO 0));
  --CPU/data_master readdata mux, which is an e_mux
  CPU_data_master_readdata <= ((((((((((((((((A_REP(NOT CPU_data_master_requests_CPU_jtag_debug_module, 32) OR CPU_jtag_debug_module_readdata_from_sa)) AND ((A_REP(NOT CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave, 32) OR Expansion_JP1_avalon_parallel_port_slave_readdata_from_sa))) AND ((A_REP(NOT CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave, 32) OR Expansion_JP2_avalon_parallel_port_slave_readdata_from_sa))) AND ((A_REP(NOT CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave, 32) OR Green_LEDs_avalon_parallel_port_slave_readdata_from_sa))) AND ((A_REP(NOT CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave, 32) OR HEX3_HEX0_avalon_parallel_port_slave_readdata_from_sa))) AND ((A_REP(NOT CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave, 32) OR HEX7_HEX4_avalon_parallel_port_slave_readdata_from_sa))) AND ((A_REP(NOT CPU_data_master_requests_Interval_timer_s1, 32) OR (std_logic_vector'("0000000000000000") & (Interval_timer_s1_readdata_from_sa))))) AND ((A_REP(NOT CPU_data_master_requests_JTAG_UART_avalon_jtag_slave, 32) OR registered_CPU_data_master_readdata))) AND ((A_REP(NOT CPU_data_master_requests_Onchip_memory_s2, 32) OR Onchip_memory_s2_readdata_from_sa))) AND ((A_REP(NOT CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave, 32) OR Pushbuttons_avalon_parallel_port_slave_readdata_from_sa))) AND ((A_REP(NOT CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave, 32) OR Red_LEDs_avalon_parallel_port_slave_readdata_from_sa))) AND ((A_REP(NOT CPU_data_master_requests_SDRAM_s1, 32) OR registered_CPU_data_master_readdata))) AND ((A_REP(NOT CPU_data_master_requests_SRAM_avalon_sram_slave, 32) OR registered_CPU_data_master_readdata))) AND ((A_REP(NOT CPU_data_master_requests_Serial_port_avalon_rs232_slave, 32) OR Serial_port_avalon_rs232_slave_readdata_from_sa))) AND ((A_REP(NOT CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave, 32) OR Slider_switches_avalon_parallel_port_slave_readdata_from_sa))) AND ((A_REP(NOT CPU_data_master_requests_sysid_control_slave, 32) OR sysid_control_slave_readdata_from_sa));
  --actual waitrequest port, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_CPU_data_master_waitrequest <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      internal_CPU_data_master_waitrequest <= Vector_To_Std_Logic(NOT (A_WE_StdLogicVector((std_logic'((NOT ((CPU_data_master_read OR CPU_data_master_write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_data_master_run AND internal_CPU_data_master_waitrequest))))))));
    end if;

  end process;

  --irq assign, which is an e_assign
  CPU_data_master_irq <= Std_Logic_Vector'(A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(Expansion_JP2_avalon_parallel_port_slave_irq_from_sa) & A_ToStdLogicVector(Expansion_JP1_avalon_parallel_port_slave_irq_from_sa) & A_ToStdLogicVector(Serial_port_avalon_rs232_slave_irq_from_sa) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(JTAG_UART_avalon_jtag_slave_irq_from_sa) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(Pushbuttons_avalon_parallel_port_slave_irq_from_sa) & A_ToStdLogicVector(Interval_timer_s1_irq_from_sa));
  --unpredictable registered wait state incoming data, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      registered_CPU_data_master_readdata <= std_logic_vector'("00000000000000000000000000000000");
    elsif clk'event and clk = '1' then
      registered_CPU_data_master_readdata <= p1_registered_CPU_data_master_readdata;
    end if;

  end process;

  --registered readdata mux, which is an e_mux
  p1_registered_CPU_data_master_readdata <= (((A_REP(NOT CPU_data_master_requests_JTAG_UART_avalon_jtag_slave, 32) OR JTAG_UART_avalon_jtag_slave_readdata_from_sa)) AND ((A_REP(NOT CPU_data_master_requests_SDRAM_s1, 32) OR Std_Logic_Vector'(SDRAM_s1_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0)))) AND ((A_REP(NOT CPU_data_master_requests_SRAM_avalon_sram_slave, 32) OR Std_Logic_Vector'(SRAM_avalon_sram_slave_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0)));
  --no_byte_enables_and_last_term, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_CPU_data_master_no_byte_enables_and_last_term <= std_logic'('0');
    elsif clk'event and clk = '1' then
      internal_CPU_data_master_no_byte_enables_and_last_term <= last_dbs_term_and_run;
    end if;

  end process;

  --compute the last dbs term, which is an e_mux
  last_dbs_term_and_run <= A_WE_StdLogic((std_logic'((CPU_data_master_requests_SDRAM_s1)) = '1'), (((to_std_logic(((internal_CPU_data_master_dbs_address = std_logic_vector'("10")))) AND CPU_data_master_write) AND NOT(or_reduce(CPU_data_master_byteenable_SDRAM_s1)))), (((to_std_logic(((internal_CPU_data_master_dbs_address = std_logic_vector'("10")))) AND CPU_data_master_write) AND NOT(or_reduce(CPU_data_master_byteenable_SRAM_avalon_sram_slave)))));
  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((((((NOT internal_CPU_data_master_no_byte_enables_and_last_term) AND CPU_data_master_requests_SDRAM_s1) AND CPU_data_master_write) AND NOT(or_reduce(CPU_data_master_byteenable_SDRAM_s1)))) OR CPU_data_master_read_data_valid_SDRAM_s1)))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((CPU_data_master_granted_SDRAM_s1 AND CPU_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT SDRAM_s1_waitrequest_from_sa)))))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((((NOT internal_CPU_data_master_no_byte_enables_and_last_term) AND CPU_data_master_requests_SRAM_avalon_sram_slave) AND CPU_data_master_write) AND NOT(or_reduce(CPU_data_master_byteenable_SRAM_avalon_sram_slave)))))))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_data_master_read_data_valid_SRAM_avalon_sram_slave)))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((CPU_data_master_granted_SRAM_avalon_sram_slave AND CPU_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))));
  --input to dbs-16 stored 0, which is an e_mux
  p1_dbs_16_reg_segment_0 <= A_WE_StdLogicVector((std_logic'((CPU_data_master_requests_SDRAM_s1)) = '1'), SDRAM_s1_readdata_from_sa, SRAM_avalon_sram_slave_readdata_from_sa);
  --dbs register for dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_CPU_data_master_dbs_address(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
      end if;
    end if;

  end process;

  --mux write dbs 1, which is an e_mux
  CPU_data_master_dbs_write_16 <= A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_dbs_address(1))) = '1'), CPU_data_master_writedata(31 DOWNTO 16), A_WE_StdLogicVector((std_logic'((NOT (internal_CPU_data_master_dbs_address(1)))) = '1'), CPU_data_master_writedata(15 DOWNTO 0), A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_dbs_address(1))) = '1'), CPU_data_master_writedata(31 DOWNTO 16), CPU_data_master_writedata(15 DOWNTO 0))));
  --dbs count increment, which is an e_mux
  CPU_data_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((CPU_data_master_requests_SDRAM_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((CPU_data_master_requests_SRAM_avalon_sram_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000000"))), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_CPU_data_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_CPU_data_master_dbs_address)) + (std_logic_vector'("0") & (CPU_data_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= (pre_dbs_count_enable AND (NOT ((CPU_data_master_requests_SDRAM_s1 AND NOT internal_CPU_data_master_waitrequest)))) AND (NOT ((CPU_data_master_requests_SRAM_avalon_sram_slave AND NOT internal_CPU_data_master_waitrequest)));
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_CPU_data_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_CPU_data_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --vhdl renameroo for output signals
  CPU_data_master_address_to_slave <= internal_CPU_data_master_address_to_slave;
  --vhdl renameroo for output signals
  CPU_data_master_dbs_address <= internal_CPU_data_master_dbs_address;
  --vhdl renameroo for output signals
  CPU_data_master_no_byte_enables_and_last_term <= internal_CPU_data_master_no_byte_enables_and_last_term;
  --vhdl renameroo for output signals
  CPU_data_master_waitrequest <= internal_CPU_data_master_waitrequest;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity CPU_instruction_master_arbitrator is 
        port (
              -- inputs:
                 signal CPU_instruction_master_address : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
                 signal CPU_instruction_master_granted_CPU_jtag_debug_module : IN STD_LOGIC;
                 signal CPU_instruction_master_granted_Onchip_memory_s1 : IN STD_LOGIC;
                 signal CPU_instruction_master_granted_SDRAM_s1 : IN STD_LOGIC;
                 signal CPU_instruction_master_granted_SRAM_avalon_sram_slave : IN STD_LOGIC;
                 signal CPU_instruction_master_qualified_request_CPU_jtag_debug_module : IN STD_LOGIC;
                 signal CPU_instruction_master_qualified_request_Onchip_memory_s1 : IN STD_LOGIC;
                 signal CPU_instruction_master_qualified_request_SDRAM_s1 : IN STD_LOGIC;
                 signal CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave : IN STD_LOGIC;
                 signal CPU_instruction_master_read : IN STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_CPU_jtag_debug_module : IN STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_Onchip_memory_s1 : IN STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SDRAM_s1 : IN STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register : IN STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave : IN STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : IN STD_LOGIC;
                 signal CPU_instruction_master_requests_CPU_jtag_debug_module : IN STD_LOGIC;
                 signal CPU_instruction_master_requests_Onchip_memory_s1 : IN STD_LOGIC;
                 signal CPU_instruction_master_requests_SDRAM_s1 : IN STD_LOGIC;
                 signal CPU_instruction_master_requests_SRAM_avalon_sram_slave : IN STD_LOGIC;
                 signal CPU_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Onchip_memory_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal SDRAM_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SDRAM_s1_waitrequest_from_sa : IN STD_LOGIC;
                 signal SRAM_avalon_sram_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal d1_CPU_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_Onchip_memory_s1_end_xfer : IN STD_LOGIC;
                 signal d1_SDRAM_s1_end_xfer : IN STD_LOGIC;
                 signal d1_SRAM_avalon_sram_slave_end_xfer : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (27 DOWNTO 0);
                 signal CPU_instruction_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal CPU_instruction_master_latency_counter : OUT STD_LOGIC;
                 signal CPU_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CPU_instruction_master_readdatavalid : OUT STD_LOGIC;
                 signal CPU_instruction_master_waitrequest : OUT STD_LOGIC
              );
end entity CPU_instruction_master_arbitrator;


architecture europa of CPU_instruction_master_arbitrator is
                signal CPU_instruction_master_address_last_time :  STD_LOGIC_VECTOR (27 DOWNTO 0);
                signal CPU_instruction_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_instruction_master_dbs_rdv_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_instruction_master_dbs_rdv_counter_inc :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_instruction_master_is_granted_some_slave :  STD_LOGIC;
                signal CPU_instruction_master_next_dbs_rdv_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_instruction_master_read_but_no_slave_selected :  STD_LOGIC;
                signal CPU_instruction_master_read_last_time :  STD_LOGIC;
                signal CPU_instruction_master_run :  STD_LOGIC;
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal dbs_latent_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_rdv_count_enable :  STD_LOGIC;
                signal dbs_rdv_counter_overflow :  STD_LOGIC;
                signal internal_CPU_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (27 DOWNTO 0);
                signal internal_CPU_instruction_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_CPU_instruction_master_latency_counter :  STD_LOGIC;
                signal internal_CPU_instruction_master_waitrequest :  STD_LOGIC;
                signal latency_load_value :  STD_LOGIC;
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_CPU_instruction_master_latency_counter :  STD_LOGIC;
                signal p1_dbs_latent_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal pre_flush_CPU_instruction_master_readdatavalid :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;
                signal r_2 :  STD_LOGIC;

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_instruction_master_qualified_request_CPU_jtag_debug_module OR NOT CPU_instruction_master_requests_CPU_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_instruction_master_granted_CPU_jtag_debug_module OR NOT CPU_instruction_master_qualified_request_CPU_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_instruction_master_qualified_request_CPU_jtag_debug_module OR NOT CPU_instruction_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_CPU_jtag_debug_module_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_read)))))))));
  --cascaded wait assignment, which is an e_assign
  CPU_instruction_master_run <= (r_0 AND r_1) AND r_2;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_instruction_master_qualified_request_Onchip_memory_s1 OR NOT CPU_instruction_master_requests_Onchip_memory_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_instruction_master_qualified_request_Onchip_memory_s1 OR NOT (CPU_instruction_master_read))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((CPU_instruction_master_read))))))))));
  --r_2 master_run cascaded wait assignment, which is an e_assign
  r_2 <= Vector_To_Std_Logic((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_instruction_master_qualified_request_SDRAM_s1 OR NOT CPU_instruction_master_requests_SDRAM_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_instruction_master_granted_SDRAM_s1 OR NOT CPU_instruction_master_qualified_request_SDRAM_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_instruction_master_qualified_request_SDRAM_s1 OR NOT CPU_instruction_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT SDRAM_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_CPU_instruction_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_read)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave OR NOT CPU_instruction_master_requests_SRAM_avalon_sram_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CPU_instruction_master_granted_SRAM_avalon_sram_slave OR NOT CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave OR NOT CPU_instruction_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_CPU_instruction_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_read)))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_CPU_instruction_master_address_to_slave <= Std_Logic_Vector'(A_ToStdLogicVector(CPU_instruction_master_address(27)) & A_ToStdLogicVector(std_logic'('0')) & CPU_instruction_master_address(25 DOWNTO 24) & A_ToStdLogicVector(std_logic'('0')) & CPU_instruction_master_address(22 DOWNTO 0));
  --CPU_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_instruction_master_read_but_no_slave_selected <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CPU_instruction_master_read_but_no_slave_selected <= (CPU_instruction_master_read AND CPU_instruction_master_run) AND NOT CPU_instruction_master_is_granted_some_slave;
    end if;

  end process;

  --some slave is getting selected, which is an e_mux
  CPU_instruction_master_is_granted_some_slave <= ((CPU_instruction_master_granted_CPU_jtag_debug_module OR CPU_instruction_master_granted_Onchip_memory_s1) OR CPU_instruction_master_granted_SDRAM_s1) OR CPU_instruction_master_granted_SRAM_avalon_sram_slave;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_CPU_instruction_master_readdatavalid <= (CPU_instruction_master_read_data_valid_Onchip_memory_s1 OR ((CPU_instruction_master_read_data_valid_SDRAM_s1 AND dbs_rdv_counter_overflow))) OR ((CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave AND dbs_rdv_counter_overflow));
  --latent slave read data valid which is not flushed, which is an e_mux
  CPU_instruction_master_readdatavalid <= (((((((CPU_instruction_master_read_but_no_slave_selected OR pre_flush_CPU_instruction_master_readdatavalid) OR CPU_instruction_master_read_data_valid_CPU_jtag_debug_module) OR CPU_instruction_master_read_but_no_slave_selected) OR pre_flush_CPU_instruction_master_readdatavalid) OR CPU_instruction_master_read_but_no_slave_selected) OR pre_flush_CPU_instruction_master_readdatavalid) OR CPU_instruction_master_read_but_no_slave_selected) OR pre_flush_CPU_instruction_master_readdatavalid;
  --CPU/instruction_master readdata mux, which is an e_mux
  CPU_instruction_master_readdata <= ((((A_REP(NOT ((CPU_instruction_master_qualified_request_CPU_jtag_debug_module AND CPU_instruction_master_read)) , 32) OR CPU_jtag_debug_module_readdata_from_sa)) AND ((A_REP(NOT CPU_instruction_master_read_data_valid_Onchip_memory_s1, 32) OR Onchip_memory_s1_readdata_from_sa))) AND ((A_REP(NOT CPU_instruction_master_read_data_valid_SDRAM_s1, 32) OR Std_Logic_Vector'(SDRAM_s1_readdata_from_sa(15 DOWNTO 0) & dbs_latent_16_reg_segment_0)))) AND ((A_REP(NOT CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave, 32) OR Std_Logic_Vector'(SRAM_avalon_sram_slave_readdata_from_sa(15 DOWNTO 0) & dbs_latent_16_reg_segment_0)));
  --actual waitrequest port, which is an e_assign
  internal_CPU_instruction_master_waitrequest <= NOT CPU_instruction_master_run;
  --latent max counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_CPU_instruction_master_latency_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      internal_CPU_instruction_master_latency_counter <= p1_CPU_instruction_master_latency_counter;
    end if;

  end process;

  --latency counter load mux, which is an e_mux
  p1_CPU_instruction_master_latency_counter <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((CPU_instruction_master_run AND CPU_instruction_master_read))) = '1'), (std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(latency_load_value))), A_WE_StdLogicVector((std_logic'((internal_CPU_instruction_master_latency_counter)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(internal_CPU_instruction_master_latency_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  --read latency load values, which is an e_mux
  latency_load_value <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_requests_Onchip_memory_s1))) AND std_logic_vector'("00000000000000000000000000000001")));
  --input to latent dbs-16 stored 0, which is an e_mux
  p1_dbs_latent_16_reg_segment_0 <= A_WE_StdLogicVector((std_logic'((CPU_instruction_master_read_data_valid_SDRAM_s1)) = '1'), SDRAM_s1_readdata_from_sa, SRAM_avalon_sram_slave_readdata_from_sa);
  --dbs register for latent dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((CPU_instruction_master_dbs_rdv_counter(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
      end if;
    end if;

  end process;

  --dbs count increment, which is an e_mux
  CPU_instruction_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((CPU_instruction_master_requests_SDRAM_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((CPU_instruction_master_requests_SRAM_avalon_sram_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000000"))), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_CPU_instruction_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_CPU_instruction_master_dbs_address)) + (std_logic_vector'("0") & (CPU_instruction_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= pre_dbs_count_enable;
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_CPU_instruction_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_CPU_instruction_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --p1 dbs rdv counter, which is an e_assign
  CPU_instruction_master_next_dbs_rdv_counter <= A_EXT (((std_logic_vector'("0") & (CPU_instruction_master_dbs_rdv_counter)) + (std_logic_vector'("0") & (CPU_instruction_master_dbs_rdv_counter_inc))), 2);
  --CPU_instruction_master_rdv_inc_mux, which is an e_mux
  CPU_instruction_master_dbs_rdv_counter_inc <= A_EXT (A_WE_StdLogicVector((std_logic'((CPU_instruction_master_read_data_valid_SDRAM_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000010")), 2);
  --master any slave rdv, which is an e_mux
  dbs_rdv_count_enable <= CPU_instruction_master_read_data_valid_SDRAM_s1 OR CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave;
  --dbs rdv counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_instruction_master_dbs_rdv_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_rdv_count_enable) = '1' then 
        CPU_instruction_master_dbs_rdv_counter <= CPU_instruction_master_next_dbs_rdv_counter;
      end if;
    end if;

  end process;

  --dbs rdv counter overflow, which is an e_assign
  dbs_rdv_counter_overflow <= CPU_instruction_master_dbs_rdv_counter(1) AND NOT CPU_instruction_master_next_dbs_rdv_counter(1);
  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic(((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((CPU_instruction_master_granted_SDRAM_s1 AND CPU_instruction_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT SDRAM_s1_waitrequest_from_sa))))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((CPU_instruction_master_granted_SRAM_avalon_sram_slave AND CPU_instruction_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))));
  --vhdl renameroo for output signals
  CPU_instruction_master_address_to_slave <= internal_CPU_instruction_master_address_to_slave;
  --vhdl renameroo for output signals
  CPU_instruction_master_dbs_address <= internal_CPU_instruction_master_dbs_address;
  --vhdl renameroo for output signals
  CPU_instruction_master_latency_counter <= internal_CPU_instruction_master_latency_counter;
  --vhdl renameroo for output signals
  CPU_instruction_master_waitrequest <= internal_CPU_instruction_master_waitrequest;
--synthesis translate_off
    --CPU_instruction_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        CPU_instruction_master_address_last_time <= std_logic_vector'("0000000000000000000000000000");
      elsif clk'event and clk = '1' then
        CPU_instruction_master_address_last_time <= CPU_instruction_master_address;
      end if;

    end process;

    --CPU/instruction_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_CPU_instruction_master_waitrequest AND (CPU_instruction_master_read);
      end if;

    end process;

    --CPU_instruction_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line2 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((CPU_instruction_master_address /= CPU_instruction_master_address_last_time))))) = '1' then 
          write(write_line2, now);
          write(write_line2, string'(": "));
          write(write_line2, string'("CPU_instruction_master_address did not heed wait!!!"));
          write(output, write_line2.all);
          deallocate (write_line2);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --CPU_instruction_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        CPU_instruction_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        CPU_instruction_master_read_last_time <= CPU_instruction_master_read;
      end if;

    end process;

    --CPU_instruction_master_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line3 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(CPU_instruction_master_read) /= std_logic'(CPU_instruction_master_read_last_time)))))) = '1' then 
          write(write_line3, now);
          write(write_line3, string'(": "));
          write(write_line3, string'("CPU_instruction_master_read did not heed wait!!!"));
          write(output, write_line3.all);
          deallocate (write_line3);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Expansion_JP1_avalon_parallel_port_slave_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Expansion_JP1_avalon_parallel_port_slave_irq : IN STD_LOGIC;
                 signal Expansion_JP1_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal Expansion_JP1_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Expansion_JP1_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal Expansion_JP1_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                 signal Expansion_JP1_avalon_parallel_port_slave_irq_from_sa : OUT STD_LOGIC;
                 signal Expansion_JP1_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                 signal Expansion_JP1_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Expansion_JP1_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                 signal Expansion_JP1_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                 signal Expansion_JP1_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_Expansion_JP1_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave : OUT STD_LOGIC
              );
end entity Expansion_JP1_avalon_parallel_port_slave_arbitrator;


architecture europa of Expansion_JP1_avalon_parallel_port_slave_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register_in :  STD_LOGIC;
                signal CPU_data_master_saved_grant_Expansion_JP1_avalon_parallel_port_slave :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_allgrants :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_any_continuerequest :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_arb_counter_enable :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Expansion_JP1_avalon_parallel_port_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Expansion_JP1_avalon_parallel_port_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Expansion_JP1_avalon_parallel_port_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_begins_xfer :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_firsttransfer :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_grant_vector :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_in_a_read_cycle :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_in_a_write_cycle :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_master_qreq_vector :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_non_bursting_master_requests :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_reg_firsttransfer :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_slavearbiterlockenable :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_unreg_firsttransfer :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_waits_for_read :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Expansion_JP1_avalon_parallel_port_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave :  STD_LOGIC;
                signal p1_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal shifted_address_to_Expansion_JP1_avalon_parallel_port_slave_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal wait_for_Expansion_JP1_avalon_parallel_port_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Expansion_JP1_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  Expansion_JP1_avalon_parallel_port_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave);
  --assign Expansion_JP1_avalon_parallel_port_slave_readdata_from_sa = Expansion_JP1_avalon_parallel_port_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_readdata_from_sa <= Expansion_JP1_avalon_parallel_port_slave_readdata;
  internal_CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("10000000000000000000001100000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --registered rdv signal_name registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave assignment, which is an e_assign
  registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register_in;
  --Expansion_JP1_avalon_parallel_port_slave_arb_share_counter set values, which is an e_mux
  Expansion_JP1_avalon_parallel_port_slave_arb_share_set_values <= std_logic_vector'("01");
  --Expansion_JP1_avalon_parallel_port_slave_non_bursting_master_requests mux, which is an e_mux
  Expansion_JP1_avalon_parallel_port_slave_non_bursting_master_requests <= internal_CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave;
  --Expansion_JP1_avalon_parallel_port_slave_any_bursting_master_saved_grant mux, which is an e_mux
  Expansion_JP1_avalon_parallel_port_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --Expansion_JP1_avalon_parallel_port_slave_arb_share_counter_next_value assignment, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(Expansion_JP1_avalon_parallel_port_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Expansion_JP1_avalon_parallel_port_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(Expansion_JP1_avalon_parallel_port_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Expansion_JP1_avalon_parallel_port_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --Expansion_JP1_avalon_parallel_port_slave_allgrants all slave grants, which is an e_mux
  Expansion_JP1_avalon_parallel_port_slave_allgrants <= Expansion_JP1_avalon_parallel_port_slave_grant_vector;
  --Expansion_JP1_avalon_parallel_port_slave_end_xfer assignment, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_end_xfer <= NOT ((Expansion_JP1_avalon_parallel_port_slave_waits_for_read OR Expansion_JP1_avalon_parallel_port_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_Expansion_JP1_avalon_parallel_port_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Expansion_JP1_avalon_parallel_port_slave <= Expansion_JP1_avalon_parallel_port_slave_end_xfer AND (((NOT Expansion_JP1_avalon_parallel_port_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Expansion_JP1_avalon_parallel_port_slave_arb_share_counter arbitration counter enable, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Expansion_JP1_avalon_parallel_port_slave AND Expansion_JP1_avalon_parallel_port_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_Expansion_JP1_avalon_parallel_port_slave AND NOT Expansion_JP1_avalon_parallel_port_slave_non_bursting_master_requests));
  --Expansion_JP1_avalon_parallel_port_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Expansion_JP1_avalon_parallel_port_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(Expansion_JP1_avalon_parallel_port_slave_arb_counter_enable) = '1' then 
        Expansion_JP1_avalon_parallel_port_slave_arb_share_counter <= Expansion_JP1_avalon_parallel_port_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Expansion_JP1_avalon_parallel_port_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Expansion_JP1_avalon_parallel_port_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Expansion_JP1_avalon_parallel_port_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_Expansion_JP1_avalon_parallel_port_slave)) OR ((end_xfer_arb_share_counter_term_Expansion_JP1_avalon_parallel_port_slave AND NOT Expansion_JP1_avalon_parallel_port_slave_non_bursting_master_requests)))) = '1' then 
        Expansion_JP1_avalon_parallel_port_slave_slavearbiterlockenable <= or_reduce(Expansion_JP1_avalon_parallel_port_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master Expansion_JP1/avalon_parallel_port_slave arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= Expansion_JP1_avalon_parallel_port_slave_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --Expansion_JP1_avalon_parallel_port_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_slavearbiterlockenable2 <= or_reduce(Expansion_JP1_avalon_parallel_port_slave_arb_share_counter_next_value);
  --CPU/data_master Expansion_JP1/avalon_parallel_port_slave arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= Expansion_JP1_avalon_parallel_port_slave_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --Expansion_JP1_avalon_parallel_port_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave AND NOT ((((CPU_data_master_read AND (CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register))) OR (((NOT CPU_data_master_waitrequest) AND CPU_data_master_write))));
  --CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register_in <= ((internal_CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave AND CPU_data_master_read) AND NOT Expansion_JP1_avalon_parallel_port_slave_waits_for_read) AND NOT (CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register);
  --shift register p1 CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register) & A_ToStdLogicVector(CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register_in)));
  --CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register <= p1_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register;
    end if;

  end process;

  --local readdatavalid CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave, which is an e_mux
  CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave_shift_register;
  --Expansion_JP1_avalon_parallel_port_slave_writedata mux, which is an e_mux
  Expansion_JP1_avalon_parallel_port_slave_writedata <= CPU_data_master_writedata;
  --master is always granted when requested
  internal_CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave;
  --CPU/data_master saved-grant Expansion_JP1/avalon_parallel_port_slave, which is an e_assign
  CPU_data_master_saved_grant_Expansion_JP1_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave;
  --allow new arb cycle for Expansion_JP1/avalon_parallel_port_slave, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Expansion_JP1_avalon_parallel_port_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Expansion_JP1_avalon_parallel_port_slave_master_qreq_vector <= std_logic'('1');
  --~Expansion_JP1_avalon_parallel_port_slave_reset assignment, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_reset <= NOT reset_n;
  Expansion_JP1_avalon_parallel_port_slave_chipselect <= internal_CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave;
  --Expansion_JP1_avalon_parallel_port_slave_firsttransfer first transaction, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_firsttransfer <= A_WE_StdLogic((std_logic'(Expansion_JP1_avalon_parallel_port_slave_begins_xfer) = '1'), Expansion_JP1_avalon_parallel_port_slave_unreg_firsttransfer, Expansion_JP1_avalon_parallel_port_slave_reg_firsttransfer);
  --Expansion_JP1_avalon_parallel_port_slave_unreg_firsttransfer first transaction, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_unreg_firsttransfer <= NOT ((Expansion_JP1_avalon_parallel_port_slave_slavearbiterlockenable AND Expansion_JP1_avalon_parallel_port_slave_any_continuerequest));
  --Expansion_JP1_avalon_parallel_port_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Expansion_JP1_avalon_parallel_port_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Expansion_JP1_avalon_parallel_port_slave_begins_xfer) = '1' then 
        Expansion_JP1_avalon_parallel_port_slave_reg_firsttransfer <= Expansion_JP1_avalon_parallel_port_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Expansion_JP1_avalon_parallel_port_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_beginbursttransfer_internal <= Expansion_JP1_avalon_parallel_port_slave_begins_xfer;
  --Expansion_JP1_avalon_parallel_port_slave_read assignment, which is an e_mux
  Expansion_JP1_avalon_parallel_port_slave_read <= internal_CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave AND CPU_data_master_read;
  --Expansion_JP1_avalon_parallel_port_slave_write assignment, which is an e_mux
  Expansion_JP1_avalon_parallel_port_slave_write <= internal_CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave AND CPU_data_master_write;
  shifted_address_to_Expansion_JP1_avalon_parallel_port_slave_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --Expansion_JP1_avalon_parallel_port_slave_address mux, which is an e_mux
  Expansion_JP1_avalon_parallel_port_slave_address <= A_EXT (A_SRL(shifted_address_to_Expansion_JP1_avalon_parallel_port_slave_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_Expansion_JP1_avalon_parallel_port_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Expansion_JP1_avalon_parallel_port_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Expansion_JP1_avalon_parallel_port_slave_end_xfer <= Expansion_JP1_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  --Expansion_JP1_avalon_parallel_port_slave_waits_for_read in a cycle, which is an e_mux
  Expansion_JP1_avalon_parallel_port_slave_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Expansion_JP1_avalon_parallel_port_slave_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Expansion_JP1_avalon_parallel_port_slave_in_a_read_cycle assignment, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_in_a_read_cycle <= internal_CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Expansion_JP1_avalon_parallel_port_slave_in_a_read_cycle;
  --Expansion_JP1_avalon_parallel_port_slave_waits_for_write in a cycle, which is an e_mux
  Expansion_JP1_avalon_parallel_port_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Expansion_JP1_avalon_parallel_port_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Expansion_JP1_avalon_parallel_port_slave_in_a_write_cycle assignment, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_in_a_write_cycle <= internal_CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Expansion_JP1_avalon_parallel_port_slave_in_a_write_cycle;
  wait_for_Expansion_JP1_avalon_parallel_port_slave_counter <= std_logic'('0');
  --Expansion_JP1_avalon_parallel_port_slave_byteenable byte enable port mux, which is an e_mux
  Expansion_JP1_avalon_parallel_port_slave_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CPU_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --assign Expansion_JP1_avalon_parallel_port_slave_irq_from_sa = Expansion_JP1_avalon_parallel_port_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  Expansion_JP1_avalon_parallel_port_slave_irq_from_sa <= Expansion_JP1_avalon_parallel_port_slave_irq;
  --vhdl renameroo for output signals
  CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave <= internal_CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave;
--synthesis translate_off
    --Expansion_JP1/avalon_parallel_port_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Expansion_JP2_avalon_parallel_port_slave_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Expansion_JP2_avalon_parallel_port_slave_irq : IN STD_LOGIC;
                 signal Expansion_JP2_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal Expansion_JP2_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Expansion_JP2_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal Expansion_JP2_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                 signal Expansion_JP2_avalon_parallel_port_slave_irq_from_sa : OUT STD_LOGIC;
                 signal Expansion_JP2_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                 signal Expansion_JP2_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Expansion_JP2_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                 signal Expansion_JP2_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                 signal Expansion_JP2_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_Expansion_JP2_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave : OUT STD_LOGIC
              );
end entity Expansion_JP2_avalon_parallel_port_slave_arbitrator;


architecture europa of Expansion_JP2_avalon_parallel_port_slave_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register_in :  STD_LOGIC;
                signal CPU_data_master_saved_grant_Expansion_JP2_avalon_parallel_port_slave :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_allgrants :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_any_continuerequest :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_arb_counter_enable :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Expansion_JP2_avalon_parallel_port_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Expansion_JP2_avalon_parallel_port_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Expansion_JP2_avalon_parallel_port_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_begins_xfer :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_firsttransfer :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_grant_vector :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_in_a_read_cycle :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_in_a_write_cycle :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_master_qreq_vector :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_non_bursting_master_requests :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_reg_firsttransfer :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_slavearbiterlockenable :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_unreg_firsttransfer :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_waits_for_read :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Expansion_JP2_avalon_parallel_port_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave :  STD_LOGIC;
                signal p1_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal shifted_address_to_Expansion_JP2_avalon_parallel_port_slave_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal wait_for_Expansion_JP2_avalon_parallel_port_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Expansion_JP2_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  Expansion_JP2_avalon_parallel_port_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave);
  --assign Expansion_JP2_avalon_parallel_port_slave_readdata_from_sa = Expansion_JP2_avalon_parallel_port_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_readdata_from_sa <= Expansion_JP2_avalon_parallel_port_slave_readdata;
  internal_CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("10000000000000000000001110000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --registered rdv signal_name registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave assignment, which is an e_assign
  registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register_in;
  --Expansion_JP2_avalon_parallel_port_slave_arb_share_counter set values, which is an e_mux
  Expansion_JP2_avalon_parallel_port_slave_arb_share_set_values <= std_logic_vector'("01");
  --Expansion_JP2_avalon_parallel_port_slave_non_bursting_master_requests mux, which is an e_mux
  Expansion_JP2_avalon_parallel_port_slave_non_bursting_master_requests <= internal_CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave;
  --Expansion_JP2_avalon_parallel_port_slave_any_bursting_master_saved_grant mux, which is an e_mux
  Expansion_JP2_avalon_parallel_port_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --Expansion_JP2_avalon_parallel_port_slave_arb_share_counter_next_value assignment, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(Expansion_JP2_avalon_parallel_port_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Expansion_JP2_avalon_parallel_port_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(Expansion_JP2_avalon_parallel_port_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Expansion_JP2_avalon_parallel_port_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --Expansion_JP2_avalon_parallel_port_slave_allgrants all slave grants, which is an e_mux
  Expansion_JP2_avalon_parallel_port_slave_allgrants <= Expansion_JP2_avalon_parallel_port_slave_grant_vector;
  --Expansion_JP2_avalon_parallel_port_slave_end_xfer assignment, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_end_xfer <= NOT ((Expansion_JP2_avalon_parallel_port_slave_waits_for_read OR Expansion_JP2_avalon_parallel_port_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_Expansion_JP2_avalon_parallel_port_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Expansion_JP2_avalon_parallel_port_slave <= Expansion_JP2_avalon_parallel_port_slave_end_xfer AND (((NOT Expansion_JP2_avalon_parallel_port_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Expansion_JP2_avalon_parallel_port_slave_arb_share_counter arbitration counter enable, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Expansion_JP2_avalon_parallel_port_slave AND Expansion_JP2_avalon_parallel_port_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_Expansion_JP2_avalon_parallel_port_slave AND NOT Expansion_JP2_avalon_parallel_port_slave_non_bursting_master_requests));
  --Expansion_JP2_avalon_parallel_port_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Expansion_JP2_avalon_parallel_port_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(Expansion_JP2_avalon_parallel_port_slave_arb_counter_enable) = '1' then 
        Expansion_JP2_avalon_parallel_port_slave_arb_share_counter <= Expansion_JP2_avalon_parallel_port_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Expansion_JP2_avalon_parallel_port_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Expansion_JP2_avalon_parallel_port_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Expansion_JP2_avalon_parallel_port_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_Expansion_JP2_avalon_parallel_port_slave)) OR ((end_xfer_arb_share_counter_term_Expansion_JP2_avalon_parallel_port_slave AND NOT Expansion_JP2_avalon_parallel_port_slave_non_bursting_master_requests)))) = '1' then 
        Expansion_JP2_avalon_parallel_port_slave_slavearbiterlockenable <= or_reduce(Expansion_JP2_avalon_parallel_port_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master Expansion_JP2/avalon_parallel_port_slave arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= Expansion_JP2_avalon_parallel_port_slave_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --Expansion_JP2_avalon_parallel_port_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_slavearbiterlockenable2 <= or_reduce(Expansion_JP2_avalon_parallel_port_slave_arb_share_counter_next_value);
  --CPU/data_master Expansion_JP2/avalon_parallel_port_slave arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= Expansion_JP2_avalon_parallel_port_slave_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --Expansion_JP2_avalon_parallel_port_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave AND NOT ((((CPU_data_master_read AND (CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register))) OR (((NOT CPU_data_master_waitrequest) AND CPU_data_master_write))));
  --CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register_in <= ((internal_CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave AND CPU_data_master_read) AND NOT Expansion_JP2_avalon_parallel_port_slave_waits_for_read) AND NOT (CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register);
  --shift register p1 CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register) & A_ToStdLogicVector(CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register_in)));
  --CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register <= p1_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register;
    end if;

  end process;

  --local readdatavalid CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave, which is an e_mux
  CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave_shift_register;
  --Expansion_JP2_avalon_parallel_port_slave_writedata mux, which is an e_mux
  Expansion_JP2_avalon_parallel_port_slave_writedata <= CPU_data_master_writedata;
  --master is always granted when requested
  internal_CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave;
  --CPU/data_master saved-grant Expansion_JP2/avalon_parallel_port_slave, which is an e_assign
  CPU_data_master_saved_grant_Expansion_JP2_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave;
  --allow new arb cycle for Expansion_JP2/avalon_parallel_port_slave, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Expansion_JP2_avalon_parallel_port_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Expansion_JP2_avalon_parallel_port_slave_master_qreq_vector <= std_logic'('1');
  --~Expansion_JP2_avalon_parallel_port_slave_reset assignment, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_reset <= NOT reset_n;
  Expansion_JP2_avalon_parallel_port_slave_chipselect <= internal_CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave;
  --Expansion_JP2_avalon_parallel_port_slave_firsttransfer first transaction, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_firsttransfer <= A_WE_StdLogic((std_logic'(Expansion_JP2_avalon_parallel_port_slave_begins_xfer) = '1'), Expansion_JP2_avalon_parallel_port_slave_unreg_firsttransfer, Expansion_JP2_avalon_parallel_port_slave_reg_firsttransfer);
  --Expansion_JP2_avalon_parallel_port_slave_unreg_firsttransfer first transaction, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_unreg_firsttransfer <= NOT ((Expansion_JP2_avalon_parallel_port_slave_slavearbiterlockenable AND Expansion_JP2_avalon_parallel_port_slave_any_continuerequest));
  --Expansion_JP2_avalon_parallel_port_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Expansion_JP2_avalon_parallel_port_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Expansion_JP2_avalon_parallel_port_slave_begins_xfer) = '1' then 
        Expansion_JP2_avalon_parallel_port_slave_reg_firsttransfer <= Expansion_JP2_avalon_parallel_port_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Expansion_JP2_avalon_parallel_port_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_beginbursttransfer_internal <= Expansion_JP2_avalon_parallel_port_slave_begins_xfer;
  --Expansion_JP2_avalon_parallel_port_slave_read assignment, which is an e_mux
  Expansion_JP2_avalon_parallel_port_slave_read <= internal_CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave AND CPU_data_master_read;
  --Expansion_JP2_avalon_parallel_port_slave_write assignment, which is an e_mux
  Expansion_JP2_avalon_parallel_port_slave_write <= internal_CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave AND CPU_data_master_write;
  shifted_address_to_Expansion_JP2_avalon_parallel_port_slave_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --Expansion_JP2_avalon_parallel_port_slave_address mux, which is an e_mux
  Expansion_JP2_avalon_parallel_port_slave_address <= A_EXT (A_SRL(shifted_address_to_Expansion_JP2_avalon_parallel_port_slave_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_Expansion_JP2_avalon_parallel_port_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Expansion_JP2_avalon_parallel_port_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Expansion_JP2_avalon_parallel_port_slave_end_xfer <= Expansion_JP2_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  --Expansion_JP2_avalon_parallel_port_slave_waits_for_read in a cycle, which is an e_mux
  Expansion_JP2_avalon_parallel_port_slave_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Expansion_JP2_avalon_parallel_port_slave_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Expansion_JP2_avalon_parallel_port_slave_in_a_read_cycle assignment, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_in_a_read_cycle <= internal_CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Expansion_JP2_avalon_parallel_port_slave_in_a_read_cycle;
  --Expansion_JP2_avalon_parallel_port_slave_waits_for_write in a cycle, which is an e_mux
  Expansion_JP2_avalon_parallel_port_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Expansion_JP2_avalon_parallel_port_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Expansion_JP2_avalon_parallel_port_slave_in_a_write_cycle assignment, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_in_a_write_cycle <= internal_CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Expansion_JP2_avalon_parallel_port_slave_in_a_write_cycle;
  wait_for_Expansion_JP2_avalon_parallel_port_slave_counter <= std_logic'('0');
  --Expansion_JP2_avalon_parallel_port_slave_byteenable byte enable port mux, which is an e_mux
  Expansion_JP2_avalon_parallel_port_slave_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CPU_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --assign Expansion_JP2_avalon_parallel_port_slave_irq_from_sa = Expansion_JP2_avalon_parallel_port_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  Expansion_JP2_avalon_parallel_port_slave_irq_from_sa <= Expansion_JP2_avalon_parallel_port_slave_irq;
  --vhdl renameroo for output signals
  CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave <= internal_CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave;
--synthesis translate_off
    --Expansion_JP2/avalon_parallel_port_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Green_LEDs_avalon_parallel_port_slave_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Green_LEDs_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal Green_LEDs_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Green_LEDs_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal Green_LEDs_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                 signal Green_LEDs_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                 signal Green_LEDs_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Green_LEDs_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                 signal Green_LEDs_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                 signal Green_LEDs_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_Green_LEDs_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC
              );
end entity Green_LEDs_avalon_parallel_port_slave_arbitrator;


architecture europa of Green_LEDs_avalon_parallel_port_slave_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register_in :  STD_LOGIC;
                signal CPU_data_master_saved_grant_Green_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_allgrants :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_any_continuerequest :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_arb_counter_enable :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Green_LEDs_avalon_parallel_port_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Green_LEDs_avalon_parallel_port_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Green_LEDs_avalon_parallel_port_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_begins_xfer :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_firsttransfer :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_grant_vector :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_in_a_read_cycle :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_in_a_write_cycle :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_master_qreq_vector :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_non_bursting_master_requests :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_reg_firsttransfer :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_slavearbiterlockenable :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_unreg_firsttransfer :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_waits_for_read :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Green_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal p1_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal shifted_address_to_Green_LEDs_avalon_parallel_port_slave_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal wait_for_Green_LEDs_avalon_parallel_port_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Green_LEDs_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  Green_LEDs_avalon_parallel_port_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave);
  --assign Green_LEDs_avalon_parallel_port_slave_readdata_from_sa = Green_LEDs_avalon_parallel_port_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_readdata_from_sa <= Green_LEDs_avalon_parallel_port_slave_readdata;
  internal_CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("10000000000000000000000010000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --registered rdv signal_name registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave assignment, which is an e_assign
  registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register_in;
  --Green_LEDs_avalon_parallel_port_slave_arb_share_counter set values, which is an e_mux
  Green_LEDs_avalon_parallel_port_slave_arb_share_set_values <= std_logic_vector'("01");
  --Green_LEDs_avalon_parallel_port_slave_non_bursting_master_requests mux, which is an e_mux
  Green_LEDs_avalon_parallel_port_slave_non_bursting_master_requests <= internal_CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave;
  --Green_LEDs_avalon_parallel_port_slave_any_bursting_master_saved_grant mux, which is an e_mux
  Green_LEDs_avalon_parallel_port_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --Green_LEDs_avalon_parallel_port_slave_arb_share_counter_next_value assignment, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(Green_LEDs_avalon_parallel_port_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Green_LEDs_avalon_parallel_port_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(Green_LEDs_avalon_parallel_port_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Green_LEDs_avalon_parallel_port_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --Green_LEDs_avalon_parallel_port_slave_allgrants all slave grants, which is an e_mux
  Green_LEDs_avalon_parallel_port_slave_allgrants <= Green_LEDs_avalon_parallel_port_slave_grant_vector;
  --Green_LEDs_avalon_parallel_port_slave_end_xfer assignment, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_end_xfer <= NOT ((Green_LEDs_avalon_parallel_port_slave_waits_for_read OR Green_LEDs_avalon_parallel_port_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_Green_LEDs_avalon_parallel_port_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Green_LEDs_avalon_parallel_port_slave <= Green_LEDs_avalon_parallel_port_slave_end_xfer AND (((NOT Green_LEDs_avalon_parallel_port_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Green_LEDs_avalon_parallel_port_slave_arb_share_counter arbitration counter enable, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Green_LEDs_avalon_parallel_port_slave AND Green_LEDs_avalon_parallel_port_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_Green_LEDs_avalon_parallel_port_slave AND NOT Green_LEDs_avalon_parallel_port_slave_non_bursting_master_requests));
  --Green_LEDs_avalon_parallel_port_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Green_LEDs_avalon_parallel_port_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(Green_LEDs_avalon_parallel_port_slave_arb_counter_enable) = '1' then 
        Green_LEDs_avalon_parallel_port_slave_arb_share_counter <= Green_LEDs_avalon_parallel_port_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Green_LEDs_avalon_parallel_port_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Green_LEDs_avalon_parallel_port_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Green_LEDs_avalon_parallel_port_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_Green_LEDs_avalon_parallel_port_slave)) OR ((end_xfer_arb_share_counter_term_Green_LEDs_avalon_parallel_port_slave AND NOT Green_LEDs_avalon_parallel_port_slave_non_bursting_master_requests)))) = '1' then 
        Green_LEDs_avalon_parallel_port_slave_slavearbiterlockenable <= or_reduce(Green_LEDs_avalon_parallel_port_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master Green_LEDs/avalon_parallel_port_slave arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= Green_LEDs_avalon_parallel_port_slave_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --Green_LEDs_avalon_parallel_port_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_slavearbiterlockenable2 <= or_reduce(Green_LEDs_avalon_parallel_port_slave_arb_share_counter_next_value);
  --CPU/data_master Green_LEDs/avalon_parallel_port_slave arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= Green_LEDs_avalon_parallel_port_slave_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --Green_LEDs_avalon_parallel_port_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave AND NOT ((((CPU_data_master_read AND (CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register))) OR (((NOT CPU_data_master_waitrequest) AND CPU_data_master_write))));
  --CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register_in <= ((internal_CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave AND CPU_data_master_read) AND NOT Green_LEDs_avalon_parallel_port_slave_waits_for_read) AND NOT (CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register);
  --shift register p1 CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register) & A_ToStdLogicVector(CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register_in)));
  --CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register <= p1_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register;
    end if;

  end process;

  --local readdatavalid CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave, which is an e_mux
  CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave_shift_register;
  --Green_LEDs_avalon_parallel_port_slave_writedata mux, which is an e_mux
  Green_LEDs_avalon_parallel_port_slave_writedata <= CPU_data_master_writedata;
  --master is always granted when requested
  internal_CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave;
  --CPU/data_master saved-grant Green_LEDs/avalon_parallel_port_slave, which is an e_assign
  CPU_data_master_saved_grant_Green_LEDs_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave;
  --allow new arb cycle for Green_LEDs/avalon_parallel_port_slave, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Green_LEDs_avalon_parallel_port_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Green_LEDs_avalon_parallel_port_slave_master_qreq_vector <= std_logic'('1');
  --~Green_LEDs_avalon_parallel_port_slave_reset assignment, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_reset <= NOT reset_n;
  Green_LEDs_avalon_parallel_port_slave_chipselect <= internal_CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave;
  --Green_LEDs_avalon_parallel_port_slave_firsttransfer first transaction, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_firsttransfer <= A_WE_StdLogic((std_logic'(Green_LEDs_avalon_parallel_port_slave_begins_xfer) = '1'), Green_LEDs_avalon_parallel_port_slave_unreg_firsttransfer, Green_LEDs_avalon_parallel_port_slave_reg_firsttransfer);
  --Green_LEDs_avalon_parallel_port_slave_unreg_firsttransfer first transaction, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_unreg_firsttransfer <= NOT ((Green_LEDs_avalon_parallel_port_slave_slavearbiterlockenable AND Green_LEDs_avalon_parallel_port_slave_any_continuerequest));
  --Green_LEDs_avalon_parallel_port_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Green_LEDs_avalon_parallel_port_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Green_LEDs_avalon_parallel_port_slave_begins_xfer) = '1' then 
        Green_LEDs_avalon_parallel_port_slave_reg_firsttransfer <= Green_LEDs_avalon_parallel_port_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Green_LEDs_avalon_parallel_port_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_beginbursttransfer_internal <= Green_LEDs_avalon_parallel_port_slave_begins_xfer;
  --Green_LEDs_avalon_parallel_port_slave_read assignment, which is an e_mux
  Green_LEDs_avalon_parallel_port_slave_read <= internal_CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave AND CPU_data_master_read;
  --Green_LEDs_avalon_parallel_port_slave_write assignment, which is an e_mux
  Green_LEDs_avalon_parallel_port_slave_write <= internal_CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave AND CPU_data_master_write;
  shifted_address_to_Green_LEDs_avalon_parallel_port_slave_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --Green_LEDs_avalon_parallel_port_slave_address mux, which is an e_mux
  Green_LEDs_avalon_parallel_port_slave_address <= A_EXT (A_SRL(shifted_address_to_Green_LEDs_avalon_parallel_port_slave_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_Green_LEDs_avalon_parallel_port_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Green_LEDs_avalon_parallel_port_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Green_LEDs_avalon_parallel_port_slave_end_xfer <= Green_LEDs_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  --Green_LEDs_avalon_parallel_port_slave_waits_for_read in a cycle, which is an e_mux
  Green_LEDs_avalon_parallel_port_slave_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Green_LEDs_avalon_parallel_port_slave_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Green_LEDs_avalon_parallel_port_slave_in_a_read_cycle assignment, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_in_a_read_cycle <= internal_CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Green_LEDs_avalon_parallel_port_slave_in_a_read_cycle;
  --Green_LEDs_avalon_parallel_port_slave_waits_for_write in a cycle, which is an e_mux
  Green_LEDs_avalon_parallel_port_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Green_LEDs_avalon_parallel_port_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Green_LEDs_avalon_parallel_port_slave_in_a_write_cycle assignment, which is an e_assign
  Green_LEDs_avalon_parallel_port_slave_in_a_write_cycle <= internal_CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Green_LEDs_avalon_parallel_port_slave_in_a_write_cycle;
  wait_for_Green_LEDs_avalon_parallel_port_slave_counter <= std_logic'('0');
  --Green_LEDs_avalon_parallel_port_slave_byteenable byte enable port mux, which is an e_mux
  Green_LEDs_avalon_parallel_port_slave_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CPU_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave <= internal_CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave;
--synthesis translate_off
    --Green_LEDs/avalon_parallel_port_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity HEX3_HEX0_avalon_parallel_port_slave_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal HEX3_HEX0_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal HEX3_HEX0_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal HEX3_HEX0_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal HEX3_HEX0_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                 signal HEX3_HEX0_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                 signal HEX3_HEX0_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal HEX3_HEX0_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                 signal HEX3_HEX0_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                 signal HEX3_HEX0_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_HEX3_HEX0_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave : OUT STD_LOGIC
              );
end entity HEX3_HEX0_avalon_parallel_port_slave_arbitrator;


architecture europa of HEX3_HEX0_avalon_parallel_port_slave_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register_in :  STD_LOGIC;
                signal CPU_data_master_saved_grant_HEX3_HEX0_avalon_parallel_port_slave :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_allgrants :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_any_continuerequest :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_arb_counter_enable :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal HEX3_HEX0_avalon_parallel_port_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal HEX3_HEX0_avalon_parallel_port_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_begins_xfer :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_firsttransfer :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_grant_vector :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_in_a_read_cycle :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_in_a_write_cycle :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_master_qreq_vector :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_non_bursting_master_requests :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_reg_firsttransfer :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_slavearbiterlockenable :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_unreg_firsttransfer :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_waits_for_read :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_HEX3_HEX0_avalon_parallel_port_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave :  STD_LOGIC;
                signal p1_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal shifted_address_to_HEX3_HEX0_avalon_parallel_port_slave_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal wait_for_HEX3_HEX0_avalon_parallel_port_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT HEX3_HEX0_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  HEX3_HEX0_avalon_parallel_port_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave);
  --assign HEX3_HEX0_avalon_parallel_port_slave_readdata_from_sa = HEX3_HEX0_avalon_parallel_port_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_readdata_from_sa <= HEX3_HEX0_avalon_parallel_port_slave_readdata;
  internal_CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("10000000000000000000000100000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --registered rdv signal_name registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave assignment, which is an e_assign
  registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register_in;
  --HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter set values, which is an e_mux
  HEX3_HEX0_avalon_parallel_port_slave_arb_share_set_values <= std_logic_vector'("01");
  --HEX3_HEX0_avalon_parallel_port_slave_non_bursting_master_requests mux, which is an e_mux
  HEX3_HEX0_avalon_parallel_port_slave_non_bursting_master_requests <= internal_CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave;
  --HEX3_HEX0_avalon_parallel_port_slave_any_bursting_master_saved_grant mux, which is an e_mux
  HEX3_HEX0_avalon_parallel_port_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter_next_value assignment, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(HEX3_HEX0_avalon_parallel_port_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (HEX3_HEX0_avalon_parallel_port_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --HEX3_HEX0_avalon_parallel_port_slave_allgrants all slave grants, which is an e_mux
  HEX3_HEX0_avalon_parallel_port_slave_allgrants <= HEX3_HEX0_avalon_parallel_port_slave_grant_vector;
  --HEX3_HEX0_avalon_parallel_port_slave_end_xfer assignment, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_end_xfer <= NOT ((HEX3_HEX0_avalon_parallel_port_slave_waits_for_read OR HEX3_HEX0_avalon_parallel_port_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_HEX3_HEX0_avalon_parallel_port_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_HEX3_HEX0_avalon_parallel_port_slave <= HEX3_HEX0_avalon_parallel_port_slave_end_xfer AND (((NOT HEX3_HEX0_avalon_parallel_port_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter arbitration counter enable, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_HEX3_HEX0_avalon_parallel_port_slave AND HEX3_HEX0_avalon_parallel_port_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_HEX3_HEX0_avalon_parallel_port_slave AND NOT HEX3_HEX0_avalon_parallel_port_slave_non_bursting_master_requests));
  --HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(HEX3_HEX0_avalon_parallel_port_slave_arb_counter_enable) = '1' then 
        HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter <= HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --HEX3_HEX0_avalon_parallel_port_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HEX3_HEX0_avalon_parallel_port_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((HEX3_HEX0_avalon_parallel_port_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_HEX3_HEX0_avalon_parallel_port_slave)) OR ((end_xfer_arb_share_counter_term_HEX3_HEX0_avalon_parallel_port_slave AND NOT HEX3_HEX0_avalon_parallel_port_slave_non_bursting_master_requests)))) = '1' then 
        HEX3_HEX0_avalon_parallel_port_slave_slavearbiterlockenable <= or_reduce(HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master HEX3_HEX0/avalon_parallel_port_slave arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= HEX3_HEX0_avalon_parallel_port_slave_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --HEX3_HEX0_avalon_parallel_port_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_slavearbiterlockenable2 <= or_reduce(HEX3_HEX0_avalon_parallel_port_slave_arb_share_counter_next_value);
  --CPU/data_master HEX3_HEX0/avalon_parallel_port_slave arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= HEX3_HEX0_avalon_parallel_port_slave_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --HEX3_HEX0_avalon_parallel_port_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave <= internal_CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave AND NOT ((((CPU_data_master_read AND (CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register))) OR (((NOT CPU_data_master_waitrequest) AND CPU_data_master_write))));
  --CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register_in <= ((internal_CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave AND CPU_data_master_read) AND NOT HEX3_HEX0_avalon_parallel_port_slave_waits_for_read) AND NOT (CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register);
  --shift register p1 CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register) & A_ToStdLogicVector(CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register_in)));
  --CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register <= p1_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register;
    end if;

  end process;

  --local readdatavalid CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave, which is an e_mux
  CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave_shift_register;
  --HEX3_HEX0_avalon_parallel_port_slave_writedata mux, which is an e_mux
  HEX3_HEX0_avalon_parallel_port_slave_writedata <= CPU_data_master_writedata;
  --master is always granted when requested
  internal_CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave;
  --CPU/data_master saved-grant HEX3_HEX0/avalon_parallel_port_slave, which is an e_assign
  CPU_data_master_saved_grant_HEX3_HEX0_avalon_parallel_port_slave <= internal_CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave;
  --allow new arb cycle for HEX3_HEX0/avalon_parallel_port_slave, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  HEX3_HEX0_avalon_parallel_port_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  HEX3_HEX0_avalon_parallel_port_slave_master_qreq_vector <= std_logic'('1');
  --~HEX3_HEX0_avalon_parallel_port_slave_reset assignment, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_reset <= NOT reset_n;
  HEX3_HEX0_avalon_parallel_port_slave_chipselect <= internal_CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave;
  --HEX3_HEX0_avalon_parallel_port_slave_firsttransfer first transaction, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_firsttransfer <= A_WE_StdLogic((std_logic'(HEX3_HEX0_avalon_parallel_port_slave_begins_xfer) = '1'), HEX3_HEX0_avalon_parallel_port_slave_unreg_firsttransfer, HEX3_HEX0_avalon_parallel_port_slave_reg_firsttransfer);
  --HEX3_HEX0_avalon_parallel_port_slave_unreg_firsttransfer first transaction, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_unreg_firsttransfer <= NOT ((HEX3_HEX0_avalon_parallel_port_slave_slavearbiterlockenable AND HEX3_HEX0_avalon_parallel_port_slave_any_continuerequest));
  --HEX3_HEX0_avalon_parallel_port_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HEX3_HEX0_avalon_parallel_port_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(HEX3_HEX0_avalon_parallel_port_slave_begins_xfer) = '1' then 
        HEX3_HEX0_avalon_parallel_port_slave_reg_firsttransfer <= HEX3_HEX0_avalon_parallel_port_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --HEX3_HEX0_avalon_parallel_port_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_beginbursttransfer_internal <= HEX3_HEX0_avalon_parallel_port_slave_begins_xfer;
  --HEX3_HEX0_avalon_parallel_port_slave_read assignment, which is an e_mux
  HEX3_HEX0_avalon_parallel_port_slave_read <= internal_CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave AND CPU_data_master_read;
  --HEX3_HEX0_avalon_parallel_port_slave_write assignment, which is an e_mux
  HEX3_HEX0_avalon_parallel_port_slave_write <= internal_CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave AND CPU_data_master_write;
  shifted_address_to_HEX3_HEX0_avalon_parallel_port_slave_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --HEX3_HEX0_avalon_parallel_port_slave_address mux, which is an e_mux
  HEX3_HEX0_avalon_parallel_port_slave_address <= A_EXT (A_SRL(shifted_address_to_HEX3_HEX0_avalon_parallel_port_slave_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_HEX3_HEX0_avalon_parallel_port_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_HEX3_HEX0_avalon_parallel_port_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_HEX3_HEX0_avalon_parallel_port_slave_end_xfer <= HEX3_HEX0_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  --HEX3_HEX0_avalon_parallel_port_slave_waits_for_read in a cycle, which is an e_mux
  HEX3_HEX0_avalon_parallel_port_slave_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(HEX3_HEX0_avalon_parallel_port_slave_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --HEX3_HEX0_avalon_parallel_port_slave_in_a_read_cycle assignment, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_in_a_read_cycle <= internal_CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= HEX3_HEX0_avalon_parallel_port_slave_in_a_read_cycle;
  --HEX3_HEX0_avalon_parallel_port_slave_waits_for_write in a cycle, which is an e_mux
  HEX3_HEX0_avalon_parallel_port_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(HEX3_HEX0_avalon_parallel_port_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --HEX3_HEX0_avalon_parallel_port_slave_in_a_write_cycle assignment, which is an e_assign
  HEX3_HEX0_avalon_parallel_port_slave_in_a_write_cycle <= internal_CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= HEX3_HEX0_avalon_parallel_port_slave_in_a_write_cycle;
  wait_for_HEX3_HEX0_avalon_parallel_port_slave_counter <= std_logic'('0');
  --HEX3_HEX0_avalon_parallel_port_slave_byteenable byte enable port mux, which is an e_mux
  HEX3_HEX0_avalon_parallel_port_slave_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CPU_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave <= internal_CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave <= internal_CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave;
--synthesis translate_off
    --HEX3_HEX0/avalon_parallel_port_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity HEX7_HEX4_avalon_parallel_port_slave_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal HEX7_HEX4_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal HEX7_HEX4_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal HEX7_HEX4_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal HEX7_HEX4_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                 signal HEX7_HEX4_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                 signal HEX7_HEX4_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal HEX7_HEX4_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                 signal HEX7_HEX4_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                 signal HEX7_HEX4_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_HEX7_HEX4_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave : OUT STD_LOGIC
              );
end entity HEX7_HEX4_avalon_parallel_port_slave_arbitrator;


architecture europa of HEX7_HEX4_avalon_parallel_port_slave_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register_in :  STD_LOGIC;
                signal CPU_data_master_saved_grant_HEX7_HEX4_avalon_parallel_port_slave :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_allgrants :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_any_continuerequest :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_arb_counter_enable :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal HEX7_HEX4_avalon_parallel_port_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal HEX7_HEX4_avalon_parallel_port_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_begins_xfer :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_firsttransfer :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_grant_vector :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_in_a_read_cycle :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_in_a_write_cycle :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_master_qreq_vector :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_non_bursting_master_requests :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_reg_firsttransfer :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_slavearbiterlockenable :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_unreg_firsttransfer :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_waits_for_read :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_HEX7_HEX4_avalon_parallel_port_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave :  STD_LOGIC;
                signal p1_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal shifted_address_to_HEX7_HEX4_avalon_parallel_port_slave_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal wait_for_HEX7_HEX4_avalon_parallel_port_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT HEX7_HEX4_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  HEX7_HEX4_avalon_parallel_port_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave);
  --assign HEX7_HEX4_avalon_parallel_port_slave_readdata_from_sa = HEX7_HEX4_avalon_parallel_port_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_readdata_from_sa <= HEX7_HEX4_avalon_parallel_port_slave_readdata;
  internal_CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("10000000000000000000000110000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --registered rdv signal_name registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave assignment, which is an e_assign
  registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register_in;
  --HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter set values, which is an e_mux
  HEX7_HEX4_avalon_parallel_port_slave_arb_share_set_values <= std_logic_vector'("01");
  --HEX7_HEX4_avalon_parallel_port_slave_non_bursting_master_requests mux, which is an e_mux
  HEX7_HEX4_avalon_parallel_port_slave_non_bursting_master_requests <= internal_CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave;
  --HEX7_HEX4_avalon_parallel_port_slave_any_bursting_master_saved_grant mux, which is an e_mux
  HEX7_HEX4_avalon_parallel_port_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter_next_value assignment, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(HEX7_HEX4_avalon_parallel_port_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (HEX7_HEX4_avalon_parallel_port_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --HEX7_HEX4_avalon_parallel_port_slave_allgrants all slave grants, which is an e_mux
  HEX7_HEX4_avalon_parallel_port_slave_allgrants <= HEX7_HEX4_avalon_parallel_port_slave_grant_vector;
  --HEX7_HEX4_avalon_parallel_port_slave_end_xfer assignment, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_end_xfer <= NOT ((HEX7_HEX4_avalon_parallel_port_slave_waits_for_read OR HEX7_HEX4_avalon_parallel_port_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_HEX7_HEX4_avalon_parallel_port_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_HEX7_HEX4_avalon_parallel_port_slave <= HEX7_HEX4_avalon_parallel_port_slave_end_xfer AND (((NOT HEX7_HEX4_avalon_parallel_port_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter arbitration counter enable, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_HEX7_HEX4_avalon_parallel_port_slave AND HEX7_HEX4_avalon_parallel_port_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_HEX7_HEX4_avalon_parallel_port_slave AND NOT HEX7_HEX4_avalon_parallel_port_slave_non_bursting_master_requests));
  --HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(HEX7_HEX4_avalon_parallel_port_slave_arb_counter_enable) = '1' then 
        HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter <= HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --HEX7_HEX4_avalon_parallel_port_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HEX7_HEX4_avalon_parallel_port_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((HEX7_HEX4_avalon_parallel_port_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_HEX7_HEX4_avalon_parallel_port_slave)) OR ((end_xfer_arb_share_counter_term_HEX7_HEX4_avalon_parallel_port_slave AND NOT HEX7_HEX4_avalon_parallel_port_slave_non_bursting_master_requests)))) = '1' then 
        HEX7_HEX4_avalon_parallel_port_slave_slavearbiterlockenable <= or_reduce(HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master HEX7_HEX4/avalon_parallel_port_slave arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= HEX7_HEX4_avalon_parallel_port_slave_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --HEX7_HEX4_avalon_parallel_port_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_slavearbiterlockenable2 <= or_reduce(HEX7_HEX4_avalon_parallel_port_slave_arb_share_counter_next_value);
  --CPU/data_master HEX7_HEX4/avalon_parallel_port_slave arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= HEX7_HEX4_avalon_parallel_port_slave_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --HEX7_HEX4_avalon_parallel_port_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave <= internal_CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave AND NOT ((((CPU_data_master_read AND (CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register))) OR (((NOT CPU_data_master_waitrequest) AND CPU_data_master_write))));
  --CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register_in <= ((internal_CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave AND CPU_data_master_read) AND NOT HEX7_HEX4_avalon_parallel_port_slave_waits_for_read) AND NOT (CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register);
  --shift register p1 CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register) & A_ToStdLogicVector(CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register_in)));
  --CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register <= p1_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register;
    end if;

  end process;

  --local readdatavalid CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave, which is an e_mux
  CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave_shift_register;
  --HEX7_HEX4_avalon_parallel_port_slave_writedata mux, which is an e_mux
  HEX7_HEX4_avalon_parallel_port_slave_writedata <= CPU_data_master_writedata;
  --master is always granted when requested
  internal_CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave;
  --CPU/data_master saved-grant HEX7_HEX4/avalon_parallel_port_slave, which is an e_assign
  CPU_data_master_saved_grant_HEX7_HEX4_avalon_parallel_port_slave <= internal_CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave;
  --allow new arb cycle for HEX7_HEX4/avalon_parallel_port_slave, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  HEX7_HEX4_avalon_parallel_port_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  HEX7_HEX4_avalon_parallel_port_slave_master_qreq_vector <= std_logic'('1');
  --~HEX7_HEX4_avalon_parallel_port_slave_reset assignment, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_reset <= NOT reset_n;
  HEX7_HEX4_avalon_parallel_port_slave_chipselect <= internal_CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave;
  --HEX7_HEX4_avalon_parallel_port_slave_firsttransfer first transaction, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_firsttransfer <= A_WE_StdLogic((std_logic'(HEX7_HEX4_avalon_parallel_port_slave_begins_xfer) = '1'), HEX7_HEX4_avalon_parallel_port_slave_unreg_firsttransfer, HEX7_HEX4_avalon_parallel_port_slave_reg_firsttransfer);
  --HEX7_HEX4_avalon_parallel_port_slave_unreg_firsttransfer first transaction, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_unreg_firsttransfer <= NOT ((HEX7_HEX4_avalon_parallel_port_slave_slavearbiterlockenable AND HEX7_HEX4_avalon_parallel_port_slave_any_continuerequest));
  --HEX7_HEX4_avalon_parallel_port_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      HEX7_HEX4_avalon_parallel_port_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(HEX7_HEX4_avalon_parallel_port_slave_begins_xfer) = '1' then 
        HEX7_HEX4_avalon_parallel_port_slave_reg_firsttransfer <= HEX7_HEX4_avalon_parallel_port_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --HEX7_HEX4_avalon_parallel_port_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_beginbursttransfer_internal <= HEX7_HEX4_avalon_parallel_port_slave_begins_xfer;
  --HEX7_HEX4_avalon_parallel_port_slave_read assignment, which is an e_mux
  HEX7_HEX4_avalon_parallel_port_slave_read <= internal_CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave AND CPU_data_master_read;
  --HEX7_HEX4_avalon_parallel_port_slave_write assignment, which is an e_mux
  HEX7_HEX4_avalon_parallel_port_slave_write <= internal_CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave AND CPU_data_master_write;
  shifted_address_to_HEX7_HEX4_avalon_parallel_port_slave_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --HEX7_HEX4_avalon_parallel_port_slave_address mux, which is an e_mux
  HEX7_HEX4_avalon_parallel_port_slave_address <= A_EXT (A_SRL(shifted_address_to_HEX7_HEX4_avalon_parallel_port_slave_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_HEX7_HEX4_avalon_parallel_port_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_HEX7_HEX4_avalon_parallel_port_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_HEX7_HEX4_avalon_parallel_port_slave_end_xfer <= HEX7_HEX4_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  --HEX7_HEX4_avalon_parallel_port_slave_waits_for_read in a cycle, which is an e_mux
  HEX7_HEX4_avalon_parallel_port_slave_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(HEX7_HEX4_avalon_parallel_port_slave_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --HEX7_HEX4_avalon_parallel_port_slave_in_a_read_cycle assignment, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_in_a_read_cycle <= internal_CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= HEX7_HEX4_avalon_parallel_port_slave_in_a_read_cycle;
  --HEX7_HEX4_avalon_parallel_port_slave_waits_for_write in a cycle, which is an e_mux
  HEX7_HEX4_avalon_parallel_port_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(HEX7_HEX4_avalon_parallel_port_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --HEX7_HEX4_avalon_parallel_port_slave_in_a_write_cycle assignment, which is an e_assign
  HEX7_HEX4_avalon_parallel_port_slave_in_a_write_cycle <= internal_CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= HEX7_HEX4_avalon_parallel_port_slave_in_a_write_cycle;
  wait_for_HEX7_HEX4_avalon_parallel_port_slave_counter <= std_logic'('0');
  --HEX7_HEX4_avalon_parallel_port_slave_byteenable byte enable port mux, which is an e_mux
  HEX7_HEX4_avalon_parallel_port_slave_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CPU_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave <= internal_CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave <= internal_CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave;
--synthesis translate_off
    --HEX7_HEX4/avalon_parallel_port_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Interval_timer_s1_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Interval_timer_s1_irq : IN STD_LOGIC;
                 signal Interval_timer_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_Interval_timer_s1 : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_Interval_timer_s1 : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Interval_timer_s1 : OUT STD_LOGIC;
                 signal CPU_data_master_requests_Interval_timer_s1 : OUT STD_LOGIC;
                 signal Interval_timer_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal Interval_timer_s1_chipselect : OUT STD_LOGIC;
                 signal Interval_timer_s1_irq_from_sa : OUT STD_LOGIC;
                 signal Interval_timer_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal Interval_timer_s1_reset_n : OUT STD_LOGIC;
                 signal Interval_timer_s1_write_n : OUT STD_LOGIC;
                 signal Interval_timer_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal d1_Interval_timer_s1_end_xfer : OUT STD_LOGIC
              );
end entity Interval_timer_s1_arbitrator;


architecture europa of Interval_timer_s1_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_saved_grant_Interval_timer_s1 :  STD_LOGIC;
                signal Interval_timer_s1_allgrants :  STD_LOGIC;
                signal Interval_timer_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal Interval_timer_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Interval_timer_s1_any_continuerequest :  STD_LOGIC;
                signal Interval_timer_s1_arb_counter_enable :  STD_LOGIC;
                signal Interval_timer_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Interval_timer_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Interval_timer_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Interval_timer_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal Interval_timer_s1_begins_xfer :  STD_LOGIC;
                signal Interval_timer_s1_end_xfer :  STD_LOGIC;
                signal Interval_timer_s1_firsttransfer :  STD_LOGIC;
                signal Interval_timer_s1_grant_vector :  STD_LOGIC;
                signal Interval_timer_s1_in_a_read_cycle :  STD_LOGIC;
                signal Interval_timer_s1_in_a_write_cycle :  STD_LOGIC;
                signal Interval_timer_s1_master_qreq_vector :  STD_LOGIC;
                signal Interval_timer_s1_non_bursting_master_requests :  STD_LOGIC;
                signal Interval_timer_s1_reg_firsttransfer :  STD_LOGIC;
                signal Interval_timer_s1_slavearbiterlockenable :  STD_LOGIC;
                signal Interval_timer_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal Interval_timer_s1_unreg_firsttransfer :  STD_LOGIC;
                signal Interval_timer_s1_waits_for_read :  STD_LOGIC;
                signal Interval_timer_s1_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Interval_timer_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_Interval_timer_s1 :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_Interval_timer_s1 :  STD_LOGIC;
                signal internal_CPU_data_master_requests_Interval_timer_s1 :  STD_LOGIC;
                signal shifted_address_to_Interval_timer_s1_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal wait_for_Interval_timer_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Interval_timer_s1_end_xfer;
    end if;

  end process;

  Interval_timer_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_Interval_timer_s1);
  --assign Interval_timer_s1_readdata_from_sa = Interval_timer_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  Interval_timer_s1_readdata_from_sa <= Interval_timer_s1_readdata;
  internal_CPU_data_master_requests_Interval_timer_s1 <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("10000000000000010000000000000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --Interval_timer_s1_arb_share_counter set values, which is an e_mux
  Interval_timer_s1_arb_share_set_values <= std_logic_vector'("01");
  --Interval_timer_s1_non_bursting_master_requests mux, which is an e_mux
  Interval_timer_s1_non_bursting_master_requests <= internal_CPU_data_master_requests_Interval_timer_s1;
  --Interval_timer_s1_any_bursting_master_saved_grant mux, which is an e_mux
  Interval_timer_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --Interval_timer_s1_arb_share_counter_next_value assignment, which is an e_assign
  Interval_timer_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(Interval_timer_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Interval_timer_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(Interval_timer_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Interval_timer_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --Interval_timer_s1_allgrants all slave grants, which is an e_mux
  Interval_timer_s1_allgrants <= Interval_timer_s1_grant_vector;
  --Interval_timer_s1_end_xfer assignment, which is an e_assign
  Interval_timer_s1_end_xfer <= NOT ((Interval_timer_s1_waits_for_read OR Interval_timer_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_Interval_timer_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Interval_timer_s1 <= Interval_timer_s1_end_xfer AND (((NOT Interval_timer_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Interval_timer_s1_arb_share_counter arbitration counter enable, which is an e_assign
  Interval_timer_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Interval_timer_s1 AND Interval_timer_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_Interval_timer_s1 AND NOT Interval_timer_s1_non_bursting_master_requests));
  --Interval_timer_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Interval_timer_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(Interval_timer_s1_arb_counter_enable) = '1' then 
        Interval_timer_s1_arb_share_counter <= Interval_timer_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Interval_timer_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Interval_timer_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Interval_timer_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_Interval_timer_s1)) OR ((end_xfer_arb_share_counter_term_Interval_timer_s1 AND NOT Interval_timer_s1_non_bursting_master_requests)))) = '1' then 
        Interval_timer_s1_slavearbiterlockenable <= or_reduce(Interval_timer_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master Interval_timer/s1 arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= Interval_timer_s1_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --Interval_timer_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Interval_timer_s1_slavearbiterlockenable2 <= or_reduce(Interval_timer_s1_arb_share_counter_next_value);
  --CPU/data_master Interval_timer/s1 arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= Interval_timer_s1_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --Interval_timer_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  Interval_timer_s1_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_Interval_timer_s1 <= internal_CPU_data_master_requests_Interval_timer_s1 AND NOT (((NOT CPU_data_master_waitrequest) AND CPU_data_master_write));
  --Interval_timer_s1_writedata mux, which is an e_mux
  Interval_timer_s1_writedata <= CPU_data_master_writedata (15 DOWNTO 0);
  --master is always granted when requested
  internal_CPU_data_master_granted_Interval_timer_s1 <= internal_CPU_data_master_qualified_request_Interval_timer_s1;
  --CPU/data_master saved-grant Interval_timer/s1, which is an e_assign
  CPU_data_master_saved_grant_Interval_timer_s1 <= internal_CPU_data_master_requests_Interval_timer_s1;
  --allow new arb cycle for Interval_timer/s1, which is an e_assign
  Interval_timer_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Interval_timer_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Interval_timer_s1_master_qreq_vector <= std_logic'('1');
  --Interval_timer_s1_reset_n assignment, which is an e_assign
  Interval_timer_s1_reset_n <= reset_n;
  Interval_timer_s1_chipselect <= internal_CPU_data_master_granted_Interval_timer_s1;
  --Interval_timer_s1_firsttransfer first transaction, which is an e_assign
  Interval_timer_s1_firsttransfer <= A_WE_StdLogic((std_logic'(Interval_timer_s1_begins_xfer) = '1'), Interval_timer_s1_unreg_firsttransfer, Interval_timer_s1_reg_firsttransfer);
  --Interval_timer_s1_unreg_firsttransfer first transaction, which is an e_assign
  Interval_timer_s1_unreg_firsttransfer <= NOT ((Interval_timer_s1_slavearbiterlockenable AND Interval_timer_s1_any_continuerequest));
  --Interval_timer_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Interval_timer_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Interval_timer_s1_begins_xfer) = '1' then 
        Interval_timer_s1_reg_firsttransfer <= Interval_timer_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Interval_timer_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Interval_timer_s1_beginbursttransfer_internal <= Interval_timer_s1_begins_xfer;
  --~Interval_timer_s1_write_n assignment, which is an e_mux
  Interval_timer_s1_write_n <= NOT ((internal_CPU_data_master_granted_Interval_timer_s1 AND CPU_data_master_write));
  shifted_address_to_Interval_timer_s1_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --Interval_timer_s1_address mux, which is an e_mux
  Interval_timer_s1_address <= A_EXT (A_SRL(shifted_address_to_Interval_timer_s1_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_Interval_timer_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Interval_timer_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Interval_timer_s1_end_xfer <= Interval_timer_s1_end_xfer;
    end if;

  end process;

  --Interval_timer_s1_waits_for_read in a cycle, which is an e_mux
  Interval_timer_s1_waits_for_read <= Interval_timer_s1_in_a_read_cycle AND Interval_timer_s1_begins_xfer;
  --Interval_timer_s1_in_a_read_cycle assignment, which is an e_assign
  Interval_timer_s1_in_a_read_cycle <= internal_CPU_data_master_granted_Interval_timer_s1 AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Interval_timer_s1_in_a_read_cycle;
  --Interval_timer_s1_waits_for_write in a cycle, which is an e_mux
  Interval_timer_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Interval_timer_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Interval_timer_s1_in_a_write_cycle assignment, which is an e_assign
  Interval_timer_s1_in_a_write_cycle <= internal_CPU_data_master_granted_Interval_timer_s1 AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Interval_timer_s1_in_a_write_cycle;
  wait_for_Interval_timer_s1_counter <= std_logic'('0');
  --assign Interval_timer_s1_irq_from_sa = Interval_timer_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  Interval_timer_s1_irq_from_sa <= Interval_timer_s1_irq;
  --vhdl renameroo for output signals
  CPU_data_master_granted_Interval_timer_s1 <= internal_CPU_data_master_granted_Interval_timer_s1;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_Interval_timer_s1 <= internal_CPU_data_master_qualified_request_Interval_timer_s1;
  --vhdl renameroo for output signals
  CPU_data_master_requests_Interval_timer_s1 <= internal_CPU_data_master_requests_Interval_timer_s1;
--synthesis translate_off
    --Interval_timer/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity JTAG_UART_avalon_jtag_slave_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal JTAG_UART_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_irq : IN STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal JTAG_UART_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                 signal CPU_data_master_requests_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_address : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal JTAG_UART_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                 signal JTAG_UART_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_JTAG_UART_avalon_jtag_slave_end_xfer : OUT STD_LOGIC
              );
end entity JTAG_UART_avalon_jtag_slave_arbitrator;


architecture europa of JTAG_UART_avalon_jtag_slave_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_saved_grant_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_allgrants :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_any_continuerequest :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_arb_counter_enable :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal JTAG_UART_avalon_jtag_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal JTAG_UART_avalon_jtag_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal JTAG_UART_avalon_jtag_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_begins_xfer :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_firsttransfer :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_grant_vector :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_in_a_read_cycle :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_in_a_write_cycle :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_master_qreq_vector :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_non_bursting_master_requests :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_reg_firsttransfer :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_slavearbiterlockenable :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_unreg_firsttransfer :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_waits_for_read :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal internal_CPU_data_master_requests_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal internal_JTAG_UART_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal shifted_address_to_JTAG_UART_avalon_jtag_slave_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal wait_for_JTAG_UART_avalon_jtag_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT JTAG_UART_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  JTAG_UART_avalon_jtag_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave);
  --assign JTAG_UART_avalon_jtag_slave_readdata_from_sa = JTAG_UART_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  JTAG_UART_avalon_jtag_slave_readdata_from_sa <= JTAG_UART_avalon_jtag_slave_readdata;
  internal_CPU_data_master_requests_JTAG_UART_avalon_jtag_slave <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("10000000000000001000000000000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --assign JTAG_UART_avalon_jtag_slave_dataavailable_from_sa = JTAG_UART_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  JTAG_UART_avalon_jtag_slave_dataavailable_from_sa <= JTAG_UART_avalon_jtag_slave_dataavailable;
  --assign JTAG_UART_avalon_jtag_slave_readyfordata_from_sa = JTAG_UART_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  JTAG_UART_avalon_jtag_slave_readyfordata_from_sa <= JTAG_UART_avalon_jtag_slave_readyfordata;
  --assign JTAG_UART_avalon_jtag_slave_waitrequest_from_sa = JTAG_UART_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_JTAG_UART_avalon_jtag_slave_waitrequest_from_sa <= JTAG_UART_avalon_jtag_slave_waitrequest;
  --JTAG_UART_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  JTAG_UART_avalon_jtag_slave_arb_share_set_values <= std_logic_vector'("01");
  --JTAG_UART_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  JTAG_UART_avalon_jtag_slave_non_bursting_master_requests <= internal_CPU_data_master_requests_JTAG_UART_avalon_jtag_slave;
  --JTAG_UART_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  JTAG_UART_avalon_jtag_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --JTAG_UART_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  JTAG_UART_avalon_jtag_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(JTAG_UART_avalon_jtag_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (JTAG_UART_avalon_jtag_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(JTAG_UART_avalon_jtag_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (JTAG_UART_avalon_jtag_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --JTAG_UART_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  JTAG_UART_avalon_jtag_slave_allgrants <= JTAG_UART_avalon_jtag_slave_grant_vector;
  --JTAG_UART_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  JTAG_UART_avalon_jtag_slave_end_xfer <= NOT ((JTAG_UART_avalon_jtag_slave_waits_for_read OR JTAG_UART_avalon_jtag_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave <= JTAG_UART_avalon_jtag_slave_end_xfer AND (((NOT JTAG_UART_avalon_jtag_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --JTAG_UART_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  JTAG_UART_avalon_jtag_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave AND JTAG_UART_avalon_jtag_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave AND NOT JTAG_UART_avalon_jtag_slave_non_bursting_master_requests));
  --JTAG_UART_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      JTAG_UART_avalon_jtag_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(JTAG_UART_avalon_jtag_slave_arb_counter_enable) = '1' then 
        JTAG_UART_avalon_jtag_slave_arb_share_counter <= JTAG_UART_avalon_jtag_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --JTAG_UART_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      JTAG_UART_avalon_jtag_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((JTAG_UART_avalon_jtag_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave)) OR ((end_xfer_arb_share_counter_term_JTAG_UART_avalon_jtag_slave AND NOT JTAG_UART_avalon_jtag_slave_non_bursting_master_requests)))) = '1' then 
        JTAG_UART_avalon_jtag_slave_slavearbiterlockenable <= or_reduce(JTAG_UART_avalon_jtag_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master JTAG_UART/avalon_jtag_slave arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= JTAG_UART_avalon_jtag_slave_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --JTAG_UART_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  JTAG_UART_avalon_jtag_slave_slavearbiterlockenable2 <= or_reduce(JTAG_UART_avalon_jtag_slave_arb_share_counter_next_value);
  --CPU/data_master JTAG_UART/avalon_jtag_slave arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= JTAG_UART_avalon_jtag_slave_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --JTAG_UART_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  JTAG_UART_avalon_jtag_slave_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave <= internal_CPU_data_master_requests_JTAG_UART_avalon_jtag_slave AND NOT ((((CPU_data_master_read AND (NOT CPU_data_master_waitrequest))) OR (((NOT CPU_data_master_waitrequest) AND CPU_data_master_write))));
  --JTAG_UART_avalon_jtag_slave_writedata mux, which is an e_mux
  JTAG_UART_avalon_jtag_slave_writedata <= CPU_data_master_writedata;
  --master is always granted when requested
  internal_CPU_data_master_granted_JTAG_UART_avalon_jtag_slave <= internal_CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave;
  --CPU/data_master saved-grant JTAG_UART/avalon_jtag_slave, which is an e_assign
  CPU_data_master_saved_grant_JTAG_UART_avalon_jtag_slave <= internal_CPU_data_master_requests_JTAG_UART_avalon_jtag_slave;
  --allow new arb cycle for JTAG_UART/avalon_jtag_slave, which is an e_assign
  JTAG_UART_avalon_jtag_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  JTAG_UART_avalon_jtag_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  JTAG_UART_avalon_jtag_slave_master_qreq_vector <= std_logic'('1');
  --JTAG_UART_avalon_jtag_slave_reset_n assignment, which is an e_assign
  JTAG_UART_avalon_jtag_slave_reset_n <= reset_n;
  JTAG_UART_avalon_jtag_slave_chipselect <= internal_CPU_data_master_granted_JTAG_UART_avalon_jtag_slave;
  --JTAG_UART_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  JTAG_UART_avalon_jtag_slave_firsttransfer <= A_WE_StdLogic((std_logic'(JTAG_UART_avalon_jtag_slave_begins_xfer) = '1'), JTAG_UART_avalon_jtag_slave_unreg_firsttransfer, JTAG_UART_avalon_jtag_slave_reg_firsttransfer);
  --JTAG_UART_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  JTAG_UART_avalon_jtag_slave_unreg_firsttransfer <= NOT ((JTAG_UART_avalon_jtag_slave_slavearbiterlockenable AND JTAG_UART_avalon_jtag_slave_any_continuerequest));
  --JTAG_UART_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      JTAG_UART_avalon_jtag_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(JTAG_UART_avalon_jtag_slave_begins_xfer) = '1' then 
        JTAG_UART_avalon_jtag_slave_reg_firsttransfer <= JTAG_UART_avalon_jtag_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --JTAG_UART_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  JTAG_UART_avalon_jtag_slave_beginbursttransfer_internal <= JTAG_UART_avalon_jtag_slave_begins_xfer;
  --~JTAG_UART_avalon_jtag_slave_read_n assignment, which is an e_mux
  JTAG_UART_avalon_jtag_slave_read_n <= NOT ((internal_CPU_data_master_granted_JTAG_UART_avalon_jtag_slave AND CPU_data_master_read));
  --~JTAG_UART_avalon_jtag_slave_write_n assignment, which is an e_mux
  JTAG_UART_avalon_jtag_slave_write_n <= NOT ((internal_CPU_data_master_granted_JTAG_UART_avalon_jtag_slave AND CPU_data_master_write));
  shifted_address_to_JTAG_UART_avalon_jtag_slave_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --JTAG_UART_avalon_jtag_slave_address mux, which is an e_mux
  JTAG_UART_avalon_jtag_slave_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_JTAG_UART_avalon_jtag_slave_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_JTAG_UART_avalon_jtag_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_JTAG_UART_avalon_jtag_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_JTAG_UART_avalon_jtag_slave_end_xfer <= JTAG_UART_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  --JTAG_UART_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  JTAG_UART_avalon_jtag_slave_waits_for_read <= JTAG_UART_avalon_jtag_slave_in_a_read_cycle AND internal_JTAG_UART_avalon_jtag_slave_waitrequest_from_sa;
  --JTAG_UART_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  JTAG_UART_avalon_jtag_slave_in_a_read_cycle <= internal_CPU_data_master_granted_JTAG_UART_avalon_jtag_slave AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= JTAG_UART_avalon_jtag_slave_in_a_read_cycle;
  --JTAG_UART_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  JTAG_UART_avalon_jtag_slave_waits_for_write <= JTAG_UART_avalon_jtag_slave_in_a_write_cycle AND internal_JTAG_UART_avalon_jtag_slave_waitrequest_from_sa;
  --JTAG_UART_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  JTAG_UART_avalon_jtag_slave_in_a_write_cycle <= internal_CPU_data_master_granted_JTAG_UART_avalon_jtag_slave AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= JTAG_UART_avalon_jtag_slave_in_a_write_cycle;
  wait_for_JTAG_UART_avalon_jtag_slave_counter <= std_logic'('0');
  --assign JTAG_UART_avalon_jtag_slave_irq_from_sa = JTAG_UART_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  JTAG_UART_avalon_jtag_slave_irq_from_sa <= JTAG_UART_avalon_jtag_slave_irq;
  --vhdl renameroo for output signals
  CPU_data_master_granted_JTAG_UART_avalon_jtag_slave <= internal_CPU_data_master_granted_JTAG_UART_avalon_jtag_slave;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave <= internal_CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave;
  --vhdl renameroo for output signals
  CPU_data_master_requests_JTAG_UART_avalon_jtag_slave <= internal_CPU_data_master_requests_JTAG_UART_avalon_jtag_slave;
  --vhdl renameroo for output signals
  JTAG_UART_avalon_jtag_slave_waitrequest_from_sa <= internal_JTAG_UART_avalon_jtag_slave_waitrequest_from_sa;
--synthesis translate_off
    --JTAG_UART/avalon_jtag_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Onchip_memory_s1_arbitrator is 
        port (
              -- inputs:
                 signal CPU_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
                 signal CPU_instruction_master_latency_counter : IN STD_LOGIC;
                 signal CPU_instruction_master_read : IN STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register : IN STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : IN STD_LOGIC;
                 signal Onchip_memory_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_instruction_master_granted_Onchip_memory_s1 : OUT STD_LOGIC;
                 signal CPU_instruction_master_qualified_request_Onchip_memory_s1 : OUT STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_Onchip_memory_s1 : OUT STD_LOGIC;
                 signal CPU_instruction_master_requests_Onchip_memory_s1 : OUT STD_LOGIC;
                 signal Onchip_memory_s1_address : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
                 signal Onchip_memory_s1_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal Onchip_memory_s1_chipselect : OUT STD_LOGIC;
                 signal Onchip_memory_s1_clken : OUT STD_LOGIC;
                 signal Onchip_memory_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Onchip_memory_s1_write : OUT STD_LOGIC;
                 signal Onchip_memory_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_Onchip_memory_s1_end_xfer : OUT STD_LOGIC
              );
end entity Onchip_memory_s1_arbitrator;


architecture europa of Onchip_memory_s1_arbitrator is
                signal CPU_instruction_master_arbiterlock :  STD_LOGIC;
                signal CPU_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_instruction_master_continuerequest :  STD_LOGIC;
                signal CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register :  STD_LOGIC;
                signal CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register_in :  STD_LOGIC;
                signal CPU_instruction_master_saved_grant_Onchip_memory_s1 :  STD_LOGIC;
                signal Onchip_memory_s1_allgrants :  STD_LOGIC;
                signal Onchip_memory_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal Onchip_memory_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Onchip_memory_s1_any_continuerequest :  STD_LOGIC;
                signal Onchip_memory_s1_arb_counter_enable :  STD_LOGIC;
                signal Onchip_memory_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Onchip_memory_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Onchip_memory_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Onchip_memory_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal Onchip_memory_s1_begins_xfer :  STD_LOGIC;
                signal Onchip_memory_s1_end_xfer :  STD_LOGIC;
                signal Onchip_memory_s1_firsttransfer :  STD_LOGIC;
                signal Onchip_memory_s1_grant_vector :  STD_LOGIC;
                signal Onchip_memory_s1_in_a_read_cycle :  STD_LOGIC;
                signal Onchip_memory_s1_in_a_write_cycle :  STD_LOGIC;
                signal Onchip_memory_s1_master_qreq_vector :  STD_LOGIC;
                signal Onchip_memory_s1_non_bursting_master_requests :  STD_LOGIC;
                signal Onchip_memory_s1_reg_firsttransfer :  STD_LOGIC;
                signal Onchip_memory_s1_slavearbiterlockenable :  STD_LOGIC;
                signal Onchip_memory_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal Onchip_memory_s1_unreg_firsttransfer :  STD_LOGIC;
                signal Onchip_memory_s1_waits_for_read :  STD_LOGIC;
                signal Onchip_memory_s1_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Onchip_memory_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_instruction_master_granted_Onchip_memory_s1 :  STD_LOGIC;
                signal internal_CPU_instruction_master_qualified_request_Onchip_memory_s1 :  STD_LOGIC;
                signal internal_CPU_instruction_master_requests_Onchip_memory_s1 :  STD_LOGIC;
                signal p1_CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register :  STD_LOGIC;
                signal shifted_address_to_Onchip_memory_s1_from_CPU_instruction_master :  STD_LOGIC_VECTOR (27 DOWNTO 0);
                signal wait_for_Onchip_memory_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Onchip_memory_s1_end_xfer;
    end if;

  end process;

  Onchip_memory_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_instruction_master_qualified_request_Onchip_memory_s1);
  --assign Onchip_memory_s1_readdata_from_sa = Onchip_memory_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  Onchip_memory_s1_readdata_from_sa <= Onchip_memory_s1_readdata;
  internal_CPU_instruction_master_requests_Onchip_memory_s1 <= ((to_std_logic(((Std_Logic_Vector'(CPU_instruction_master_address_to_slave(27 DOWNTO 13) & std_logic_vector'("0000000000000")) = std_logic_vector'("1001000000000000000000000000")))) AND (CPU_instruction_master_read))) AND CPU_instruction_master_read;
  --Onchip_memory_s1_arb_share_counter set values, which is an e_mux
  Onchip_memory_s1_arb_share_set_values <= std_logic_vector'("01");
  --Onchip_memory_s1_non_bursting_master_requests mux, which is an e_mux
  Onchip_memory_s1_non_bursting_master_requests <= internal_CPU_instruction_master_requests_Onchip_memory_s1;
  --Onchip_memory_s1_any_bursting_master_saved_grant mux, which is an e_mux
  Onchip_memory_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --Onchip_memory_s1_arb_share_counter_next_value assignment, which is an e_assign
  Onchip_memory_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(Onchip_memory_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Onchip_memory_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(Onchip_memory_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Onchip_memory_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --Onchip_memory_s1_allgrants all slave grants, which is an e_mux
  Onchip_memory_s1_allgrants <= Onchip_memory_s1_grant_vector;
  --Onchip_memory_s1_end_xfer assignment, which is an e_assign
  Onchip_memory_s1_end_xfer <= NOT ((Onchip_memory_s1_waits_for_read OR Onchip_memory_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_Onchip_memory_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Onchip_memory_s1 <= Onchip_memory_s1_end_xfer AND (((NOT Onchip_memory_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Onchip_memory_s1_arb_share_counter arbitration counter enable, which is an e_assign
  Onchip_memory_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Onchip_memory_s1 AND Onchip_memory_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_Onchip_memory_s1 AND NOT Onchip_memory_s1_non_bursting_master_requests));
  --Onchip_memory_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Onchip_memory_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(Onchip_memory_s1_arb_counter_enable) = '1' then 
        Onchip_memory_s1_arb_share_counter <= Onchip_memory_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Onchip_memory_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Onchip_memory_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Onchip_memory_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_Onchip_memory_s1)) OR ((end_xfer_arb_share_counter_term_Onchip_memory_s1 AND NOT Onchip_memory_s1_non_bursting_master_requests)))) = '1' then 
        Onchip_memory_s1_slavearbiterlockenable <= or_reduce(Onchip_memory_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/instruction_master Onchip_memory/s1 arbiterlock, which is an e_assign
  CPU_instruction_master_arbiterlock <= Onchip_memory_s1_slavearbiterlockenable AND CPU_instruction_master_continuerequest;
  --Onchip_memory_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Onchip_memory_s1_slavearbiterlockenable2 <= or_reduce(Onchip_memory_s1_arb_share_counter_next_value);
  --CPU/instruction_master Onchip_memory/s1 arbiterlock2, which is an e_assign
  CPU_instruction_master_arbiterlock2 <= Onchip_memory_s1_slavearbiterlockenable2 AND CPU_instruction_master_continuerequest;
  --Onchip_memory_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  Onchip_memory_s1_any_continuerequest <= std_logic'('1');
  --CPU_instruction_master_continuerequest continued request, which is an e_assign
  CPU_instruction_master_continuerequest <= std_logic'('1');
  internal_CPU_instruction_master_qualified_request_Onchip_memory_s1 <= internal_CPU_instruction_master_requests_Onchip_memory_s1 AND NOT ((CPU_instruction_master_read AND (((to_std_logic(((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_latency_counter)))))) OR (CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register)) OR (CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register)))));
  --CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register_in <= (internal_CPU_instruction_master_granted_Onchip_memory_s1 AND CPU_instruction_master_read) AND NOT Onchip_memory_s1_waits_for_read;
  --shift register p1 CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register) & A_ToStdLogicVector(CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register_in)));
  --CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register <= p1_CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register;
    end if;

  end process;

  --local readdatavalid CPU_instruction_master_read_data_valid_Onchip_memory_s1, which is an e_mux
  CPU_instruction_master_read_data_valid_Onchip_memory_s1 <= CPU_instruction_master_read_data_valid_Onchip_memory_s1_shift_register;
  --mux Onchip_memory_s1_clken, which is an e_mux
  Onchip_memory_s1_clken <= std_logic'('1');
  --master is always granted when requested
  internal_CPU_instruction_master_granted_Onchip_memory_s1 <= internal_CPU_instruction_master_qualified_request_Onchip_memory_s1;
  --CPU/instruction_master saved-grant Onchip_memory/s1, which is an e_assign
  CPU_instruction_master_saved_grant_Onchip_memory_s1 <= internal_CPU_instruction_master_requests_Onchip_memory_s1;
  --allow new arb cycle for Onchip_memory/s1, which is an e_assign
  Onchip_memory_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Onchip_memory_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Onchip_memory_s1_master_qreq_vector <= std_logic'('1');
  Onchip_memory_s1_chipselect <= internal_CPU_instruction_master_granted_Onchip_memory_s1;
  --Onchip_memory_s1_firsttransfer first transaction, which is an e_assign
  Onchip_memory_s1_firsttransfer <= A_WE_StdLogic((std_logic'(Onchip_memory_s1_begins_xfer) = '1'), Onchip_memory_s1_unreg_firsttransfer, Onchip_memory_s1_reg_firsttransfer);
  --Onchip_memory_s1_unreg_firsttransfer first transaction, which is an e_assign
  Onchip_memory_s1_unreg_firsttransfer <= NOT ((Onchip_memory_s1_slavearbiterlockenable AND Onchip_memory_s1_any_continuerequest));
  --Onchip_memory_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Onchip_memory_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Onchip_memory_s1_begins_xfer) = '1' then 
        Onchip_memory_s1_reg_firsttransfer <= Onchip_memory_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Onchip_memory_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Onchip_memory_s1_beginbursttransfer_internal <= Onchip_memory_s1_begins_xfer;
  --Onchip_memory_s1_write assignment, which is an e_mux
  Onchip_memory_s1_write <= std_logic'('0');
  shifted_address_to_Onchip_memory_s1_from_CPU_instruction_master <= CPU_instruction_master_address_to_slave;
  --Onchip_memory_s1_address mux, which is an e_mux
  Onchip_memory_s1_address <= A_EXT (A_SRL(shifted_address_to_Onchip_memory_s1_from_CPU_instruction_master,std_logic_vector'("00000000000000000000000000000010")), 11);
  --d1_Onchip_memory_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Onchip_memory_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Onchip_memory_s1_end_xfer <= Onchip_memory_s1_end_xfer;
    end if;

  end process;

  --Onchip_memory_s1_waits_for_read in a cycle, which is an e_mux
  Onchip_memory_s1_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Onchip_memory_s1_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Onchip_memory_s1_in_a_read_cycle assignment, which is an e_assign
  Onchip_memory_s1_in_a_read_cycle <= internal_CPU_instruction_master_granted_Onchip_memory_s1 AND CPU_instruction_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Onchip_memory_s1_in_a_read_cycle;
  --Onchip_memory_s1_waits_for_write in a cycle, which is an e_mux
  Onchip_memory_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Onchip_memory_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Onchip_memory_s1_in_a_write_cycle assignment, which is an e_assign
  Onchip_memory_s1_in_a_write_cycle <= std_logic'('0');
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Onchip_memory_s1_in_a_write_cycle;
  wait_for_Onchip_memory_s1_counter <= std_logic'('0');
  --Onchip_memory_s1_byteenable byte enable port mux, which is an e_mux
  Onchip_memory_s1_byteenable <= A_EXT (-SIGNED(std_logic_vector'("00000000000000000000000000000001")), 4);
  --vhdl renameroo for output signals
  CPU_instruction_master_granted_Onchip_memory_s1 <= internal_CPU_instruction_master_granted_Onchip_memory_s1;
  --vhdl renameroo for output signals
  CPU_instruction_master_qualified_request_Onchip_memory_s1 <= internal_CPU_instruction_master_qualified_request_Onchip_memory_s1;
  --vhdl renameroo for output signals
  CPU_instruction_master_requests_Onchip_memory_s1 <= internal_CPU_instruction_master_requests_Onchip_memory_s1;
--synthesis translate_off
    --Onchip_memory/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Onchip_memory_s2_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Onchip_memory_s2_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_Onchip_memory_s2 : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_Onchip_memory_s2 : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Onchip_memory_s2 : OUT STD_LOGIC;
                 signal CPU_data_master_requests_Onchip_memory_s2 : OUT STD_LOGIC;
                 signal Onchip_memory_s2_address : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
                 signal Onchip_memory_s2_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal Onchip_memory_s2_chipselect : OUT STD_LOGIC;
                 signal Onchip_memory_s2_clken : OUT STD_LOGIC;
                 signal Onchip_memory_s2_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Onchip_memory_s2_write : OUT STD_LOGIC;
                 signal Onchip_memory_s2_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_Onchip_memory_s2_end_xfer : OUT STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Onchip_memory_s2 : OUT STD_LOGIC
              );
end entity Onchip_memory_s2_arbitrator;


architecture europa of Onchip_memory_s2_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register_in :  STD_LOGIC;
                signal CPU_data_master_saved_grant_Onchip_memory_s2 :  STD_LOGIC;
                signal Onchip_memory_s2_allgrants :  STD_LOGIC;
                signal Onchip_memory_s2_allow_new_arb_cycle :  STD_LOGIC;
                signal Onchip_memory_s2_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Onchip_memory_s2_any_continuerequest :  STD_LOGIC;
                signal Onchip_memory_s2_arb_counter_enable :  STD_LOGIC;
                signal Onchip_memory_s2_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Onchip_memory_s2_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Onchip_memory_s2_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Onchip_memory_s2_beginbursttransfer_internal :  STD_LOGIC;
                signal Onchip_memory_s2_begins_xfer :  STD_LOGIC;
                signal Onchip_memory_s2_end_xfer :  STD_LOGIC;
                signal Onchip_memory_s2_firsttransfer :  STD_LOGIC;
                signal Onchip_memory_s2_grant_vector :  STD_LOGIC;
                signal Onchip_memory_s2_in_a_read_cycle :  STD_LOGIC;
                signal Onchip_memory_s2_in_a_write_cycle :  STD_LOGIC;
                signal Onchip_memory_s2_master_qreq_vector :  STD_LOGIC;
                signal Onchip_memory_s2_non_bursting_master_requests :  STD_LOGIC;
                signal Onchip_memory_s2_reg_firsttransfer :  STD_LOGIC;
                signal Onchip_memory_s2_slavearbiterlockenable :  STD_LOGIC;
                signal Onchip_memory_s2_slavearbiterlockenable2 :  STD_LOGIC;
                signal Onchip_memory_s2_unreg_firsttransfer :  STD_LOGIC;
                signal Onchip_memory_s2_waits_for_read :  STD_LOGIC;
                signal Onchip_memory_s2_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Onchip_memory_s2 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_Onchip_memory_s2 :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_Onchip_memory_s2 :  STD_LOGIC;
                signal internal_CPU_data_master_requests_Onchip_memory_s2 :  STD_LOGIC;
                signal p1_CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register :  STD_LOGIC;
                signal shifted_address_to_Onchip_memory_s2_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal wait_for_Onchip_memory_s2_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Onchip_memory_s2_end_xfer;
    end if;

  end process;

  Onchip_memory_s2_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_Onchip_memory_s2);
  --assign Onchip_memory_s2_readdata_from_sa = Onchip_memory_s2_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  Onchip_memory_s2_readdata_from_sa <= Onchip_memory_s2_readdata;
  internal_CPU_data_master_requests_Onchip_memory_s2 <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 13) & std_logic_vector'("0000000000000")) = std_logic_vector'("01001000000000000000000000000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --registered rdv signal_name registered_CPU_data_master_read_data_valid_Onchip_memory_s2 assignment, which is an e_assign
  registered_CPU_data_master_read_data_valid_Onchip_memory_s2 <= CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register_in;
  --Onchip_memory_s2_arb_share_counter set values, which is an e_mux
  Onchip_memory_s2_arb_share_set_values <= std_logic_vector'("01");
  --Onchip_memory_s2_non_bursting_master_requests mux, which is an e_mux
  Onchip_memory_s2_non_bursting_master_requests <= internal_CPU_data_master_requests_Onchip_memory_s2;
  --Onchip_memory_s2_any_bursting_master_saved_grant mux, which is an e_mux
  Onchip_memory_s2_any_bursting_master_saved_grant <= std_logic'('0');
  --Onchip_memory_s2_arb_share_counter_next_value assignment, which is an e_assign
  Onchip_memory_s2_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(Onchip_memory_s2_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Onchip_memory_s2_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(Onchip_memory_s2_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Onchip_memory_s2_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --Onchip_memory_s2_allgrants all slave grants, which is an e_mux
  Onchip_memory_s2_allgrants <= Onchip_memory_s2_grant_vector;
  --Onchip_memory_s2_end_xfer assignment, which is an e_assign
  Onchip_memory_s2_end_xfer <= NOT ((Onchip_memory_s2_waits_for_read OR Onchip_memory_s2_waits_for_write));
  --end_xfer_arb_share_counter_term_Onchip_memory_s2 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Onchip_memory_s2 <= Onchip_memory_s2_end_xfer AND (((NOT Onchip_memory_s2_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Onchip_memory_s2_arb_share_counter arbitration counter enable, which is an e_assign
  Onchip_memory_s2_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Onchip_memory_s2 AND Onchip_memory_s2_allgrants)) OR ((end_xfer_arb_share_counter_term_Onchip_memory_s2 AND NOT Onchip_memory_s2_non_bursting_master_requests));
  --Onchip_memory_s2_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Onchip_memory_s2_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(Onchip_memory_s2_arb_counter_enable) = '1' then 
        Onchip_memory_s2_arb_share_counter <= Onchip_memory_s2_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Onchip_memory_s2_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Onchip_memory_s2_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Onchip_memory_s2_master_qreq_vector AND end_xfer_arb_share_counter_term_Onchip_memory_s2)) OR ((end_xfer_arb_share_counter_term_Onchip_memory_s2 AND NOT Onchip_memory_s2_non_bursting_master_requests)))) = '1' then 
        Onchip_memory_s2_slavearbiterlockenable <= or_reduce(Onchip_memory_s2_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master Onchip_memory/s2 arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= Onchip_memory_s2_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --Onchip_memory_s2_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Onchip_memory_s2_slavearbiterlockenable2 <= or_reduce(Onchip_memory_s2_arb_share_counter_next_value);
  --CPU/data_master Onchip_memory/s2 arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= Onchip_memory_s2_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --Onchip_memory_s2_any_continuerequest at least one master continues requesting, which is an e_assign
  Onchip_memory_s2_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_Onchip_memory_s2 <= internal_CPU_data_master_requests_Onchip_memory_s2 AND NOT ((((CPU_data_master_read AND (CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register))) OR (((NOT CPU_data_master_waitrequest) AND CPU_data_master_write))));
  --CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register_in mux for readlatency shift register, which is an e_mux
  CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register_in <= ((internal_CPU_data_master_granted_Onchip_memory_s2 AND CPU_data_master_read) AND NOT Onchip_memory_s2_waits_for_read) AND NOT (CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register);
  --shift register p1 CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register) & A_ToStdLogicVector(CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register_in)));
  --CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register <= p1_CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register;
    end if;

  end process;

  --local readdatavalid CPU_data_master_read_data_valid_Onchip_memory_s2, which is an e_mux
  CPU_data_master_read_data_valid_Onchip_memory_s2 <= CPU_data_master_read_data_valid_Onchip_memory_s2_shift_register;
  --Onchip_memory_s2_writedata mux, which is an e_mux
  Onchip_memory_s2_writedata <= CPU_data_master_writedata;
  --mux Onchip_memory_s2_clken, which is an e_mux
  Onchip_memory_s2_clken <= std_logic'('1');
  --master is always granted when requested
  internal_CPU_data_master_granted_Onchip_memory_s2 <= internal_CPU_data_master_qualified_request_Onchip_memory_s2;
  --CPU/data_master saved-grant Onchip_memory/s2, which is an e_assign
  CPU_data_master_saved_grant_Onchip_memory_s2 <= internal_CPU_data_master_requests_Onchip_memory_s2;
  --allow new arb cycle for Onchip_memory/s2, which is an e_assign
  Onchip_memory_s2_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Onchip_memory_s2_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Onchip_memory_s2_master_qreq_vector <= std_logic'('1');
  Onchip_memory_s2_chipselect <= internal_CPU_data_master_granted_Onchip_memory_s2;
  --Onchip_memory_s2_firsttransfer first transaction, which is an e_assign
  Onchip_memory_s2_firsttransfer <= A_WE_StdLogic((std_logic'(Onchip_memory_s2_begins_xfer) = '1'), Onchip_memory_s2_unreg_firsttransfer, Onchip_memory_s2_reg_firsttransfer);
  --Onchip_memory_s2_unreg_firsttransfer first transaction, which is an e_assign
  Onchip_memory_s2_unreg_firsttransfer <= NOT ((Onchip_memory_s2_slavearbiterlockenable AND Onchip_memory_s2_any_continuerequest));
  --Onchip_memory_s2_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Onchip_memory_s2_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Onchip_memory_s2_begins_xfer) = '1' then 
        Onchip_memory_s2_reg_firsttransfer <= Onchip_memory_s2_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Onchip_memory_s2_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Onchip_memory_s2_beginbursttransfer_internal <= Onchip_memory_s2_begins_xfer;
  --Onchip_memory_s2_write assignment, which is an e_mux
  Onchip_memory_s2_write <= internal_CPU_data_master_granted_Onchip_memory_s2 AND CPU_data_master_write;
  shifted_address_to_Onchip_memory_s2_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --Onchip_memory_s2_address mux, which is an e_mux
  Onchip_memory_s2_address <= A_EXT (A_SRL(shifted_address_to_Onchip_memory_s2_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")), 11);
  --d1_Onchip_memory_s2_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Onchip_memory_s2_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Onchip_memory_s2_end_xfer <= Onchip_memory_s2_end_xfer;
    end if;

  end process;

  --Onchip_memory_s2_waits_for_read in a cycle, which is an e_mux
  Onchip_memory_s2_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Onchip_memory_s2_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Onchip_memory_s2_in_a_read_cycle assignment, which is an e_assign
  Onchip_memory_s2_in_a_read_cycle <= internal_CPU_data_master_granted_Onchip_memory_s2 AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Onchip_memory_s2_in_a_read_cycle;
  --Onchip_memory_s2_waits_for_write in a cycle, which is an e_mux
  Onchip_memory_s2_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Onchip_memory_s2_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Onchip_memory_s2_in_a_write_cycle assignment, which is an e_assign
  Onchip_memory_s2_in_a_write_cycle <= internal_CPU_data_master_granted_Onchip_memory_s2 AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Onchip_memory_s2_in_a_write_cycle;
  wait_for_Onchip_memory_s2_counter <= std_logic'('0');
  --Onchip_memory_s2_byteenable byte enable port mux, which is an e_mux
  Onchip_memory_s2_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_Onchip_memory_s2)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CPU_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  CPU_data_master_granted_Onchip_memory_s2 <= internal_CPU_data_master_granted_Onchip_memory_s2;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_Onchip_memory_s2 <= internal_CPU_data_master_qualified_request_Onchip_memory_s2;
  --vhdl renameroo for output signals
  CPU_data_master_requests_Onchip_memory_s2 <= internal_CPU_data_master_requests_Onchip_memory_s2;
--synthesis translate_off
    --Onchip_memory/s2 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Pushbuttons_avalon_parallel_port_slave_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Pushbuttons_avalon_parallel_port_slave_irq : IN STD_LOGIC;
                 signal Pushbuttons_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal Pushbuttons_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Pushbuttons_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal Pushbuttons_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                 signal Pushbuttons_avalon_parallel_port_slave_irq_from_sa : OUT STD_LOGIC;
                 signal Pushbuttons_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                 signal Pushbuttons_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Pushbuttons_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                 signal Pushbuttons_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                 signal Pushbuttons_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_Pushbuttons_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave : OUT STD_LOGIC
              );
end entity Pushbuttons_avalon_parallel_port_slave_arbitrator;


architecture europa of Pushbuttons_avalon_parallel_port_slave_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register_in :  STD_LOGIC;
                signal CPU_data_master_saved_grant_Pushbuttons_avalon_parallel_port_slave :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_allgrants :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_any_continuerequest :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_arb_counter_enable :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Pushbuttons_avalon_parallel_port_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Pushbuttons_avalon_parallel_port_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Pushbuttons_avalon_parallel_port_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_begins_xfer :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_firsttransfer :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_grant_vector :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_in_a_read_cycle :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_in_a_write_cycle :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_master_qreq_vector :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_non_bursting_master_requests :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_reg_firsttransfer :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_slavearbiterlockenable :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_unreg_firsttransfer :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_waits_for_read :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Pushbuttons_avalon_parallel_port_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave :  STD_LOGIC;
                signal p1_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal shifted_address_to_Pushbuttons_avalon_parallel_port_slave_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal wait_for_Pushbuttons_avalon_parallel_port_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Pushbuttons_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  Pushbuttons_avalon_parallel_port_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave);
  --assign Pushbuttons_avalon_parallel_port_slave_readdata_from_sa = Pushbuttons_avalon_parallel_port_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_readdata_from_sa <= Pushbuttons_avalon_parallel_port_slave_readdata;
  internal_CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("10000000000000000000001010000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --registered rdv signal_name registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave assignment, which is an e_assign
  registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register_in;
  --Pushbuttons_avalon_parallel_port_slave_arb_share_counter set values, which is an e_mux
  Pushbuttons_avalon_parallel_port_slave_arb_share_set_values <= std_logic_vector'("01");
  --Pushbuttons_avalon_parallel_port_slave_non_bursting_master_requests mux, which is an e_mux
  Pushbuttons_avalon_parallel_port_slave_non_bursting_master_requests <= internal_CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave;
  --Pushbuttons_avalon_parallel_port_slave_any_bursting_master_saved_grant mux, which is an e_mux
  Pushbuttons_avalon_parallel_port_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --Pushbuttons_avalon_parallel_port_slave_arb_share_counter_next_value assignment, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(Pushbuttons_avalon_parallel_port_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Pushbuttons_avalon_parallel_port_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(Pushbuttons_avalon_parallel_port_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Pushbuttons_avalon_parallel_port_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --Pushbuttons_avalon_parallel_port_slave_allgrants all slave grants, which is an e_mux
  Pushbuttons_avalon_parallel_port_slave_allgrants <= Pushbuttons_avalon_parallel_port_slave_grant_vector;
  --Pushbuttons_avalon_parallel_port_slave_end_xfer assignment, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_end_xfer <= NOT ((Pushbuttons_avalon_parallel_port_slave_waits_for_read OR Pushbuttons_avalon_parallel_port_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_Pushbuttons_avalon_parallel_port_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Pushbuttons_avalon_parallel_port_slave <= Pushbuttons_avalon_parallel_port_slave_end_xfer AND (((NOT Pushbuttons_avalon_parallel_port_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Pushbuttons_avalon_parallel_port_slave_arb_share_counter arbitration counter enable, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Pushbuttons_avalon_parallel_port_slave AND Pushbuttons_avalon_parallel_port_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_Pushbuttons_avalon_parallel_port_slave AND NOT Pushbuttons_avalon_parallel_port_slave_non_bursting_master_requests));
  --Pushbuttons_avalon_parallel_port_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Pushbuttons_avalon_parallel_port_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(Pushbuttons_avalon_parallel_port_slave_arb_counter_enable) = '1' then 
        Pushbuttons_avalon_parallel_port_slave_arb_share_counter <= Pushbuttons_avalon_parallel_port_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Pushbuttons_avalon_parallel_port_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Pushbuttons_avalon_parallel_port_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Pushbuttons_avalon_parallel_port_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_Pushbuttons_avalon_parallel_port_slave)) OR ((end_xfer_arb_share_counter_term_Pushbuttons_avalon_parallel_port_slave AND NOT Pushbuttons_avalon_parallel_port_slave_non_bursting_master_requests)))) = '1' then 
        Pushbuttons_avalon_parallel_port_slave_slavearbiterlockenable <= or_reduce(Pushbuttons_avalon_parallel_port_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master Pushbuttons/avalon_parallel_port_slave arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= Pushbuttons_avalon_parallel_port_slave_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --Pushbuttons_avalon_parallel_port_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_slavearbiterlockenable2 <= or_reduce(Pushbuttons_avalon_parallel_port_slave_arb_share_counter_next_value);
  --CPU/data_master Pushbuttons/avalon_parallel_port_slave arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= Pushbuttons_avalon_parallel_port_slave_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --Pushbuttons_avalon_parallel_port_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave AND NOT ((((CPU_data_master_read AND (CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register))) OR (((NOT CPU_data_master_waitrequest) AND CPU_data_master_write))));
  --CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register_in <= ((internal_CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave AND CPU_data_master_read) AND NOT Pushbuttons_avalon_parallel_port_slave_waits_for_read) AND NOT (CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register);
  --shift register p1 CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register) & A_ToStdLogicVector(CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register_in)));
  --CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register <= p1_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register;
    end if;

  end process;

  --local readdatavalid CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave, which is an e_mux
  CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave_shift_register;
  --Pushbuttons_avalon_parallel_port_slave_writedata mux, which is an e_mux
  Pushbuttons_avalon_parallel_port_slave_writedata <= CPU_data_master_writedata;
  --master is always granted when requested
  internal_CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave;
  --CPU/data_master saved-grant Pushbuttons/avalon_parallel_port_slave, which is an e_assign
  CPU_data_master_saved_grant_Pushbuttons_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave;
  --allow new arb cycle for Pushbuttons/avalon_parallel_port_slave, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Pushbuttons_avalon_parallel_port_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Pushbuttons_avalon_parallel_port_slave_master_qreq_vector <= std_logic'('1');
  --~Pushbuttons_avalon_parallel_port_slave_reset assignment, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_reset <= NOT reset_n;
  Pushbuttons_avalon_parallel_port_slave_chipselect <= internal_CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave;
  --Pushbuttons_avalon_parallel_port_slave_firsttransfer first transaction, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_firsttransfer <= A_WE_StdLogic((std_logic'(Pushbuttons_avalon_parallel_port_slave_begins_xfer) = '1'), Pushbuttons_avalon_parallel_port_slave_unreg_firsttransfer, Pushbuttons_avalon_parallel_port_slave_reg_firsttransfer);
  --Pushbuttons_avalon_parallel_port_slave_unreg_firsttransfer first transaction, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_unreg_firsttransfer <= NOT ((Pushbuttons_avalon_parallel_port_slave_slavearbiterlockenable AND Pushbuttons_avalon_parallel_port_slave_any_continuerequest));
  --Pushbuttons_avalon_parallel_port_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Pushbuttons_avalon_parallel_port_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Pushbuttons_avalon_parallel_port_slave_begins_xfer) = '1' then 
        Pushbuttons_avalon_parallel_port_slave_reg_firsttransfer <= Pushbuttons_avalon_parallel_port_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Pushbuttons_avalon_parallel_port_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_beginbursttransfer_internal <= Pushbuttons_avalon_parallel_port_slave_begins_xfer;
  --Pushbuttons_avalon_parallel_port_slave_read assignment, which is an e_mux
  Pushbuttons_avalon_parallel_port_slave_read <= internal_CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave AND CPU_data_master_read;
  --Pushbuttons_avalon_parallel_port_slave_write assignment, which is an e_mux
  Pushbuttons_avalon_parallel_port_slave_write <= internal_CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave AND CPU_data_master_write;
  shifted_address_to_Pushbuttons_avalon_parallel_port_slave_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --Pushbuttons_avalon_parallel_port_slave_address mux, which is an e_mux
  Pushbuttons_avalon_parallel_port_slave_address <= A_EXT (A_SRL(shifted_address_to_Pushbuttons_avalon_parallel_port_slave_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_Pushbuttons_avalon_parallel_port_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Pushbuttons_avalon_parallel_port_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Pushbuttons_avalon_parallel_port_slave_end_xfer <= Pushbuttons_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  --Pushbuttons_avalon_parallel_port_slave_waits_for_read in a cycle, which is an e_mux
  Pushbuttons_avalon_parallel_port_slave_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Pushbuttons_avalon_parallel_port_slave_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Pushbuttons_avalon_parallel_port_slave_in_a_read_cycle assignment, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_in_a_read_cycle <= internal_CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Pushbuttons_avalon_parallel_port_slave_in_a_read_cycle;
  --Pushbuttons_avalon_parallel_port_slave_waits_for_write in a cycle, which is an e_mux
  Pushbuttons_avalon_parallel_port_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Pushbuttons_avalon_parallel_port_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Pushbuttons_avalon_parallel_port_slave_in_a_write_cycle assignment, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_in_a_write_cycle <= internal_CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Pushbuttons_avalon_parallel_port_slave_in_a_write_cycle;
  wait_for_Pushbuttons_avalon_parallel_port_slave_counter <= std_logic'('0');
  --Pushbuttons_avalon_parallel_port_slave_byteenable byte enable port mux, which is an e_mux
  Pushbuttons_avalon_parallel_port_slave_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CPU_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --assign Pushbuttons_avalon_parallel_port_slave_irq_from_sa = Pushbuttons_avalon_parallel_port_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  Pushbuttons_avalon_parallel_port_slave_irq_from_sa <= Pushbuttons_avalon_parallel_port_slave_irq;
  --vhdl renameroo for output signals
  CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave <= internal_CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave;
--synthesis translate_off
    --Pushbuttons/avalon_parallel_port_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Red_LEDs_avalon_parallel_port_slave_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Red_LEDs_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal Red_LEDs_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Red_LEDs_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal Red_LEDs_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                 signal Red_LEDs_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                 signal Red_LEDs_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Red_LEDs_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                 signal Red_LEDs_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                 signal Red_LEDs_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_Red_LEDs_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC
              );
end entity Red_LEDs_avalon_parallel_port_slave_arbitrator;


architecture europa of Red_LEDs_avalon_parallel_port_slave_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register_in :  STD_LOGIC;
                signal CPU_data_master_saved_grant_Red_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_allgrants :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_any_continuerequest :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_arb_counter_enable :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Red_LEDs_avalon_parallel_port_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Red_LEDs_avalon_parallel_port_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Red_LEDs_avalon_parallel_port_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_begins_xfer :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_firsttransfer :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_grant_vector :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_in_a_read_cycle :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_in_a_write_cycle :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_master_qreq_vector :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_non_bursting_master_requests :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_reg_firsttransfer :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_slavearbiterlockenable :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_unreg_firsttransfer :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_waits_for_read :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Red_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal p1_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal shifted_address_to_Red_LEDs_avalon_parallel_port_slave_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal wait_for_Red_LEDs_avalon_parallel_port_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Red_LEDs_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  Red_LEDs_avalon_parallel_port_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave);
  --assign Red_LEDs_avalon_parallel_port_slave_readdata_from_sa = Red_LEDs_avalon_parallel_port_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_readdata_from_sa <= Red_LEDs_avalon_parallel_port_slave_readdata;
  internal_CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("10000000000000000000000000000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --registered rdv signal_name registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave assignment, which is an e_assign
  registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register_in;
  --Red_LEDs_avalon_parallel_port_slave_arb_share_counter set values, which is an e_mux
  Red_LEDs_avalon_parallel_port_slave_arb_share_set_values <= std_logic_vector'("01");
  --Red_LEDs_avalon_parallel_port_slave_non_bursting_master_requests mux, which is an e_mux
  Red_LEDs_avalon_parallel_port_slave_non_bursting_master_requests <= internal_CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave;
  --Red_LEDs_avalon_parallel_port_slave_any_bursting_master_saved_grant mux, which is an e_mux
  Red_LEDs_avalon_parallel_port_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --Red_LEDs_avalon_parallel_port_slave_arb_share_counter_next_value assignment, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(Red_LEDs_avalon_parallel_port_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Red_LEDs_avalon_parallel_port_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(Red_LEDs_avalon_parallel_port_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Red_LEDs_avalon_parallel_port_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --Red_LEDs_avalon_parallel_port_slave_allgrants all slave grants, which is an e_mux
  Red_LEDs_avalon_parallel_port_slave_allgrants <= Red_LEDs_avalon_parallel_port_slave_grant_vector;
  --Red_LEDs_avalon_parallel_port_slave_end_xfer assignment, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_end_xfer <= NOT ((Red_LEDs_avalon_parallel_port_slave_waits_for_read OR Red_LEDs_avalon_parallel_port_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_Red_LEDs_avalon_parallel_port_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Red_LEDs_avalon_parallel_port_slave <= Red_LEDs_avalon_parallel_port_slave_end_xfer AND (((NOT Red_LEDs_avalon_parallel_port_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Red_LEDs_avalon_parallel_port_slave_arb_share_counter arbitration counter enable, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Red_LEDs_avalon_parallel_port_slave AND Red_LEDs_avalon_parallel_port_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_Red_LEDs_avalon_parallel_port_slave AND NOT Red_LEDs_avalon_parallel_port_slave_non_bursting_master_requests));
  --Red_LEDs_avalon_parallel_port_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Red_LEDs_avalon_parallel_port_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(Red_LEDs_avalon_parallel_port_slave_arb_counter_enable) = '1' then 
        Red_LEDs_avalon_parallel_port_slave_arb_share_counter <= Red_LEDs_avalon_parallel_port_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Red_LEDs_avalon_parallel_port_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Red_LEDs_avalon_parallel_port_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Red_LEDs_avalon_parallel_port_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_Red_LEDs_avalon_parallel_port_slave)) OR ((end_xfer_arb_share_counter_term_Red_LEDs_avalon_parallel_port_slave AND NOT Red_LEDs_avalon_parallel_port_slave_non_bursting_master_requests)))) = '1' then 
        Red_LEDs_avalon_parallel_port_slave_slavearbiterlockenable <= or_reduce(Red_LEDs_avalon_parallel_port_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master Red_LEDs/avalon_parallel_port_slave arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= Red_LEDs_avalon_parallel_port_slave_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --Red_LEDs_avalon_parallel_port_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_slavearbiterlockenable2 <= or_reduce(Red_LEDs_avalon_parallel_port_slave_arb_share_counter_next_value);
  --CPU/data_master Red_LEDs/avalon_parallel_port_slave arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= Red_LEDs_avalon_parallel_port_slave_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --Red_LEDs_avalon_parallel_port_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave AND NOT ((((CPU_data_master_read AND (CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register))) OR (((NOT CPU_data_master_waitrequest) AND CPU_data_master_write))));
  --CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register_in <= ((internal_CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave AND CPU_data_master_read) AND NOT Red_LEDs_avalon_parallel_port_slave_waits_for_read) AND NOT (CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register);
  --shift register p1 CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register) & A_ToStdLogicVector(CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register_in)));
  --CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register <= p1_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register;
    end if;

  end process;

  --local readdatavalid CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave, which is an e_mux
  CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave_shift_register;
  --Red_LEDs_avalon_parallel_port_slave_writedata mux, which is an e_mux
  Red_LEDs_avalon_parallel_port_slave_writedata <= CPU_data_master_writedata;
  --master is always granted when requested
  internal_CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave;
  --CPU/data_master saved-grant Red_LEDs/avalon_parallel_port_slave, which is an e_assign
  CPU_data_master_saved_grant_Red_LEDs_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave;
  --allow new arb cycle for Red_LEDs/avalon_parallel_port_slave, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Red_LEDs_avalon_parallel_port_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Red_LEDs_avalon_parallel_port_slave_master_qreq_vector <= std_logic'('1');
  --~Red_LEDs_avalon_parallel_port_slave_reset assignment, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_reset <= NOT reset_n;
  Red_LEDs_avalon_parallel_port_slave_chipselect <= internal_CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave;
  --Red_LEDs_avalon_parallel_port_slave_firsttransfer first transaction, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_firsttransfer <= A_WE_StdLogic((std_logic'(Red_LEDs_avalon_parallel_port_slave_begins_xfer) = '1'), Red_LEDs_avalon_parallel_port_slave_unreg_firsttransfer, Red_LEDs_avalon_parallel_port_slave_reg_firsttransfer);
  --Red_LEDs_avalon_parallel_port_slave_unreg_firsttransfer first transaction, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_unreg_firsttransfer <= NOT ((Red_LEDs_avalon_parallel_port_slave_slavearbiterlockenable AND Red_LEDs_avalon_parallel_port_slave_any_continuerequest));
  --Red_LEDs_avalon_parallel_port_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Red_LEDs_avalon_parallel_port_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Red_LEDs_avalon_parallel_port_slave_begins_xfer) = '1' then 
        Red_LEDs_avalon_parallel_port_slave_reg_firsttransfer <= Red_LEDs_avalon_parallel_port_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Red_LEDs_avalon_parallel_port_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_beginbursttransfer_internal <= Red_LEDs_avalon_parallel_port_slave_begins_xfer;
  --Red_LEDs_avalon_parallel_port_slave_read assignment, which is an e_mux
  Red_LEDs_avalon_parallel_port_slave_read <= internal_CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave AND CPU_data_master_read;
  --Red_LEDs_avalon_parallel_port_slave_write assignment, which is an e_mux
  Red_LEDs_avalon_parallel_port_slave_write <= internal_CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave AND CPU_data_master_write;
  shifted_address_to_Red_LEDs_avalon_parallel_port_slave_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --Red_LEDs_avalon_parallel_port_slave_address mux, which is an e_mux
  Red_LEDs_avalon_parallel_port_slave_address <= A_EXT (A_SRL(shifted_address_to_Red_LEDs_avalon_parallel_port_slave_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_Red_LEDs_avalon_parallel_port_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Red_LEDs_avalon_parallel_port_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Red_LEDs_avalon_parallel_port_slave_end_xfer <= Red_LEDs_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  --Red_LEDs_avalon_parallel_port_slave_waits_for_read in a cycle, which is an e_mux
  Red_LEDs_avalon_parallel_port_slave_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Red_LEDs_avalon_parallel_port_slave_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Red_LEDs_avalon_parallel_port_slave_in_a_read_cycle assignment, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_in_a_read_cycle <= internal_CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Red_LEDs_avalon_parallel_port_slave_in_a_read_cycle;
  --Red_LEDs_avalon_parallel_port_slave_waits_for_write in a cycle, which is an e_mux
  Red_LEDs_avalon_parallel_port_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Red_LEDs_avalon_parallel_port_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Red_LEDs_avalon_parallel_port_slave_in_a_write_cycle assignment, which is an e_assign
  Red_LEDs_avalon_parallel_port_slave_in_a_write_cycle <= internal_CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Red_LEDs_avalon_parallel_port_slave_in_a_write_cycle;
  wait_for_Red_LEDs_avalon_parallel_port_slave_counter <= std_logic'('0');
  --Red_LEDs_avalon_parallel_port_slave_byteenable byte enable port mux, which is an e_mux
  Red_LEDs_avalon_parallel_port_slave_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CPU_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave <= internal_CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave;
--synthesis translate_off
    --Red_LEDs/avalon_parallel_port_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_CPU_data_master_to_SDRAM_s1_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_CPU_data_master_to_SDRAM_s1_module;


architecture europa of rdv_fifo_for_CPU_data_master_to_SDRAM_s1_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal full_4 :  STD_LOGIC;
                signal full_5 :  STD_LOGIC;
                signal full_6 :  STD_LOGIC;
                signal full_7 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC;
                signal p3_full_3 :  STD_LOGIC;
                signal p3_stage_3 :  STD_LOGIC;
                signal p4_full_4 :  STD_LOGIC;
                signal p4_stage_4 :  STD_LOGIC;
                signal p5_full_5 :  STD_LOGIC;
                signal p5_stage_5 :  STD_LOGIC;
                signal p6_full_6 :  STD_LOGIC;
                signal p6_stage_6 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal stage_2 :  STD_LOGIC;
                signal stage_3 :  STD_LOGIC;
                signal stage_4 :  STD_LOGIC;
                signal stage_5 :  STD_LOGIC;
                signal stage_6 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_6;
  empty <= NOT(full_0);
  full_7 <= std_logic'('0');
  --data_6, which is an e_mux
  p6_stage_6 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_7 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_6))))) = '1' then 
        if std_logic'(((sync_reset AND full_6) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_7))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_6 <= std_logic'('0');
        else
          stage_6 <= p6_stage_6;
        end if;
      end if;
    end if;

  end process;

  --control_6, which is an e_mux
  p6_full_6 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_6 <= std_logic'('0');
        else
          full_6 <= p6_full_6;
        end if;
      end if;
    end if;

  end process;

  --data_5, which is an e_mux
  p5_stage_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_6 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_6);
  --data_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_5))))) = '1' then 
        if std_logic'(((sync_reset AND full_5) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_6))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_5 <= std_logic'('0');
        else
          stage_5 <= p5_stage_5;
        end if;
      end if;
    end if;

  end process;

  --control_5, which is an e_mux
  p5_full_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_4, full_6);
  --control_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_5 <= std_logic'('0');
        else
          full_5 <= p5_full_5;
        end if;
      end if;
    end if;

  end process;

  --data_4, which is an e_mux
  p4_stage_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_5 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_5);
  --data_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_4))))) = '1' then 
        if std_logic'(((sync_reset AND full_4) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_4 <= std_logic'('0');
        else
          stage_4 <= p4_stage_4;
        end if;
      end if;
    end if;

  end process;

  --control_4, which is an e_mux
  p4_full_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_3, full_5);
  --control_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_4 <= std_logic'('0');
        else
          full_4 <= p4_full_4;
        end if;
      end if;
    end if;

  end process;

  --data_3, which is an e_mux
  p3_stage_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_4 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_4);
  --data_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_3))))) = '1' then 
        if std_logic'(((sync_reset AND full_3) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_4))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_3 <= std_logic'('0');
        else
          stage_3 <= p3_stage_3;
        end if;
      end if;
    end if;

  end process;

  --control_3, which is an e_mux
  p3_full_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_2, full_4);
  --control_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_3 <= std_logic'('0');
        else
          full_3 <= p3_full_3;
        end if;
      end if;
    end if;

  end process;

  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_3);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic'('0');
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_1, full_3);
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 4);
  one_count_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 4);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("000") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 4);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_CPU_instruction_master_to_SDRAM_s1_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_CPU_instruction_master_to_SDRAM_s1_module;


architecture europa of rdv_fifo_for_CPU_instruction_master_to_SDRAM_s1_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal full_4 :  STD_LOGIC;
                signal full_5 :  STD_LOGIC;
                signal full_6 :  STD_LOGIC;
                signal full_7 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC;
                signal p3_full_3 :  STD_LOGIC;
                signal p3_stage_3 :  STD_LOGIC;
                signal p4_full_4 :  STD_LOGIC;
                signal p4_stage_4 :  STD_LOGIC;
                signal p5_full_5 :  STD_LOGIC;
                signal p5_stage_5 :  STD_LOGIC;
                signal p6_full_6 :  STD_LOGIC;
                signal p6_stage_6 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal stage_2 :  STD_LOGIC;
                signal stage_3 :  STD_LOGIC;
                signal stage_4 :  STD_LOGIC;
                signal stage_5 :  STD_LOGIC;
                signal stage_6 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_6;
  empty <= NOT(full_0);
  full_7 <= std_logic'('0');
  --data_6, which is an e_mux
  p6_stage_6 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_7 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_6))))) = '1' then 
        if std_logic'(((sync_reset AND full_6) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_7))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_6 <= std_logic'('0');
        else
          stage_6 <= p6_stage_6;
        end if;
      end if;
    end if;

  end process;

  --control_6, which is an e_mux
  p6_full_6 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_6 <= std_logic'('0');
        else
          full_6 <= p6_full_6;
        end if;
      end if;
    end if;

  end process;

  --data_5, which is an e_mux
  p5_stage_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_6 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_6);
  --data_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_5))))) = '1' then 
        if std_logic'(((sync_reset AND full_5) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_6))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_5 <= std_logic'('0');
        else
          stage_5 <= p5_stage_5;
        end if;
      end if;
    end if;

  end process;

  --control_5, which is an e_mux
  p5_full_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_4, full_6);
  --control_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_5 <= std_logic'('0');
        else
          full_5 <= p5_full_5;
        end if;
      end if;
    end if;

  end process;

  --data_4, which is an e_mux
  p4_stage_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_5 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_5);
  --data_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_4))))) = '1' then 
        if std_logic'(((sync_reset AND full_4) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_4 <= std_logic'('0');
        else
          stage_4 <= p4_stage_4;
        end if;
      end if;
    end if;

  end process;

  --control_4, which is an e_mux
  p4_full_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_3, full_5);
  --control_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_4 <= std_logic'('0');
        else
          full_4 <= p4_full_4;
        end if;
      end if;
    end if;

  end process;

  --data_3, which is an e_mux
  p3_stage_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_4 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_4);
  --data_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_3))))) = '1' then 
        if std_logic'(((sync_reset AND full_3) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_4))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_3 <= std_logic'('0');
        else
          stage_3 <= p3_stage_3;
        end if;
      end if;
    end if;

  end process;

  --control_3, which is an e_mux
  p3_full_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_2, full_4);
  --control_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_3 <= std_logic'('0');
        else
          full_3 <= p3_full_3;
        end if;
      end if;
    end if;

  end process;

  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_3);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic'('0');
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_1, full_3);
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 4);
  one_count_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 4);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("000") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 4);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity SDRAM_s1_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal CPU_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal CPU_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
                 signal CPU_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal CPU_instruction_master_latency_counter : IN STD_LOGIC;
                 signal CPU_instruction_master_read : IN STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : IN STD_LOGIC;
                 signal SDRAM_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SDRAM_s1_readdatavalid : IN STD_LOGIC;
                 signal SDRAM_s1_waitrequest : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_byteenable_SDRAM_s1 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal CPU_data_master_granted_SDRAM_s1 : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_SDRAM_s1 : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_SDRAM_s1 : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_SDRAM_s1_shift_register : OUT STD_LOGIC;
                 signal CPU_data_master_requests_SDRAM_s1 : OUT STD_LOGIC;
                 signal CPU_instruction_master_granted_SDRAM_s1 : OUT STD_LOGIC;
                 signal CPU_instruction_master_qualified_request_SDRAM_s1 : OUT STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SDRAM_s1 : OUT STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register : OUT STD_LOGIC;
                 signal CPU_instruction_master_requests_SDRAM_s1 : OUT STD_LOGIC;
                 signal SDRAM_s1_address : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
                 signal SDRAM_s1_byteenable_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal SDRAM_s1_chipselect : OUT STD_LOGIC;
                 signal SDRAM_s1_read_n : OUT STD_LOGIC;
                 signal SDRAM_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SDRAM_s1_reset_n : OUT STD_LOGIC;
                 signal SDRAM_s1_waitrequest_from_sa : OUT STD_LOGIC;
                 signal SDRAM_s1_write_n : OUT STD_LOGIC;
                 signal SDRAM_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal d1_SDRAM_s1_end_xfer : OUT STD_LOGIC
              );
end entity SDRAM_s1_arbitrator;


architecture europa of SDRAM_s1_arbitrator is
component rdv_fifo_for_CPU_data_master_to_SDRAM_s1_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_CPU_data_master_to_SDRAM_s1_module;

component rdv_fifo_for_CPU_instruction_master_to_SDRAM_s1_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_CPU_instruction_master_to_SDRAM_s1_module;

                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_byteenable_SDRAM_s1_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_data_master_byteenable_SDRAM_s1_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_rdv_fifo_empty_SDRAM_s1 :  STD_LOGIC;
                signal CPU_data_master_rdv_fifo_output_from_SDRAM_s1 :  STD_LOGIC;
                signal CPU_data_master_saved_grant_SDRAM_s1 :  STD_LOGIC;
                signal CPU_instruction_master_arbiterlock :  STD_LOGIC;
                signal CPU_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_instruction_master_continuerequest :  STD_LOGIC;
                signal CPU_instruction_master_rdv_fifo_empty_SDRAM_s1 :  STD_LOGIC;
                signal CPU_instruction_master_rdv_fifo_output_from_SDRAM_s1 :  STD_LOGIC;
                signal CPU_instruction_master_saved_grant_SDRAM_s1 :  STD_LOGIC;
                signal SDRAM_s1_allgrants :  STD_LOGIC;
                signal SDRAM_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal SDRAM_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal SDRAM_s1_any_continuerequest :  STD_LOGIC;
                signal SDRAM_s1_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SDRAM_s1_arb_counter_enable :  STD_LOGIC;
                signal SDRAM_s1_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SDRAM_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SDRAM_s1_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SDRAM_s1_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SDRAM_s1_arbitration_holdoff_internal :  STD_LOGIC;
                signal SDRAM_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal SDRAM_s1_begins_xfer :  STD_LOGIC;
                signal SDRAM_s1_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal SDRAM_s1_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SDRAM_s1_end_xfer :  STD_LOGIC;
                signal SDRAM_s1_firsttransfer :  STD_LOGIC;
                signal SDRAM_s1_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SDRAM_s1_in_a_read_cycle :  STD_LOGIC;
                signal SDRAM_s1_in_a_write_cycle :  STD_LOGIC;
                signal SDRAM_s1_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SDRAM_s1_move_on_to_next_transaction :  STD_LOGIC;
                signal SDRAM_s1_non_bursting_master_requests :  STD_LOGIC;
                signal SDRAM_s1_readdatavalid_from_sa :  STD_LOGIC;
                signal SDRAM_s1_reg_firsttransfer :  STD_LOGIC;
                signal SDRAM_s1_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SDRAM_s1_slavearbiterlockenable :  STD_LOGIC;
                signal SDRAM_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal SDRAM_s1_unreg_firsttransfer :  STD_LOGIC;
                signal SDRAM_s1_waits_for_read :  STD_LOGIC;
                signal SDRAM_s1_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_SDRAM_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_byteenable_SDRAM_s1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_CPU_data_master_granted_SDRAM_s1 :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_SDRAM_s1 :  STD_LOGIC;
                signal internal_CPU_data_master_read_data_valid_SDRAM_s1_shift_register :  STD_LOGIC;
                signal internal_CPU_data_master_requests_SDRAM_s1 :  STD_LOGIC;
                signal internal_CPU_instruction_master_granted_SDRAM_s1 :  STD_LOGIC;
                signal internal_CPU_instruction_master_qualified_request_SDRAM_s1 :  STD_LOGIC;
                signal internal_CPU_instruction_master_requests_SDRAM_s1 :  STD_LOGIC;
                signal internal_SDRAM_s1_waitrequest_from_sa :  STD_LOGIC;
                signal last_cycle_CPU_data_master_granted_slave_SDRAM_s1 :  STD_LOGIC;
                signal last_cycle_CPU_instruction_master_granted_slave_SDRAM_s1 :  STD_LOGIC;
                signal module_input :  STD_LOGIC;
                signal module_input1 :  STD_LOGIC;
                signal module_input2 :  STD_LOGIC;
                signal module_input3 :  STD_LOGIC;
                signal module_input4 :  STD_LOGIC;
                signal module_input5 :  STD_LOGIC;
                signal shifted_address_to_SDRAM_s1_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal shifted_address_to_SDRAM_s1_from_CPU_instruction_master :  STD_LOGIC_VECTOR (27 DOWNTO 0);
                signal wait_for_SDRAM_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT SDRAM_s1_end_xfer;
    end if;

  end process;

  SDRAM_s1_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_CPU_data_master_qualified_request_SDRAM_s1 OR internal_CPU_instruction_master_qualified_request_SDRAM_s1));
  --assign SDRAM_s1_readdatavalid_from_sa = SDRAM_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  SDRAM_s1_readdatavalid_from_sa <= SDRAM_s1_readdatavalid;
  --assign SDRAM_s1_readdata_from_sa = SDRAM_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  SDRAM_s1_readdata_from_sa <= SDRAM_s1_readdata;
  internal_CPU_data_master_requests_SDRAM_s1 <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 23) & std_logic_vector'("00000000000000000000000")) = std_logic_vector'("00000000000000000000000000000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --assign SDRAM_s1_waitrequest_from_sa = SDRAM_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_SDRAM_s1_waitrequest_from_sa <= SDRAM_s1_waitrequest;
  --SDRAM_s1_arb_share_counter set values, which is an e_mux
  SDRAM_s1_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_SDRAM_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_CPU_instruction_master_granted_SDRAM_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_SDRAM_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_CPU_instruction_master_granted_SDRAM_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001"))))), 2);
  --SDRAM_s1_non_bursting_master_requests mux, which is an e_mux
  SDRAM_s1_non_bursting_master_requests <= ((internal_CPU_data_master_requests_SDRAM_s1 OR internal_CPU_instruction_master_requests_SDRAM_s1) OR internal_CPU_data_master_requests_SDRAM_s1) OR internal_CPU_instruction_master_requests_SDRAM_s1;
  --SDRAM_s1_any_bursting_master_saved_grant mux, which is an e_mux
  SDRAM_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --SDRAM_s1_arb_share_counter_next_value assignment, which is an e_assign
  SDRAM_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(SDRAM_s1_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (SDRAM_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(SDRAM_s1_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (SDRAM_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --SDRAM_s1_allgrants all slave grants, which is an e_mux
  SDRAM_s1_allgrants <= (((or_reduce(SDRAM_s1_grant_vector)) OR (or_reduce(SDRAM_s1_grant_vector))) OR (or_reduce(SDRAM_s1_grant_vector))) OR (or_reduce(SDRAM_s1_grant_vector));
  --SDRAM_s1_end_xfer assignment, which is an e_assign
  SDRAM_s1_end_xfer <= NOT ((SDRAM_s1_waits_for_read OR SDRAM_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_SDRAM_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_SDRAM_s1 <= SDRAM_s1_end_xfer AND (((NOT SDRAM_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --SDRAM_s1_arb_share_counter arbitration counter enable, which is an e_assign
  SDRAM_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_SDRAM_s1 AND SDRAM_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_SDRAM_s1 AND NOT SDRAM_s1_non_bursting_master_requests));
  --SDRAM_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SDRAM_s1_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(SDRAM_s1_arb_counter_enable) = '1' then 
        SDRAM_s1_arb_share_counter <= SDRAM_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --SDRAM_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SDRAM_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(SDRAM_s1_master_qreq_vector) AND end_xfer_arb_share_counter_term_SDRAM_s1)) OR ((end_xfer_arb_share_counter_term_SDRAM_s1 AND NOT SDRAM_s1_non_bursting_master_requests)))) = '1' then 
        SDRAM_s1_slavearbiterlockenable <= or_reduce(SDRAM_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master SDRAM/s1 arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= SDRAM_s1_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --SDRAM_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  SDRAM_s1_slavearbiterlockenable2 <= or_reduce(SDRAM_s1_arb_share_counter_next_value);
  --CPU/data_master SDRAM/s1 arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= SDRAM_s1_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --CPU/instruction_master SDRAM/s1 arbiterlock, which is an e_assign
  CPU_instruction_master_arbiterlock <= SDRAM_s1_slavearbiterlockenable AND CPU_instruction_master_continuerequest;
  --CPU/instruction_master SDRAM/s1 arbiterlock2, which is an e_assign
  CPU_instruction_master_arbiterlock2 <= SDRAM_s1_slavearbiterlockenable2 AND CPU_instruction_master_continuerequest;
  --CPU/instruction_master granted SDRAM/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_CPU_instruction_master_granted_slave_SDRAM_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_CPU_instruction_master_granted_slave_SDRAM_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(CPU_instruction_master_saved_grant_SDRAM_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((SDRAM_s1_arbitration_holdoff_internal OR NOT internal_CPU_instruction_master_requests_SDRAM_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_CPU_instruction_master_granted_slave_SDRAM_s1))))));
    end if;

  end process;

  --CPU_instruction_master_continuerequest continued request, which is an e_mux
  CPU_instruction_master_continuerequest <= last_cycle_CPU_instruction_master_granted_slave_SDRAM_s1 AND internal_CPU_instruction_master_requests_SDRAM_s1;
  --SDRAM_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  SDRAM_s1_any_continuerequest <= CPU_instruction_master_continuerequest OR CPU_data_master_continuerequest;
  internal_CPU_data_master_qualified_request_SDRAM_s1 <= internal_CPU_data_master_requests_SDRAM_s1 AND NOT (((((CPU_data_master_read AND ((NOT CPU_data_master_waitrequest OR (internal_CPU_data_master_read_data_valid_SDRAM_s1_shift_register))))) OR (((((NOT CPU_data_master_waitrequest OR CPU_data_master_no_byte_enables_and_last_term) OR NOT(or_reduce(internal_CPU_data_master_byteenable_SDRAM_s1)))) AND CPU_data_master_write))) OR CPU_instruction_master_arbiterlock));
  --unique name for SDRAM_s1_move_on_to_next_transaction, which is an e_assign
  SDRAM_s1_move_on_to_next_transaction <= SDRAM_s1_readdatavalid_from_sa;
  --rdv_fifo_for_CPU_data_master_to_SDRAM_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_CPU_data_master_to_SDRAM_s1 : rdv_fifo_for_CPU_data_master_to_SDRAM_s1_module
    port map(
      data_out => CPU_data_master_rdv_fifo_output_from_SDRAM_s1,
      empty => open,
      fifo_contains_ones_n => CPU_data_master_rdv_fifo_empty_SDRAM_s1,
      full => open,
      clear_fifo => module_input,
      clk => clk,
      data_in => internal_CPU_data_master_granted_SDRAM_s1,
      read => SDRAM_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input1,
      write => module_input2
    );

  module_input <= std_logic'('0');
  module_input1 <= std_logic'('0');
  module_input2 <= in_a_read_cycle AND NOT SDRAM_s1_waits_for_read;

  internal_CPU_data_master_read_data_valid_SDRAM_s1_shift_register <= NOT CPU_data_master_rdv_fifo_empty_SDRAM_s1;
  --local readdatavalid CPU_data_master_read_data_valid_SDRAM_s1, which is an e_mux
  CPU_data_master_read_data_valid_SDRAM_s1 <= ((SDRAM_s1_readdatavalid_from_sa AND CPU_data_master_rdv_fifo_output_from_SDRAM_s1)) AND NOT CPU_data_master_rdv_fifo_empty_SDRAM_s1;
  --SDRAM_s1_writedata mux, which is an e_mux
  SDRAM_s1_writedata <= CPU_data_master_dbs_write_16;
  internal_CPU_instruction_master_requests_SDRAM_s1 <= ((to_std_logic(((Std_Logic_Vector'(CPU_instruction_master_address_to_slave(27 DOWNTO 23) & std_logic_vector'("00000000000000000000000")) = std_logic_vector'("0000000000000000000000000000")))) AND (CPU_instruction_master_read))) AND CPU_instruction_master_read;
  --CPU/data_master granted SDRAM/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_CPU_data_master_granted_slave_SDRAM_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_CPU_data_master_granted_slave_SDRAM_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(CPU_data_master_saved_grant_SDRAM_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((SDRAM_s1_arbitration_holdoff_internal OR NOT internal_CPU_data_master_requests_SDRAM_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_CPU_data_master_granted_slave_SDRAM_s1))))));
    end if;

  end process;

  --CPU_data_master_continuerequest continued request, which is an e_mux
  CPU_data_master_continuerequest <= last_cycle_CPU_data_master_granted_slave_SDRAM_s1 AND internal_CPU_data_master_requests_SDRAM_s1;
  internal_CPU_instruction_master_qualified_request_SDRAM_s1 <= internal_CPU_instruction_master_requests_SDRAM_s1 AND NOT ((((CPU_instruction_master_read AND ((to_std_logic(((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))) OR ((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_latency_counter))))))) OR (CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register))))) OR CPU_data_master_arbiterlock));
  --rdv_fifo_for_CPU_instruction_master_to_SDRAM_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_CPU_instruction_master_to_SDRAM_s1 : rdv_fifo_for_CPU_instruction_master_to_SDRAM_s1_module
    port map(
      data_out => CPU_instruction_master_rdv_fifo_output_from_SDRAM_s1,
      empty => open,
      fifo_contains_ones_n => CPU_instruction_master_rdv_fifo_empty_SDRAM_s1,
      full => open,
      clear_fifo => module_input3,
      clk => clk,
      data_in => internal_CPU_instruction_master_granted_SDRAM_s1,
      read => SDRAM_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input4,
      write => module_input5
    );

  module_input3 <= std_logic'('0');
  module_input4 <= std_logic'('0');
  module_input5 <= in_a_read_cycle AND NOT SDRAM_s1_waits_for_read;

  CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register <= NOT CPU_instruction_master_rdv_fifo_empty_SDRAM_s1;
  --local readdatavalid CPU_instruction_master_read_data_valid_SDRAM_s1, which is an e_mux
  CPU_instruction_master_read_data_valid_SDRAM_s1 <= ((SDRAM_s1_readdatavalid_from_sa AND CPU_instruction_master_rdv_fifo_output_from_SDRAM_s1)) AND NOT CPU_instruction_master_rdv_fifo_empty_SDRAM_s1;
  --allow new arb cycle for SDRAM/s1, which is an e_assign
  SDRAM_s1_allow_new_arb_cycle <= NOT CPU_data_master_arbiterlock AND NOT CPU_instruction_master_arbiterlock;
  --CPU/instruction_master assignment into master qualified-requests vector for SDRAM/s1, which is an e_assign
  SDRAM_s1_master_qreq_vector(0) <= internal_CPU_instruction_master_qualified_request_SDRAM_s1;
  --CPU/instruction_master grant SDRAM/s1, which is an e_assign
  internal_CPU_instruction_master_granted_SDRAM_s1 <= SDRAM_s1_grant_vector(0);
  --CPU/instruction_master saved-grant SDRAM/s1, which is an e_assign
  CPU_instruction_master_saved_grant_SDRAM_s1 <= SDRAM_s1_arb_winner(0) AND internal_CPU_instruction_master_requests_SDRAM_s1;
  --CPU/data_master assignment into master qualified-requests vector for SDRAM/s1, which is an e_assign
  SDRAM_s1_master_qreq_vector(1) <= internal_CPU_data_master_qualified_request_SDRAM_s1;
  --CPU/data_master grant SDRAM/s1, which is an e_assign
  internal_CPU_data_master_granted_SDRAM_s1 <= SDRAM_s1_grant_vector(1);
  --CPU/data_master saved-grant SDRAM/s1, which is an e_assign
  CPU_data_master_saved_grant_SDRAM_s1 <= SDRAM_s1_arb_winner(1) AND internal_CPU_data_master_requests_SDRAM_s1;
  --SDRAM/s1 chosen-master double-vector, which is an e_assign
  SDRAM_s1_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((SDRAM_s1_master_qreq_vector & SDRAM_s1_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT SDRAM_s1_master_qreq_vector & NOT SDRAM_s1_master_qreq_vector))) + (std_logic_vector'("000") & (SDRAM_s1_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  SDRAM_s1_arb_winner <= A_WE_StdLogicVector((std_logic'(((SDRAM_s1_allow_new_arb_cycle AND or_reduce(SDRAM_s1_grant_vector)))) = '1'), SDRAM_s1_grant_vector, SDRAM_s1_saved_chosen_master_vector);
  --saved SDRAM_s1_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SDRAM_s1_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(SDRAM_s1_allow_new_arb_cycle) = '1' then 
        SDRAM_s1_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(SDRAM_s1_grant_vector)) = '1'), SDRAM_s1_grant_vector, SDRAM_s1_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  SDRAM_s1_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((SDRAM_s1_chosen_master_double_vector(1) OR SDRAM_s1_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((SDRAM_s1_chosen_master_double_vector(0) OR SDRAM_s1_chosen_master_double_vector(2)))));
  --SDRAM/s1 chosen master rotated left, which is an e_assign
  SDRAM_s1_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(SDRAM_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(SDRAM_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --SDRAM/s1's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SDRAM_s1_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(SDRAM_s1_grant_vector)) = '1' then 
        SDRAM_s1_arb_addend <= A_WE_StdLogicVector((std_logic'(SDRAM_s1_end_xfer) = '1'), SDRAM_s1_chosen_master_rot_left, SDRAM_s1_grant_vector);
      end if;
    end if;

  end process;

  --SDRAM_s1_reset_n assignment, which is an e_assign
  SDRAM_s1_reset_n <= reset_n;
  SDRAM_s1_chipselect <= internal_CPU_data_master_granted_SDRAM_s1 OR internal_CPU_instruction_master_granted_SDRAM_s1;
  --SDRAM_s1_firsttransfer first transaction, which is an e_assign
  SDRAM_s1_firsttransfer <= A_WE_StdLogic((std_logic'(SDRAM_s1_begins_xfer) = '1'), SDRAM_s1_unreg_firsttransfer, SDRAM_s1_reg_firsttransfer);
  --SDRAM_s1_unreg_firsttransfer first transaction, which is an e_assign
  SDRAM_s1_unreg_firsttransfer <= NOT ((SDRAM_s1_slavearbiterlockenable AND SDRAM_s1_any_continuerequest));
  --SDRAM_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SDRAM_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(SDRAM_s1_begins_xfer) = '1' then 
        SDRAM_s1_reg_firsttransfer <= SDRAM_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --SDRAM_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  SDRAM_s1_beginbursttransfer_internal <= SDRAM_s1_begins_xfer;
  --SDRAM_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  SDRAM_s1_arbitration_holdoff_internal <= SDRAM_s1_begins_xfer AND SDRAM_s1_firsttransfer;
  --~SDRAM_s1_read_n assignment, which is an e_mux
  SDRAM_s1_read_n <= NOT ((((internal_CPU_data_master_granted_SDRAM_s1 AND CPU_data_master_read)) OR ((internal_CPU_instruction_master_granted_SDRAM_s1 AND CPU_instruction_master_read))));
  --~SDRAM_s1_write_n assignment, which is an e_mux
  SDRAM_s1_write_n <= NOT ((internal_CPU_data_master_granted_SDRAM_s1 AND CPU_data_master_write));
  shifted_address_to_SDRAM_s1_from_CPU_data_master <= A_EXT (Std_Logic_Vector'(A_SRL(CPU_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(CPU_data_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 29);
  --SDRAM_s1_address mux, which is an e_mux
  SDRAM_s1_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_SDRAM_s1)) = '1'), (A_SRL(shifted_address_to_SDRAM_s1_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000001"))), (std_logic_vector'("0") & ((A_SRL(shifted_address_to_SDRAM_s1_from_CPU_instruction_master,std_logic_vector'("00000000000000000000000000000001")))))), 22);
  shifted_address_to_SDRAM_s1_from_CPU_instruction_master <= A_EXT (Std_Logic_Vector'(A_SRL(CPU_instruction_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(CPU_instruction_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 28);
  --d1_SDRAM_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_SDRAM_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_SDRAM_s1_end_xfer <= SDRAM_s1_end_xfer;
    end if;

  end process;

  --SDRAM_s1_waits_for_read in a cycle, which is an e_mux
  SDRAM_s1_waits_for_read <= SDRAM_s1_in_a_read_cycle AND internal_SDRAM_s1_waitrequest_from_sa;
  --SDRAM_s1_in_a_read_cycle assignment, which is an e_assign
  SDRAM_s1_in_a_read_cycle <= ((internal_CPU_data_master_granted_SDRAM_s1 AND CPU_data_master_read)) OR ((internal_CPU_instruction_master_granted_SDRAM_s1 AND CPU_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= SDRAM_s1_in_a_read_cycle;
  --SDRAM_s1_waits_for_write in a cycle, which is an e_mux
  SDRAM_s1_waits_for_write <= SDRAM_s1_in_a_write_cycle AND internal_SDRAM_s1_waitrequest_from_sa;
  --SDRAM_s1_in_a_write_cycle assignment, which is an e_assign
  SDRAM_s1_in_a_write_cycle <= internal_CPU_data_master_granted_SDRAM_s1 AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= SDRAM_s1_in_a_write_cycle;
  wait_for_SDRAM_s1_counter <= std_logic'('0');
  --~SDRAM_s1_byteenable_n byte enable port mux, which is an e_mux
  SDRAM_s1_byteenable_n <= A_EXT (NOT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_SDRAM_s1)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_CPU_data_master_byteenable_SDRAM_s1)), -SIGNED(std_logic_vector'("00000000000000000000000000000001")))), 2);
  (CPU_data_master_byteenable_SDRAM_s1_segment_1(1), CPU_data_master_byteenable_SDRAM_s1_segment_1(0), CPU_data_master_byteenable_SDRAM_s1_segment_0(1), CPU_data_master_byteenable_SDRAM_s1_segment_0(0)) <= CPU_data_master_byteenable;
  internal_CPU_data_master_byteenable_SDRAM_s1 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_data_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), CPU_data_master_byteenable_SDRAM_s1_segment_0, CPU_data_master_byteenable_SDRAM_s1_segment_1);
  --vhdl renameroo for output signals
  CPU_data_master_byteenable_SDRAM_s1 <= internal_CPU_data_master_byteenable_SDRAM_s1;
  --vhdl renameroo for output signals
  CPU_data_master_granted_SDRAM_s1 <= internal_CPU_data_master_granted_SDRAM_s1;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_SDRAM_s1 <= internal_CPU_data_master_qualified_request_SDRAM_s1;
  --vhdl renameroo for output signals
  CPU_data_master_read_data_valid_SDRAM_s1_shift_register <= internal_CPU_data_master_read_data_valid_SDRAM_s1_shift_register;
  --vhdl renameroo for output signals
  CPU_data_master_requests_SDRAM_s1 <= internal_CPU_data_master_requests_SDRAM_s1;
  --vhdl renameroo for output signals
  CPU_instruction_master_granted_SDRAM_s1 <= internal_CPU_instruction_master_granted_SDRAM_s1;
  --vhdl renameroo for output signals
  CPU_instruction_master_qualified_request_SDRAM_s1 <= internal_CPU_instruction_master_qualified_request_SDRAM_s1;
  --vhdl renameroo for output signals
  CPU_instruction_master_requests_SDRAM_s1 <= internal_CPU_instruction_master_requests_SDRAM_s1;
  --vhdl renameroo for output signals
  SDRAM_s1_waitrequest_from_sa <= internal_SDRAM_s1_waitrequest_from_sa;
--synthesis translate_off
    --SDRAM/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line4 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_CPU_data_master_granted_SDRAM_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_CPU_instruction_master_granted_SDRAM_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line4, now);
          write(write_line4, string'(": "));
          write(write_line4, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line4.all);
          deallocate (write_line4);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line5 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(CPU_data_master_saved_grant_SDRAM_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_saved_grant_SDRAM_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line5, now);
          write(write_line5, string'(": "));
          write(write_line5, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line5.all);
          deallocate (write_line5);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_CPU_data_master_to_SRAM_avalon_sram_slave_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_CPU_data_master_to_SRAM_avalon_sram_slave_module;


architecture europa of rdv_fifo_for_CPU_data_master_to_SRAM_avalon_sram_slave_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (2 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_1;
  empty <= NOT(full_0);
  full_2 <= std_logic'('0');
  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_0))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 3);
  one_count_minus_one <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 3);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("00000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("00") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 3);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_CPU_instruction_master_to_SRAM_avalon_sram_slave_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_CPU_instruction_master_to_SRAM_avalon_sram_slave_module;


architecture europa of rdv_fifo_for_CPU_instruction_master_to_SRAM_avalon_sram_slave_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (2 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_1;
  empty <= NOT(full_0);
  full_2 <= std_logic'('0');
  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_0))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 3);
  one_count_minus_one <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 3);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("00000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("00") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 3);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity SRAM_avalon_sram_slave_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal CPU_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal CPU_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
                 signal CPU_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal CPU_instruction_master_latency_counter : IN STD_LOGIC;
                 signal CPU_instruction_master_read : IN STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register : IN STD_LOGIC;
                 signal SRAM_avalon_sram_slave_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SRAM_avalon_sram_slave_readdatavalid : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_byteenable_SRAM_avalon_sram_slave : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal CPU_data_master_granted_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : OUT STD_LOGIC;
                 signal CPU_data_master_requests_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                 signal CPU_instruction_master_granted_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                 signal CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                 signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : OUT STD_LOGIC;
                 signal CPU_instruction_master_requests_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                 signal SRAM_avalon_sram_slave_address : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal SRAM_avalon_sram_slave_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal SRAM_avalon_sram_slave_read : OUT STD_LOGIC;
                 signal SRAM_avalon_sram_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SRAM_avalon_sram_slave_reset : OUT STD_LOGIC;
                 signal SRAM_avalon_sram_slave_write : OUT STD_LOGIC;
                 signal SRAM_avalon_sram_slave_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal d1_SRAM_avalon_sram_slave_end_xfer : OUT STD_LOGIC
              );
end entity SRAM_avalon_sram_slave_arbitrator;


architecture europa of SRAM_avalon_sram_slave_arbitrator is
component rdv_fifo_for_CPU_data_master_to_SRAM_avalon_sram_slave_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_CPU_data_master_to_SRAM_avalon_sram_slave_module;

component rdv_fifo_for_CPU_instruction_master_to_SRAM_avalon_sram_slave_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_CPU_instruction_master_to_SRAM_avalon_sram_slave_module;

                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_byteenable_SRAM_avalon_sram_slave_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_data_master_byteenable_SRAM_avalon_sram_slave_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_rdv_fifo_empty_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_data_master_rdv_fifo_output_from_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_data_master_saved_grant_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_instruction_master_arbiterlock :  STD_LOGIC;
                signal CPU_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_instruction_master_continuerequest :  STD_LOGIC;
                signal CPU_instruction_master_rdv_fifo_empty_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_instruction_master_rdv_fifo_output_from_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_instruction_master_saved_grant_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_allgrants :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_any_continuerequest :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SRAM_avalon_sram_slave_arb_counter_enable :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SRAM_avalon_sram_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SRAM_avalon_sram_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SRAM_avalon_sram_slave_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SRAM_avalon_sram_slave_arbitration_holdoff_internal :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_begins_xfer :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal SRAM_avalon_sram_slave_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SRAM_avalon_sram_slave_end_xfer :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_firsttransfer :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SRAM_avalon_sram_slave_in_a_read_cycle :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_in_a_write_cycle :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SRAM_avalon_sram_slave_move_on_to_next_transaction :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_non_bursting_master_requests :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_readdatavalid_from_sa :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_reg_firsttransfer :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SRAM_avalon_sram_slave_slavearbiterlockenable :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_unreg_firsttransfer :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_waits_for_read :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_byteenable_SRAM_avalon_sram_slave :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_CPU_data_master_granted_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal internal_CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register :  STD_LOGIC;
                signal internal_CPU_data_master_requests_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal internal_CPU_instruction_master_granted_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal internal_CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal internal_CPU_instruction_master_requests_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal last_cycle_CPU_data_master_granted_slave_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal last_cycle_CPU_instruction_master_granted_slave_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal module_input10 :  STD_LOGIC;
                signal module_input11 :  STD_LOGIC;
                signal module_input6 :  STD_LOGIC;
                signal module_input7 :  STD_LOGIC;
                signal module_input8 :  STD_LOGIC;
                signal module_input9 :  STD_LOGIC;
                signal shifted_address_to_SRAM_avalon_sram_slave_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal shifted_address_to_SRAM_avalon_sram_slave_from_CPU_instruction_master :  STD_LOGIC_VECTOR (27 DOWNTO 0);
                signal wait_for_SRAM_avalon_sram_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT SRAM_avalon_sram_slave_end_xfer;
    end if;

  end process;

  SRAM_avalon_sram_slave_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_CPU_data_master_qualified_request_SRAM_avalon_sram_slave OR internal_CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave));
  --assign SRAM_avalon_sram_slave_readdatavalid_from_sa = SRAM_avalon_sram_slave_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  SRAM_avalon_sram_slave_readdatavalid_from_sa <= SRAM_avalon_sram_slave_readdatavalid;
  --assign SRAM_avalon_sram_slave_readdata_from_sa = SRAM_avalon_sram_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  SRAM_avalon_sram_slave_readdata_from_sa <= SRAM_avalon_sram_slave_readdata;
  internal_CPU_data_master_requests_SRAM_avalon_sram_slave <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 19) & std_logic_vector'("0000000000000000000")) = std_logic_vector'("01000000000000000000000000000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --SRAM_avalon_sram_slave_arb_share_counter set values, which is an e_mux
  SRAM_avalon_sram_slave_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_SRAM_avalon_sram_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_CPU_instruction_master_granted_SRAM_avalon_sram_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_SRAM_avalon_sram_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_CPU_instruction_master_granted_SRAM_avalon_sram_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001"))))), 2);
  --SRAM_avalon_sram_slave_non_bursting_master_requests mux, which is an e_mux
  SRAM_avalon_sram_slave_non_bursting_master_requests <= ((internal_CPU_data_master_requests_SRAM_avalon_sram_slave OR internal_CPU_instruction_master_requests_SRAM_avalon_sram_slave) OR internal_CPU_data_master_requests_SRAM_avalon_sram_slave) OR internal_CPU_instruction_master_requests_SRAM_avalon_sram_slave;
  --SRAM_avalon_sram_slave_any_bursting_master_saved_grant mux, which is an e_mux
  SRAM_avalon_sram_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --SRAM_avalon_sram_slave_arb_share_counter_next_value assignment, which is an e_assign
  SRAM_avalon_sram_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(SRAM_avalon_sram_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (SRAM_avalon_sram_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(SRAM_avalon_sram_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (SRAM_avalon_sram_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --SRAM_avalon_sram_slave_allgrants all slave grants, which is an e_mux
  SRAM_avalon_sram_slave_allgrants <= (((or_reduce(SRAM_avalon_sram_slave_grant_vector)) OR (or_reduce(SRAM_avalon_sram_slave_grant_vector))) OR (or_reduce(SRAM_avalon_sram_slave_grant_vector))) OR (or_reduce(SRAM_avalon_sram_slave_grant_vector));
  --SRAM_avalon_sram_slave_end_xfer assignment, which is an e_assign
  SRAM_avalon_sram_slave_end_xfer <= NOT ((SRAM_avalon_sram_slave_waits_for_read OR SRAM_avalon_sram_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_SRAM_avalon_sram_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_SRAM_avalon_sram_slave <= SRAM_avalon_sram_slave_end_xfer AND (((NOT SRAM_avalon_sram_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --SRAM_avalon_sram_slave_arb_share_counter arbitration counter enable, which is an e_assign
  SRAM_avalon_sram_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_SRAM_avalon_sram_slave AND SRAM_avalon_sram_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_SRAM_avalon_sram_slave AND NOT SRAM_avalon_sram_slave_non_bursting_master_requests));
  --SRAM_avalon_sram_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SRAM_avalon_sram_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(SRAM_avalon_sram_slave_arb_counter_enable) = '1' then 
        SRAM_avalon_sram_slave_arb_share_counter <= SRAM_avalon_sram_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --SRAM_avalon_sram_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SRAM_avalon_sram_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(SRAM_avalon_sram_slave_master_qreq_vector) AND end_xfer_arb_share_counter_term_SRAM_avalon_sram_slave)) OR ((end_xfer_arb_share_counter_term_SRAM_avalon_sram_slave AND NOT SRAM_avalon_sram_slave_non_bursting_master_requests)))) = '1' then 
        SRAM_avalon_sram_slave_slavearbiterlockenable <= or_reduce(SRAM_avalon_sram_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master SRAM/avalon_sram_slave arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= SRAM_avalon_sram_slave_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --SRAM_avalon_sram_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  SRAM_avalon_sram_slave_slavearbiterlockenable2 <= or_reduce(SRAM_avalon_sram_slave_arb_share_counter_next_value);
  --CPU/data_master SRAM/avalon_sram_slave arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= SRAM_avalon_sram_slave_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --CPU/instruction_master SRAM/avalon_sram_slave arbiterlock, which is an e_assign
  CPU_instruction_master_arbiterlock <= SRAM_avalon_sram_slave_slavearbiterlockenable AND CPU_instruction_master_continuerequest;
  --CPU/instruction_master SRAM/avalon_sram_slave arbiterlock2, which is an e_assign
  CPU_instruction_master_arbiterlock2 <= SRAM_avalon_sram_slave_slavearbiterlockenable2 AND CPU_instruction_master_continuerequest;
  --CPU/instruction_master granted SRAM/avalon_sram_slave last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_CPU_instruction_master_granted_slave_SRAM_avalon_sram_slave <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_CPU_instruction_master_granted_slave_SRAM_avalon_sram_slave <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(CPU_instruction_master_saved_grant_SRAM_avalon_sram_slave) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((SRAM_avalon_sram_slave_arbitration_holdoff_internal OR NOT internal_CPU_instruction_master_requests_SRAM_avalon_sram_slave))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_CPU_instruction_master_granted_slave_SRAM_avalon_sram_slave))))));
    end if;

  end process;

  --CPU_instruction_master_continuerequest continued request, which is an e_mux
  CPU_instruction_master_continuerequest <= last_cycle_CPU_instruction_master_granted_slave_SRAM_avalon_sram_slave AND internal_CPU_instruction_master_requests_SRAM_avalon_sram_slave;
  --SRAM_avalon_sram_slave_any_continuerequest at least one master continues requesting, which is an e_mux
  SRAM_avalon_sram_slave_any_continuerequest <= CPU_instruction_master_continuerequest OR CPU_data_master_continuerequest;
  internal_CPU_data_master_qualified_request_SRAM_avalon_sram_slave <= internal_CPU_data_master_requests_SRAM_avalon_sram_slave AND NOT (((((CPU_data_master_read AND ((NOT CPU_data_master_waitrequest OR (internal_CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register))))) OR (((((NOT CPU_data_master_waitrequest OR CPU_data_master_no_byte_enables_and_last_term) OR NOT(or_reduce(internal_CPU_data_master_byteenable_SRAM_avalon_sram_slave)))) AND CPU_data_master_write))) OR CPU_instruction_master_arbiterlock));
  --unique name for SRAM_avalon_sram_slave_move_on_to_next_transaction, which is an e_assign
  SRAM_avalon_sram_slave_move_on_to_next_transaction <= SRAM_avalon_sram_slave_readdatavalid_from_sa;
  --rdv_fifo_for_CPU_data_master_to_SRAM_avalon_sram_slave, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_CPU_data_master_to_SRAM_avalon_sram_slave : rdv_fifo_for_CPU_data_master_to_SRAM_avalon_sram_slave_module
    port map(
      data_out => CPU_data_master_rdv_fifo_output_from_SRAM_avalon_sram_slave,
      empty => open,
      fifo_contains_ones_n => CPU_data_master_rdv_fifo_empty_SRAM_avalon_sram_slave,
      full => open,
      clear_fifo => module_input6,
      clk => clk,
      data_in => internal_CPU_data_master_granted_SRAM_avalon_sram_slave,
      read => SRAM_avalon_sram_slave_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input7,
      write => module_input8
    );

  module_input6 <= std_logic'('0');
  module_input7 <= std_logic'('0');
  module_input8 <= in_a_read_cycle AND NOT SRAM_avalon_sram_slave_waits_for_read;

  internal_CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register <= NOT CPU_data_master_rdv_fifo_empty_SRAM_avalon_sram_slave;
  --local readdatavalid CPU_data_master_read_data_valid_SRAM_avalon_sram_slave, which is an e_mux
  CPU_data_master_read_data_valid_SRAM_avalon_sram_slave <= ((SRAM_avalon_sram_slave_readdatavalid_from_sa AND CPU_data_master_rdv_fifo_output_from_SRAM_avalon_sram_slave)) AND NOT CPU_data_master_rdv_fifo_empty_SRAM_avalon_sram_slave;
  --SRAM_avalon_sram_slave_writedata mux, which is an e_mux
  SRAM_avalon_sram_slave_writedata <= CPU_data_master_dbs_write_16;
  internal_CPU_instruction_master_requests_SRAM_avalon_sram_slave <= ((to_std_logic(((Std_Logic_Vector'(CPU_instruction_master_address_to_slave(27 DOWNTO 19) & std_logic_vector'("0000000000000000000")) = std_logic_vector'("1000000000000000000000000000")))) AND (CPU_instruction_master_read))) AND CPU_instruction_master_read;
  --CPU/data_master granted SRAM/avalon_sram_slave last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_CPU_data_master_granted_slave_SRAM_avalon_sram_slave <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_CPU_data_master_granted_slave_SRAM_avalon_sram_slave <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(CPU_data_master_saved_grant_SRAM_avalon_sram_slave) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((SRAM_avalon_sram_slave_arbitration_holdoff_internal OR NOT internal_CPU_data_master_requests_SRAM_avalon_sram_slave))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_CPU_data_master_granted_slave_SRAM_avalon_sram_slave))))));
    end if;

  end process;

  --CPU_data_master_continuerequest continued request, which is an e_mux
  CPU_data_master_continuerequest <= last_cycle_CPU_data_master_granted_slave_SRAM_avalon_sram_slave AND internal_CPU_data_master_requests_SRAM_avalon_sram_slave;
  internal_CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave <= internal_CPU_instruction_master_requests_SRAM_avalon_sram_slave AND NOT ((((CPU_instruction_master_read AND ((to_std_logic(((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))) OR ((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_latency_counter))))))) OR (CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register))))) OR CPU_data_master_arbiterlock));
  --rdv_fifo_for_CPU_instruction_master_to_SRAM_avalon_sram_slave, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_CPU_instruction_master_to_SRAM_avalon_sram_slave : rdv_fifo_for_CPU_instruction_master_to_SRAM_avalon_sram_slave_module
    port map(
      data_out => CPU_instruction_master_rdv_fifo_output_from_SRAM_avalon_sram_slave,
      empty => open,
      fifo_contains_ones_n => CPU_instruction_master_rdv_fifo_empty_SRAM_avalon_sram_slave,
      full => open,
      clear_fifo => module_input9,
      clk => clk,
      data_in => internal_CPU_instruction_master_granted_SRAM_avalon_sram_slave,
      read => SRAM_avalon_sram_slave_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input10,
      write => module_input11
    );

  module_input9 <= std_logic'('0');
  module_input10 <= std_logic'('0');
  module_input11 <= in_a_read_cycle AND NOT SRAM_avalon_sram_slave_waits_for_read;

  CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register <= NOT CPU_instruction_master_rdv_fifo_empty_SRAM_avalon_sram_slave;
  --local readdatavalid CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave, which is an e_mux
  CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave <= ((SRAM_avalon_sram_slave_readdatavalid_from_sa AND CPU_instruction_master_rdv_fifo_output_from_SRAM_avalon_sram_slave)) AND NOT CPU_instruction_master_rdv_fifo_empty_SRAM_avalon_sram_slave;
  --allow new arb cycle for SRAM/avalon_sram_slave, which is an e_assign
  SRAM_avalon_sram_slave_allow_new_arb_cycle <= NOT CPU_data_master_arbiterlock AND NOT CPU_instruction_master_arbiterlock;
  --CPU/instruction_master assignment into master qualified-requests vector for SRAM/avalon_sram_slave, which is an e_assign
  SRAM_avalon_sram_slave_master_qreq_vector(0) <= internal_CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave;
  --CPU/instruction_master grant SRAM/avalon_sram_slave, which is an e_assign
  internal_CPU_instruction_master_granted_SRAM_avalon_sram_slave <= SRAM_avalon_sram_slave_grant_vector(0);
  --CPU/instruction_master saved-grant SRAM/avalon_sram_slave, which is an e_assign
  CPU_instruction_master_saved_grant_SRAM_avalon_sram_slave <= SRAM_avalon_sram_slave_arb_winner(0) AND internal_CPU_instruction_master_requests_SRAM_avalon_sram_slave;
  --CPU/data_master assignment into master qualified-requests vector for SRAM/avalon_sram_slave, which is an e_assign
  SRAM_avalon_sram_slave_master_qreq_vector(1) <= internal_CPU_data_master_qualified_request_SRAM_avalon_sram_slave;
  --CPU/data_master grant SRAM/avalon_sram_slave, which is an e_assign
  internal_CPU_data_master_granted_SRAM_avalon_sram_slave <= SRAM_avalon_sram_slave_grant_vector(1);
  --CPU/data_master saved-grant SRAM/avalon_sram_slave, which is an e_assign
  CPU_data_master_saved_grant_SRAM_avalon_sram_slave <= SRAM_avalon_sram_slave_arb_winner(1) AND internal_CPU_data_master_requests_SRAM_avalon_sram_slave;
  --SRAM/avalon_sram_slave chosen-master double-vector, which is an e_assign
  SRAM_avalon_sram_slave_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((SRAM_avalon_sram_slave_master_qreq_vector & SRAM_avalon_sram_slave_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT SRAM_avalon_sram_slave_master_qreq_vector & NOT SRAM_avalon_sram_slave_master_qreq_vector))) + (std_logic_vector'("000") & (SRAM_avalon_sram_slave_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  SRAM_avalon_sram_slave_arb_winner <= A_WE_StdLogicVector((std_logic'(((SRAM_avalon_sram_slave_allow_new_arb_cycle AND or_reduce(SRAM_avalon_sram_slave_grant_vector)))) = '1'), SRAM_avalon_sram_slave_grant_vector, SRAM_avalon_sram_slave_saved_chosen_master_vector);
  --saved SRAM_avalon_sram_slave_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SRAM_avalon_sram_slave_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(SRAM_avalon_sram_slave_allow_new_arb_cycle) = '1' then 
        SRAM_avalon_sram_slave_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(SRAM_avalon_sram_slave_grant_vector)) = '1'), SRAM_avalon_sram_slave_grant_vector, SRAM_avalon_sram_slave_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  SRAM_avalon_sram_slave_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((SRAM_avalon_sram_slave_chosen_master_double_vector(1) OR SRAM_avalon_sram_slave_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((SRAM_avalon_sram_slave_chosen_master_double_vector(0) OR SRAM_avalon_sram_slave_chosen_master_double_vector(2)))));
  --SRAM/avalon_sram_slave chosen master rotated left, which is an e_assign
  SRAM_avalon_sram_slave_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(SRAM_avalon_sram_slave_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(SRAM_avalon_sram_slave_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --SRAM/avalon_sram_slave's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SRAM_avalon_sram_slave_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(SRAM_avalon_sram_slave_grant_vector)) = '1' then 
        SRAM_avalon_sram_slave_arb_addend <= A_WE_StdLogicVector((std_logic'(SRAM_avalon_sram_slave_end_xfer) = '1'), SRAM_avalon_sram_slave_chosen_master_rot_left, SRAM_avalon_sram_slave_grant_vector);
      end if;
    end if;

  end process;

  --~SRAM_avalon_sram_slave_reset assignment, which is an e_assign
  SRAM_avalon_sram_slave_reset <= NOT reset_n;
  --SRAM_avalon_sram_slave_firsttransfer first transaction, which is an e_assign
  SRAM_avalon_sram_slave_firsttransfer <= A_WE_StdLogic((std_logic'(SRAM_avalon_sram_slave_begins_xfer) = '1'), SRAM_avalon_sram_slave_unreg_firsttransfer, SRAM_avalon_sram_slave_reg_firsttransfer);
  --SRAM_avalon_sram_slave_unreg_firsttransfer first transaction, which is an e_assign
  SRAM_avalon_sram_slave_unreg_firsttransfer <= NOT ((SRAM_avalon_sram_slave_slavearbiterlockenable AND SRAM_avalon_sram_slave_any_continuerequest));
  --SRAM_avalon_sram_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      SRAM_avalon_sram_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(SRAM_avalon_sram_slave_begins_xfer) = '1' then 
        SRAM_avalon_sram_slave_reg_firsttransfer <= SRAM_avalon_sram_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --SRAM_avalon_sram_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  SRAM_avalon_sram_slave_beginbursttransfer_internal <= SRAM_avalon_sram_slave_begins_xfer;
  --SRAM_avalon_sram_slave_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  SRAM_avalon_sram_slave_arbitration_holdoff_internal <= SRAM_avalon_sram_slave_begins_xfer AND SRAM_avalon_sram_slave_firsttransfer;
  --SRAM_avalon_sram_slave_read assignment, which is an e_mux
  SRAM_avalon_sram_slave_read <= ((internal_CPU_data_master_granted_SRAM_avalon_sram_slave AND CPU_data_master_read)) OR ((internal_CPU_instruction_master_granted_SRAM_avalon_sram_slave AND CPU_instruction_master_read));
  --SRAM_avalon_sram_slave_write assignment, which is an e_mux
  SRAM_avalon_sram_slave_write <= internal_CPU_data_master_granted_SRAM_avalon_sram_slave AND CPU_data_master_write;
  shifted_address_to_SRAM_avalon_sram_slave_from_CPU_data_master <= A_EXT (Std_Logic_Vector'(A_SRL(CPU_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(CPU_data_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 29);
  --SRAM_avalon_sram_slave_address mux, which is an e_mux
  SRAM_avalon_sram_slave_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_SRAM_avalon_sram_slave)) = '1'), (A_SRL(shifted_address_to_SRAM_avalon_sram_slave_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000001"))), (std_logic_vector'("0") & ((A_SRL(shifted_address_to_SRAM_avalon_sram_slave_from_CPU_instruction_master,std_logic_vector'("00000000000000000000000000000001")))))), 18);
  shifted_address_to_SRAM_avalon_sram_slave_from_CPU_instruction_master <= A_EXT (Std_Logic_Vector'(A_SRL(CPU_instruction_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(CPU_instruction_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 28);
  --d1_SRAM_avalon_sram_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_SRAM_avalon_sram_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_SRAM_avalon_sram_slave_end_xfer <= SRAM_avalon_sram_slave_end_xfer;
    end if;

  end process;

  --SRAM_avalon_sram_slave_waits_for_read in a cycle, which is an e_mux
  SRAM_avalon_sram_slave_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(SRAM_avalon_sram_slave_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --SRAM_avalon_sram_slave_in_a_read_cycle assignment, which is an e_assign
  SRAM_avalon_sram_slave_in_a_read_cycle <= ((internal_CPU_data_master_granted_SRAM_avalon_sram_slave AND CPU_data_master_read)) OR ((internal_CPU_instruction_master_granted_SRAM_avalon_sram_slave AND CPU_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= SRAM_avalon_sram_slave_in_a_read_cycle;
  --SRAM_avalon_sram_slave_waits_for_write in a cycle, which is an e_mux
  SRAM_avalon_sram_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(SRAM_avalon_sram_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --SRAM_avalon_sram_slave_in_a_write_cycle assignment, which is an e_assign
  SRAM_avalon_sram_slave_in_a_write_cycle <= internal_CPU_data_master_granted_SRAM_avalon_sram_slave AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= SRAM_avalon_sram_slave_in_a_write_cycle;
  wait_for_SRAM_avalon_sram_slave_counter <= std_logic'('0');
  --SRAM_avalon_sram_slave_byteenable byte enable port mux, which is an e_mux
  SRAM_avalon_sram_slave_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_SRAM_avalon_sram_slave)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_CPU_data_master_byteenable_SRAM_avalon_sram_slave)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 2);
  (CPU_data_master_byteenable_SRAM_avalon_sram_slave_segment_1(1), CPU_data_master_byteenable_SRAM_avalon_sram_slave_segment_1(0), CPU_data_master_byteenable_SRAM_avalon_sram_slave_segment_0(1), CPU_data_master_byteenable_SRAM_avalon_sram_slave_segment_0(0)) <= CPU_data_master_byteenable;
  internal_CPU_data_master_byteenable_SRAM_avalon_sram_slave <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_data_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), CPU_data_master_byteenable_SRAM_avalon_sram_slave_segment_0, CPU_data_master_byteenable_SRAM_avalon_sram_slave_segment_1);
  --vhdl renameroo for output signals
  CPU_data_master_byteenable_SRAM_avalon_sram_slave <= internal_CPU_data_master_byteenable_SRAM_avalon_sram_slave;
  --vhdl renameroo for output signals
  CPU_data_master_granted_SRAM_avalon_sram_slave <= internal_CPU_data_master_granted_SRAM_avalon_sram_slave;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_SRAM_avalon_sram_slave <= internal_CPU_data_master_qualified_request_SRAM_avalon_sram_slave;
  --vhdl renameroo for output signals
  CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register <= internal_CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register;
  --vhdl renameroo for output signals
  CPU_data_master_requests_SRAM_avalon_sram_slave <= internal_CPU_data_master_requests_SRAM_avalon_sram_slave;
  --vhdl renameroo for output signals
  CPU_instruction_master_granted_SRAM_avalon_sram_slave <= internal_CPU_instruction_master_granted_SRAM_avalon_sram_slave;
  --vhdl renameroo for output signals
  CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave <= internal_CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave;
  --vhdl renameroo for output signals
  CPU_instruction_master_requests_SRAM_avalon_sram_slave <= internal_CPU_instruction_master_requests_SRAM_avalon_sram_slave;
--synthesis translate_off
    --SRAM/avalon_sram_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line6 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_CPU_data_master_granted_SRAM_avalon_sram_slave))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_CPU_instruction_master_granted_SRAM_avalon_sram_slave))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line6, now);
          write(write_line6, string'(": "));
          write(write_line6, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line6.all);
          deallocate (write_line6);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line7 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(CPU_data_master_saved_grant_SRAM_avalon_sram_slave))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(CPU_instruction_master_saved_grant_SRAM_avalon_sram_slave))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line7, now);
          write(write_line7, string'(": "));
          write(write_line7, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line7.all);
          deallocate (write_line7);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Serial_port_avalon_rs232_slave_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Serial_port_avalon_rs232_slave_irq : IN STD_LOGIC;
                 signal Serial_port_avalon_rs232_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_Serial_port_avalon_rs232_slave : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave : OUT STD_LOGIC;
                 signal CPU_data_master_requests_Serial_port_avalon_rs232_slave : OUT STD_LOGIC;
                 signal Serial_port_avalon_rs232_slave_address : OUT STD_LOGIC;
                 signal Serial_port_avalon_rs232_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal Serial_port_avalon_rs232_slave_chipselect : OUT STD_LOGIC;
                 signal Serial_port_avalon_rs232_slave_irq_from_sa : OUT STD_LOGIC;
                 signal Serial_port_avalon_rs232_slave_read : OUT STD_LOGIC;
                 signal Serial_port_avalon_rs232_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Serial_port_avalon_rs232_slave_reset : OUT STD_LOGIC;
                 signal Serial_port_avalon_rs232_slave_write : OUT STD_LOGIC;
                 signal Serial_port_avalon_rs232_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_Serial_port_avalon_rs232_slave_end_xfer : OUT STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave : OUT STD_LOGIC
              );
end entity Serial_port_avalon_rs232_slave_arbitrator;


architecture europa of Serial_port_avalon_rs232_slave_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register_in :  STD_LOGIC;
                signal CPU_data_master_saved_grant_Serial_port_avalon_rs232_slave :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_allgrants :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_any_continuerequest :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_arb_counter_enable :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Serial_port_avalon_rs232_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Serial_port_avalon_rs232_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Serial_port_avalon_rs232_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_begins_xfer :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_end_xfer :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_firsttransfer :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_grant_vector :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_in_a_read_cycle :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_in_a_write_cycle :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_master_qreq_vector :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_non_bursting_master_requests :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_reg_firsttransfer :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_slavearbiterlockenable :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_unreg_firsttransfer :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_waits_for_read :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Serial_port_avalon_rs232_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_Serial_port_avalon_rs232_slave :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave :  STD_LOGIC;
                signal internal_CPU_data_master_requests_Serial_port_avalon_rs232_slave :  STD_LOGIC;
                signal p1_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register :  STD_LOGIC;
                signal shifted_address_to_Serial_port_avalon_rs232_slave_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal wait_for_Serial_port_avalon_rs232_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Serial_port_avalon_rs232_slave_end_xfer;
    end if;

  end process;

  Serial_port_avalon_rs232_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave);
  --assign Serial_port_avalon_rs232_slave_readdata_from_sa = Serial_port_avalon_rs232_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  Serial_port_avalon_rs232_slave_readdata_from_sa <= Serial_port_avalon_rs232_slave_readdata;
  internal_CPU_data_master_requests_Serial_port_avalon_rs232_slave <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("10000000000000001000000010000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --registered rdv signal_name registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave assignment, which is an e_assign
  registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave <= CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register_in;
  --Serial_port_avalon_rs232_slave_arb_share_counter set values, which is an e_mux
  Serial_port_avalon_rs232_slave_arb_share_set_values <= std_logic_vector'("01");
  --Serial_port_avalon_rs232_slave_non_bursting_master_requests mux, which is an e_mux
  Serial_port_avalon_rs232_slave_non_bursting_master_requests <= internal_CPU_data_master_requests_Serial_port_avalon_rs232_slave;
  --Serial_port_avalon_rs232_slave_any_bursting_master_saved_grant mux, which is an e_mux
  Serial_port_avalon_rs232_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --Serial_port_avalon_rs232_slave_arb_share_counter_next_value assignment, which is an e_assign
  Serial_port_avalon_rs232_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(Serial_port_avalon_rs232_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Serial_port_avalon_rs232_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(Serial_port_avalon_rs232_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Serial_port_avalon_rs232_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --Serial_port_avalon_rs232_slave_allgrants all slave grants, which is an e_mux
  Serial_port_avalon_rs232_slave_allgrants <= Serial_port_avalon_rs232_slave_grant_vector;
  --Serial_port_avalon_rs232_slave_end_xfer assignment, which is an e_assign
  Serial_port_avalon_rs232_slave_end_xfer <= NOT ((Serial_port_avalon_rs232_slave_waits_for_read OR Serial_port_avalon_rs232_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_Serial_port_avalon_rs232_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Serial_port_avalon_rs232_slave <= Serial_port_avalon_rs232_slave_end_xfer AND (((NOT Serial_port_avalon_rs232_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Serial_port_avalon_rs232_slave_arb_share_counter arbitration counter enable, which is an e_assign
  Serial_port_avalon_rs232_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Serial_port_avalon_rs232_slave AND Serial_port_avalon_rs232_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_Serial_port_avalon_rs232_slave AND NOT Serial_port_avalon_rs232_slave_non_bursting_master_requests));
  --Serial_port_avalon_rs232_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Serial_port_avalon_rs232_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(Serial_port_avalon_rs232_slave_arb_counter_enable) = '1' then 
        Serial_port_avalon_rs232_slave_arb_share_counter <= Serial_port_avalon_rs232_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Serial_port_avalon_rs232_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Serial_port_avalon_rs232_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Serial_port_avalon_rs232_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_Serial_port_avalon_rs232_slave)) OR ((end_xfer_arb_share_counter_term_Serial_port_avalon_rs232_slave AND NOT Serial_port_avalon_rs232_slave_non_bursting_master_requests)))) = '1' then 
        Serial_port_avalon_rs232_slave_slavearbiterlockenable <= or_reduce(Serial_port_avalon_rs232_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master Serial_port/avalon_rs232_slave arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= Serial_port_avalon_rs232_slave_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --Serial_port_avalon_rs232_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Serial_port_avalon_rs232_slave_slavearbiterlockenable2 <= or_reduce(Serial_port_avalon_rs232_slave_arb_share_counter_next_value);
  --CPU/data_master Serial_port/avalon_rs232_slave arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= Serial_port_avalon_rs232_slave_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --Serial_port_avalon_rs232_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  Serial_port_avalon_rs232_slave_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave <= internal_CPU_data_master_requests_Serial_port_avalon_rs232_slave AND NOT ((((CPU_data_master_read AND (CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register))) OR (((NOT CPU_data_master_waitrequest) AND CPU_data_master_write))));
  --CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register_in <= ((internal_CPU_data_master_granted_Serial_port_avalon_rs232_slave AND CPU_data_master_read) AND NOT Serial_port_avalon_rs232_slave_waits_for_read) AND NOT (CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register);
  --shift register p1 CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register) & A_ToStdLogicVector(CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register_in)));
  --CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register <= p1_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register;
    end if;

  end process;

  --local readdatavalid CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave, which is an e_mux
  CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave <= CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave_shift_register;
  --Serial_port_avalon_rs232_slave_writedata mux, which is an e_mux
  Serial_port_avalon_rs232_slave_writedata <= CPU_data_master_writedata;
  --master is always granted when requested
  internal_CPU_data_master_granted_Serial_port_avalon_rs232_slave <= internal_CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave;
  --CPU/data_master saved-grant Serial_port/avalon_rs232_slave, which is an e_assign
  CPU_data_master_saved_grant_Serial_port_avalon_rs232_slave <= internal_CPU_data_master_requests_Serial_port_avalon_rs232_slave;
  --allow new arb cycle for Serial_port/avalon_rs232_slave, which is an e_assign
  Serial_port_avalon_rs232_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Serial_port_avalon_rs232_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Serial_port_avalon_rs232_slave_master_qreq_vector <= std_logic'('1');
  --~Serial_port_avalon_rs232_slave_reset assignment, which is an e_assign
  Serial_port_avalon_rs232_slave_reset <= NOT reset_n;
  Serial_port_avalon_rs232_slave_chipselect <= internal_CPU_data_master_granted_Serial_port_avalon_rs232_slave;
  --Serial_port_avalon_rs232_slave_firsttransfer first transaction, which is an e_assign
  Serial_port_avalon_rs232_slave_firsttransfer <= A_WE_StdLogic((std_logic'(Serial_port_avalon_rs232_slave_begins_xfer) = '1'), Serial_port_avalon_rs232_slave_unreg_firsttransfer, Serial_port_avalon_rs232_slave_reg_firsttransfer);
  --Serial_port_avalon_rs232_slave_unreg_firsttransfer first transaction, which is an e_assign
  Serial_port_avalon_rs232_slave_unreg_firsttransfer <= NOT ((Serial_port_avalon_rs232_slave_slavearbiterlockenable AND Serial_port_avalon_rs232_slave_any_continuerequest));
  --Serial_port_avalon_rs232_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Serial_port_avalon_rs232_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Serial_port_avalon_rs232_slave_begins_xfer) = '1' then 
        Serial_port_avalon_rs232_slave_reg_firsttransfer <= Serial_port_avalon_rs232_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Serial_port_avalon_rs232_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Serial_port_avalon_rs232_slave_beginbursttransfer_internal <= Serial_port_avalon_rs232_slave_begins_xfer;
  --Serial_port_avalon_rs232_slave_read assignment, which is an e_mux
  Serial_port_avalon_rs232_slave_read <= internal_CPU_data_master_granted_Serial_port_avalon_rs232_slave AND CPU_data_master_read;
  --Serial_port_avalon_rs232_slave_write assignment, which is an e_mux
  Serial_port_avalon_rs232_slave_write <= internal_CPU_data_master_granted_Serial_port_avalon_rs232_slave AND CPU_data_master_write;
  shifted_address_to_Serial_port_avalon_rs232_slave_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --Serial_port_avalon_rs232_slave_address mux, which is an e_mux
  Serial_port_avalon_rs232_slave_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_Serial_port_avalon_rs232_slave_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_Serial_port_avalon_rs232_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Serial_port_avalon_rs232_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Serial_port_avalon_rs232_slave_end_xfer <= Serial_port_avalon_rs232_slave_end_xfer;
    end if;

  end process;

  --Serial_port_avalon_rs232_slave_waits_for_read in a cycle, which is an e_mux
  Serial_port_avalon_rs232_slave_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Serial_port_avalon_rs232_slave_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Serial_port_avalon_rs232_slave_in_a_read_cycle assignment, which is an e_assign
  Serial_port_avalon_rs232_slave_in_a_read_cycle <= internal_CPU_data_master_granted_Serial_port_avalon_rs232_slave AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Serial_port_avalon_rs232_slave_in_a_read_cycle;
  --Serial_port_avalon_rs232_slave_waits_for_write in a cycle, which is an e_mux
  Serial_port_avalon_rs232_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Serial_port_avalon_rs232_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Serial_port_avalon_rs232_slave_in_a_write_cycle assignment, which is an e_assign
  Serial_port_avalon_rs232_slave_in_a_write_cycle <= internal_CPU_data_master_granted_Serial_port_avalon_rs232_slave AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Serial_port_avalon_rs232_slave_in_a_write_cycle;
  wait_for_Serial_port_avalon_rs232_slave_counter <= std_logic'('0');
  --Serial_port_avalon_rs232_slave_byteenable byte enable port mux, which is an e_mux
  Serial_port_avalon_rs232_slave_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_Serial_port_avalon_rs232_slave)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CPU_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --assign Serial_port_avalon_rs232_slave_irq_from_sa = Serial_port_avalon_rs232_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  Serial_port_avalon_rs232_slave_irq_from_sa <= Serial_port_avalon_rs232_slave_irq;
  --vhdl renameroo for output signals
  CPU_data_master_granted_Serial_port_avalon_rs232_slave <= internal_CPU_data_master_granted_Serial_port_avalon_rs232_slave;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave <= internal_CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave;
  --vhdl renameroo for output signals
  CPU_data_master_requests_Serial_port_avalon_rs232_slave <= internal_CPU_data_master_requests_Serial_port_avalon_rs232_slave;
--synthesis translate_off
    --Serial_port/avalon_rs232_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Slider_switches_avalon_parallel_port_slave_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_waitrequest : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Slider_switches_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave : OUT STD_LOGIC;
                 signal Slider_switches_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal Slider_switches_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal Slider_switches_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                 signal Slider_switches_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                 signal Slider_switches_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal Slider_switches_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                 signal Slider_switches_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                 signal Slider_switches_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_Slider_switches_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                 signal registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave : OUT STD_LOGIC
              );
end entity Slider_switches_avalon_parallel_port_slave_arbitrator;


architecture europa of Slider_switches_avalon_parallel_port_slave_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register_in :  STD_LOGIC;
                signal CPU_data_master_saved_grant_Slider_switches_avalon_parallel_port_slave :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_allgrants :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_any_continuerequest :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_arb_counter_enable :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Slider_switches_avalon_parallel_port_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Slider_switches_avalon_parallel_port_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Slider_switches_avalon_parallel_port_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_begins_xfer :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_firsttransfer :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_grant_vector :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_in_a_read_cycle :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_in_a_write_cycle :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_master_qreq_vector :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_non_bursting_master_requests :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_reg_firsttransfer :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_slavearbiterlockenable :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_unreg_firsttransfer :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_waits_for_read :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_Slider_switches_avalon_parallel_port_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave :  STD_LOGIC;
                signal internal_CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave :  STD_LOGIC;
                signal p1_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register :  STD_LOGIC;
                signal shifted_address_to_Slider_switches_avalon_parallel_port_slave_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal wait_for_Slider_switches_avalon_parallel_port_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT Slider_switches_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  Slider_switches_avalon_parallel_port_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave);
  --assign Slider_switches_avalon_parallel_port_slave_readdata_from_sa = Slider_switches_avalon_parallel_port_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_readdata_from_sa <= Slider_switches_avalon_parallel_port_slave_readdata;
  internal_CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave <= to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("10000000000000000000001000000")))) AND ((CPU_data_master_read OR CPU_data_master_write));
  --registered rdv signal_name registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave assignment, which is an e_assign
  registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register_in;
  --Slider_switches_avalon_parallel_port_slave_arb_share_counter set values, which is an e_mux
  Slider_switches_avalon_parallel_port_slave_arb_share_set_values <= std_logic_vector'("01");
  --Slider_switches_avalon_parallel_port_slave_non_bursting_master_requests mux, which is an e_mux
  Slider_switches_avalon_parallel_port_slave_non_bursting_master_requests <= internal_CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave;
  --Slider_switches_avalon_parallel_port_slave_any_bursting_master_saved_grant mux, which is an e_mux
  Slider_switches_avalon_parallel_port_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --Slider_switches_avalon_parallel_port_slave_arb_share_counter_next_value assignment, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(Slider_switches_avalon_parallel_port_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Slider_switches_avalon_parallel_port_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(Slider_switches_avalon_parallel_port_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (Slider_switches_avalon_parallel_port_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --Slider_switches_avalon_parallel_port_slave_allgrants all slave grants, which is an e_mux
  Slider_switches_avalon_parallel_port_slave_allgrants <= Slider_switches_avalon_parallel_port_slave_grant_vector;
  --Slider_switches_avalon_parallel_port_slave_end_xfer assignment, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_end_xfer <= NOT ((Slider_switches_avalon_parallel_port_slave_waits_for_read OR Slider_switches_avalon_parallel_port_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_Slider_switches_avalon_parallel_port_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_Slider_switches_avalon_parallel_port_slave <= Slider_switches_avalon_parallel_port_slave_end_xfer AND (((NOT Slider_switches_avalon_parallel_port_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --Slider_switches_avalon_parallel_port_slave_arb_share_counter arbitration counter enable, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_Slider_switches_avalon_parallel_port_slave AND Slider_switches_avalon_parallel_port_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_Slider_switches_avalon_parallel_port_slave AND NOT Slider_switches_avalon_parallel_port_slave_non_bursting_master_requests));
  --Slider_switches_avalon_parallel_port_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Slider_switches_avalon_parallel_port_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(Slider_switches_avalon_parallel_port_slave_arb_counter_enable) = '1' then 
        Slider_switches_avalon_parallel_port_slave_arb_share_counter <= Slider_switches_avalon_parallel_port_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --Slider_switches_avalon_parallel_port_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Slider_switches_avalon_parallel_port_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((Slider_switches_avalon_parallel_port_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_Slider_switches_avalon_parallel_port_slave)) OR ((end_xfer_arb_share_counter_term_Slider_switches_avalon_parallel_port_slave AND NOT Slider_switches_avalon_parallel_port_slave_non_bursting_master_requests)))) = '1' then 
        Slider_switches_avalon_parallel_port_slave_slavearbiterlockenable <= or_reduce(Slider_switches_avalon_parallel_port_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master Slider_switches/avalon_parallel_port_slave arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= Slider_switches_avalon_parallel_port_slave_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --Slider_switches_avalon_parallel_port_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_slavearbiterlockenable2 <= or_reduce(Slider_switches_avalon_parallel_port_slave_arb_share_counter_next_value);
  --CPU/data_master Slider_switches/avalon_parallel_port_slave arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= Slider_switches_avalon_parallel_port_slave_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --Slider_switches_avalon_parallel_port_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave AND NOT ((((CPU_data_master_read AND (CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register))) OR (((NOT CPU_data_master_waitrequest) AND CPU_data_master_write))));
  --CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register_in <= ((internal_CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave AND CPU_data_master_read) AND NOT Slider_switches_avalon_parallel_port_slave_waits_for_read) AND NOT (CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register);
  --shift register p1 CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register) & A_ToStdLogicVector(CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register_in)));
  --CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register <= p1_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register;
    end if;

  end process;

  --local readdatavalid CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave, which is an e_mux
  CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave <= CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave_shift_register;
  --Slider_switches_avalon_parallel_port_slave_writedata mux, which is an e_mux
  Slider_switches_avalon_parallel_port_slave_writedata <= CPU_data_master_writedata;
  --master is always granted when requested
  internal_CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave;
  --CPU/data_master saved-grant Slider_switches/avalon_parallel_port_slave, which is an e_assign
  CPU_data_master_saved_grant_Slider_switches_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave;
  --allow new arb cycle for Slider_switches/avalon_parallel_port_slave, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  Slider_switches_avalon_parallel_port_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  Slider_switches_avalon_parallel_port_slave_master_qreq_vector <= std_logic'('1');
  --~Slider_switches_avalon_parallel_port_slave_reset assignment, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_reset <= NOT reset_n;
  Slider_switches_avalon_parallel_port_slave_chipselect <= internal_CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave;
  --Slider_switches_avalon_parallel_port_slave_firsttransfer first transaction, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_firsttransfer <= A_WE_StdLogic((std_logic'(Slider_switches_avalon_parallel_port_slave_begins_xfer) = '1'), Slider_switches_avalon_parallel_port_slave_unreg_firsttransfer, Slider_switches_avalon_parallel_port_slave_reg_firsttransfer);
  --Slider_switches_avalon_parallel_port_slave_unreg_firsttransfer first transaction, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_unreg_firsttransfer <= NOT ((Slider_switches_avalon_parallel_port_slave_slavearbiterlockenable AND Slider_switches_avalon_parallel_port_slave_any_continuerequest));
  --Slider_switches_avalon_parallel_port_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      Slider_switches_avalon_parallel_port_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(Slider_switches_avalon_parallel_port_slave_begins_xfer) = '1' then 
        Slider_switches_avalon_parallel_port_slave_reg_firsttransfer <= Slider_switches_avalon_parallel_port_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --Slider_switches_avalon_parallel_port_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_beginbursttransfer_internal <= Slider_switches_avalon_parallel_port_slave_begins_xfer;
  --Slider_switches_avalon_parallel_port_slave_read assignment, which is an e_mux
  Slider_switches_avalon_parallel_port_slave_read <= internal_CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave AND CPU_data_master_read;
  --Slider_switches_avalon_parallel_port_slave_write assignment, which is an e_mux
  Slider_switches_avalon_parallel_port_slave_write <= internal_CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave AND CPU_data_master_write;
  shifted_address_to_Slider_switches_avalon_parallel_port_slave_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --Slider_switches_avalon_parallel_port_slave_address mux, which is an e_mux
  Slider_switches_avalon_parallel_port_slave_address <= A_EXT (A_SRL(shifted_address_to_Slider_switches_avalon_parallel_port_slave_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_Slider_switches_avalon_parallel_port_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_Slider_switches_avalon_parallel_port_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_Slider_switches_avalon_parallel_port_slave_end_xfer <= Slider_switches_avalon_parallel_port_slave_end_xfer;
    end if;

  end process;

  --Slider_switches_avalon_parallel_port_slave_waits_for_read in a cycle, which is an e_mux
  Slider_switches_avalon_parallel_port_slave_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Slider_switches_avalon_parallel_port_slave_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Slider_switches_avalon_parallel_port_slave_in_a_read_cycle assignment, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_in_a_read_cycle <= internal_CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= Slider_switches_avalon_parallel_port_slave_in_a_read_cycle;
  --Slider_switches_avalon_parallel_port_slave_waits_for_write in a cycle, which is an e_mux
  Slider_switches_avalon_parallel_port_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(Slider_switches_avalon_parallel_port_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --Slider_switches_avalon_parallel_port_slave_in_a_write_cycle assignment, which is an e_assign
  Slider_switches_avalon_parallel_port_slave_in_a_write_cycle <= internal_CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= Slider_switches_avalon_parallel_port_slave_in_a_write_cycle;
  wait_for_Slider_switches_avalon_parallel_port_slave_counter <= std_logic'('0');
  --Slider_switches_avalon_parallel_port_slave_byteenable byte enable port mux, which is an e_mux
  Slider_switches_avalon_parallel_port_slave_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CPU_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave <= internal_CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave <= internal_CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave;
  --vhdl renameroo for output signals
  CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave <= internal_CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave;
--synthesis translate_off
    --Slider_switches/avalon_parallel_port_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sysid_control_slave_arbitrator is 
        port (
              -- inputs:
                 signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                 signal CPU_data_master_read : IN STD_LOGIC;
                 signal CPU_data_master_write : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sysid_control_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- outputs:
                 signal CPU_data_master_granted_sysid_control_slave : OUT STD_LOGIC;
                 signal CPU_data_master_qualified_request_sysid_control_slave : OUT STD_LOGIC;
                 signal CPU_data_master_read_data_valid_sysid_control_slave : OUT STD_LOGIC;
                 signal CPU_data_master_requests_sysid_control_slave : OUT STD_LOGIC;
                 signal d1_sysid_control_slave_end_xfer : OUT STD_LOGIC;
                 signal sysid_control_slave_address : OUT STD_LOGIC;
                 signal sysid_control_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity sysid_control_slave_arbitrator;


architecture europa of sysid_control_slave_arbitrator is
                signal CPU_data_master_arbiterlock :  STD_LOGIC;
                signal CPU_data_master_arbiterlock2 :  STD_LOGIC;
                signal CPU_data_master_continuerequest :  STD_LOGIC;
                signal CPU_data_master_saved_grant_sysid_control_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_sysid_control_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CPU_data_master_granted_sysid_control_slave :  STD_LOGIC;
                signal internal_CPU_data_master_qualified_request_sysid_control_slave :  STD_LOGIC;
                signal internal_CPU_data_master_requests_sysid_control_slave :  STD_LOGIC;
                signal shifted_address_to_sysid_control_slave_from_CPU_data_master :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal sysid_control_slave_allgrants :  STD_LOGIC;
                signal sysid_control_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal sysid_control_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal sysid_control_slave_any_continuerequest :  STD_LOGIC;
                signal sysid_control_slave_arb_counter_enable :  STD_LOGIC;
                signal sysid_control_slave_arb_share_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sysid_control_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sysid_control_slave_arb_share_set_values :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sysid_control_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal sysid_control_slave_begins_xfer :  STD_LOGIC;
                signal sysid_control_slave_end_xfer :  STD_LOGIC;
                signal sysid_control_slave_firsttransfer :  STD_LOGIC;
                signal sysid_control_slave_grant_vector :  STD_LOGIC;
                signal sysid_control_slave_in_a_read_cycle :  STD_LOGIC;
                signal sysid_control_slave_in_a_write_cycle :  STD_LOGIC;
                signal sysid_control_slave_master_qreq_vector :  STD_LOGIC;
                signal sysid_control_slave_non_bursting_master_requests :  STD_LOGIC;
                signal sysid_control_slave_reg_firsttransfer :  STD_LOGIC;
                signal sysid_control_slave_slavearbiterlockenable :  STD_LOGIC;
                signal sysid_control_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal sysid_control_slave_unreg_firsttransfer :  STD_LOGIC;
                signal sysid_control_slave_waits_for_read :  STD_LOGIC;
                signal sysid_control_slave_waits_for_write :  STD_LOGIC;
                signal wait_for_sysid_control_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT sysid_control_slave_end_xfer;
    end if;

  end process;

  sysid_control_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CPU_data_master_qualified_request_sysid_control_slave);
  --assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  sysid_control_slave_readdata_from_sa <= sysid_control_slave_readdata;
  internal_CPU_data_master_requests_sysid_control_slave <= ((to_std_logic(((Std_Logic_Vector'(CPU_data_master_address_to_slave(28 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("10000000000000010000000100000")))) AND ((CPU_data_master_read OR CPU_data_master_write)))) AND CPU_data_master_read;
  --sysid_control_slave_arb_share_counter set values, which is an e_mux
  sysid_control_slave_arb_share_set_values <= std_logic_vector'("01");
  --sysid_control_slave_non_bursting_master_requests mux, which is an e_mux
  sysid_control_slave_non_bursting_master_requests <= internal_CPU_data_master_requests_sysid_control_slave;
  --sysid_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  sysid_control_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --sysid_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  sysid_control_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(sysid_control_slave_firsttransfer) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (sysid_control_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(sysid_control_slave_arb_share_counter)) = '1'), (((std_logic_vector'("0000000000000000000000000000000") & (sysid_control_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --sysid_control_slave_allgrants all slave grants, which is an e_mux
  sysid_control_slave_allgrants <= sysid_control_slave_grant_vector;
  --sysid_control_slave_end_xfer assignment, which is an e_assign
  sysid_control_slave_end_xfer <= NOT ((sysid_control_slave_waits_for_read OR sysid_control_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_sysid_control_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_sysid_control_slave <= sysid_control_slave_end_xfer AND (((NOT sysid_control_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --sysid_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  sysid_control_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_sysid_control_slave AND sysid_control_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_sysid_control_slave AND NOT sysid_control_slave_non_bursting_master_requests));
  --sysid_control_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sysid_control_slave_arb_share_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(sysid_control_slave_arb_counter_enable) = '1' then 
        sysid_control_slave_arb_share_counter <= sysid_control_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --sysid_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sysid_control_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((sysid_control_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_sysid_control_slave)) OR ((end_xfer_arb_share_counter_term_sysid_control_slave AND NOT sysid_control_slave_non_bursting_master_requests)))) = '1' then 
        sysid_control_slave_slavearbiterlockenable <= or_reduce(sysid_control_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --CPU/data_master sysid/control_slave arbiterlock, which is an e_assign
  CPU_data_master_arbiterlock <= sysid_control_slave_slavearbiterlockenable AND CPU_data_master_continuerequest;
  --sysid_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  sysid_control_slave_slavearbiterlockenable2 <= or_reduce(sysid_control_slave_arb_share_counter_next_value);
  --CPU/data_master sysid/control_slave arbiterlock2, which is an e_assign
  CPU_data_master_arbiterlock2 <= sysid_control_slave_slavearbiterlockenable2 AND CPU_data_master_continuerequest;
  --sysid_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  sysid_control_slave_any_continuerequest <= std_logic'('1');
  --CPU_data_master_continuerequest continued request, which is an e_assign
  CPU_data_master_continuerequest <= std_logic'('1');
  internal_CPU_data_master_qualified_request_sysid_control_slave <= internal_CPU_data_master_requests_sysid_control_slave;
  --master is always granted when requested
  internal_CPU_data_master_granted_sysid_control_slave <= internal_CPU_data_master_qualified_request_sysid_control_slave;
  --CPU/data_master saved-grant sysid/control_slave, which is an e_assign
  CPU_data_master_saved_grant_sysid_control_slave <= internal_CPU_data_master_requests_sysid_control_slave;
  --allow new arb cycle for sysid/control_slave, which is an e_assign
  sysid_control_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  sysid_control_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  sysid_control_slave_master_qreq_vector <= std_logic'('1');
  --sysid_control_slave_firsttransfer first transaction, which is an e_assign
  sysid_control_slave_firsttransfer <= A_WE_StdLogic((std_logic'(sysid_control_slave_begins_xfer) = '1'), sysid_control_slave_unreg_firsttransfer, sysid_control_slave_reg_firsttransfer);
  --sysid_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  sysid_control_slave_unreg_firsttransfer <= NOT ((sysid_control_slave_slavearbiterlockenable AND sysid_control_slave_any_continuerequest));
  --sysid_control_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sysid_control_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(sysid_control_slave_begins_xfer) = '1' then 
        sysid_control_slave_reg_firsttransfer <= sysid_control_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --sysid_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  sysid_control_slave_beginbursttransfer_internal <= sysid_control_slave_begins_xfer;
  shifted_address_to_sysid_control_slave_from_CPU_data_master <= CPU_data_master_address_to_slave;
  --sysid_control_slave_address mux, which is an e_mux
  sysid_control_slave_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_sysid_control_slave_from_CPU_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_sysid_control_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_sysid_control_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_sysid_control_slave_end_xfer <= sysid_control_slave_end_xfer;
    end if;

  end process;

  --sysid_control_slave_waits_for_read in a cycle, which is an e_mux
  sysid_control_slave_waits_for_read <= sysid_control_slave_in_a_read_cycle AND sysid_control_slave_begins_xfer;
  --sysid_control_slave_in_a_read_cycle assignment, which is an e_assign
  sysid_control_slave_in_a_read_cycle <= internal_CPU_data_master_granted_sysid_control_slave AND CPU_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= sysid_control_slave_in_a_read_cycle;
  --sysid_control_slave_waits_for_write in a cycle, which is an e_mux
  sysid_control_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(sysid_control_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --sysid_control_slave_in_a_write_cycle assignment, which is an e_assign
  sysid_control_slave_in_a_write_cycle <= internal_CPU_data_master_granted_sysid_control_slave AND CPU_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= sysid_control_slave_in_a_write_cycle;
  wait_for_sysid_control_slave_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  CPU_data_master_granted_sysid_control_slave <= internal_CPU_data_master_granted_sysid_control_slave;
  --vhdl renameroo for output signals
  CPU_data_master_qualified_request_sysid_control_slave <= internal_CPU_data_master_qualified_request_sysid_control_slave;
  --vhdl renameroo for output signals
  CPU_data_master_requests_sysid_control_slave <= internal_CPU_data_master_requests_sysid_control_slave;
--synthesis translate_off
    --sysid/control_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity nios_system_reset_clk_domain_synch_module is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC
              );
end entity nios_system_reset_clk_domain_synch_module;


architecture europa of nios_system_reset_clk_domain_synch_module is
                signal data_in_d1 :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of data_in_d1 : signal is "{-from ""*""} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";
attribute ALTERA_ATTRIBUTE of data_out : signal is "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_in_d1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_in_d1 <= data_in;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_out <= data_in_d1;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity nios_system is 
        port (
              -- 1) global signals:
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- the_Expansion_JP1
                 signal GPIO_0_to_and_from_the_Expansion_JP1 : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- the_Expansion_JP2
                 signal GPIO_1_to_and_from_the_Expansion_JP2 : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);

              -- the_Green_LEDs
                 signal LEDG_from_the_Green_LEDs : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);

              -- the_HEX3_HEX0
                 signal HEX0_from_the_HEX3_HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal HEX1_from_the_HEX3_HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal HEX2_from_the_HEX3_HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal HEX3_from_the_HEX3_HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);

              -- the_HEX7_HEX4
                 signal HEX4_from_the_HEX7_HEX4 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal HEX5_from_the_HEX7_HEX4 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal HEX6_from_the_HEX7_HEX4 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal HEX7_from_the_HEX7_HEX4 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);

              -- the_Pushbuttons
                 signal KEY_to_the_Pushbuttons : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

              -- the_Red_LEDs
                 signal LEDR_from_the_Red_LEDs : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);

              -- the_SDRAM
                 signal zs_addr_from_the_SDRAM : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                 signal zs_ba_from_the_SDRAM : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal zs_cas_n_from_the_SDRAM : OUT STD_LOGIC;
                 signal zs_cke_from_the_SDRAM : OUT STD_LOGIC;
                 signal zs_cs_n_from_the_SDRAM : OUT STD_LOGIC;
                 signal zs_dq_to_and_from_the_SDRAM : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal zs_dqm_from_the_SDRAM : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal zs_ras_n_from_the_SDRAM : OUT STD_LOGIC;
                 signal zs_we_n_from_the_SDRAM : OUT STD_LOGIC;

              -- the_SRAM
                 signal SRAM_ADDR_from_the_SRAM : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal SRAM_CE_N_from_the_SRAM : OUT STD_LOGIC;
                 signal SRAM_DQ_to_and_from_the_SRAM : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SRAM_LB_N_from_the_SRAM : OUT STD_LOGIC;
                 signal SRAM_OE_N_from_the_SRAM : OUT STD_LOGIC;
                 signal SRAM_UB_N_from_the_SRAM : OUT STD_LOGIC;
                 signal SRAM_WE_N_from_the_SRAM : OUT STD_LOGIC;

              -- the_Serial_port
                 signal UART_RXD_to_the_Serial_port : IN STD_LOGIC;
                 signal UART_TXD_from_the_Serial_port : OUT STD_LOGIC;

              -- the_Slider_switches
                 signal SW_to_the_Slider_switches : IN STD_LOGIC_VECTOR (17 DOWNTO 0)
              );
end entity nios_system;


architecture europa of nios_system is
component CPU_jtag_debug_module_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_debugaccess : IN STD_LOGIC;
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CPU_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
                    signal CPU_instruction_master_latency_counter : IN STD_LOGIC;
                    signal CPU_instruction_master_read : IN STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register : IN STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : IN STD_LOGIC;
                    signal CPU_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CPU_jtag_debug_module_resetrequest : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_CPU_jtag_debug_module : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_CPU_jtag_debug_module : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_CPU_jtag_debug_module : OUT STD_LOGIC;
                    signal CPU_data_master_requests_CPU_jtag_debug_module : OUT STD_LOGIC;
                    signal CPU_instruction_master_granted_CPU_jtag_debug_module : OUT STD_LOGIC;
                    signal CPU_instruction_master_qualified_request_CPU_jtag_debug_module : OUT STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_CPU_jtag_debug_module : OUT STD_LOGIC;
                    signal CPU_instruction_master_requests_CPU_jtag_debug_module : OUT STD_LOGIC;
                    signal CPU_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal CPU_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                    signal CPU_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_jtag_debug_module_chipselect : OUT STD_LOGIC;
                    signal CPU_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                    signal CPU_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CPU_jtag_debug_module_reset_n : OUT STD_LOGIC;
                    signal CPU_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                    signal CPU_jtag_debug_module_write : OUT STD_LOGIC;
                    signal CPU_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_CPU_jtag_debug_module_end_xfer : OUT STD_LOGIC
                 );
end component CPU_jtag_debug_module_arbitrator;

component CPU_data_master_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable_SDRAM_s1 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal CPU_data_master_byteenable_SRAM_avalon_sram_slave : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal CPU_data_master_granted_CPU_jtag_debug_module : IN STD_LOGIC;
                    signal CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_granted_Interval_timer_s1 : IN STD_LOGIC;
                    signal CPU_data_master_granted_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                    signal CPU_data_master_granted_Onchip_memory_s2 : IN STD_LOGIC;
                    signal CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_granted_SDRAM_s1 : IN STD_LOGIC;
                    signal CPU_data_master_granted_SRAM_avalon_sram_slave : IN STD_LOGIC;
                    signal CPU_data_master_granted_Serial_port_avalon_rs232_slave : IN STD_LOGIC;
                    signal CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_granted_sysid_control_slave : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_CPU_jtag_debug_module : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_Interval_timer_s1 : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_Onchip_memory_s2 : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_SDRAM_s1 : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_SRAM_avalon_sram_slave : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_qualified_request_sysid_control_slave : IN STD_LOGIC;
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_CPU_jtag_debug_module : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Interval_timer_s1 : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Onchip_memory_s2 : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_SDRAM_s1 : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_SDRAM_s1_shift_register : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_SRAM_avalon_sram_slave : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_read_data_valid_sysid_control_slave : IN STD_LOGIC;
                    signal CPU_data_master_requests_CPU_jtag_debug_module : IN STD_LOGIC;
                    signal CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_requests_Interval_timer_s1 : IN STD_LOGIC;
                    signal CPU_data_master_requests_JTAG_UART_avalon_jtag_slave : IN STD_LOGIC;
                    signal CPU_data_master_requests_Onchip_memory_s2 : IN STD_LOGIC;
                    signal CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_requests_SDRAM_s1 : IN STD_LOGIC;
                    signal CPU_data_master_requests_SRAM_avalon_sram_slave : IN STD_LOGIC;
                    signal CPU_data_master_requests_Serial_port_avalon_rs232_slave : IN STD_LOGIC;
                    signal CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal CPU_data_master_requests_sysid_control_slave : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CPU_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Expansion_JP1_avalon_parallel_port_slave_irq_from_sa : IN STD_LOGIC;
                    signal Expansion_JP1_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Expansion_JP2_avalon_parallel_port_slave_irq_from_sa : IN STD_LOGIC;
                    signal Expansion_JP2_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Green_LEDs_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal HEX3_HEX0_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal HEX7_HEX4_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Interval_timer_s1_irq_from_sa : IN STD_LOGIC;
                    signal Interval_timer_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal JTAG_UART_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal JTAG_UART_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                    signal Onchip_memory_s2_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Pushbuttons_avalon_parallel_port_slave_irq_from_sa : IN STD_LOGIC;
                    signal Pushbuttons_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Red_LEDs_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal SDRAM_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SDRAM_s1_waitrequest_from_sa : IN STD_LOGIC;
                    signal SRAM_avalon_sram_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal Serial_port_avalon_rs232_slave_irq_from_sa : IN STD_LOGIC;
                    signal Serial_port_avalon_rs232_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Slider_switches_avalon_parallel_port_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal d1_CPU_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_Expansion_JP1_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                    signal d1_Expansion_JP2_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                    signal d1_Green_LEDs_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                    signal d1_HEX3_HEX0_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                    signal d1_HEX7_HEX4_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                    signal d1_Interval_timer_s1_end_xfer : IN STD_LOGIC;
                    signal d1_JTAG_UART_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                    signal d1_Onchip_memory_s2_end_xfer : IN STD_LOGIC;
                    signal d1_Pushbuttons_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                    signal d1_Red_LEDs_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                    signal d1_SDRAM_s1_end_xfer : IN STD_LOGIC;
                    signal d1_SRAM_avalon_sram_slave_end_xfer : IN STD_LOGIC;
                    signal d1_Serial_port_avalon_rs232_slave_end_xfer : IN STD_LOGIC;
                    signal d1_Slider_switches_avalon_parallel_port_slave_end_xfer : IN STD_LOGIC;
                    signal d1_sysid_control_slave_end_xfer : IN STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Onchip_memory_s2 : IN STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave : IN STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sysid_control_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal CPU_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal CPU_data_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal CPU_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CPU_data_master_no_byte_enables_and_last_term : OUT STD_LOGIC;
                    signal CPU_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CPU_data_master_waitrequest : OUT STD_LOGIC
                 );
end component CPU_data_master_arbitrator;

component CPU_instruction_master_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_instruction_master_address : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
                    signal CPU_instruction_master_granted_CPU_jtag_debug_module : IN STD_LOGIC;
                    signal CPU_instruction_master_granted_Onchip_memory_s1 : IN STD_LOGIC;
                    signal CPU_instruction_master_granted_SDRAM_s1 : IN STD_LOGIC;
                    signal CPU_instruction_master_granted_SRAM_avalon_sram_slave : IN STD_LOGIC;
                    signal CPU_instruction_master_qualified_request_CPU_jtag_debug_module : IN STD_LOGIC;
                    signal CPU_instruction_master_qualified_request_Onchip_memory_s1 : IN STD_LOGIC;
                    signal CPU_instruction_master_qualified_request_SDRAM_s1 : IN STD_LOGIC;
                    signal CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave : IN STD_LOGIC;
                    signal CPU_instruction_master_read : IN STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_CPU_jtag_debug_module : IN STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_Onchip_memory_s1 : IN STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SDRAM_s1 : IN STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register : IN STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave : IN STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : IN STD_LOGIC;
                    signal CPU_instruction_master_requests_CPU_jtag_debug_module : IN STD_LOGIC;
                    signal CPU_instruction_master_requests_Onchip_memory_s1 : IN STD_LOGIC;
                    signal CPU_instruction_master_requests_SDRAM_s1 : IN STD_LOGIC;
                    signal CPU_instruction_master_requests_SRAM_avalon_sram_slave : IN STD_LOGIC;
                    signal CPU_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Onchip_memory_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal SDRAM_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SDRAM_s1_waitrequest_from_sa : IN STD_LOGIC;
                    signal SRAM_avalon_sram_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal d1_CPU_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_Onchip_memory_s1_end_xfer : IN STD_LOGIC;
                    signal d1_SDRAM_s1_end_xfer : IN STD_LOGIC;
                    signal d1_SRAM_avalon_sram_slave_end_xfer : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (27 DOWNTO 0);
                    signal CPU_instruction_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal CPU_instruction_master_latency_counter : OUT STD_LOGIC;
                    signal CPU_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CPU_instruction_master_readdatavalid : OUT STD_LOGIC;
                    signal CPU_instruction_master_waitrequest : OUT STD_LOGIC
                 );
end component CPU_instruction_master_arbitrator;

component CPU is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal d_irq : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_waitrequest : IN STD_LOGIC;
                    signal i_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_readdatavalid : IN STD_LOGIC;
                    signal i_waitrequest : IN STD_LOGIC;
                    signal jtag_debug_module_address : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal jtag_debug_module_begintransfer : IN STD_LOGIC;
                    signal jtag_debug_module_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal jtag_debug_module_debugaccess : IN STD_LOGIC;
                    signal jtag_debug_module_select : IN STD_LOGIC;
                    signal jtag_debug_module_write : IN STD_LOGIC;
                    signal jtag_debug_module_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d_address : OUT STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal d_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal d_read : OUT STD_LOGIC;
                    signal d_write : OUT STD_LOGIC;
                    signal d_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_address : OUT STD_LOGIC_VECTOR (27 DOWNTO 0);
                    signal i_read : OUT STD_LOGIC;
                    signal jtag_debug_module_debugaccess_to_roms : OUT STD_LOGIC;
                    signal jtag_debug_module_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_debug_module_resetrequest : OUT STD_LOGIC
                 );
end component CPU;

component Expansion_JP1_avalon_parallel_port_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Expansion_JP1_avalon_parallel_port_slave_irq : IN STD_LOGIC;
                    signal Expansion_JP1_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal Expansion_JP1_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Expansion_JP1_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal Expansion_JP1_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                    signal Expansion_JP1_avalon_parallel_port_slave_irq_from_sa : OUT STD_LOGIC;
                    signal Expansion_JP1_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                    signal Expansion_JP1_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Expansion_JP1_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                    signal Expansion_JP1_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                    signal Expansion_JP1_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_Expansion_JP1_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave : OUT STD_LOGIC
                 );
end component Expansion_JP1_avalon_parallel_port_slave_arbitrator;

component Expansion_JP1 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal GPIO_0 : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component Expansion_JP1;

component Expansion_JP2_avalon_parallel_port_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Expansion_JP2_avalon_parallel_port_slave_irq : IN STD_LOGIC;
                    signal Expansion_JP2_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal Expansion_JP2_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Expansion_JP2_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal Expansion_JP2_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                    signal Expansion_JP2_avalon_parallel_port_slave_irq_from_sa : OUT STD_LOGIC;
                    signal Expansion_JP2_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                    signal Expansion_JP2_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Expansion_JP2_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                    signal Expansion_JP2_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                    signal Expansion_JP2_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_Expansion_JP2_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave : OUT STD_LOGIC
                 );
end component Expansion_JP2_avalon_parallel_port_slave_arbitrator;

component Expansion_JP2 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal GPIO_1 : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component Expansion_JP2;

component Green_LEDs_avalon_parallel_port_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Green_LEDs_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal Green_LEDs_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Green_LEDs_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal Green_LEDs_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                    signal Green_LEDs_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                    signal Green_LEDs_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Green_LEDs_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                    signal Green_LEDs_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                    signal Green_LEDs_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_Green_LEDs_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC
                 );
end component Green_LEDs_avalon_parallel_port_slave_arbitrator;

component Green_LEDs is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal LEDG : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component Green_LEDs;

component HEX3_HEX0_avalon_parallel_port_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal HEX3_HEX0_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal HEX3_HEX0_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal HEX3_HEX0_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal HEX3_HEX0_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                    signal HEX3_HEX0_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                    signal HEX3_HEX0_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal HEX3_HEX0_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                    signal HEX3_HEX0_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                    signal HEX3_HEX0_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_HEX3_HEX0_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave : OUT STD_LOGIC
                 );
end component HEX3_HEX0_avalon_parallel_port_slave_arbitrator;

component HEX3_HEX0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal HEX1 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal HEX2 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal HEX3 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component HEX3_HEX0;

component HEX7_HEX4_avalon_parallel_port_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal HEX7_HEX4_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal HEX7_HEX4_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal HEX7_HEX4_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal HEX7_HEX4_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                    signal HEX7_HEX4_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                    signal HEX7_HEX4_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal HEX7_HEX4_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                    signal HEX7_HEX4_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                    signal HEX7_HEX4_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_HEX7_HEX4_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave : OUT STD_LOGIC
                 );
end component HEX7_HEX4_avalon_parallel_port_slave_arbitrator;

component HEX7_HEX4 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal HEX4 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal HEX5 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal HEX6 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal HEX7 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component HEX7_HEX4;

component Interval_timer_s1_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Interval_timer_s1_irq : IN STD_LOGIC;
                    signal Interval_timer_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_Interval_timer_s1 : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_Interval_timer_s1 : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Interval_timer_s1 : OUT STD_LOGIC;
                    signal CPU_data_master_requests_Interval_timer_s1 : OUT STD_LOGIC;
                    signal Interval_timer_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal Interval_timer_s1_chipselect : OUT STD_LOGIC;
                    signal Interval_timer_s1_irq_from_sa : OUT STD_LOGIC;
                    signal Interval_timer_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal Interval_timer_s1_reset_n : OUT STD_LOGIC;
                    signal Interval_timer_s1_write_n : OUT STD_LOGIC;
                    signal Interval_timer_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal d1_Interval_timer_s1_end_xfer : OUT STD_LOGIC
                 );
end component Interval_timer_s1_arbitrator;

component Interval_timer is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component Interval_timer;

component JTAG_UART_avalon_jtag_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal JTAG_UART_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_irq : IN STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal JTAG_UART_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                    signal CPU_data_master_requests_JTAG_UART_avalon_jtag_slave : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_address : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal JTAG_UART_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                    signal JTAG_UART_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_JTAG_UART_avalon_jtag_slave_end_xfer : OUT STD_LOGIC
                 );
end component JTAG_UART_avalon_jtag_slave_arbitrator;

component JTAG_UART is 
           port (
                 -- inputs:
                    signal av_address : IN STD_LOGIC;
                    signal av_chipselect : IN STD_LOGIC;
                    signal av_read_n : IN STD_LOGIC;
                    signal av_write_n : IN STD_LOGIC;
                    signal av_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal rst_n : IN STD_LOGIC;

                 -- outputs:
                    signal av_irq : OUT STD_LOGIC;
                    signal av_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal av_waitrequest : OUT STD_LOGIC;
                    signal dataavailable : OUT STD_LOGIC;
                    signal readyfordata : OUT STD_LOGIC
                 );
end component JTAG_UART;

component Onchip_memory_s1_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
                    signal CPU_instruction_master_latency_counter : IN STD_LOGIC;
                    signal CPU_instruction_master_read : IN STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register : IN STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : IN STD_LOGIC;
                    signal Onchip_memory_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_instruction_master_granted_Onchip_memory_s1 : OUT STD_LOGIC;
                    signal CPU_instruction_master_qualified_request_Onchip_memory_s1 : OUT STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_Onchip_memory_s1 : OUT STD_LOGIC;
                    signal CPU_instruction_master_requests_Onchip_memory_s1 : OUT STD_LOGIC;
                    signal Onchip_memory_s1_address : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
                    signal Onchip_memory_s1_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal Onchip_memory_s1_chipselect : OUT STD_LOGIC;
                    signal Onchip_memory_s1_clken : OUT STD_LOGIC;
                    signal Onchip_memory_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Onchip_memory_s1_write : OUT STD_LOGIC;
                    signal Onchip_memory_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_Onchip_memory_s1_end_xfer : OUT STD_LOGIC
                 );
end component Onchip_memory_s1_arbitrator;

component Onchip_memory_s2_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Onchip_memory_s2_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_Onchip_memory_s2 : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_Onchip_memory_s2 : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Onchip_memory_s2 : OUT STD_LOGIC;
                    signal CPU_data_master_requests_Onchip_memory_s2 : OUT STD_LOGIC;
                    signal Onchip_memory_s2_address : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
                    signal Onchip_memory_s2_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal Onchip_memory_s2_chipselect : OUT STD_LOGIC;
                    signal Onchip_memory_s2_clken : OUT STD_LOGIC;
                    signal Onchip_memory_s2_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Onchip_memory_s2_write : OUT STD_LOGIC;
                    signal Onchip_memory_s2_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_Onchip_memory_s2_end_xfer : OUT STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Onchip_memory_s2 : OUT STD_LOGIC
                 );
end component Onchip_memory_s2_arbitrator;

component Onchip_memory is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
                    signal address2 : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal byteenable2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal chipselect2 : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal clk2 : IN STD_LOGIC;
                    signal clken : IN STD_LOGIC;
                    signal clken2 : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal write2 : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal writedata2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal readdata2 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component Onchip_memory;

component Pushbuttons_avalon_parallel_port_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Pushbuttons_avalon_parallel_port_slave_irq : IN STD_LOGIC;
                    signal Pushbuttons_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal Pushbuttons_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Pushbuttons_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal Pushbuttons_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                    signal Pushbuttons_avalon_parallel_port_slave_irq_from_sa : OUT STD_LOGIC;
                    signal Pushbuttons_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                    signal Pushbuttons_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Pushbuttons_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                    signal Pushbuttons_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                    signal Pushbuttons_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_Pushbuttons_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave : OUT STD_LOGIC
                 );
end component Pushbuttons_avalon_parallel_port_slave_arbitrator;

component Pushbuttons is 
           port (
                 -- inputs:
                    signal KEY : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component Pushbuttons;

component Red_LEDs_avalon_parallel_port_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Red_LEDs_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal Red_LEDs_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Red_LEDs_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal Red_LEDs_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                    signal Red_LEDs_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                    signal Red_LEDs_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Red_LEDs_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                    signal Red_LEDs_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                    signal Red_LEDs_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_Red_LEDs_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave : OUT STD_LOGIC
                 );
end component Red_LEDs_avalon_parallel_port_slave_arbitrator;

component Red_LEDs is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal LEDR : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component Red_LEDs;

component SDRAM_s1_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal CPU_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal CPU_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
                    signal CPU_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal CPU_instruction_master_latency_counter : IN STD_LOGIC;
                    signal CPU_instruction_master_read : IN STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : IN STD_LOGIC;
                    signal SDRAM_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SDRAM_s1_readdatavalid : IN STD_LOGIC;
                    signal SDRAM_s1_waitrequest : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_byteenable_SDRAM_s1 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal CPU_data_master_granted_SDRAM_s1 : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_SDRAM_s1 : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_SDRAM_s1 : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_SDRAM_s1_shift_register : OUT STD_LOGIC;
                    signal CPU_data_master_requests_SDRAM_s1 : OUT STD_LOGIC;
                    signal CPU_instruction_master_granted_SDRAM_s1 : OUT STD_LOGIC;
                    signal CPU_instruction_master_qualified_request_SDRAM_s1 : OUT STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SDRAM_s1 : OUT STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register : OUT STD_LOGIC;
                    signal CPU_instruction_master_requests_SDRAM_s1 : OUT STD_LOGIC;
                    signal SDRAM_s1_address : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
                    signal SDRAM_s1_byteenable_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal SDRAM_s1_chipselect : OUT STD_LOGIC;
                    signal SDRAM_s1_read_n : OUT STD_LOGIC;
                    signal SDRAM_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SDRAM_s1_reset_n : OUT STD_LOGIC;
                    signal SDRAM_s1_waitrequest_from_sa : OUT STD_LOGIC;
                    signal SDRAM_s1_write_n : OUT STD_LOGIC;
                    signal SDRAM_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal d1_SDRAM_s1_end_xfer : OUT STD_LOGIC
                 );
end component SDRAM_s1_arbitrator;

component SDRAM is 
           port (
                 -- inputs:
                    signal az_addr : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
                    signal az_be_n : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal az_cs : IN STD_LOGIC;
                    signal az_data : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal az_rd_n : IN STD_LOGIC;
                    signal az_wr_n : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal za_data : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal za_valid : OUT STD_LOGIC;
                    signal za_waitrequest : OUT STD_LOGIC;
                    signal zs_addr : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal zs_ba : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_cas_n : OUT STD_LOGIC;
                    signal zs_cke : OUT STD_LOGIC;
                    signal zs_cs_n : OUT STD_LOGIC;
                    signal zs_dq : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal zs_dqm : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_ras_n : OUT STD_LOGIC;
                    signal zs_we_n : OUT STD_LOGIC
                 );
end component SDRAM;

component SRAM_avalon_sram_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal CPU_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal CPU_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
                    signal CPU_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal CPU_instruction_master_latency_counter : IN STD_LOGIC;
                    signal CPU_instruction_master_read : IN STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register : IN STD_LOGIC;
                    signal SRAM_avalon_sram_slave_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SRAM_avalon_sram_slave_readdatavalid : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_byteenable_SRAM_avalon_sram_slave : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal CPU_data_master_granted_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : OUT STD_LOGIC;
                    signal CPU_data_master_requests_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                    signal CPU_instruction_master_granted_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                    signal CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                    signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register : OUT STD_LOGIC;
                    signal CPU_instruction_master_requests_SRAM_avalon_sram_slave : OUT STD_LOGIC;
                    signal SRAM_avalon_sram_slave_address : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal SRAM_avalon_sram_slave_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal SRAM_avalon_sram_slave_read : OUT STD_LOGIC;
                    signal SRAM_avalon_sram_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SRAM_avalon_sram_slave_reset : OUT STD_LOGIC;
                    signal SRAM_avalon_sram_slave_write : OUT STD_LOGIC;
                    signal SRAM_avalon_sram_slave_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal d1_SRAM_avalon_sram_slave_end_xfer : OUT STD_LOGIC
                 );
end component SRAM_avalon_sram_slave_arbitrator;

component SRAM is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal SRAM_ADDR : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal SRAM_CE_N : OUT STD_LOGIC;
                    signal SRAM_DQ : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SRAM_LB_N : OUT STD_LOGIC;
                    signal SRAM_OE_N : OUT STD_LOGIC;
                    signal SRAM_UB_N : OUT STD_LOGIC;
                    signal SRAM_WE_N : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal readdatavalid : OUT STD_LOGIC
                 );
end component SRAM;

component Serial_port_avalon_rs232_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Serial_port_avalon_rs232_slave_irq : IN STD_LOGIC;
                    signal Serial_port_avalon_rs232_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_Serial_port_avalon_rs232_slave : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave : OUT STD_LOGIC;
                    signal CPU_data_master_requests_Serial_port_avalon_rs232_slave : OUT STD_LOGIC;
                    signal Serial_port_avalon_rs232_slave_address : OUT STD_LOGIC;
                    signal Serial_port_avalon_rs232_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal Serial_port_avalon_rs232_slave_chipselect : OUT STD_LOGIC;
                    signal Serial_port_avalon_rs232_slave_irq_from_sa : OUT STD_LOGIC;
                    signal Serial_port_avalon_rs232_slave_read : OUT STD_LOGIC;
                    signal Serial_port_avalon_rs232_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Serial_port_avalon_rs232_slave_reset : OUT STD_LOGIC;
                    signal Serial_port_avalon_rs232_slave_write : OUT STD_LOGIC;
                    signal Serial_port_avalon_rs232_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_Serial_port_avalon_rs232_slave_end_xfer : OUT STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave : OUT STD_LOGIC
                 );
end component Serial_port_avalon_rs232_slave_arbitrator;

component Serial_port is 
           port (
                 -- inputs:
                    signal UART_RXD : IN STD_LOGIC;
                    signal address : IN STD_LOGIC;
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal UART_TXD : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component Serial_port;

component Slider_switches_avalon_parallel_port_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_waitrequest : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal CPU_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Slider_switches_avalon_parallel_port_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave : OUT STD_LOGIC;
                    signal Slider_switches_avalon_parallel_port_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal Slider_switches_avalon_parallel_port_slave_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal Slider_switches_avalon_parallel_port_slave_chipselect : OUT STD_LOGIC;
                    signal Slider_switches_avalon_parallel_port_slave_read : OUT STD_LOGIC;
                    signal Slider_switches_avalon_parallel_port_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal Slider_switches_avalon_parallel_port_slave_reset : OUT STD_LOGIC;
                    signal Slider_switches_avalon_parallel_port_slave_write : OUT STD_LOGIC;
                    signal Slider_switches_avalon_parallel_port_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_Slider_switches_avalon_parallel_port_slave_end_xfer : OUT STD_LOGIC;
                    signal registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave : OUT STD_LOGIC
                 );
end component Slider_switches_avalon_parallel_port_slave_arbitrator;

component Slider_switches is 
           port (
                 -- inputs:
                    signal SW : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component Slider_switches;

component sysid_control_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CPU_data_master_address_to_slave : IN STD_LOGIC_VECTOR (28 DOWNTO 0);
                    signal CPU_data_master_read : IN STD_LOGIC;
                    signal CPU_data_master_write : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sysid_control_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal CPU_data_master_granted_sysid_control_slave : OUT STD_LOGIC;
                    signal CPU_data_master_qualified_request_sysid_control_slave : OUT STD_LOGIC;
                    signal CPU_data_master_read_data_valid_sysid_control_slave : OUT STD_LOGIC;
                    signal CPU_data_master_requests_sysid_control_slave : OUT STD_LOGIC;
                    signal d1_sysid_control_slave_end_xfer : OUT STD_LOGIC;
                    signal sysid_control_slave_address : OUT STD_LOGIC;
                    signal sysid_control_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component sysid_control_slave_arbitrator;

component sysid is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component sysid;

component nios_system_reset_clk_domain_synch_module is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC
                 );
end component nios_system_reset_clk_domain_synch_module;

                signal CPU_data_master_address :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal CPU_data_master_address_to_slave :  STD_LOGIC_VECTOR (28 DOWNTO 0);
                signal CPU_data_master_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal CPU_data_master_byteenable_SDRAM_s1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_data_master_byteenable_SRAM_avalon_sram_slave :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_data_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_data_master_dbs_write_16 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal CPU_data_master_debugaccess :  STD_LOGIC;
                signal CPU_data_master_granted_CPU_jtag_debug_module :  STD_LOGIC;
                signal CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_granted_Interval_timer_s1 :  STD_LOGIC;
                signal CPU_data_master_granted_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal CPU_data_master_granted_Onchip_memory_s2 :  STD_LOGIC;
                signal CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_granted_SDRAM_s1 :  STD_LOGIC;
                signal CPU_data_master_granted_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_data_master_granted_Serial_port_avalon_rs232_slave :  STD_LOGIC;
                signal CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_granted_sysid_control_slave :  STD_LOGIC;
                signal CPU_data_master_irq :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal CPU_data_master_no_byte_enables_and_last_term :  STD_LOGIC;
                signal CPU_data_master_qualified_request_CPU_jtag_debug_module :  STD_LOGIC;
                signal CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_qualified_request_Interval_timer_s1 :  STD_LOGIC;
                signal CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal CPU_data_master_qualified_request_Onchip_memory_s2 :  STD_LOGIC;
                signal CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_qualified_request_SDRAM_s1 :  STD_LOGIC;
                signal CPU_data_master_qualified_request_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave :  STD_LOGIC;
                signal CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_qualified_request_sysid_control_slave :  STD_LOGIC;
                signal CPU_data_master_read :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_CPU_jtag_debug_module :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Interval_timer_s1 :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Onchip_memory_s2 :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_SDRAM_s1 :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_SDRAM_s1_shift_register :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_read_data_valid_sysid_control_slave :  STD_LOGIC;
                signal CPU_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal CPU_data_master_requests_CPU_jtag_debug_module :  STD_LOGIC;
                signal CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_requests_Interval_timer_s1 :  STD_LOGIC;
                signal CPU_data_master_requests_JTAG_UART_avalon_jtag_slave :  STD_LOGIC;
                signal CPU_data_master_requests_Onchip_memory_s2 :  STD_LOGIC;
                signal CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_requests_SDRAM_s1 :  STD_LOGIC;
                signal CPU_data_master_requests_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_data_master_requests_Serial_port_avalon_rs232_slave :  STD_LOGIC;
                signal CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave :  STD_LOGIC;
                signal CPU_data_master_requests_sysid_control_slave :  STD_LOGIC;
                signal CPU_data_master_waitrequest :  STD_LOGIC;
                signal CPU_data_master_write :  STD_LOGIC;
                signal CPU_data_master_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal CPU_instruction_master_address :  STD_LOGIC_VECTOR (27 DOWNTO 0);
                signal CPU_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (27 DOWNTO 0);
                signal CPU_instruction_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CPU_instruction_master_granted_CPU_jtag_debug_module :  STD_LOGIC;
                signal CPU_instruction_master_granted_Onchip_memory_s1 :  STD_LOGIC;
                signal CPU_instruction_master_granted_SDRAM_s1 :  STD_LOGIC;
                signal CPU_instruction_master_granted_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_instruction_master_latency_counter :  STD_LOGIC;
                signal CPU_instruction_master_qualified_request_CPU_jtag_debug_module :  STD_LOGIC;
                signal CPU_instruction_master_qualified_request_Onchip_memory_s1 :  STD_LOGIC;
                signal CPU_instruction_master_qualified_request_SDRAM_s1 :  STD_LOGIC;
                signal CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_instruction_master_read :  STD_LOGIC;
                signal CPU_instruction_master_read_data_valid_CPU_jtag_debug_module :  STD_LOGIC;
                signal CPU_instruction_master_read_data_valid_Onchip_memory_s1 :  STD_LOGIC;
                signal CPU_instruction_master_read_data_valid_SDRAM_s1 :  STD_LOGIC;
                signal CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register :  STD_LOGIC;
                signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register :  STD_LOGIC;
                signal CPU_instruction_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal CPU_instruction_master_readdatavalid :  STD_LOGIC;
                signal CPU_instruction_master_requests_CPU_jtag_debug_module :  STD_LOGIC;
                signal CPU_instruction_master_requests_Onchip_memory_s1 :  STD_LOGIC;
                signal CPU_instruction_master_requests_SDRAM_s1 :  STD_LOGIC;
                signal CPU_instruction_master_requests_SRAM_avalon_sram_slave :  STD_LOGIC;
                signal CPU_instruction_master_waitrequest :  STD_LOGIC;
                signal CPU_jtag_debug_module_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal CPU_jtag_debug_module_begintransfer :  STD_LOGIC;
                signal CPU_jtag_debug_module_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal CPU_jtag_debug_module_chipselect :  STD_LOGIC;
                signal CPU_jtag_debug_module_debugaccess :  STD_LOGIC;
                signal CPU_jtag_debug_module_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal CPU_jtag_debug_module_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal CPU_jtag_debug_module_reset_n :  STD_LOGIC;
                signal CPU_jtag_debug_module_resetrequest :  STD_LOGIC;
                signal CPU_jtag_debug_module_resetrequest_from_sa :  STD_LOGIC;
                signal CPU_jtag_debug_module_write :  STD_LOGIC;
                signal CPU_jtag_debug_module_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Expansion_JP1_avalon_parallel_port_slave_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Expansion_JP1_avalon_parallel_port_slave_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal Expansion_JP1_avalon_parallel_port_slave_chipselect :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_irq :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_irq_from_sa :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_read :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Expansion_JP1_avalon_parallel_port_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Expansion_JP1_avalon_parallel_port_slave_reset :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_write :  STD_LOGIC;
                signal Expansion_JP1_avalon_parallel_port_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Expansion_JP2_avalon_parallel_port_slave_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Expansion_JP2_avalon_parallel_port_slave_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal Expansion_JP2_avalon_parallel_port_slave_chipselect :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_irq :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_irq_from_sa :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_read :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Expansion_JP2_avalon_parallel_port_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Expansion_JP2_avalon_parallel_port_slave_reset :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_write :  STD_LOGIC;
                signal Expansion_JP2_avalon_parallel_port_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Green_LEDs_avalon_parallel_port_slave_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Green_LEDs_avalon_parallel_port_slave_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal Green_LEDs_avalon_parallel_port_slave_chipselect :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_read :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Green_LEDs_avalon_parallel_port_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Green_LEDs_avalon_parallel_port_slave_reset :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_write :  STD_LOGIC;
                signal Green_LEDs_avalon_parallel_port_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal HEX3_HEX0_avalon_parallel_port_slave_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal HEX3_HEX0_avalon_parallel_port_slave_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal HEX3_HEX0_avalon_parallel_port_slave_chipselect :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_read :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal HEX3_HEX0_avalon_parallel_port_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal HEX3_HEX0_avalon_parallel_port_slave_reset :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_write :  STD_LOGIC;
                signal HEX3_HEX0_avalon_parallel_port_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal HEX7_HEX4_avalon_parallel_port_slave_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal HEX7_HEX4_avalon_parallel_port_slave_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal HEX7_HEX4_avalon_parallel_port_slave_chipselect :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_read :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal HEX7_HEX4_avalon_parallel_port_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal HEX7_HEX4_avalon_parallel_port_slave_reset :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_write :  STD_LOGIC;
                signal HEX7_HEX4_avalon_parallel_port_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Interval_timer_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal Interval_timer_s1_chipselect :  STD_LOGIC;
                signal Interval_timer_s1_irq :  STD_LOGIC;
                signal Interval_timer_s1_irq_from_sa :  STD_LOGIC;
                signal Interval_timer_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal Interval_timer_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal Interval_timer_s1_reset_n :  STD_LOGIC;
                signal Interval_timer_s1_write_n :  STD_LOGIC;
                signal Interval_timer_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal JTAG_UART_avalon_jtag_slave_address :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_chipselect :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_dataavailable :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_irq :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_irq_from_sa :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_read_n :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal JTAG_UART_avalon_jtag_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal JTAG_UART_avalon_jtag_slave_readyfordata :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_reset_n :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_waitrequest :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_write_n :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Onchip_memory_s1_address :  STD_LOGIC_VECTOR (10 DOWNTO 0);
                signal Onchip_memory_s1_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal Onchip_memory_s1_chipselect :  STD_LOGIC;
                signal Onchip_memory_s1_clken :  STD_LOGIC;
                signal Onchip_memory_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Onchip_memory_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Onchip_memory_s1_write :  STD_LOGIC;
                signal Onchip_memory_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Onchip_memory_s2_address :  STD_LOGIC_VECTOR (10 DOWNTO 0);
                signal Onchip_memory_s2_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal Onchip_memory_s2_chipselect :  STD_LOGIC;
                signal Onchip_memory_s2_clken :  STD_LOGIC;
                signal Onchip_memory_s2_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Onchip_memory_s2_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Onchip_memory_s2_write :  STD_LOGIC;
                signal Onchip_memory_s2_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Pushbuttons_avalon_parallel_port_slave_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Pushbuttons_avalon_parallel_port_slave_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal Pushbuttons_avalon_parallel_port_slave_chipselect :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_irq :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_irq_from_sa :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_read :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Pushbuttons_avalon_parallel_port_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Pushbuttons_avalon_parallel_port_slave_reset :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_write :  STD_LOGIC;
                signal Pushbuttons_avalon_parallel_port_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Red_LEDs_avalon_parallel_port_slave_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Red_LEDs_avalon_parallel_port_slave_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal Red_LEDs_avalon_parallel_port_slave_chipselect :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_read :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Red_LEDs_avalon_parallel_port_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Red_LEDs_avalon_parallel_port_slave_reset :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_write :  STD_LOGIC;
                signal Red_LEDs_avalon_parallel_port_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal SDRAM_s1_address :  STD_LOGIC_VECTOR (21 DOWNTO 0);
                signal SDRAM_s1_byteenable_n :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SDRAM_s1_chipselect :  STD_LOGIC;
                signal SDRAM_s1_read_n :  STD_LOGIC;
                signal SDRAM_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SDRAM_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SDRAM_s1_readdatavalid :  STD_LOGIC;
                signal SDRAM_s1_reset_n :  STD_LOGIC;
                signal SDRAM_s1_waitrequest :  STD_LOGIC;
                signal SDRAM_s1_waitrequest_from_sa :  STD_LOGIC;
                signal SDRAM_s1_write_n :  STD_LOGIC;
                signal SDRAM_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SRAM_avalon_sram_slave_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal SRAM_avalon_sram_slave_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal SRAM_avalon_sram_slave_read :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SRAM_avalon_sram_slave_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SRAM_avalon_sram_slave_readdatavalid :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_reset :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_write :  STD_LOGIC;
                signal SRAM_avalon_sram_slave_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal Serial_port_avalon_rs232_slave_address :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal Serial_port_avalon_rs232_slave_chipselect :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_irq :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_irq_from_sa :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_read :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Serial_port_avalon_rs232_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Serial_port_avalon_rs232_slave_reset :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_write :  STD_LOGIC;
                signal Serial_port_avalon_rs232_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Slider_switches_avalon_parallel_port_slave_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal Slider_switches_avalon_parallel_port_slave_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal Slider_switches_avalon_parallel_port_slave_chipselect :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_read :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Slider_switches_avalon_parallel_port_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal Slider_switches_avalon_parallel_port_slave_reset :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_write :  STD_LOGIC;
                signal Slider_switches_avalon_parallel_port_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal clk_reset_n :  STD_LOGIC;
                signal d1_CPU_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal d1_Expansion_JP1_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal d1_Expansion_JP2_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal d1_Green_LEDs_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal d1_HEX3_HEX0_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal d1_HEX7_HEX4_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal d1_Interval_timer_s1_end_xfer :  STD_LOGIC;
                signal d1_JTAG_UART_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal d1_Onchip_memory_s1_end_xfer :  STD_LOGIC;
                signal d1_Onchip_memory_s2_end_xfer :  STD_LOGIC;
                signal d1_Pushbuttons_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal d1_Red_LEDs_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal d1_SDRAM_s1_end_xfer :  STD_LOGIC;
                signal d1_SRAM_avalon_sram_slave_end_xfer :  STD_LOGIC;
                signal d1_Serial_port_avalon_rs232_slave_end_xfer :  STD_LOGIC;
                signal d1_Slider_switches_avalon_parallel_port_slave_end_xfer :  STD_LOGIC;
                signal d1_sysid_control_slave_end_xfer :  STD_LOGIC;
                signal internal_HEX0_from_the_HEX3_HEX0 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal internal_HEX1_from_the_HEX3_HEX0 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal internal_HEX2_from_the_HEX3_HEX0 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal internal_HEX3_from_the_HEX3_HEX0 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal internal_HEX4_from_the_HEX7_HEX4 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal internal_HEX5_from_the_HEX7_HEX4 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal internal_HEX6_from_the_HEX7_HEX4 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal internal_HEX7_from_the_HEX7_HEX4 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal internal_LEDG_from_the_Green_LEDs :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal internal_LEDR_from_the_Red_LEDs :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_SRAM_ADDR_from_the_SRAM :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_SRAM_CE_N_from_the_SRAM :  STD_LOGIC;
                signal internal_SRAM_LB_N_from_the_SRAM :  STD_LOGIC;
                signal internal_SRAM_OE_N_from_the_SRAM :  STD_LOGIC;
                signal internal_SRAM_UB_N_from_the_SRAM :  STD_LOGIC;
                signal internal_SRAM_WE_N_from_the_SRAM :  STD_LOGIC;
                signal internal_UART_TXD_from_the_Serial_port :  STD_LOGIC;
                signal internal_zs_addr_from_the_SDRAM :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal internal_zs_ba_from_the_SDRAM :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_zs_cas_n_from_the_SDRAM :  STD_LOGIC;
                signal internal_zs_cke_from_the_SDRAM :  STD_LOGIC;
                signal internal_zs_cs_n_from_the_SDRAM :  STD_LOGIC;
                signal internal_zs_dqm_from_the_SDRAM :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_zs_ras_n_from_the_SDRAM :  STD_LOGIC;
                signal internal_zs_we_n_from_the_SDRAM :  STD_LOGIC;
                signal module_input12 :  STD_LOGIC;
                signal registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave :  STD_LOGIC;
                signal registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave :  STD_LOGIC;
                signal registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave :  STD_LOGIC;
                signal registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave :  STD_LOGIC;
                signal registered_CPU_data_master_read_data_valid_Onchip_memory_s2 :  STD_LOGIC;
                signal registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave :  STD_LOGIC;
                signal registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave :  STD_LOGIC;
                signal registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave :  STD_LOGIC;
                signal registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave :  STD_LOGIC;
                signal reset_n_sources :  STD_LOGIC;
                signal sysid_control_slave_address :  STD_LOGIC;
                signal sysid_control_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal sysid_control_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);

begin

  --the_CPU_jtag_debug_module, which is an e_instance
  the_CPU_jtag_debug_module : CPU_jtag_debug_module_arbitrator
    port map(
      CPU_data_master_granted_CPU_jtag_debug_module => CPU_data_master_granted_CPU_jtag_debug_module,
      CPU_data_master_qualified_request_CPU_jtag_debug_module => CPU_data_master_qualified_request_CPU_jtag_debug_module,
      CPU_data_master_read_data_valid_CPU_jtag_debug_module => CPU_data_master_read_data_valid_CPU_jtag_debug_module,
      CPU_data_master_requests_CPU_jtag_debug_module => CPU_data_master_requests_CPU_jtag_debug_module,
      CPU_instruction_master_granted_CPU_jtag_debug_module => CPU_instruction_master_granted_CPU_jtag_debug_module,
      CPU_instruction_master_qualified_request_CPU_jtag_debug_module => CPU_instruction_master_qualified_request_CPU_jtag_debug_module,
      CPU_instruction_master_read_data_valid_CPU_jtag_debug_module => CPU_instruction_master_read_data_valid_CPU_jtag_debug_module,
      CPU_instruction_master_requests_CPU_jtag_debug_module => CPU_instruction_master_requests_CPU_jtag_debug_module,
      CPU_jtag_debug_module_address => CPU_jtag_debug_module_address,
      CPU_jtag_debug_module_begintransfer => CPU_jtag_debug_module_begintransfer,
      CPU_jtag_debug_module_byteenable => CPU_jtag_debug_module_byteenable,
      CPU_jtag_debug_module_chipselect => CPU_jtag_debug_module_chipselect,
      CPU_jtag_debug_module_debugaccess => CPU_jtag_debug_module_debugaccess,
      CPU_jtag_debug_module_readdata_from_sa => CPU_jtag_debug_module_readdata_from_sa,
      CPU_jtag_debug_module_reset_n => CPU_jtag_debug_module_reset_n,
      CPU_jtag_debug_module_resetrequest_from_sa => CPU_jtag_debug_module_resetrequest_from_sa,
      CPU_jtag_debug_module_write => CPU_jtag_debug_module_write,
      CPU_jtag_debug_module_writedata => CPU_jtag_debug_module_writedata,
      d1_CPU_jtag_debug_module_end_xfer => d1_CPU_jtag_debug_module_end_xfer,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_debugaccess => CPU_data_master_debugaccess,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      CPU_instruction_master_address_to_slave => CPU_instruction_master_address_to_slave,
      CPU_instruction_master_latency_counter => CPU_instruction_master_latency_counter,
      CPU_instruction_master_read => CPU_instruction_master_read,
      CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register => CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register,
      CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register => CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register,
      CPU_jtag_debug_module_readdata => CPU_jtag_debug_module_readdata,
      CPU_jtag_debug_module_resetrequest => CPU_jtag_debug_module_resetrequest,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_CPU_data_master, which is an e_instance
  the_CPU_data_master : CPU_data_master_arbitrator
    port map(
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_dbs_address => CPU_data_master_dbs_address,
      CPU_data_master_dbs_write_16 => CPU_data_master_dbs_write_16,
      CPU_data_master_irq => CPU_data_master_irq,
      CPU_data_master_no_byte_enables_and_last_term => CPU_data_master_no_byte_enables_and_last_term,
      CPU_data_master_readdata => CPU_data_master_readdata,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_address => CPU_data_master_address,
      CPU_data_master_byteenable_SDRAM_s1 => CPU_data_master_byteenable_SDRAM_s1,
      CPU_data_master_byteenable_SRAM_avalon_sram_slave => CPU_data_master_byteenable_SRAM_avalon_sram_slave,
      CPU_data_master_granted_CPU_jtag_debug_module => CPU_data_master_granted_CPU_jtag_debug_module,
      CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave => CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave,
      CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave => CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave,
      CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave => CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave,
      CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave => CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave,
      CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave => CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave,
      CPU_data_master_granted_Interval_timer_s1 => CPU_data_master_granted_Interval_timer_s1,
      CPU_data_master_granted_JTAG_UART_avalon_jtag_slave => CPU_data_master_granted_JTAG_UART_avalon_jtag_slave,
      CPU_data_master_granted_Onchip_memory_s2 => CPU_data_master_granted_Onchip_memory_s2,
      CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave => CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave,
      CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave => CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave,
      CPU_data_master_granted_SDRAM_s1 => CPU_data_master_granted_SDRAM_s1,
      CPU_data_master_granted_SRAM_avalon_sram_slave => CPU_data_master_granted_SRAM_avalon_sram_slave,
      CPU_data_master_granted_Serial_port_avalon_rs232_slave => CPU_data_master_granted_Serial_port_avalon_rs232_slave,
      CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave => CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave,
      CPU_data_master_granted_sysid_control_slave => CPU_data_master_granted_sysid_control_slave,
      CPU_data_master_qualified_request_CPU_jtag_debug_module => CPU_data_master_qualified_request_CPU_jtag_debug_module,
      CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave => CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave => CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave => CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave => CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave => CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_Interval_timer_s1 => CPU_data_master_qualified_request_Interval_timer_s1,
      CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave => CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave,
      CPU_data_master_qualified_request_Onchip_memory_s2 => CPU_data_master_qualified_request_Onchip_memory_s2,
      CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave => CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave => CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_SDRAM_s1 => CPU_data_master_qualified_request_SDRAM_s1,
      CPU_data_master_qualified_request_SRAM_avalon_sram_slave => CPU_data_master_qualified_request_SRAM_avalon_sram_slave,
      CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave => CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave,
      CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave => CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_sysid_control_slave => CPU_data_master_qualified_request_sysid_control_slave,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_read_data_valid_CPU_jtag_debug_module => CPU_data_master_read_data_valid_CPU_jtag_debug_module,
      CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave => CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave => CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave => CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave => CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave => CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_Interval_timer_s1 => CPU_data_master_read_data_valid_Interval_timer_s1,
      CPU_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave => CPU_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave,
      CPU_data_master_read_data_valid_Onchip_memory_s2 => CPU_data_master_read_data_valid_Onchip_memory_s2,
      CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave => CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave => CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_SDRAM_s1 => CPU_data_master_read_data_valid_SDRAM_s1,
      CPU_data_master_read_data_valid_SDRAM_s1_shift_register => CPU_data_master_read_data_valid_SDRAM_s1_shift_register,
      CPU_data_master_read_data_valid_SRAM_avalon_sram_slave => CPU_data_master_read_data_valid_SRAM_avalon_sram_slave,
      CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register => CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register,
      CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave => CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave,
      CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave => CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_sysid_control_slave => CPU_data_master_read_data_valid_sysid_control_slave,
      CPU_data_master_requests_CPU_jtag_debug_module => CPU_data_master_requests_CPU_jtag_debug_module,
      CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave => CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave,
      CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave => CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave,
      CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave => CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave,
      CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave => CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave,
      CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave => CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave,
      CPU_data_master_requests_Interval_timer_s1 => CPU_data_master_requests_Interval_timer_s1,
      CPU_data_master_requests_JTAG_UART_avalon_jtag_slave => CPU_data_master_requests_JTAG_UART_avalon_jtag_slave,
      CPU_data_master_requests_Onchip_memory_s2 => CPU_data_master_requests_Onchip_memory_s2,
      CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave => CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave,
      CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave => CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave,
      CPU_data_master_requests_SDRAM_s1 => CPU_data_master_requests_SDRAM_s1,
      CPU_data_master_requests_SRAM_avalon_sram_slave => CPU_data_master_requests_SRAM_avalon_sram_slave,
      CPU_data_master_requests_Serial_port_avalon_rs232_slave => CPU_data_master_requests_Serial_port_avalon_rs232_slave,
      CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave => CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave,
      CPU_data_master_requests_sysid_control_slave => CPU_data_master_requests_sysid_control_slave,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      CPU_jtag_debug_module_readdata_from_sa => CPU_jtag_debug_module_readdata_from_sa,
      Expansion_JP1_avalon_parallel_port_slave_irq_from_sa => Expansion_JP1_avalon_parallel_port_slave_irq_from_sa,
      Expansion_JP1_avalon_parallel_port_slave_readdata_from_sa => Expansion_JP1_avalon_parallel_port_slave_readdata_from_sa,
      Expansion_JP2_avalon_parallel_port_slave_irq_from_sa => Expansion_JP2_avalon_parallel_port_slave_irq_from_sa,
      Expansion_JP2_avalon_parallel_port_slave_readdata_from_sa => Expansion_JP2_avalon_parallel_port_slave_readdata_from_sa,
      Green_LEDs_avalon_parallel_port_slave_readdata_from_sa => Green_LEDs_avalon_parallel_port_slave_readdata_from_sa,
      HEX3_HEX0_avalon_parallel_port_slave_readdata_from_sa => HEX3_HEX0_avalon_parallel_port_slave_readdata_from_sa,
      HEX7_HEX4_avalon_parallel_port_slave_readdata_from_sa => HEX7_HEX4_avalon_parallel_port_slave_readdata_from_sa,
      Interval_timer_s1_irq_from_sa => Interval_timer_s1_irq_from_sa,
      Interval_timer_s1_readdata_from_sa => Interval_timer_s1_readdata_from_sa,
      JTAG_UART_avalon_jtag_slave_irq_from_sa => JTAG_UART_avalon_jtag_slave_irq_from_sa,
      JTAG_UART_avalon_jtag_slave_readdata_from_sa => JTAG_UART_avalon_jtag_slave_readdata_from_sa,
      JTAG_UART_avalon_jtag_slave_waitrequest_from_sa => JTAG_UART_avalon_jtag_slave_waitrequest_from_sa,
      Onchip_memory_s2_readdata_from_sa => Onchip_memory_s2_readdata_from_sa,
      Pushbuttons_avalon_parallel_port_slave_irq_from_sa => Pushbuttons_avalon_parallel_port_slave_irq_from_sa,
      Pushbuttons_avalon_parallel_port_slave_readdata_from_sa => Pushbuttons_avalon_parallel_port_slave_readdata_from_sa,
      Red_LEDs_avalon_parallel_port_slave_readdata_from_sa => Red_LEDs_avalon_parallel_port_slave_readdata_from_sa,
      SDRAM_s1_readdata_from_sa => SDRAM_s1_readdata_from_sa,
      SDRAM_s1_waitrequest_from_sa => SDRAM_s1_waitrequest_from_sa,
      SRAM_avalon_sram_slave_readdata_from_sa => SRAM_avalon_sram_slave_readdata_from_sa,
      Serial_port_avalon_rs232_slave_irq_from_sa => Serial_port_avalon_rs232_slave_irq_from_sa,
      Serial_port_avalon_rs232_slave_readdata_from_sa => Serial_port_avalon_rs232_slave_readdata_from_sa,
      Slider_switches_avalon_parallel_port_slave_readdata_from_sa => Slider_switches_avalon_parallel_port_slave_readdata_from_sa,
      clk => clk,
      d1_CPU_jtag_debug_module_end_xfer => d1_CPU_jtag_debug_module_end_xfer,
      d1_Expansion_JP1_avalon_parallel_port_slave_end_xfer => d1_Expansion_JP1_avalon_parallel_port_slave_end_xfer,
      d1_Expansion_JP2_avalon_parallel_port_slave_end_xfer => d1_Expansion_JP2_avalon_parallel_port_slave_end_xfer,
      d1_Green_LEDs_avalon_parallel_port_slave_end_xfer => d1_Green_LEDs_avalon_parallel_port_slave_end_xfer,
      d1_HEX3_HEX0_avalon_parallel_port_slave_end_xfer => d1_HEX3_HEX0_avalon_parallel_port_slave_end_xfer,
      d1_HEX7_HEX4_avalon_parallel_port_slave_end_xfer => d1_HEX7_HEX4_avalon_parallel_port_slave_end_xfer,
      d1_Interval_timer_s1_end_xfer => d1_Interval_timer_s1_end_xfer,
      d1_JTAG_UART_avalon_jtag_slave_end_xfer => d1_JTAG_UART_avalon_jtag_slave_end_xfer,
      d1_Onchip_memory_s2_end_xfer => d1_Onchip_memory_s2_end_xfer,
      d1_Pushbuttons_avalon_parallel_port_slave_end_xfer => d1_Pushbuttons_avalon_parallel_port_slave_end_xfer,
      d1_Red_LEDs_avalon_parallel_port_slave_end_xfer => d1_Red_LEDs_avalon_parallel_port_slave_end_xfer,
      d1_SDRAM_s1_end_xfer => d1_SDRAM_s1_end_xfer,
      d1_SRAM_avalon_sram_slave_end_xfer => d1_SRAM_avalon_sram_slave_end_xfer,
      d1_Serial_port_avalon_rs232_slave_end_xfer => d1_Serial_port_avalon_rs232_slave_end_xfer,
      d1_Slider_switches_avalon_parallel_port_slave_end_xfer => d1_Slider_switches_avalon_parallel_port_slave_end_xfer,
      d1_sysid_control_slave_end_xfer => d1_sysid_control_slave_end_xfer,
      registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave,
      registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave,
      registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave,
      registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave,
      registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave,
      registered_CPU_data_master_read_data_valid_Onchip_memory_s2 => registered_CPU_data_master_read_data_valid_Onchip_memory_s2,
      registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave,
      registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave,
      registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave => registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave,
      registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave,
      reset_n => clk_reset_n,
      sysid_control_slave_readdata_from_sa => sysid_control_slave_readdata_from_sa
    );


  --the_CPU_instruction_master, which is an e_instance
  the_CPU_instruction_master : CPU_instruction_master_arbitrator
    port map(
      CPU_instruction_master_address_to_slave => CPU_instruction_master_address_to_slave,
      CPU_instruction_master_dbs_address => CPU_instruction_master_dbs_address,
      CPU_instruction_master_latency_counter => CPU_instruction_master_latency_counter,
      CPU_instruction_master_readdata => CPU_instruction_master_readdata,
      CPU_instruction_master_readdatavalid => CPU_instruction_master_readdatavalid,
      CPU_instruction_master_waitrequest => CPU_instruction_master_waitrequest,
      CPU_instruction_master_address => CPU_instruction_master_address,
      CPU_instruction_master_granted_CPU_jtag_debug_module => CPU_instruction_master_granted_CPU_jtag_debug_module,
      CPU_instruction_master_granted_Onchip_memory_s1 => CPU_instruction_master_granted_Onchip_memory_s1,
      CPU_instruction_master_granted_SDRAM_s1 => CPU_instruction_master_granted_SDRAM_s1,
      CPU_instruction_master_granted_SRAM_avalon_sram_slave => CPU_instruction_master_granted_SRAM_avalon_sram_slave,
      CPU_instruction_master_qualified_request_CPU_jtag_debug_module => CPU_instruction_master_qualified_request_CPU_jtag_debug_module,
      CPU_instruction_master_qualified_request_Onchip_memory_s1 => CPU_instruction_master_qualified_request_Onchip_memory_s1,
      CPU_instruction_master_qualified_request_SDRAM_s1 => CPU_instruction_master_qualified_request_SDRAM_s1,
      CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave => CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave,
      CPU_instruction_master_read => CPU_instruction_master_read,
      CPU_instruction_master_read_data_valid_CPU_jtag_debug_module => CPU_instruction_master_read_data_valid_CPU_jtag_debug_module,
      CPU_instruction_master_read_data_valid_Onchip_memory_s1 => CPU_instruction_master_read_data_valid_Onchip_memory_s1,
      CPU_instruction_master_read_data_valid_SDRAM_s1 => CPU_instruction_master_read_data_valid_SDRAM_s1,
      CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register => CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register,
      CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave => CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave,
      CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register => CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register,
      CPU_instruction_master_requests_CPU_jtag_debug_module => CPU_instruction_master_requests_CPU_jtag_debug_module,
      CPU_instruction_master_requests_Onchip_memory_s1 => CPU_instruction_master_requests_Onchip_memory_s1,
      CPU_instruction_master_requests_SDRAM_s1 => CPU_instruction_master_requests_SDRAM_s1,
      CPU_instruction_master_requests_SRAM_avalon_sram_slave => CPU_instruction_master_requests_SRAM_avalon_sram_slave,
      CPU_jtag_debug_module_readdata_from_sa => CPU_jtag_debug_module_readdata_from_sa,
      Onchip_memory_s1_readdata_from_sa => Onchip_memory_s1_readdata_from_sa,
      SDRAM_s1_readdata_from_sa => SDRAM_s1_readdata_from_sa,
      SDRAM_s1_waitrequest_from_sa => SDRAM_s1_waitrequest_from_sa,
      SRAM_avalon_sram_slave_readdata_from_sa => SRAM_avalon_sram_slave_readdata_from_sa,
      clk => clk,
      d1_CPU_jtag_debug_module_end_xfer => d1_CPU_jtag_debug_module_end_xfer,
      d1_Onchip_memory_s1_end_xfer => d1_Onchip_memory_s1_end_xfer,
      d1_SDRAM_s1_end_xfer => d1_SDRAM_s1_end_xfer,
      d1_SRAM_avalon_sram_slave_end_xfer => d1_SRAM_avalon_sram_slave_end_xfer,
      reset_n => clk_reset_n
    );


  --the_CPU, which is an e_ptf_instance
  the_CPU : CPU
    port map(
      d_address => CPU_data_master_address,
      d_byteenable => CPU_data_master_byteenable,
      d_read => CPU_data_master_read,
      d_write => CPU_data_master_write,
      d_writedata => CPU_data_master_writedata,
      i_address => CPU_instruction_master_address,
      i_read => CPU_instruction_master_read,
      jtag_debug_module_debugaccess_to_roms => CPU_data_master_debugaccess,
      jtag_debug_module_readdata => CPU_jtag_debug_module_readdata,
      jtag_debug_module_resetrequest => CPU_jtag_debug_module_resetrequest,
      clk => clk,
      d_irq => CPU_data_master_irq,
      d_readdata => CPU_data_master_readdata,
      d_waitrequest => CPU_data_master_waitrequest,
      i_readdata => CPU_instruction_master_readdata,
      i_readdatavalid => CPU_instruction_master_readdatavalid,
      i_waitrequest => CPU_instruction_master_waitrequest,
      jtag_debug_module_address => CPU_jtag_debug_module_address,
      jtag_debug_module_begintransfer => CPU_jtag_debug_module_begintransfer,
      jtag_debug_module_byteenable => CPU_jtag_debug_module_byteenable,
      jtag_debug_module_debugaccess => CPU_jtag_debug_module_debugaccess,
      jtag_debug_module_select => CPU_jtag_debug_module_chipselect,
      jtag_debug_module_write => CPU_jtag_debug_module_write,
      jtag_debug_module_writedata => CPU_jtag_debug_module_writedata,
      reset_n => CPU_jtag_debug_module_reset_n
    );


  --the_Expansion_JP1_avalon_parallel_port_slave, which is an e_instance
  the_Expansion_JP1_avalon_parallel_port_slave : Expansion_JP1_avalon_parallel_port_slave_arbitrator
    port map(
      CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave => CPU_data_master_granted_Expansion_JP1_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave => CPU_data_master_qualified_request_Expansion_JP1_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave => CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave,
      CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave => CPU_data_master_requests_Expansion_JP1_avalon_parallel_port_slave,
      Expansion_JP1_avalon_parallel_port_slave_address => Expansion_JP1_avalon_parallel_port_slave_address,
      Expansion_JP1_avalon_parallel_port_slave_byteenable => Expansion_JP1_avalon_parallel_port_slave_byteenable,
      Expansion_JP1_avalon_parallel_port_slave_chipselect => Expansion_JP1_avalon_parallel_port_slave_chipselect,
      Expansion_JP1_avalon_parallel_port_slave_irq_from_sa => Expansion_JP1_avalon_parallel_port_slave_irq_from_sa,
      Expansion_JP1_avalon_parallel_port_slave_read => Expansion_JP1_avalon_parallel_port_slave_read,
      Expansion_JP1_avalon_parallel_port_slave_readdata_from_sa => Expansion_JP1_avalon_parallel_port_slave_readdata_from_sa,
      Expansion_JP1_avalon_parallel_port_slave_reset => Expansion_JP1_avalon_parallel_port_slave_reset,
      Expansion_JP1_avalon_parallel_port_slave_write => Expansion_JP1_avalon_parallel_port_slave_write,
      Expansion_JP1_avalon_parallel_port_slave_writedata => Expansion_JP1_avalon_parallel_port_slave_writedata,
      d1_Expansion_JP1_avalon_parallel_port_slave_end_xfer => d1_Expansion_JP1_avalon_parallel_port_slave_end_xfer,
      registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_Expansion_JP1_avalon_parallel_port_slave,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      Expansion_JP1_avalon_parallel_port_slave_irq => Expansion_JP1_avalon_parallel_port_slave_irq,
      Expansion_JP1_avalon_parallel_port_slave_readdata => Expansion_JP1_avalon_parallel_port_slave_readdata,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_Expansion_JP1, which is an e_ptf_instance
  the_Expansion_JP1 : Expansion_JP1
    port map(
      GPIO_0 => GPIO_0_to_and_from_the_Expansion_JP1,
      irq => Expansion_JP1_avalon_parallel_port_slave_irq,
      readdata => Expansion_JP1_avalon_parallel_port_slave_readdata,
      address => Expansion_JP1_avalon_parallel_port_slave_address,
      byteenable => Expansion_JP1_avalon_parallel_port_slave_byteenable,
      chipselect => Expansion_JP1_avalon_parallel_port_slave_chipselect,
      clk => clk,
      read => Expansion_JP1_avalon_parallel_port_slave_read,
      reset => Expansion_JP1_avalon_parallel_port_slave_reset,
      write => Expansion_JP1_avalon_parallel_port_slave_write,
      writedata => Expansion_JP1_avalon_parallel_port_slave_writedata
    );


  --the_Expansion_JP2_avalon_parallel_port_slave, which is an e_instance
  the_Expansion_JP2_avalon_parallel_port_slave : Expansion_JP2_avalon_parallel_port_slave_arbitrator
    port map(
      CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave => CPU_data_master_granted_Expansion_JP2_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave => CPU_data_master_qualified_request_Expansion_JP2_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave => CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave,
      CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave => CPU_data_master_requests_Expansion_JP2_avalon_parallel_port_slave,
      Expansion_JP2_avalon_parallel_port_slave_address => Expansion_JP2_avalon_parallel_port_slave_address,
      Expansion_JP2_avalon_parallel_port_slave_byteenable => Expansion_JP2_avalon_parallel_port_slave_byteenable,
      Expansion_JP2_avalon_parallel_port_slave_chipselect => Expansion_JP2_avalon_parallel_port_slave_chipselect,
      Expansion_JP2_avalon_parallel_port_slave_irq_from_sa => Expansion_JP2_avalon_parallel_port_slave_irq_from_sa,
      Expansion_JP2_avalon_parallel_port_slave_read => Expansion_JP2_avalon_parallel_port_slave_read,
      Expansion_JP2_avalon_parallel_port_slave_readdata_from_sa => Expansion_JP2_avalon_parallel_port_slave_readdata_from_sa,
      Expansion_JP2_avalon_parallel_port_slave_reset => Expansion_JP2_avalon_parallel_port_slave_reset,
      Expansion_JP2_avalon_parallel_port_slave_write => Expansion_JP2_avalon_parallel_port_slave_write,
      Expansion_JP2_avalon_parallel_port_slave_writedata => Expansion_JP2_avalon_parallel_port_slave_writedata,
      d1_Expansion_JP2_avalon_parallel_port_slave_end_xfer => d1_Expansion_JP2_avalon_parallel_port_slave_end_xfer,
      registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_Expansion_JP2_avalon_parallel_port_slave,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      Expansion_JP2_avalon_parallel_port_slave_irq => Expansion_JP2_avalon_parallel_port_slave_irq,
      Expansion_JP2_avalon_parallel_port_slave_readdata => Expansion_JP2_avalon_parallel_port_slave_readdata,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_Expansion_JP2, which is an e_ptf_instance
  the_Expansion_JP2 : Expansion_JP2
    port map(
      GPIO_1 => GPIO_1_to_and_from_the_Expansion_JP2,
      irq => Expansion_JP2_avalon_parallel_port_slave_irq,
      readdata => Expansion_JP2_avalon_parallel_port_slave_readdata,
      address => Expansion_JP2_avalon_parallel_port_slave_address,
      byteenable => Expansion_JP2_avalon_parallel_port_slave_byteenable,
      chipselect => Expansion_JP2_avalon_parallel_port_slave_chipselect,
      clk => clk,
      read => Expansion_JP2_avalon_parallel_port_slave_read,
      reset => Expansion_JP2_avalon_parallel_port_slave_reset,
      write => Expansion_JP2_avalon_parallel_port_slave_write,
      writedata => Expansion_JP2_avalon_parallel_port_slave_writedata
    );


  --the_Green_LEDs_avalon_parallel_port_slave, which is an e_instance
  the_Green_LEDs_avalon_parallel_port_slave : Green_LEDs_avalon_parallel_port_slave_arbitrator
    port map(
      CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave => CPU_data_master_granted_Green_LEDs_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave => CPU_data_master_qualified_request_Green_LEDs_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave => CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave,
      CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave => CPU_data_master_requests_Green_LEDs_avalon_parallel_port_slave,
      Green_LEDs_avalon_parallel_port_slave_address => Green_LEDs_avalon_parallel_port_slave_address,
      Green_LEDs_avalon_parallel_port_slave_byteenable => Green_LEDs_avalon_parallel_port_slave_byteenable,
      Green_LEDs_avalon_parallel_port_slave_chipselect => Green_LEDs_avalon_parallel_port_slave_chipselect,
      Green_LEDs_avalon_parallel_port_slave_read => Green_LEDs_avalon_parallel_port_slave_read,
      Green_LEDs_avalon_parallel_port_slave_readdata_from_sa => Green_LEDs_avalon_parallel_port_slave_readdata_from_sa,
      Green_LEDs_avalon_parallel_port_slave_reset => Green_LEDs_avalon_parallel_port_slave_reset,
      Green_LEDs_avalon_parallel_port_slave_write => Green_LEDs_avalon_parallel_port_slave_write,
      Green_LEDs_avalon_parallel_port_slave_writedata => Green_LEDs_avalon_parallel_port_slave_writedata,
      d1_Green_LEDs_avalon_parallel_port_slave_end_xfer => d1_Green_LEDs_avalon_parallel_port_slave_end_xfer,
      registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_Green_LEDs_avalon_parallel_port_slave,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      Green_LEDs_avalon_parallel_port_slave_readdata => Green_LEDs_avalon_parallel_port_slave_readdata,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_Green_LEDs, which is an e_ptf_instance
  the_Green_LEDs : Green_LEDs
    port map(
      LEDG => internal_LEDG_from_the_Green_LEDs,
      readdata => Green_LEDs_avalon_parallel_port_slave_readdata,
      address => Green_LEDs_avalon_parallel_port_slave_address,
      byteenable => Green_LEDs_avalon_parallel_port_slave_byteenable,
      chipselect => Green_LEDs_avalon_parallel_port_slave_chipselect,
      clk => clk,
      read => Green_LEDs_avalon_parallel_port_slave_read,
      reset => Green_LEDs_avalon_parallel_port_slave_reset,
      write => Green_LEDs_avalon_parallel_port_slave_write,
      writedata => Green_LEDs_avalon_parallel_port_slave_writedata
    );


  --the_HEX3_HEX0_avalon_parallel_port_slave, which is an e_instance
  the_HEX3_HEX0_avalon_parallel_port_slave : HEX3_HEX0_avalon_parallel_port_slave_arbitrator
    port map(
      CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave => CPU_data_master_granted_HEX3_HEX0_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave => CPU_data_master_qualified_request_HEX3_HEX0_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave => CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave,
      CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave => CPU_data_master_requests_HEX3_HEX0_avalon_parallel_port_slave,
      HEX3_HEX0_avalon_parallel_port_slave_address => HEX3_HEX0_avalon_parallel_port_slave_address,
      HEX3_HEX0_avalon_parallel_port_slave_byteenable => HEX3_HEX0_avalon_parallel_port_slave_byteenable,
      HEX3_HEX0_avalon_parallel_port_slave_chipselect => HEX3_HEX0_avalon_parallel_port_slave_chipselect,
      HEX3_HEX0_avalon_parallel_port_slave_read => HEX3_HEX0_avalon_parallel_port_slave_read,
      HEX3_HEX0_avalon_parallel_port_slave_readdata_from_sa => HEX3_HEX0_avalon_parallel_port_slave_readdata_from_sa,
      HEX3_HEX0_avalon_parallel_port_slave_reset => HEX3_HEX0_avalon_parallel_port_slave_reset,
      HEX3_HEX0_avalon_parallel_port_slave_write => HEX3_HEX0_avalon_parallel_port_slave_write,
      HEX3_HEX0_avalon_parallel_port_slave_writedata => HEX3_HEX0_avalon_parallel_port_slave_writedata,
      d1_HEX3_HEX0_avalon_parallel_port_slave_end_xfer => d1_HEX3_HEX0_avalon_parallel_port_slave_end_xfer,
      registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_HEX3_HEX0_avalon_parallel_port_slave,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      HEX3_HEX0_avalon_parallel_port_slave_readdata => HEX3_HEX0_avalon_parallel_port_slave_readdata,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_HEX3_HEX0, which is an e_ptf_instance
  the_HEX3_HEX0 : HEX3_HEX0
    port map(
      HEX0 => internal_HEX0_from_the_HEX3_HEX0,
      HEX1 => internal_HEX1_from_the_HEX3_HEX0,
      HEX2 => internal_HEX2_from_the_HEX3_HEX0,
      HEX3 => internal_HEX3_from_the_HEX3_HEX0,
      readdata => HEX3_HEX0_avalon_parallel_port_slave_readdata,
      address => HEX3_HEX0_avalon_parallel_port_slave_address,
      byteenable => HEX3_HEX0_avalon_parallel_port_slave_byteenable,
      chipselect => HEX3_HEX0_avalon_parallel_port_slave_chipselect,
      clk => clk,
      read => HEX3_HEX0_avalon_parallel_port_slave_read,
      reset => HEX3_HEX0_avalon_parallel_port_slave_reset,
      write => HEX3_HEX0_avalon_parallel_port_slave_write,
      writedata => HEX3_HEX0_avalon_parallel_port_slave_writedata
    );


  --the_HEX7_HEX4_avalon_parallel_port_slave, which is an e_instance
  the_HEX7_HEX4_avalon_parallel_port_slave : HEX7_HEX4_avalon_parallel_port_slave_arbitrator
    port map(
      CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave => CPU_data_master_granted_HEX7_HEX4_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave => CPU_data_master_qualified_request_HEX7_HEX4_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave => CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave,
      CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave => CPU_data_master_requests_HEX7_HEX4_avalon_parallel_port_slave,
      HEX7_HEX4_avalon_parallel_port_slave_address => HEX7_HEX4_avalon_parallel_port_slave_address,
      HEX7_HEX4_avalon_parallel_port_slave_byteenable => HEX7_HEX4_avalon_parallel_port_slave_byteenable,
      HEX7_HEX4_avalon_parallel_port_slave_chipselect => HEX7_HEX4_avalon_parallel_port_slave_chipselect,
      HEX7_HEX4_avalon_parallel_port_slave_read => HEX7_HEX4_avalon_parallel_port_slave_read,
      HEX7_HEX4_avalon_parallel_port_slave_readdata_from_sa => HEX7_HEX4_avalon_parallel_port_slave_readdata_from_sa,
      HEX7_HEX4_avalon_parallel_port_slave_reset => HEX7_HEX4_avalon_parallel_port_slave_reset,
      HEX7_HEX4_avalon_parallel_port_slave_write => HEX7_HEX4_avalon_parallel_port_slave_write,
      HEX7_HEX4_avalon_parallel_port_slave_writedata => HEX7_HEX4_avalon_parallel_port_slave_writedata,
      d1_HEX7_HEX4_avalon_parallel_port_slave_end_xfer => d1_HEX7_HEX4_avalon_parallel_port_slave_end_xfer,
      registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_HEX7_HEX4_avalon_parallel_port_slave,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      HEX7_HEX4_avalon_parallel_port_slave_readdata => HEX7_HEX4_avalon_parallel_port_slave_readdata,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_HEX7_HEX4, which is an e_ptf_instance
  the_HEX7_HEX4 : HEX7_HEX4
    port map(
      HEX4 => internal_HEX4_from_the_HEX7_HEX4,
      HEX5 => internal_HEX5_from_the_HEX7_HEX4,
      HEX6 => internal_HEX6_from_the_HEX7_HEX4,
      HEX7 => internal_HEX7_from_the_HEX7_HEX4,
      readdata => HEX7_HEX4_avalon_parallel_port_slave_readdata,
      address => HEX7_HEX4_avalon_parallel_port_slave_address,
      byteenable => HEX7_HEX4_avalon_parallel_port_slave_byteenable,
      chipselect => HEX7_HEX4_avalon_parallel_port_slave_chipselect,
      clk => clk,
      read => HEX7_HEX4_avalon_parallel_port_slave_read,
      reset => HEX7_HEX4_avalon_parallel_port_slave_reset,
      write => HEX7_HEX4_avalon_parallel_port_slave_write,
      writedata => HEX7_HEX4_avalon_parallel_port_slave_writedata
    );


  --the_Interval_timer_s1, which is an e_instance
  the_Interval_timer_s1 : Interval_timer_s1_arbitrator
    port map(
      CPU_data_master_granted_Interval_timer_s1 => CPU_data_master_granted_Interval_timer_s1,
      CPU_data_master_qualified_request_Interval_timer_s1 => CPU_data_master_qualified_request_Interval_timer_s1,
      CPU_data_master_read_data_valid_Interval_timer_s1 => CPU_data_master_read_data_valid_Interval_timer_s1,
      CPU_data_master_requests_Interval_timer_s1 => CPU_data_master_requests_Interval_timer_s1,
      Interval_timer_s1_address => Interval_timer_s1_address,
      Interval_timer_s1_chipselect => Interval_timer_s1_chipselect,
      Interval_timer_s1_irq_from_sa => Interval_timer_s1_irq_from_sa,
      Interval_timer_s1_readdata_from_sa => Interval_timer_s1_readdata_from_sa,
      Interval_timer_s1_reset_n => Interval_timer_s1_reset_n,
      Interval_timer_s1_write_n => Interval_timer_s1_write_n,
      Interval_timer_s1_writedata => Interval_timer_s1_writedata,
      d1_Interval_timer_s1_end_xfer => d1_Interval_timer_s1_end_xfer,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      Interval_timer_s1_irq => Interval_timer_s1_irq,
      Interval_timer_s1_readdata => Interval_timer_s1_readdata,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_Interval_timer, which is an e_ptf_instance
  the_Interval_timer : Interval_timer
    port map(
      irq => Interval_timer_s1_irq,
      readdata => Interval_timer_s1_readdata,
      address => Interval_timer_s1_address,
      chipselect => Interval_timer_s1_chipselect,
      clk => clk,
      reset_n => Interval_timer_s1_reset_n,
      write_n => Interval_timer_s1_write_n,
      writedata => Interval_timer_s1_writedata
    );


  --the_JTAG_UART_avalon_jtag_slave, which is an e_instance
  the_JTAG_UART_avalon_jtag_slave : JTAG_UART_avalon_jtag_slave_arbitrator
    port map(
      CPU_data_master_granted_JTAG_UART_avalon_jtag_slave => CPU_data_master_granted_JTAG_UART_avalon_jtag_slave,
      CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave => CPU_data_master_qualified_request_JTAG_UART_avalon_jtag_slave,
      CPU_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave => CPU_data_master_read_data_valid_JTAG_UART_avalon_jtag_slave,
      CPU_data_master_requests_JTAG_UART_avalon_jtag_slave => CPU_data_master_requests_JTAG_UART_avalon_jtag_slave,
      JTAG_UART_avalon_jtag_slave_address => JTAG_UART_avalon_jtag_slave_address,
      JTAG_UART_avalon_jtag_slave_chipselect => JTAG_UART_avalon_jtag_slave_chipselect,
      JTAG_UART_avalon_jtag_slave_dataavailable_from_sa => JTAG_UART_avalon_jtag_slave_dataavailable_from_sa,
      JTAG_UART_avalon_jtag_slave_irq_from_sa => JTAG_UART_avalon_jtag_slave_irq_from_sa,
      JTAG_UART_avalon_jtag_slave_read_n => JTAG_UART_avalon_jtag_slave_read_n,
      JTAG_UART_avalon_jtag_slave_readdata_from_sa => JTAG_UART_avalon_jtag_slave_readdata_from_sa,
      JTAG_UART_avalon_jtag_slave_readyfordata_from_sa => JTAG_UART_avalon_jtag_slave_readyfordata_from_sa,
      JTAG_UART_avalon_jtag_slave_reset_n => JTAG_UART_avalon_jtag_slave_reset_n,
      JTAG_UART_avalon_jtag_slave_waitrequest_from_sa => JTAG_UART_avalon_jtag_slave_waitrequest_from_sa,
      JTAG_UART_avalon_jtag_slave_write_n => JTAG_UART_avalon_jtag_slave_write_n,
      JTAG_UART_avalon_jtag_slave_writedata => JTAG_UART_avalon_jtag_slave_writedata,
      d1_JTAG_UART_avalon_jtag_slave_end_xfer => d1_JTAG_UART_avalon_jtag_slave_end_xfer,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      JTAG_UART_avalon_jtag_slave_dataavailable => JTAG_UART_avalon_jtag_slave_dataavailable,
      JTAG_UART_avalon_jtag_slave_irq => JTAG_UART_avalon_jtag_slave_irq,
      JTAG_UART_avalon_jtag_slave_readdata => JTAG_UART_avalon_jtag_slave_readdata,
      JTAG_UART_avalon_jtag_slave_readyfordata => JTAG_UART_avalon_jtag_slave_readyfordata,
      JTAG_UART_avalon_jtag_slave_waitrequest => JTAG_UART_avalon_jtag_slave_waitrequest,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_JTAG_UART, which is an e_ptf_instance
  the_JTAG_UART : JTAG_UART
    port map(
      av_irq => JTAG_UART_avalon_jtag_slave_irq,
      av_readdata => JTAG_UART_avalon_jtag_slave_readdata,
      av_waitrequest => JTAG_UART_avalon_jtag_slave_waitrequest,
      dataavailable => JTAG_UART_avalon_jtag_slave_dataavailable,
      readyfordata => JTAG_UART_avalon_jtag_slave_readyfordata,
      av_address => JTAG_UART_avalon_jtag_slave_address,
      av_chipselect => JTAG_UART_avalon_jtag_slave_chipselect,
      av_read_n => JTAG_UART_avalon_jtag_slave_read_n,
      av_write_n => JTAG_UART_avalon_jtag_slave_write_n,
      av_writedata => JTAG_UART_avalon_jtag_slave_writedata,
      clk => clk,
      rst_n => JTAG_UART_avalon_jtag_slave_reset_n
    );


  --the_Onchip_memory_s1, which is an e_instance
  the_Onchip_memory_s1 : Onchip_memory_s1_arbitrator
    port map(
      CPU_instruction_master_granted_Onchip_memory_s1 => CPU_instruction_master_granted_Onchip_memory_s1,
      CPU_instruction_master_qualified_request_Onchip_memory_s1 => CPU_instruction_master_qualified_request_Onchip_memory_s1,
      CPU_instruction_master_read_data_valid_Onchip_memory_s1 => CPU_instruction_master_read_data_valid_Onchip_memory_s1,
      CPU_instruction_master_requests_Onchip_memory_s1 => CPU_instruction_master_requests_Onchip_memory_s1,
      Onchip_memory_s1_address => Onchip_memory_s1_address,
      Onchip_memory_s1_byteenable => Onchip_memory_s1_byteenable,
      Onchip_memory_s1_chipselect => Onchip_memory_s1_chipselect,
      Onchip_memory_s1_clken => Onchip_memory_s1_clken,
      Onchip_memory_s1_readdata_from_sa => Onchip_memory_s1_readdata_from_sa,
      Onchip_memory_s1_write => Onchip_memory_s1_write,
      Onchip_memory_s1_writedata => Onchip_memory_s1_writedata,
      d1_Onchip_memory_s1_end_xfer => d1_Onchip_memory_s1_end_xfer,
      CPU_instruction_master_address_to_slave => CPU_instruction_master_address_to_slave,
      CPU_instruction_master_latency_counter => CPU_instruction_master_latency_counter,
      CPU_instruction_master_read => CPU_instruction_master_read,
      CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register => CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register,
      CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register => CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register,
      Onchip_memory_s1_readdata => Onchip_memory_s1_readdata,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_Onchip_memory_s2, which is an e_instance
  the_Onchip_memory_s2 : Onchip_memory_s2_arbitrator
    port map(
      CPU_data_master_granted_Onchip_memory_s2 => CPU_data_master_granted_Onchip_memory_s2,
      CPU_data_master_qualified_request_Onchip_memory_s2 => CPU_data_master_qualified_request_Onchip_memory_s2,
      CPU_data_master_read_data_valid_Onchip_memory_s2 => CPU_data_master_read_data_valid_Onchip_memory_s2,
      CPU_data_master_requests_Onchip_memory_s2 => CPU_data_master_requests_Onchip_memory_s2,
      Onchip_memory_s2_address => Onchip_memory_s2_address,
      Onchip_memory_s2_byteenable => Onchip_memory_s2_byteenable,
      Onchip_memory_s2_chipselect => Onchip_memory_s2_chipselect,
      Onchip_memory_s2_clken => Onchip_memory_s2_clken,
      Onchip_memory_s2_readdata_from_sa => Onchip_memory_s2_readdata_from_sa,
      Onchip_memory_s2_write => Onchip_memory_s2_write,
      Onchip_memory_s2_writedata => Onchip_memory_s2_writedata,
      d1_Onchip_memory_s2_end_xfer => d1_Onchip_memory_s2_end_xfer,
      registered_CPU_data_master_read_data_valid_Onchip_memory_s2 => registered_CPU_data_master_read_data_valid_Onchip_memory_s2,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      Onchip_memory_s2_readdata => Onchip_memory_s2_readdata,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_Onchip_memory, which is an e_ptf_instance
  the_Onchip_memory : Onchip_memory
    port map(
      readdata => Onchip_memory_s1_readdata,
      readdata2 => Onchip_memory_s2_readdata,
      address => Onchip_memory_s1_address,
      address2 => Onchip_memory_s2_address,
      byteenable => Onchip_memory_s1_byteenable,
      byteenable2 => Onchip_memory_s2_byteenable,
      chipselect => Onchip_memory_s1_chipselect,
      chipselect2 => Onchip_memory_s2_chipselect,
      clk => clk,
      clk2 => clk,
      clken => Onchip_memory_s1_clken,
      clken2 => Onchip_memory_s2_clken,
      write => Onchip_memory_s1_write,
      write2 => Onchip_memory_s2_write,
      writedata => Onchip_memory_s1_writedata,
      writedata2 => Onchip_memory_s2_writedata
    );


  --the_Pushbuttons_avalon_parallel_port_slave, which is an e_instance
  the_Pushbuttons_avalon_parallel_port_slave : Pushbuttons_avalon_parallel_port_slave_arbitrator
    port map(
      CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave => CPU_data_master_granted_Pushbuttons_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave => CPU_data_master_qualified_request_Pushbuttons_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave => CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave,
      CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave => CPU_data_master_requests_Pushbuttons_avalon_parallel_port_slave,
      Pushbuttons_avalon_parallel_port_slave_address => Pushbuttons_avalon_parallel_port_slave_address,
      Pushbuttons_avalon_parallel_port_slave_byteenable => Pushbuttons_avalon_parallel_port_slave_byteenable,
      Pushbuttons_avalon_parallel_port_slave_chipselect => Pushbuttons_avalon_parallel_port_slave_chipselect,
      Pushbuttons_avalon_parallel_port_slave_irq_from_sa => Pushbuttons_avalon_parallel_port_slave_irq_from_sa,
      Pushbuttons_avalon_parallel_port_slave_read => Pushbuttons_avalon_parallel_port_slave_read,
      Pushbuttons_avalon_parallel_port_slave_readdata_from_sa => Pushbuttons_avalon_parallel_port_slave_readdata_from_sa,
      Pushbuttons_avalon_parallel_port_slave_reset => Pushbuttons_avalon_parallel_port_slave_reset,
      Pushbuttons_avalon_parallel_port_slave_write => Pushbuttons_avalon_parallel_port_slave_write,
      Pushbuttons_avalon_parallel_port_slave_writedata => Pushbuttons_avalon_parallel_port_slave_writedata,
      d1_Pushbuttons_avalon_parallel_port_slave_end_xfer => d1_Pushbuttons_avalon_parallel_port_slave_end_xfer,
      registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_Pushbuttons_avalon_parallel_port_slave,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      Pushbuttons_avalon_parallel_port_slave_irq => Pushbuttons_avalon_parallel_port_slave_irq,
      Pushbuttons_avalon_parallel_port_slave_readdata => Pushbuttons_avalon_parallel_port_slave_readdata,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_Pushbuttons, which is an e_ptf_instance
  the_Pushbuttons : Pushbuttons
    port map(
      irq => Pushbuttons_avalon_parallel_port_slave_irq,
      readdata => Pushbuttons_avalon_parallel_port_slave_readdata,
      KEY => KEY_to_the_Pushbuttons,
      address => Pushbuttons_avalon_parallel_port_slave_address,
      byteenable => Pushbuttons_avalon_parallel_port_slave_byteenable,
      chipselect => Pushbuttons_avalon_parallel_port_slave_chipselect,
      clk => clk,
      read => Pushbuttons_avalon_parallel_port_slave_read,
      reset => Pushbuttons_avalon_parallel_port_slave_reset,
      write => Pushbuttons_avalon_parallel_port_slave_write,
      writedata => Pushbuttons_avalon_parallel_port_slave_writedata
    );


  --the_Red_LEDs_avalon_parallel_port_slave, which is an e_instance
  the_Red_LEDs_avalon_parallel_port_slave : Red_LEDs_avalon_parallel_port_slave_arbitrator
    port map(
      CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave => CPU_data_master_granted_Red_LEDs_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave => CPU_data_master_qualified_request_Red_LEDs_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave => CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave,
      CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave => CPU_data_master_requests_Red_LEDs_avalon_parallel_port_slave,
      Red_LEDs_avalon_parallel_port_slave_address => Red_LEDs_avalon_parallel_port_slave_address,
      Red_LEDs_avalon_parallel_port_slave_byteenable => Red_LEDs_avalon_parallel_port_slave_byteenable,
      Red_LEDs_avalon_parallel_port_slave_chipselect => Red_LEDs_avalon_parallel_port_slave_chipselect,
      Red_LEDs_avalon_parallel_port_slave_read => Red_LEDs_avalon_parallel_port_slave_read,
      Red_LEDs_avalon_parallel_port_slave_readdata_from_sa => Red_LEDs_avalon_parallel_port_slave_readdata_from_sa,
      Red_LEDs_avalon_parallel_port_slave_reset => Red_LEDs_avalon_parallel_port_slave_reset,
      Red_LEDs_avalon_parallel_port_slave_write => Red_LEDs_avalon_parallel_port_slave_write,
      Red_LEDs_avalon_parallel_port_slave_writedata => Red_LEDs_avalon_parallel_port_slave_writedata,
      d1_Red_LEDs_avalon_parallel_port_slave_end_xfer => d1_Red_LEDs_avalon_parallel_port_slave_end_xfer,
      registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_Red_LEDs_avalon_parallel_port_slave,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      Red_LEDs_avalon_parallel_port_slave_readdata => Red_LEDs_avalon_parallel_port_slave_readdata,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_Red_LEDs, which is an e_ptf_instance
  the_Red_LEDs : Red_LEDs
    port map(
      LEDR => internal_LEDR_from_the_Red_LEDs,
      readdata => Red_LEDs_avalon_parallel_port_slave_readdata,
      address => Red_LEDs_avalon_parallel_port_slave_address,
      byteenable => Red_LEDs_avalon_parallel_port_slave_byteenable,
      chipselect => Red_LEDs_avalon_parallel_port_slave_chipselect,
      clk => clk,
      read => Red_LEDs_avalon_parallel_port_slave_read,
      reset => Red_LEDs_avalon_parallel_port_slave_reset,
      write => Red_LEDs_avalon_parallel_port_slave_write,
      writedata => Red_LEDs_avalon_parallel_port_slave_writedata
    );


  --the_SDRAM_s1, which is an e_instance
  the_SDRAM_s1 : SDRAM_s1_arbitrator
    port map(
      CPU_data_master_byteenable_SDRAM_s1 => CPU_data_master_byteenable_SDRAM_s1,
      CPU_data_master_granted_SDRAM_s1 => CPU_data_master_granted_SDRAM_s1,
      CPU_data_master_qualified_request_SDRAM_s1 => CPU_data_master_qualified_request_SDRAM_s1,
      CPU_data_master_read_data_valid_SDRAM_s1 => CPU_data_master_read_data_valid_SDRAM_s1,
      CPU_data_master_read_data_valid_SDRAM_s1_shift_register => CPU_data_master_read_data_valid_SDRAM_s1_shift_register,
      CPU_data_master_requests_SDRAM_s1 => CPU_data_master_requests_SDRAM_s1,
      CPU_instruction_master_granted_SDRAM_s1 => CPU_instruction_master_granted_SDRAM_s1,
      CPU_instruction_master_qualified_request_SDRAM_s1 => CPU_instruction_master_qualified_request_SDRAM_s1,
      CPU_instruction_master_read_data_valid_SDRAM_s1 => CPU_instruction_master_read_data_valid_SDRAM_s1,
      CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register => CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register,
      CPU_instruction_master_requests_SDRAM_s1 => CPU_instruction_master_requests_SDRAM_s1,
      SDRAM_s1_address => SDRAM_s1_address,
      SDRAM_s1_byteenable_n => SDRAM_s1_byteenable_n,
      SDRAM_s1_chipselect => SDRAM_s1_chipselect,
      SDRAM_s1_read_n => SDRAM_s1_read_n,
      SDRAM_s1_readdata_from_sa => SDRAM_s1_readdata_from_sa,
      SDRAM_s1_reset_n => SDRAM_s1_reset_n,
      SDRAM_s1_waitrequest_from_sa => SDRAM_s1_waitrequest_from_sa,
      SDRAM_s1_write_n => SDRAM_s1_write_n,
      SDRAM_s1_writedata => SDRAM_s1_writedata,
      d1_SDRAM_s1_end_xfer => d1_SDRAM_s1_end_xfer,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_dbs_address => CPU_data_master_dbs_address,
      CPU_data_master_dbs_write_16 => CPU_data_master_dbs_write_16,
      CPU_data_master_no_byte_enables_and_last_term => CPU_data_master_no_byte_enables_and_last_term,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_instruction_master_address_to_slave => CPU_instruction_master_address_to_slave,
      CPU_instruction_master_dbs_address => CPU_instruction_master_dbs_address,
      CPU_instruction_master_latency_counter => CPU_instruction_master_latency_counter,
      CPU_instruction_master_read => CPU_instruction_master_read,
      CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register => CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register,
      SDRAM_s1_readdata => SDRAM_s1_readdata,
      SDRAM_s1_readdatavalid => SDRAM_s1_readdatavalid,
      SDRAM_s1_waitrequest => SDRAM_s1_waitrequest,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_SDRAM, which is an e_ptf_instance
  the_SDRAM : SDRAM
    port map(
      za_data => SDRAM_s1_readdata,
      za_valid => SDRAM_s1_readdatavalid,
      za_waitrequest => SDRAM_s1_waitrequest,
      zs_addr => internal_zs_addr_from_the_SDRAM,
      zs_ba => internal_zs_ba_from_the_SDRAM,
      zs_cas_n => internal_zs_cas_n_from_the_SDRAM,
      zs_cke => internal_zs_cke_from_the_SDRAM,
      zs_cs_n => internal_zs_cs_n_from_the_SDRAM,
      zs_dq => zs_dq_to_and_from_the_SDRAM,
      zs_dqm => internal_zs_dqm_from_the_SDRAM,
      zs_ras_n => internal_zs_ras_n_from_the_SDRAM,
      zs_we_n => internal_zs_we_n_from_the_SDRAM,
      az_addr => SDRAM_s1_address,
      az_be_n => SDRAM_s1_byteenable_n,
      az_cs => SDRAM_s1_chipselect,
      az_data => SDRAM_s1_writedata,
      az_rd_n => SDRAM_s1_read_n,
      az_wr_n => SDRAM_s1_write_n,
      clk => clk,
      reset_n => SDRAM_s1_reset_n
    );


  --the_SRAM_avalon_sram_slave, which is an e_instance
  the_SRAM_avalon_sram_slave : SRAM_avalon_sram_slave_arbitrator
    port map(
      CPU_data_master_byteenable_SRAM_avalon_sram_slave => CPU_data_master_byteenable_SRAM_avalon_sram_slave,
      CPU_data_master_granted_SRAM_avalon_sram_slave => CPU_data_master_granted_SRAM_avalon_sram_slave,
      CPU_data_master_qualified_request_SRAM_avalon_sram_slave => CPU_data_master_qualified_request_SRAM_avalon_sram_slave,
      CPU_data_master_read_data_valid_SRAM_avalon_sram_slave => CPU_data_master_read_data_valid_SRAM_avalon_sram_slave,
      CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register => CPU_data_master_read_data_valid_SRAM_avalon_sram_slave_shift_register,
      CPU_data_master_requests_SRAM_avalon_sram_slave => CPU_data_master_requests_SRAM_avalon_sram_slave,
      CPU_instruction_master_granted_SRAM_avalon_sram_slave => CPU_instruction_master_granted_SRAM_avalon_sram_slave,
      CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave => CPU_instruction_master_qualified_request_SRAM_avalon_sram_slave,
      CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave => CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave,
      CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register => CPU_instruction_master_read_data_valid_SRAM_avalon_sram_slave_shift_register,
      CPU_instruction_master_requests_SRAM_avalon_sram_slave => CPU_instruction_master_requests_SRAM_avalon_sram_slave,
      SRAM_avalon_sram_slave_address => SRAM_avalon_sram_slave_address,
      SRAM_avalon_sram_slave_byteenable => SRAM_avalon_sram_slave_byteenable,
      SRAM_avalon_sram_slave_read => SRAM_avalon_sram_slave_read,
      SRAM_avalon_sram_slave_readdata_from_sa => SRAM_avalon_sram_slave_readdata_from_sa,
      SRAM_avalon_sram_slave_reset => SRAM_avalon_sram_slave_reset,
      SRAM_avalon_sram_slave_write => SRAM_avalon_sram_slave_write,
      SRAM_avalon_sram_slave_writedata => SRAM_avalon_sram_slave_writedata,
      d1_SRAM_avalon_sram_slave_end_xfer => d1_SRAM_avalon_sram_slave_end_xfer,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_dbs_address => CPU_data_master_dbs_address,
      CPU_data_master_dbs_write_16 => CPU_data_master_dbs_write_16,
      CPU_data_master_no_byte_enables_and_last_term => CPU_data_master_no_byte_enables_and_last_term,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_instruction_master_address_to_slave => CPU_instruction_master_address_to_slave,
      CPU_instruction_master_dbs_address => CPU_instruction_master_dbs_address,
      CPU_instruction_master_latency_counter => CPU_instruction_master_latency_counter,
      CPU_instruction_master_read => CPU_instruction_master_read,
      CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register => CPU_instruction_master_read_data_valid_SDRAM_s1_shift_register,
      SRAM_avalon_sram_slave_readdata => SRAM_avalon_sram_slave_readdata,
      SRAM_avalon_sram_slave_readdatavalid => SRAM_avalon_sram_slave_readdatavalid,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_SRAM, which is an e_ptf_instance
  the_SRAM : SRAM
    port map(
      SRAM_ADDR => internal_SRAM_ADDR_from_the_SRAM,
      SRAM_CE_N => internal_SRAM_CE_N_from_the_SRAM,
      SRAM_DQ => SRAM_DQ_to_and_from_the_SRAM,
      SRAM_LB_N => internal_SRAM_LB_N_from_the_SRAM,
      SRAM_OE_N => internal_SRAM_OE_N_from_the_SRAM,
      SRAM_UB_N => internal_SRAM_UB_N_from_the_SRAM,
      SRAM_WE_N => internal_SRAM_WE_N_from_the_SRAM,
      readdata => SRAM_avalon_sram_slave_readdata,
      readdatavalid => SRAM_avalon_sram_slave_readdatavalid,
      address => SRAM_avalon_sram_slave_address,
      byteenable => SRAM_avalon_sram_slave_byteenable,
      clk => clk,
      read => SRAM_avalon_sram_slave_read,
      reset => SRAM_avalon_sram_slave_reset,
      write => SRAM_avalon_sram_slave_write,
      writedata => SRAM_avalon_sram_slave_writedata
    );


  --the_Serial_port_avalon_rs232_slave, which is an e_instance
  the_Serial_port_avalon_rs232_slave : Serial_port_avalon_rs232_slave_arbitrator
    port map(
      CPU_data_master_granted_Serial_port_avalon_rs232_slave => CPU_data_master_granted_Serial_port_avalon_rs232_slave,
      CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave => CPU_data_master_qualified_request_Serial_port_avalon_rs232_slave,
      CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave => CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave,
      CPU_data_master_requests_Serial_port_avalon_rs232_slave => CPU_data_master_requests_Serial_port_avalon_rs232_slave,
      Serial_port_avalon_rs232_slave_address => Serial_port_avalon_rs232_slave_address,
      Serial_port_avalon_rs232_slave_byteenable => Serial_port_avalon_rs232_slave_byteenable,
      Serial_port_avalon_rs232_slave_chipselect => Serial_port_avalon_rs232_slave_chipselect,
      Serial_port_avalon_rs232_slave_irq_from_sa => Serial_port_avalon_rs232_slave_irq_from_sa,
      Serial_port_avalon_rs232_slave_read => Serial_port_avalon_rs232_slave_read,
      Serial_port_avalon_rs232_slave_readdata_from_sa => Serial_port_avalon_rs232_slave_readdata_from_sa,
      Serial_port_avalon_rs232_slave_reset => Serial_port_avalon_rs232_slave_reset,
      Serial_port_avalon_rs232_slave_write => Serial_port_avalon_rs232_slave_write,
      Serial_port_avalon_rs232_slave_writedata => Serial_port_avalon_rs232_slave_writedata,
      d1_Serial_port_avalon_rs232_slave_end_xfer => d1_Serial_port_avalon_rs232_slave_end_xfer,
      registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave => registered_CPU_data_master_read_data_valid_Serial_port_avalon_rs232_slave,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      Serial_port_avalon_rs232_slave_irq => Serial_port_avalon_rs232_slave_irq,
      Serial_port_avalon_rs232_slave_readdata => Serial_port_avalon_rs232_slave_readdata,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_Serial_port, which is an e_ptf_instance
  the_Serial_port : Serial_port
    port map(
      UART_TXD => internal_UART_TXD_from_the_Serial_port,
      irq => Serial_port_avalon_rs232_slave_irq,
      readdata => Serial_port_avalon_rs232_slave_readdata,
      UART_RXD => UART_RXD_to_the_Serial_port,
      address => Serial_port_avalon_rs232_slave_address,
      byteenable => Serial_port_avalon_rs232_slave_byteenable,
      chipselect => Serial_port_avalon_rs232_slave_chipselect,
      clk => clk,
      read => Serial_port_avalon_rs232_slave_read,
      reset => Serial_port_avalon_rs232_slave_reset,
      write => Serial_port_avalon_rs232_slave_write,
      writedata => Serial_port_avalon_rs232_slave_writedata
    );


  --the_Slider_switches_avalon_parallel_port_slave, which is an e_instance
  the_Slider_switches_avalon_parallel_port_slave : Slider_switches_avalon_parallel_port_slave_arbitrator
    port map(
      CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave => CPU_data_master_granted_Slider_switches_avalon_parallel_port_slave,
      CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave => CPU_data_master_qualified_request_Slider_switches_avalon_parallel_port_slave,
      CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave => CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave,
      CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave => CPU_data_master_requests_Slider_switches_avalon_parallel_port_slave,
      Slider_switches_avalon_parallel_port_slave_address => Slider_switches_avalon_parallel_port_slave_address,
      Slider_switches_avalon_parallel_port_slave_byteenable => Slider_switches_avalon_parallel_port_slave_byteenable,
      Slider_switches_avalon_parallel_port_slave_chipselect => Slider_switches_avalon_parallel_port_slave_chipselect,
      Slider_switches_avalon_parallel_port_slave_read => Slider_switches_avalon_parallel_port_slave_read,
      Slider_switches_avalon_parallel_port_slave_readdata_from_sa => Slider_switches_avalon_parallel_port_slave_readdata_from_sa,
      Slider_switches_avalon_parallel_port_slave_reset => Slider_switches_avalon_parallel_port_slave_reset,
      Slider_switches_avalon_parallel_port_slave_write => Slider_switches_avalon_parallel_port_slave_write,
      Slider_switches_avalon_parallel_port_slave_writedata => Slider_switches_avalon_parallel_port_slave_writedata,
      d1_Slider_switches_avalon_parallel_port_slave_end_xfer => d1_Slider_switches_avalon_parallel_port_slave_end_xfer,
      registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave => registered_CPU_data_master_read_data_valid_Slider_switches_avalon_parallel_port_slave,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_byteenable => CPU_data_master_byteenable,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_waitrequest => CPU_data_master_waitrequest,
      CPU_data_master_write => CPU_data_master_write,
      CPU_data_master_writedata => CPU_data_master_writedata,
      Slider_switches_avalon_parallel_port_slave_readdata => Slider_switches_avalon_parallel_port_slave_readdata,
      clk => clk,
      reset_n => clk_reset_n
    );


  --the_Slider_switches, which is an e_ptf_instance
  the_Slider_switches : Slider_switches
    port map(
      readdata => Slider_switches_avalon_parallel_port_slave_readdata,
      SW => SW_to_the_Slider_switches,
      address => Slider_switches_avalon_parallel_port_slave_address,
      byteenable => Slider_switches_avalon_parallel_port_slave_byteenable,
      chipselect => Slider_switches_avalon_parallel_port_slave_chipselect,
      clk => clk,
      read => Slider_switches_avalon_parallel_port_slave_read,
      reset => Slider_switches_avalon_parallel_port_slave_reset,
      write => Slider_switches_avalon_parallel_port_slave_write,
      writedata => Slider_switches_avalon_parallel_port_slave_writedata
    );


  --the_sysid_control_slave, which is an e_instance
  the_sysid_control_slave : sysid_control_slave_arbitrator
    port map(
      CPU_data_master_granted_sysid_control_slave => CPU_data_master_granted_sysid_control_slave,
      CPU_data_master_qualified_request_sysid_control_slave => CPU_data_master_qualified_request_sysid_control_slave,
      CPU_data_master_read_data_valid_sysid_control_slave => CPU_data_master_read_data_valid_sysid_control_slave,
      CPU_data_master_requests_sysid_control_slave => CPU_data_master_requests_sysid_control_slave,
      d1_sysid_control_slave_end_xfer => d1_sysid_control_slave_end_xfer,
      sysid_control_slave_address => sysid_control_slave_address,
      sysid_control_slave_readdata_from_sa => sysid_control_slave_readdata_from_sa,
      CPU_data_master_address_to_slave => CPU_data_master_address_to_slave,
      CPU_data_master_read => CPU_data_master_read,
      CPU_data_master_write => CPU_data_master_write,
      clk => clk,
      reset_n => clk_reset_n,
      sysid_control_slave_readdata => sysid_control_slave_readdata
    );


  --the_sysid, which is an e_ptf_instance
  the_sysid : sysid
    port map(
      readdata => sysid_control_slave_readdata,
      address => sysid_control_slave_address
    );


  --reset is asserted asynchronously and deasserted synchronously
  nios_system_reset_clk_domain_synch : nios_system_reset_clk_domain_synch_module
    port map(
      data_out => clk_reset_n,
      clk => clk,
      data_in => module_input12,
      reset_n => reset_n_sources
    );

  module_input12 <= std_logic'('1');

  --reset sources mux, which is an e_mux
  reset_n_sources <= Vector_To_Std_Logic(NOT (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT reset_n))) OR std_logic_vector'("00000000000000000000000000000000")) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_jtag_debug_module_resetrequest_from_sa)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CPU_jtag_debug_module_resetrequest_from_sa))))));
  --vhdl renameroo for output signals
  HEX0_from_the_HEX3_HEX0 <= internal_HEX0_from_the_HEX3_HEX0;
  --vhdl renameroo for output signals
  HEX1_from_the_HEX3_HEX0 <= internal_HEX1_from_the_HEX3_HEX0;
  --vhdl renameroo for output signals
  HEX2_from_the_HEX3_HEX0 <= internal_HEX2_from_the_HEX3_HEX0;
  --vhdl renameroo for output signals
  HEX3_from_the_HEX3_HEX0 <= internal_HEX3_from_the_HEX3_HEX0;
  --vhdl renameroo for output signals
  HEX4_from_the_HEX7_HEX4 <= internal_HEX4_from_the_HEX7_HEX4;
  --vhdl renameroo for output signals
  HEX5_from_the_HEX7_HEX4 <= internal_HEX5_from_the_HEX7_HEX4;
  --vhdl renameroo for output signals
  HEX6_from_the_HEX7_HEX4 <= internal_HEX6_from_the_HEX7_HEX4;
  --vhdl renameroo for output signals
  HEX7_from_the_HEX7_HEX4 <= internal_HEX7_from_the_HEX7_HEX4;
  --vhdl renameroo for output signals
  LEDG_from_the_Green_LEDs <= internal_LEDG_from_the_Green_LEDs;
  --vhdl renameroo for output signals
  LEDR_from_the_Red_LEDs <= internal_LEDR_from_the_Red_LEDs;
  --vhdl renameroo for output signals
  SRAM_ADDR_from_the_SRAM <= internal_SRAM_ADDR_from_the_SRAM;
  --vhdl renameroo for output signals
  SRAM_CE_N_from_the_SRAM <= internal_SRAM_CE_N_from_the_SRAM;
  --vhdl renameroo for output signals
  SRAM_LB_N_from_the_SRAM <= internal_SRAM_LB_N_from_the_SRAM;
  --vhdl renameroo for output signals
  SRAM_OE_N_from_the_SRAM <= internal_SRAM_OE_N_from_the_SRAM;
  --vhdl renameroo for output signals
  SRAM_UB_N_from_the_SRAM <= internal_SRAM_UB_N_from_the_SRAM;
  --vhdl renameroo for output signals
  SRAM_WE_N_from_the_SRAM <= internal_SRAM_WE_N_from_the_SRAM;
  --vhdl renameroo for output signals
  UART_TXD_from_the_Serial_port <= internal_UART_TXD_from_the_Serial_port;
  --vhdl renameroo for output signals
  zs_addr_from_the_SDRAM <= internal_zs_addr_from_the_SDRAM;
  --vhdl renameroo for output signals
  zs_ba_from_the_SDRAM <= internal_zs_ba_from_the_SDRAM;
  --vhdl renameroo for output signals
  zs_cas_n_from_the_SDRAM <= internal_zs_cas_n_from_the_SDRAM;
  --vhdl renameroo for output signals
  zs_cke_from_the_SDRAM <= internal_zs_cke_from_the_SDRAM;
  --vhdl renameroo for output signals
  zs_cs_n_from_the_SDRAM <= internal_zs_cs_n_from_the_SDRAM;
  --vhdl renameroo for output signals
  zs_dqm_from_the_SDRAM <= internal_zs_dqm_from_the_SDRAM;
  --vhdl renameroo for output signals
  zs_ras_n_from_the_SDRAM <= internal_zs_ras_n_from_the_SDRAM;
  --vhdl renameroo for output signals
  zs_we_n_from_the_SDRAM <= internal_zs_we_n_from_the_SDRAM;

end europa;


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your libraries here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>

entity test_bench is 
end entity test_bench;


architecture europa of test_bench is
component nios_system is 
           port (
                 -- 1) global signals:
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- the_Expansion_JP1
                    signal GPIO_0_to_and_from_the_Expansion_JP1 : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- the_Expansion_JP2
                    signal GPIO_1_to_and_from_the_Expansion_JP2 : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- the_Green_LEDs
                    signal LEDG_from_the_Green_LEDs : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);

                 -- the_HEX3_HEX0
                    signal HEX0_from_the_HEX3_HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal HEX1_from_the_HEX3_HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal HEX2_from_the_HEX3_HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal HEX3_from_the_HEX3_HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);

                 -- the_HEX7_HEX4
                    signal HEX4_from_the_HEX7_HEX4 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal HEX5_from_the_HEX7_HEX4 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal HEX6_from_the_HEX7_HEX4 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal HEX7_from_the_HEX7_HEX4 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);

                 -- the_Pushbuttons
                    signal KEY_to_the_Pushbuttons : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

                 -- the_Red_LEDs
                    signal LEDR_from_the_Red_LEDs : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);

                 -- the_SDRAM
                    signal zs_addr_from_the_SDRAM : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal zs_ba_from_the_SDRAM : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_cas_n_from_the_SDRAM : OUT STD_LOGIC;
                    signal zs_cke_from_the_SDRAM : OUT STD_LOGIC;
                    signal zs_cs_n_from_the_SDRAM : OUT STD_LOGIC;
                    signal zs_dq_to_and_from_the_SDRAM : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal zs_dqm_from_the_SDRAM : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_ras_n_from_the_SDRAM : OUT STD_LOGIC;
                    signal zs_we_n_from_the_SDRAM : OUT STD_LOGIC;

                 -- the_SRAM
                    signal SRAM_ADDR_from_the_SRAM : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal SRAM_CE_N_from_the_SRAM : OUT STD_LOGIC;
                    signal SRAM_DQ_to_and_from_the_SRAM : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SRAM_LB_N_from_the_SRAM : OUT STD_LOGIC;
                    signal SRAM_OE_N_from_the_SRAM : OUT STD_LOGIC;
                    signal SRAM_UB_N_from_the_SRAM : OUT STD_LOGIC;
                    signal SRAM_WE_N_from_the_SRAM : OUT STD_LOGIC;

                 -- the_Serial_port
                    signal UART_RXD_to_the_Serial_port : IN STD_LOGIC;
                    signal UART_TXD_from_the_Serial_port : OUT STD_LOGIC;

                 -- the_Slider_switches
                    signal SW_to_the_Slider_switches : IN STD_LOGIC_VECTOR (17 DOWNTO 0)
                 );
end component nios_system;

                signal GPIO_0_to_and_from_the_Expansion_JP1 :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal GPIO_1_to_and_from_the_Expansion_JP2 :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal HEX0_from_the_HEX3_HEX0 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal HEX1_from_the_HEX3_HEX0 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal HEX2_from_the_HEX3_HEX0 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal HEX3_from_the_HEX3_HEX0 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal HEX4_from_the_HEX7_HEX4 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal HEX5_from_the_HEX7_HEX4 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal HEX6_from_the_HEX7_HEX4 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal HEX7_from_the_HEX7_HEX4 :  STD_LOGIC_VECTOR (6 DOWNTO 0);
                signal JTAG_UART_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal JTAG_UART_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal KEY_to_the_Pushbuttons :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal LEDG_from_the_Green_LEDs :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal LEDR_from_the_Red_LEDs :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal SRAM_ADDR_from_the_SRAM :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal SRAM_CE_N_from_the_SRAM :  STD_LOGIC;
                signal SRAM_DQ_to_and_from_the_SRAM :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SRAM_LB_N_from_the_SRAM :  STD_LOGIC;
                signal SRAM_OE_N_from_the_SRAM :  STD_LOGIC;
                signal SRAM_UB_N_from_the_SRAM :  STD_LOGIC;
                signal SRAM_WE_N_from_the_SRAM :  STD_LOGIC;
                signal SW_to_the_Slider_switches :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal UART_RXD_to_the_Serial_port :  STD_LOGIC;
                signal UART_TXD_from_the_Serial_port :  STD_LOGIC;
                signal clk :  STD_LOGIC;
                signal reset_n :  STD_LOGIC;
                signal zs_addr_from_the_SDRAM :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal zs_ba_from_the_SDRAM :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal zs_cas_n_from_the_SDRAM :  STD_LOGIC;
                signal zs_cke_from_the_SDRAM :  STD_LOGIC;
                signal zs_cs_n_from_the_SDRAM :  STD_LOGIC;
                signal zs_dq_to_and_from_the_SDRAM :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal zs_dqm_from_the_SDRAM :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal zs_ras_n_from_the_SDRAM :  STD_LOGIC;
                signal zs_we_n_from_the_SDRAM :  STD_LOGIC;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your component and signal declaration here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


begin

  --Set us up the Dut
  DUT : nios_system
    port map(
      GPIO_0_to_and_from_the_Expansion_JP1 => GPIO_0_to_and_from_the_Expansion_JP1,
      GPIO_1_to_and_from_the_Expansion_JP2 => GPIO_1_to_and_from_the_Expansion_JP2,
      HEX0_from_the_HEX3_HEX0 => HEX0_from_the_HEX3_HEX0,
      HEX1_from_the_HEX3_HEX0 => HEX1_from_the_HEX3_HEX0,
      HEX2_from_the_HEX3_HEX0 => HEX2_from_the_HEX3_HEX0,
      HEX3_from_the_HEX3_HEX0 => HEX3_from_the_HEX3_HEX0,
      HEX4_from_the_HEX7_HEX4 => HEX4_from_the_HEX7_HEX4,
      HEX5_from_the_HEX7_HEX4 => HEX5_from_the_HEX7_HEX4,
      HEX6_from_the_HEX7_HEX4 => HEX6_from_the_HEX7_HEX4,
      HEX7_from_the_HEX7_HEX4 => HEX7_from_the_HEX7_HEX4,
      LEDG_from_the_Green_LEDs => LEDG_from_the_Green_LEDs,
      LEDR_from_the_Red_LEDs => LEDR_from_the_Red_LEDs,
      SRAM_ADDR_from_the_SRAM => SRAM_ADDR_from_the_SRAM,
      SRAM_CE_N_from_the_SRAM => SRAM_CE_N_from_the_SRAM,
      SRAM_DQ_to_and_from_the_SRAM => SRAM_DQ_to_and_from_the_SRAM,
      SRAM_LB_N_from_the_SRAM => SRAM_LB_N_from_the_SRAM,
      SRAM_OE_N_from_the_SRAM => SRAM_OE_N_from_the_SRAM,
      SRAM_UB_N_from_the_SRAM => SRAM_UB_N_from_the_SRAM,
      SRAM_WE_N_from_the_SRAM => SRAM_WE_N_from_the_SRAM,
      UART_TXD_from_the_Serial_port => UART_TXD_from_the_Serial_port,
      zs_addr_from_the_SDRAM => zs_addr_from_the_SDRAM,
      zs_ba_from_the_SDRAM => zs_ba_from_the_SDRAM,
      zs_cas_n_from_the_SDRAM => zs_cas_n_from_the_SDRAM,
      zs_cke_from_the_SDRAM => zs_cke_from_the_SDRAM,
      zs_cs_n_from_the_SDRAM => zs_cs_n_from_the_SDRAM,
      zs_dq_to_and_from_the_SDRAM => zs_dq_to_and_from_the_SDRAM,
      zs_dqm_from_the_SDRAM => zs_dqm_from_the_SDRAM,
      zs_ras_n_from_the_SDRAM => zs_ras_n_from_the_SDRAM,
      zs_we_n_from_the_SDRAM => zs_we_n_from_the_SDRAM,
      KEY_to_the_Pushbuttons => KEY_to_the_Pushbuttons,
      SW_to_the_Slider_switches => SW_to_the_Slider_switches,
      UART_RXD_to_the_Serial_port => UART_RXD_to_the_Serial_port,
      clk => clk,
      reset_n => reset_n
    );


  process
  begin
    clk <= '0';
    loop
       wait for 10 ns;
       clk <= not clk;
    end loop;
  end process;
  PROCESS
    BEGIN
       reset_n <= '0';
       wait for 200 ns;
       reset_n <= '1'; 
    WAIT;
  END PROCESS;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add additional architecture here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


end europa;



--synthesis translate_on
