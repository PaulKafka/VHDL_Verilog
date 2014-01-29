--megafunction wizard: %Altera SOPC Builder%
--GENERATION: STANDARD
--VERSION: WM1.0


--Legal Notice: (C)2013 Altera Corporation. All rights reserved.  Your
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

entity LEDS_s1_arbitrator is 
        port (
              -- inputs:
                 signal LEDS_s1_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal LEDS_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal LEDS_s1_chipselect : OUT STD_LOGIC;
                 signal LEDS_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal LEDS_s1_reset_n : OUT STD_LOGIC;
                 signal LEDS_s1_write_n : OUT STD_LOGIC;
                 signal LEDS_s1_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cpu_data_master_granted_LEDS_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_LEDS_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_LEDS_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_LEDS_s1 : OUT STD_LOGIC;
                 signal d1_LEDS_s1_end_xfer : OUT STD_LOGIC
              );
end entity LEDS_s1_arbitrator;


architecture europa of LEDS_s1_arbitrator is
                signal LEDS_s1_allgrants :  STD_LOGIC;
                signal LEDS_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal LEDS_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal LEDS_s1_any_continuerequest :  STD_LOGIC;
                signal LEDS_s1_arb_counter_enable :  STD_LOGIC;
                signal LEDS_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal LEDS_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal LEDS_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal LEDS_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal LEDS_s1_begins_xfer :  STD_LOGIC;
                signal LEDS_s1_end_xfer :  STD_LOGIC;
                signal LEDS_s1_firsttransfer :  STD_LOGIC;
                signal LEDS_s1_grant_vector :  STD_LOGIC;
                signal LEDS_s1_in_a_read_cycle :  STD_LOGIC;
                signal LEDS_s1_in_a_write_cycle :  STD_LOGIC;
                signal LEDS_s1_master_qreq_vector :  STD_LOGIC;
                signal LEDS_s1_non_bursting_master_requests :  STD_LOGIC;
                signal LEDS_s1_pretend_byte_enable :  STD_LOGIC;
                signal LEDS_s1_reg_firsttransfer :  STD_LOGIC;
                signal LEDS_s1_slavearbiterlockenable :  STD_LOGIC;
                signal LEDS_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal LEDS_s1_unreg_firsttransfer :  STD_LOGIC;
                signal LEDS_s1_waits_for_read :  STD_LOGIC;
                signal LEDS_s1_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_LEDS_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_LEDS_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_LEDS_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_LEDS_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_LEDS_s1 :  STD_LOGIC;
                signal shifted_address_to_LEDS_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_LEDS_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT LEDS_s1_end_xfer;
    end if;

  end process;

  LEDS_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_LEDS_s1);
  --assign LEDS_s1_readdata_from_sa = LEDS_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  LEDS_s1_readdata_from_sa <= LEDS_s1_readdata;
  internal_cpu_data_master_requests_LEDS_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("1100100000001000001100000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --LEDS_s1_arb_share_counter set values, which is an e_mux
  LEDS_s1_arb_share_set_values <= std_logic_vector'("001");
  --LEDS_s1_non_bursting_master_requests mux, which is an e_mux
  LEDS_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_LEDS_s1;
  --LEDS_s1_any_bursting_master_saved_grant mux, which is an e_mux
  LEDS_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --LEDS_s1_arb_share_counter_next_value assignment, which is an e_assign
  LEDS_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(LEDS_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (LEDS_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(LEDS_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (LEDS_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --LEDS_s1_allgrants all slave grants, which is an e_mux
  LEDS_s1_allgrants <= LEDS_s1_grant_vector;
  --LEDS_s1_end_xfer assignment, which is an e_assign
  LEDS_s1_end_xfer <= NOT ((LEDS_s1_waits_for_read OR LEDS_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_LEDS_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_LEDS_s1 <= LEDS_s1_end_xfer AND (((NOT LEDS_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --LEDS_s1_arb_share_counter arbitration counter enable, which is an e_assign
  LEDS_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_LEDS_s1 AND LEDS_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_LEDS_s1 AND NOT LEDS_s1_non_bursting_master_requests));
  --LEDS_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      LEDS_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(LEDS_s1_arb_counter_enable) = '1' then 
        LEDS_s1_arb_share_counter <= LEDS_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --LEDS_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      LEDS_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((LEDS_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_LEDS_s1)) OR ((end_xfer_arb_share_counter_term_LEDS_s1 AND NOT LEDS_s1_non_bursting_master_requests)))) = '1' then 
        LEDS_s1_slavearbiterlockenable <= or_reduce(LEDS_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master LEDS/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= LEDS_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --LEDS_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  LEDS_s1_slavearbiterlockenable2 <= or_reduce(LEDS_s1_arb_share_counter_next_value);
  --cpu/data_master LEDS/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= LEDS_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --LEDS_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  LEDS_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_LEDS_s1 <= internal_cpu_data_master_requests_LEDS_s1 AND NOT (((NOT cpu_data_master_waitrequest) AND cpu_data_master_write));
  --LEDS_s1_writedata mux, which is an e_mux
  LEDS_s1_writedata <= cpu_data_master_writedata (7 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_data_master_granted_LEDS_s1 <= internal_cpu_data_master_qualified_request_LEDS_s1;
  --cpu/data_master saved-grant LEDS/s1, which is an e_assign
  cpu_data_master_saved_grant_LEDS_s1 <= internal_cpu_data_master_requests_LEDS_s1;
  --allow new arb cycle for LEDS/s1, which is an e_assign
  LEDS_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  LEDS_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  LEDS_s1_master_qreq_vector <= std_logic'('1');
  --LEDS_s1_reset_n assignment, which is an e_assign
  LEDS_s1_reset_n <= reset_n;
  LEDS_s1_chipselect <= internal_cpu_data_master_granted_LEDS_s1;
  --LEDS_s1_firsttransfer first transaction, which is an e_assign
  LEDS_s1_firsttransfer <= A_WE_StdLogic((std_logic'(LEDS_s1_begins_xfer) = '1'), LEDS_s1_unreg_firsttransfer, LEDS_s1_reg_firsttransfer);
  --LEDS_s1_unreg_firsttransfer first transaction, which is an e_assign
  LEDS_s1_unreg_firsttransfer <= NOT ((LEDS_s1_slavearbiterlockenable AND LEDS_s1_any_continuerequest));
  --LEDS_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      LEDS_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(LEDS_s1_begins_xfer) = '1' then 
        LEDS_s1_reg_firsttransfer <= LEDS_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --LEDS_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  LEDS_s1_beginbursttransfer_internal <= LEDS_s1_begins_xfer;
  --~LEDS_s1_write_n assignment, which is an e_mux
  LEDS_s1_write_n <= NOT ((((internal_cpu_data_master_granted_LEDS_s1 AND cpu_data_master_write)) AND LEDS_s1_pretend_byte_enable));
  shifted_address_to_LEDS_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --LEDS_s1_address mux, which is an e_mux
  LEDS_s1_address <= A_EXT (A_SRL(shifted_address_to_LEDS_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_LEDS_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_LEDS_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_LEDS_s1_end_xfer <= LEDS_s1_end_xfer;
    end if;

  end process;

  --LEDS_s1_waits_for_read in a cycle, which is an e_mux
  LEDS_s1_waits_for_read <= LEDS_s1_in_a_read_cycle AND LEDS_s1_begins_xfer;
  --LEDS_s1_in_a_read_cycle assignment, which is an e_assign
  LEDS_s1_in_a_read_cycle <= internal_cpu_data_master_granted_LEDS_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= LEDS_s1_in_a_read_cycle;
  --LEDS_s1_waits_for_write in a cycle, which is an e_mux
  LEDS_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(LEDS_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --LEDS_s1_in_a_write_cycle assignment, which is an e_assign
  LEDS_s1_in_a_write_cycle <= internal_cpu_data_master_granted_LEDS_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= LEDS_s1_in_a_write_cycle;
  wait_for_LEDS_s1_counter <= std_logic'('0');
  --LEDS_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  LEDS_s1_pretend_byte_enable <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_LEDS_s1)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))));
  --vhdl renameroo for output signals
  cpu_data_master_granted_LEDS_s1 <= internal_cpu_data_master_granted_LEDS_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_LEDS_s1 <= internal_cpu_data_master_qualified_request_LEDS_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_LEDS_s1 <= internal_cpu_data_master_requests_LEDS_s1;
--synthesis translate_off
    --LEDS/s1 enable non-zero assertions, which is an e_register
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

entity buttons_s1_arbitrator is 
        port (
              -- inputs:
                 signal buttons_s1_irq : IN STD_LOGIC;
                 signal buttons_s1_readdata : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal buttons_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal buttons_s1_chipselect : OUT STD_LOGIC;
                 signal buttons_s1_irq_from_sa : OUT STD_LOGIC;
                 signal buttons_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal buttons_s1_reset_n : OUT STD_LOGIC;
                 signal buttons_s1_write_n : OUT STD_LOGIC;
                 signal buttons_s1_writedata : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_granted_buttons_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_buttons_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_buttons_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_buttons_s1 : OUT STD_LOGIC;
                 signal d1_buttons_s1_end_xfer : OUT STD_LOGIC
              );
end entity buttons_s1_arbitrator;


architecture europa of buttons_s1_arbitrator is
                signal buttons_s1_allgrants :  STD_LOGIC;
                signal buttons_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal buttons_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal buttons_s1_any_continuerequest :  STD_LOGIC;
                signal buttons_s1_arb_counter_enable :  STD_LOGIC;
                signal buttons_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal buttons_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal buttons_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal buttons_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal buttons_s1_begins_xfer :  STD_LOGIC;
                signal buttons_s1_end_xfer :  STD_LOGIC;
                signal buttons_s1_firsttransfer :  STD_LOGIC;
                signal buttons_s1_grant_vector :  STD_LOGIC;
                signal buttons_s1_in_a_read_cycle :  STD_LOGIC;
                signal buttons_s1_in_a_write_cycle :  STD_LOGIC;
                signal buttons_s1_master_qreq_vector :  STD_LOGIC;
                signal buttons_s1_non_bursting_master_requests :  STD_LOGIC;
                signal buttons_s1_reg_firsttransfer :  STD_LOGIC;
                signal buttons_s1_slavearbiterlockenable :  STD_LOGIC;
                signal buttons_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal buttons_s1_unreg_firsttransfer :  STD_LOGIC;
                signal buttons_s1_waits_for_read :  STD_LOGIC;
                signal buttons_s1_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_buttons_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_buttons_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_buttons_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_buttons_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_buttons_s1 :  STD_LOGIC;
                signal shifted_address_to_buttons_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_buttons_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT buttons_s1_end_xfer;
    end if;

  end process;

  buttons_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_buttons_s1);
  --assign buttons_s1_readdata_from_sa = buttons_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  buttons_s1_readdata_from_sa <= buttons_s1_readdata;
  internal_cpu_data_master_requests_buttons_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("1100100000001000001000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --buttons_s1_arb_share_counter set values, which is an e_mux
  buttons_s1_arb_share_set_values <= std_logic_vector'("001");
  --buttons_s1_non_bursting_master_requests mux, which is an e_mux
  buttons_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_buttons_s1;
  --buttons_s1_any_bursting_master_saved_grant mux, which is an e_mux
  buttons_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --buttons_s1_arb_share_counter_next_value assignment, which is an e_assign
  buttons_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(buttons_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (buttons_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(buttons_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (buttons_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --buttons_s1_allgrants all slave grants, which is an e_mux
  buttons_s1_allgrants <= buttons_s1_grant_vector;
  --buttons_s1_end_xfer assignment, which is an e_assign
  buttons_s1_end_xfer <= NOT ((buttons_s1_waits_for_read OR buttons_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_buttons_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_buttons_s1 <= buttons_s1_end_xfer AND (((NOT buttons_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --buttons_s1_arb_share_counter arbitration counter enable, which is an e_assign
  buttons_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_buttons_s1 AND buttons_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_buttons_s1 AND NOT buttons_s1_non_bursting_master_requests));
  --buttons_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      buttons_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(buttons_s1_arb_counter_enable) = '1' then 
        buttons_s1_arb_share_counter <= buttons_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --buttons_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      buttons_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((buttons_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_buttons_s1)) OR ((end_xfer_arb_share_counter_term_buttons_s1 AND NOT buttons_s1_non_bursting_master_requests)))) = '1' then 
        buttons_s1_slavearbiterlockenable <= or_reduce(buttons_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master buttons/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= buttons_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --buttons_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  buttons_s1_slavearbiterlockenable2 <= or_reduce(buttons_s1_arb_share_counter_next_value);
  --cpu/data_master buttons/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= buttons_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --buttons_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  buttons_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_buttons_s1 <= internal_cpu_data_master_requests_buttons_s1 AND NOT (((NOT cpu_data_master_waitrequest) AND cpu_data_master_write));
  --buttons_s1_writedata mux, which is an e_mux
  buttons_s1_writedata <= cpu_data_master_writedata (3 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_data_master_granted_buttons_s1 <= internal_cpu_data_master_qualified_request_buttons_s1;
  --cpu/data_master saved-grant buttons/s1, which is an e_assign
  cpu_data_master_saved_grant_buttons_s1 <= internal_cpu_data_master_requests_buttons_s1;
  --allow new arb cycle for buttons/s1, which is an e_assign
  buttons_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  buttons_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  buttons_s1_master_qreq_vector <= std_logic'('1');
  --buttons_s1_reset_n assignment, which is an e_assign
  buttons_s1_reset_n <= reset_n;
  buttons_s1_chipselect <= internal_cpu_data_master_granted_buttons_s1;
  --buttons_s1_firsttransfer first transaction, which is an e_assign
  buttons_s1_firsttransfer <= A_WE_StdLogic((std_logic'(buttons_s1_begins_xfer) = '1'), buttons_s1_unreg_firsttransfer, buttons_s1_reg_firsttransfer);
  --buttons_s1_unreg_firsttransfer first transaction, which is an e_assign
  buttons_s1_unreg_firsttransfer <= NOT ((buttons_s1_slavearbiterlockenable AND buttons_s1_any_continuerequest));
  --buttons_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      buttons_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(buttons_s1_begins_xfer) = '1' then 
        buttons_s1_reg_firsttransfer <= buttons_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --buttons_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  buttons_s1_beginbursttransfer_internal <= buttons_s1_begins_xfer;
  --~buttons_s1_write_n assignment, which is an e_mux
  buttons_s1_write_n <= NOT ((internal_cpu_data_master_granted_buttons_s1 AND cpu_data_master_write));
  shifted_address_to_buttons_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --buttons_s1_address mux, which is an e_mux
  buttons_s1_address <= A_EXT (A_SRL(shifted_address_to_buttons_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_buttons_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_buttons_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_buttons_s1_end_xfer <= buttons_s1_end_xfer;
    end if;

  end process;

  --buttons_s1_waits_for_read in a cycle, which is an e_mux
  buttons_s1_waits_for_read <= buttons_s1_in_a_read_cycle AND buttons_s1_begins_xfer;
  --buttons_s1_in_a_read_cycle assignment, which is an e_assign
  buttons_s1_in_a_read_cycle <= internal_cpu_data_master_granted_buttons_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= buttons_s1_in_a_read_cycle;
  --buttons_s1_waits_for_write in a cycle, which is an e_mux
  buttons_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(buttons_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --buttons_s1_in_a_write_cycle assignment, which is an e_assign
  buttons_s1_in_a_write_cycle <= internal_cpu_data_master_granted_buttons_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= buttons_s1_in_a_write_cycle;
  wait_for_buttons_s1_counter <= std_logic'('0');
  --assign buttons_s1_irq_from_sa = buttons_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  buttons_s1_irq_from_sa <= buttons_s1_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_buttons_s1 <= internal_cpu_data_master_granted_buttons_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_buttons_s1 <= internal_cpu_data_master_qualified_request_buttons_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_buttons_s1 <= internal_cpu_data_master_requests_buttons_s1;
--synthesis translate_off
    --buttons/s1 enable non-zero assertions, which is an e_register
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

library std;
use std.textio.all;

entity cpu_jtag_debug_module_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_debugaccess : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register : IN STD_LOGIC;
                 signal cpu_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_jtag_debug_module_resetrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_data_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal cpu_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_jtag_debug_module_chipselect : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_write : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_cpu_jtag_debug_module_end_xfer : OUT STD_LOGIC
              );
end entity cpu_jtag_debug_module_arbitrator;


architecture europa of cpu_jtag_debug_module_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_instruction_master_saved_grant_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_jtag_debug_module_allgrants :  STD_LOGIC;
                signal cpu_jtag_debug_module_allow_new_arb_cycle :  STD_LOGIC;
                signal cpu_jtag_debug_module_any_bursting_master_saved_grant :  STD_LOGIC;
                signal cpu_jtag_debug_module_any_continuerequest :  STD_LOGIC;
                signal cpu_jtag_debug_module_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_counter_enable :  STD_LOGIC;
                signal cpu_jtag_debug_module_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_arbitration_holdoff_internal :  STD_LOGIC;
                signal cpu_jtag_debug_module_beginbursttransfer_internal :  STD_LOGIC;
                signal cpu_jtag_debug_module_begins_xfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_jtag_debug_module_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_firsttransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_in_a_read_cycle :  STD_LOGIC;
                signal cpu_jtag_debug_module_in_a_write_cycle :  STD_LOGIC;
                signal cpu_jtag_debug_module_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_non_bursting_master_requests :  STD_LOGIC;
                signal cpu_jtag_debug_module_reg_firsttransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_slavearbiterlockenable :  STD_LOGIC;
                signal cpu_jtag_debug_module_slavearbiterlockenable2 :  STD_LOGIC;
                signal cpu_jtag_debug_module_unreg_firsttransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_waits_for_read :  STD_LOGIC;
                signal cpu_jtag_debug_module_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_cpu_jtag_debug_module :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_data_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_instruction_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_instruction_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module :  STD_LOGIC;
                signal shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_cpu_jtag_debug_module_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT cpu_jtag_debug_module_end_xfer;
    end if;

  end process;

  cpu_jtag_debug_module_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_data_master_qualified_request_cpu_jtag_debug_module OR internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module));
  --assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_jtag_debug_module_readdata_from_sa <= cpu_jtag_debug_module_readdata;
  internal_cpu_data_master_requests_cpu_jtag_debug_module <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("1100100000000100000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --cpu_jtag_debug_module_arb_share_counter set values, which is an e_mux
  cpu_jtag_debug_module_arb_share_set_values <= std_logic_vector'("001");
  --cpu_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  cpu_jtag_debug_module_non_bursting_master_requests <= ((internal_cpu_data_master_requests_cpu_jtag_debug_module OR internal_cpu_instruction_master_requests_cpu_jtag_debug_module) OR internal_cpu_data_master_requests_cpu_jtag_debug_module) OR internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --cpu_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  cpu_jtag_debug_module_any_bursting_master_saved_grant <= std_logic'('0');
  --cpu_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  cpu_jtag_debug_module_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(cpu_jtag_debug_module_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (cpu_jtag_debug_module_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(cpu_jtag_debug_module_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (cpu_jtag_debug_module_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --cpu_jtag_debug_module_allgrants all slave grants, which is an e_mux
  cpu_jtag_debug_module_allgrants <= (((or_reduce(cpu_jtag_debug_module_grant_vector)) OR (or_reduce(cpu_jtag_debug_module_grant_vector))) OR (or_reduce(cpu_jtag_debug_module_grant_vector))) OR (or_reduce(cpu_jtag_debug_module_grant_vector));
  --cpu_jtag_debug_module_end_xfer assignment, which is an e_assign
  cpu_jtag_debug_module_end_xfer <= NOT ((cpu_jtag_debug_module_waits_for_read OR cpu_jtag_debug_module_waits_for_write));
  --end_xfer_arb_share_counter_term_cpu_jtag_debug_module arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_cpu_jtag_debug_module <= cpu_jtag_debug_module_end_xfer AND (((NOT cpu_jtag_debug_module_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --cpu_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  cpu_jtag_debug_module_arb_counter_enable <= ((end_xfer_arb_share_counter_term_cpu_jtag_debug_module AND cpu_jtag_debug_module_allgrants)) OR ((end_xfer_arb_share_counter_term_cpu_jtag_debug_module AND NOT cpu_jtag_debug_module_non_bursting_master_requests));
  --cpu_jtag_debug_module_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_jtag_debug_module_arb_counter_enable) = '1' then 
        cpu_jtag_debug_module_arb_share_counter <= cpu_jtag_debug_module_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(cpu_jtag_debug_module_master_qreq_vector) AND end_xfer_arb_share_counter_term_cpu_jtag_debug_module)) OR ((end_xfer_arb_share_counter_term_cpu_jtag_debug_module AND NOT cpu_jtag_debug_module_non_bursting_master_requests)))) = '1' then 
        cpu_jtag_debug_module_slavearbiterlockenable <= or_reduce(cpu_jtag_debug_module_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= cpu_jtag_debug_module_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --cpu_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  cpu_jtag_debug_module_slavearbiterlockenable2 <= or_reduce(cpu_jtag_debug_module_arb_share_counter_next_value);
  --cpu/data_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= cpu_jtag_debug_module_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --cpu/instruction_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  cpu_instruction_master_arbiterlock <= cpu_jtag_debug_module_slavearbiterlockenable AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  cpu_instruction_master_arbiterlock2 <= cpu_jtag_debug_module_slavearbiterlockenable2 AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master granted cpu/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_instruction_master_saved_grant_cpu_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((cpu_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_cpu_instruction_master_requests_cpu_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module))))));
    end if;

  end process;

  --cpu_instruction_master_continuerequest continued request, which is an e_mux
  cpu_instruction_master_continuerequest <= last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module AND internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --cpu_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  cpu_jtag_debug_module_any_continuerequest <= cpu_instruction_master_continuerequest OR cpu_data_master_continuerequest;
  internal_cpu_data_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_data_master_requests_cpu_jtag_debug_module AND NOT (((((NOT cpu_data_master_waitrequest) AND cpu_data_master_write)) OR cpu_instruction_master_arbiterlock));
  --cpu_jtag_debug_module_writedata mux, which is an e_mux
  cpu_jtag_debug_module_writedata <= cpu_data_master_writedata;
  internal_cpu_instruction_master_requests_cpu_jtag_debug_module <= ((to_std_logic(((Std_Logic_Vector'(cpu_instruction_master_address_to_slave(24 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("1100100000000100000000000")))) AND (cpu_instruction_master_read))) AND cpu_instruction_master_read;
  --cpu/data_master granted cpu/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_data_master_saved_grant_cpu_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((cpu_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_cpu_data_master_requests_cpu_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module))))));
    end if;

  end process;

  --cpu_data_master_continuerequest continued request, which is an e_mux
  cpu_data_master_continuerequest <= last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module AND internal_cpu_data_master_requests_cpu_jtag_debug_module;
  internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_instruction_master_requests_cpu_jtag_debug_module AND NOT ((((cpu_instruction_master_read AND (((to_std_logic((((std_logic_vector'("000000000000000000000000000000") & (cpu_instruction_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_instruction_master_read_data_valid_sdram_s1_shift_register)) OR (cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register))))) OR cpu_data_master_arbiterlock));
  --local readdatavalid cpu_instruction_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  cpu_instruction_master_read_data_valid_cpu_jtag_debug_module <= (internal_cpu_instruction_master_granted_cpu_jtag_debug_module AND cpu_instruction_master_read) AND NOT cpu_jtag_debug_module_waits_for_read;
  --allow new arb cycle for cpu/jtag_debug_module, which is an e_assign
  cpu_jtag_debug_module_allow_new_arb_cycle <= NOT cpu_data_master_arbiterlock AND NOT cpu_instruction_master_arbiterlock;
  --cpu/instruction_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  cpu_jtag_debug_module_master_qreq_vector(0) <= internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  --cpu/instruction_master grant cpu/jtag_debug_module, which is an e_assign
  internal_cpu_instruction_master_granted_cpu_jtag_debug_module <= cpu_jtag_debug_module_grant_vector(0);
  --cpu/instruction_master saved-grant cpu/jtag_debug_module, which is an e_assign
  cpu_instruction_master_saved_grant_cpu_jtag_debug_module <= cpu_jtag_debug_module_arb_winner(0) AND internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --cpu/data_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  cpu_jtag_debug_module_master_qreq_vector(1) <= internal_cpu_data_master_qualified_request_cpu_jtag_debug_module;
  --cpu/data_master grant cpu/jtag_debug_module, which is an e_assign
  internal_cpu_data_master_granted_cpu_jtag_debug_module <= cpu_jtag_debug_module_grant_vector(1);
  --cpu/data_master saved-grant cpu/jtag_debug_module, which is an e_assign
  cpu_data_master_saved_grant_cpu_jtag_debug_module <= cpu_jtag_debug_module_arb_winner(1) AND internal_cpu_data_master_requests_cpu_jtag_debug_module;
  --cpu/jtag_debug_module chosen-master double-vector, which is an e_assign
  cpu_jtag_debug_module_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((cpu_jtag_debug_module_master_qreq_vector & cpu_jtag_debug_module_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT cpu_jtag_debug_module_master_qreq_vector & NOT cpu_jtag_debug_module_master_qreq_vector))) + (std_logic_vector'("000") & (cpu_jtag_debug_module_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  cpu_jtag_debug_module_arb_winner <= A_WE_StdLogicVector((std_logic'(((cpu_jtag_debug_module_allow_new_arb_cycle AND or_reduce(cpu_jtag_debug_module_grant_vector)))) = '1'), cpu_jtag_debug_module_grant_vector, cpu_jtag_debug_module_saved_chosen_master_vector);
  --saved cpu_jtag_debug_module_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_jtag_debug_module_allow_new_arb_cycle) = '1' then 
        cpu_jtag_debug_module_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(cpu_jtag_debug_module_grant_vector)) = '1'), cpu_jtag_debug_module_grant_vector, cpu_jtag_debug_module_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  cpu_jtag_debug_module_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((cpu_jtag_debug_module_chosen_master_double_vector(1) OR cpu_jtag_debug_module_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((cpu_jtag_debug_module_chosen_master_double_vector(0) OR cpu_jtag_debug_module_chosen_master_double_vector(2)))));
  --cpu/jtag_debug_module chosen master rotated left, which is an e_assign
  cpu_jtag_debug_module_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(cpu_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(cpu_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --cpu/jtag_debug_module's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(cpu_jtag_debug_module_grant_vector)) = '1' then 
        cpu_jtag_debug_module_arb_addend <= A_WE_StdLogicVector((std_logic'(cpu_jtag_debug_module_end_xfer) = '1'), cpu_jtag_debug_module_chosen_master_rot_left, cpu_jtag_debug_module_grant_vector);
      end if;
    end if;

  end process;

  cpu_jtag_debug_module_begintransfer <= cpu_jtag_debug_module_begins_xfer;
  --assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_jtag_debug_module_resetrequest_from_sa <= cpu_jtag_debug_module_resetrequest;
  cpu_jtag_debug_module_chipselect <= internal_cpu_data_master_granted_cpu_jtag_debug_module OR internal_cpu_instruction_master_granted_cpu_jtag_debug_module;
  --cpu_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  cpu_jtag_debug_module_firsttransfer <= A_WE_StdLogic((std_logic'(cpu_jtag_debug_module_begins_xfer) = '1'), cpu_jtag_debug_module_unreg_firsttransfer, cpu_jtag_debug_module_reg_firsttransfer);
  --cpu_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  cpu_jtag_debug_module_unreg_firsttransfer <= NOT ((cpu_jtag_debug_module_slavearbiterlockenable AND cpu_jtag_debug_module_any_continuerequest));
  --cpu_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_jtag_debug_module_begins_xfer) = '1' then 
        cpu_jtag_debug_module_reg_firsttransfer <= cpu_jtag_debug_module_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --cpu_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  cpu_jtag_debug_module_beginbursttransfer_internal <= cpu_jtag_debug_module_begins_xfer;
  --cpu_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  cpu_jtag_debug_module_arbitration_holdoff_internal <= cpu_jtag_debug_module_begins_xfer AND cpu_jtag_debug_module_firsttransfer;
  --cpu_jtag_debug_module_write assignment, which is an e_mux
  cpu_jtag_debug_module_write <= internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_write;
  shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --cpu_jtag_debug_module_address mux, which is an e_mux
  cpu_jtag_debug_module_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_cpu_jtag_debug_module)) = '1'), (A_SRL(shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010"))), (A_SRL(shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master,std_logic_vector'("00000000000000000000000000000010")))), 9);
  shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master <= cpu_instruction_master_address_to_slave;
  --d1_cpu_jtag_debug_module_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_cpu_jtag_debug_module_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_cpu_jtag_debug_module_end_xfer <= cpu_jtag_debug_module_end_xfer;
    end if;

  end process;

  --cpu_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  cpu_jtag_debug_module_waits_for_read <= cpu_jtag_debug_module_in_a_read_cycle AND cpu_jtag_debug_module_begins_xfer;
  --cpu_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  cpu_jtag_debug_module_in_a_read_cycle <= ((internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_cpu_jtag_debug_module AND cpu_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= cpu_jtag_debug_module_in_a_read_cycle;
  --cpu_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  cpu_jtag_debug_module_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --cpu_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  cpu_jtag_debug_module_in_a_write_cycle <= internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= cpu_jtag_debug_module_in_a_write_cycle;
  wait_for_cpu_jtag_debug_module_counter <= std_logic'('0');
  --cpu_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  cpu_jtag_debug_module_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_cpu_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --debugaccess mux, which is an e_mux
  cpu_jtag_debug_module_debugaccess <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_cpu_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_debugaccess))), std_logic_vector'("00000000000000000000000000000000")));
  --vhdl renameroo for output signals
  cpu_data_master_granted_cpu_jtag_debug_module <= internal_cpu_data_master_granted_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_data_master_qualified_request_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_data_master_requests_cpu_jtag_debug_module <= internal_cpu_data_master_requests_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_instruction_master_granted_cpu_jtag_debug_module <= internal_cpu_instruction_master_granted_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_instruction_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_instruction_master_requests_cpu_jtag_debug_module <= internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
--synthesis translate_off
    --cpu/jtag_debug_module enable non-zero assertions, which is an e_register
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
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_granted_cpu_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_instruction_master_granted_cpu_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
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
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_data_master_saved_grant_cpu_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_saved_grant_cpu_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
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

entity cpu_custom_instruction_master_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_bitswap_s1_result_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_custom_instruction_master_combo_n : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_result_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_bitswap_s1_select : OUT STD_LOGIC;
                 signal cpu_custom_instruction_master_combo_result : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_custom_instruction_master_reset_n : OUT STD_LOGIC;
                 signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_select : OUT STD_LOGIC
              );
end entity cpu_custom_instruction_master_arbitrator;


architecture europa of cpu_custom_instruction_master_arbitrator is
                signal internal_cpu_bitswap_s1_select :  STD_LOGIC;
                signal internal_cpu_custominstruction_inst_nios_custom_instruction_slave_0_select :  STD_LOGIC;

begin

  internal_cpu_bitswap_s1_select <= to_std_logic((std_logic'(cpu_custom_instruction_master_combo_n(0)) = std_logic'(std_logic'('0'))));
  internal_cpu_custominstruction_inst_nios_custom_instruction_slave_0_select <= to_std_logic((std_logic'(cpu_custom_instruction_master_combo_n(0)) = std_logic'(std_logic'('1'))));
  --cpu_custom_instruction_master_combo_result mux, which is an e_mux
  cpu_custom_instruction_master_combo_result <= ((A_REP(internal_cpu_bitswap_s1_select, 32) AND cpu_bitswap_s1_result_from_sa)) OR ((A_REP(internal_cpu_custominstruction_inst_nios_custom_instruction_slave_0_select, 32) AND cpu_custominstruction_inst_nios_custom_instruction_slave_0_result_from_sa));
  --cpu_custom_instruction_master_reset_n local reset_n, which is an e_assign
  cpu_custom_instruction_master_reset_n <= reset_n;
  --vhdl renameroo for output signals
  cpu_bitswap_s1_select <= internal_cpu_bitswap_s1_select;
  --vhdl renameroo for output signals
  cpu_custominstruction_inst_nios_custom_instruction_slave_0_select <= internal_cpu_custominstruction_inst_nios_custom_instruction_slave_0_select;

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

entity cpu_data_master_arbitrator is 
        port (
              -- inputs:
                 signal LEDS_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal buttons_s1_irq_from_sa : IN STD_LOGIC;
                 signal buttons_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable_flash_s1 : IN STD_LOGIC;
                 signal cpu_data_master_byteenable_sdram_s1 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_byteenable_sram_avalon_sram_slave : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_granted_LEDS_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_buttons_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_granted_flash_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_lcd_control_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_sdram_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_sram_avalon_sram_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_switches_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_timer_s1 : IN STD_LOGIC;
                 signal cpu_data_master_granted_uart_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_LEDS_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_buttons_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_flash_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_lcd_control_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_sdram_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_sram_avalon_sram_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_switches_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_timer_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_uart_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_LEDS_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_buttons_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_flash_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_lcd_control_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sdram_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sram_avalon_sram_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_switches_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_timer_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_uart_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_LEDS_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_buttons_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_requests_flash_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_lcd_control_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_sdram_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_sram_avalon_sram_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_switches_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_timer_s1 : IN STD_LOGIC;
                 signal cpu_data_master_requests_uart_s1 : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_LEDS_s1_end_xfer : IN STD_LOGIC;
                 signal d1_buttons_s1_end_xfer : IN STD_LOGIC;
                 signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_ext_bus_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_jtag_uart_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                 signal d1_lcd_control_slave_end_xfer : IN STD_LOGIC;
                 signal d1_sdram_s1_end_xfer : IN STD_LOGIC;
                 signal d1_sram_avalon_sram_slave_end_xfer : IN STD_LOGIC;
                 signal d1_switches_s1_end_xfer : IN STD_LOGIC;
                 signal d1_timer_s1_end_xfer : IN STD_LOGIC;
                 signal d1_uart_s1_end_xfer : IN STD_LOGIC;
                 signal flash_s1_wait_counter_eq_0 : IN STD_LOGIC;
                 signal flash_s1_wait_counter_eq_1 : IN STD_LOGIC;
                 signal incoming_data_to_and_from_the_flash_with_Xs_converted_to_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                 signal lcd_control_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal lcd_control_slave_wait_counter_eq_0 : IN STD_LOGIC;
                 signal lcd_control_slave_wait_counter_eq_1 : IN STD_LOGIC;
                 signal registered_cpu_data_master_read_data_valid_flash_s1 : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_s1_waitrequest_from_sa : IN STD_LOGIC;
                 signal sram_avalon_sram_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal switches_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal timer_s1_irq_from_sa : IN STD_LOGIC;
                 signal timer_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal uart_s1_irq_from_sa : IN STD_LOGIC;
                 signal uart_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal cpu_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_dbs_write_8 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cpu_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_no_byte_enables_and_last_term : OUT STD_LOGIC;
                 signal cpu_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_waitrequest : OUT STD_LOGIC
              );
end entity cpu_data_master_arbitrator;


architecture europa of cpu_data_master_arbitrator is
                signal cpu_data_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_run :  STD_LOGIC;
                signal dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_8_reg_segment_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_8_reg_segment_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_8_reg_segment_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal internal_cpu_data_master_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal internal_cpu_data_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_data_master_no_byte_enables_and_last_term :  STD_LOGIC;
                signal internal_cpu_data_master_waitrequest :  STD_LOGIC;
                signal last_dbs_term_and_run :  STD_LOGIC;
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal p1_dbs_8_reg_segment_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_8_reg_segment_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_8_reg_segment_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_registered_cpu_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;
                signal r_2 :  STD_LOGIC;
                signal registered_cpu_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_LEDS_s1 OR NOT cpu_data_master_requests_LEDS_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_LEDS_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_LEDS_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_buttons_s1 OR NOT cpu_data_master_requests_buttons_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_buttons_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_buttons_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_data_master_requests_cpu_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_granted_cpu_jtag_debug_module OR NOT cpu_data_master_qualified_request_cpu_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((((cpu_data_master_qualified_request_flash_s1 OR (((registered_cpu_data_master_read_data_valid_flash_s1 AND internal_cpu_data_master_dbs_address(1)) AND internal_cpu_data_master_dbs_address(0)))) OR ((((cpu_data_master_write AND NOT(cpu_data_master_byteenable_flash_s1)) AND internal_cpu_data_master_dbs_address(1)) AND internal_cpu_data_master_dbs_address(0)))) OR NOT cpu_data_master_requests_flash_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_granted_flash_s1 OR NOT cpu_data_master_qualified_request_flash_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT cpu_data_master_qualified_request_flash_s1 OR NOT cpu_data_master_read) OR (((registered_cpu_data_master_read_data_valid_flash_s1 AND ((internal_cpu_data_master_dbs_address(1) AND internal_cpu_data_master_dbs_address(0)))) AND cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_flash_s1 OR NOT cpu_data_master_write)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(flash_s1_wait_counter_eq_1)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((internal_cpu_data_master_dbs_address(1) AND internal_cpu_data_master_dbs_address(0))))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave OR NOT cpu_data_master_requests_jtag_uart_avalon_jtag_slave)))))));
  --cascaded wait assignment, which is an e_assign
  cpu_data_master_run <= (r_0 AND r_1) AND r_2;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic(((((((((((((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT jtag_uart_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT jtag_uart_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_lcd_control_slave OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(lcd_control_slave_wait_counter_eq_1)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_lcd_control_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(lcd_control_slave_wait_counter_eq_1)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((((cpu_data_master_qualified_request_sdram_s1 OR ((cpu_data_master_read_data_valid_sdram_s1 AND internal_cpu_data_master_dbs_address(1)))) OR (((cpu_data_master_write AND NOT(or_reduce(cpu_data_master_byteenable_sdram_s1))) AND internal_cpu_data_master_dbs_address(1)))) OR NOT cpu_data_master_requests_sdram_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_granted_sdram_s1 OR NOT cpu_data_master_qualified_request_sdram_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT cpu_data_master_qualified_request_sdram_s1 OR NOT cpu_data_master_read) OR (((cpu_data_master_read_data_valid_sdram_s1 AND (internal_cpu_data_master_dbs_address(1))) AND cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_sdram_s1 OR NOT cpu_data_master_write)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((((cpu_data_master_qualified_request_sram_avalon_sram_slave OR ((cpu_data_master_read_data_valid_sram_avalon_sram_slave AND internal_cpu_data_master_dbs_address(1)))) OR (((cpu_data_master_write AND NOT(or_reduce(cpu_data_master_byteenable_sram_avalon_sram_slave))) AND internal_cpu_data_master_dbs_address(1)))) OR NOT cpu_data_master_requests_sram_avalon_sram_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_granted_sram_avalon_sram_slave OR NOT cpu_data_master_qualified_request_sram_avalon_sram_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT cpu_data_master_qualified_request_sram_avalon_sram_slave OR NOT cpu_data_master_read) OR (((cpu_data_master_read_data_valid_sram_avalon_sram_slave AND (internal_cpu_data_master_dbs_address(1))) AND cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_sram_avalon_sram_slave OR NOT cpu_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_switches_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_switches_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_timer_s1 OR NOT cpu_data_master_requests_timer_s1)))))));
  --r_2 master_run cascaded wait assignment, which is an e_assign
  r_2 <= Vector_To_Std_Logic((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_timer_s1 OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_timer_s1 OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_uart_s1 OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_uart_s1 OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_cpu_data_master_address_to_slave <= cpu_data_master_address(24 DOWNTO 0);
  --cpu/data_master readdata mux, which is an e_mux
  cpu_data_master_readdata <= (((((((((((A_REP(NOT cpu_data_master_requests_LEDS_s1, 32) OR (std_logic_vector'("000000000000000000000000") & (LEDS_s1_readdata_from_sa)))) AND ((A_REP(NOT cpu_data_master_requests_buttons_s1, 32) OR (std_logic_vector'("0000000000000000000000000000") & (buttons_s1_readdata_from_sa))))) AND ((A_REP(NOT cpu_data_master_requests_cpu_jtag_debug_module, 32) OR cpu_jtag_debug_module_readdata_from_sa))) AND ((A_REP(NOT cpu_data_master_requests_flash_s1, 32) OR Std_Logic_Vector'(incoming_data_to_and_from_the_flash_with_Xs_converted_to_0(7 DOWNTO 0) & dbs_8_reg_segment_2 & dbs_8_reg_segment_1 & dbs_8_reg_segment_0)))) AND ((A_REP(NOT cpu_data_master_requests_jtag_uart_avalon_jtag_slave, 32) OR registered_cpu_data_master_readdata))) AND ((A_REP(NOT cpu_data_master_requests_lcd_control_slave, 32) OR (std_logic_vector'("000000000000000000000000") & (lcd_control_slave_readdata_from_sa))))) AND ((A_REP(NOT cpu_data_master_requests_sdram_s1, 32) OR registered_cpu_data_master_readdata))) AND ((A_REP(NOT cpu_data_master_requests_sram_avalon_sram_slave, 32) OR registered_cpu_data_master_readdata))) AND ((A_REP(NOT cpu_data_master_requests_switches_s1, 32) OR (std_logic_vector'("000000000000000000000000") & (switches_s1_readdata_from_sa))))) AND ((A_REP(NOT cpu_data_master_requests_timer_s1, 32) OR (std_logic_vector'("0000000000000000") & (timer_s1_readdata_from_sa))))) AND ((A_REP(NOT cpu_data_master_requests_uart_s1, 32) OR (std_logic_vector'("0000000000000000") & (uart_s1_readdata_from_sa))));
  --actual waitrequest port, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_data_master_waitrequest <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      internal_cpu_data_master_waitrequest <= Vector_To_Std_Logic(NOT (A_WE_StdLogicVector((std_logic'((NOT ((cpu_data_master_read OR cpu_data_master_write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_run AND internal_cpu_data_master_waitrequest))))))));
    end if;

  end process;

  --irq assign, which is an e_assign
  cpu_data_master_irq <= Std_Logic_Vector'(A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(buttons_s1_irq_from_sa) & A_ToStdLogicVector(timer_s1_irq_from_sa) & A_ToStdLogicVector(uart_s1_irq_from_sa) & A_ToStdLogicVector(jtag_uart_avalon_jtag_slave_irq_from_sa));
  --no_byte_enables_and_last_term, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_data_master_no_byte_enables_and_last_term <= std_logic'('0');
    elsif clk'event and clk = '1' then
      internal_cpu_data_master_no_byte_enables_and_last_term <= last_dbs_term_and_run;
    end if;

  end process;

  --compute the last dbs term, which is an e_mux
  last_dbs_term_and_run <= A_WE_StdLogic((std_logic'((cpu_data_master_requests_flash_s1)) = '1'), (((to_std_logic(((internal_cpu_data_master_dbs_address = std_logic_vector'("11")))) AND cpu_data_master_write) AND NOT(cpu_data_master_byteenable_flash_s1))), A_WE_StdLogic((std_logic'((cpu_data_master_requests_sdram_s1)) = '1'), (((to_std_logic(((internal_cpu_data_master_dbs_address = std_logic_vector'("10")))) AND cpu_data_master_write) AND NOT(or_reduce(cpu_data_master_byteenable_sdram_s1)))), (((to_std_logic(((internal_cpu_data_master_dbs_address = std_logic_vector'("10")))) AND cpu_data_master_write) AND NOT(or_reduce(cpu_data_master_byteenable_sram_avalon_sram_slave))))));
  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic(((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((((((NOT internal_cpu_data_master_no_byte_enables_and_last_term) AND cpu_data_master_requests_flash_s1) AND cpu_data_master_write) AND NOT(cpu_data_master_byteenable_flash_s1))) OR cpu_data_master_read_data_valid_flash_s1)))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_data_master_granted_flash_s1 AND cpu_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((flash_s1_wait_counter_eq_0 AND NOT d1_ext_bus_avalon_slave_end_xfer)))))))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((((NOT internal_cpu_data_master_no_byte_enables_and_last_term) AND cpu_data_master_requests_sdram_s1) AND cpu_data_master_write) AND NOT(or_reduce(cpu_data_master_byteenable_sdram_s1)))))))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read_data_valid_sdram_s1)))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_data_master_granted_sdram_s1 AND cpu_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_s1_waitrequest_from_sa)))))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((((NOT internal_cpu_data_master_no_byte_enables_and_last_term) AND cpu_data_master_requests_sram_avalon_sram_slave) AND cpu_data_master_write) AND NOT(or_reduce(cpu_data_master_byteenable_sram_avalon_sram_slave)))))))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read_data_valid_sram_avalon_sram_slave)))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_data_master_granted_sram_avalon_sram_slave AND cpu_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))));
  --input to dbs-8 stored 0, which is an e_mux
  p1_dbs_8_reg_segment_0 <= incoming_data_to_and_from_the_flash_with_Xs_converted_to_0;
  --dbs register for dbs-8 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_8_reg_segment_0 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((internal_cpu_data_master_dbs_address(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_8_reg_segment_0 <= p1_dbs_8_reg_segment_0;
      end if;
    end if;

  end process;

  --input to dbs-8 stored 1, which is an e_mux
  p1_dbs_8_reg_segment_1 <= incoming_data_to_and_from_the_flash_with_Xs_converted_to_0;
  --dbs register for dbs-8 segment 1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_8_reg_segment_1 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((internal_cpu_data_master_dbs_address(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000001")))))) = '1' then 
        dbs_8_reg_segment_1 <= p1_dbs_8_reg_segment_1;
      end if;
    end if;

  end process;

  --input to dbs-8 stored 2, which is an e_mux
  p1_dbs_8_reg_segment_2 <= incoming_data_to_and_from_the_flash_with_Xs_converted_to_0;
  --dbs register for dbs-8 segment 2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_8_reg_segment_2 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((internal_cpu_data_master_dbs_address(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000010")))))) = '1' then 
        dbs_8_reg_segment_2 <= p1_dbs_8_reg_segment_2;
      end if;
    end if;

  end process;

  --mux write dbs 2, which is an e_mux
  cpu_data_master_dbs_write_8 <= A_WE_StdLogicVector((((std_logic_vector'("000000000000000000000000000000") & (internal_cpu_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_data_master_writedata(7 DOWNTO 0), A_WE_StdLogicVector((((std_logic_vector'("000000000000000000000000000000") & (internal_cpu_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000001"))), cpu_data_master_writedata(15 DOWNTO 8), A_WE_StdLogicVector((((std_logic_vector'("000000000000000000000000000000") & (internal_cpu_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000010"))), cpu_data_master_writedata(23 DOWNTO 16), cpu_data_master_writedata(31 DOWNTO 24))));
  --dbs count increment, which is an e_mux
  cpu_data_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_data_master_requests_flash_s1)) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((cpu_data_master_requests_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((cpu_data_master_requests_sram_avalon_sram_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000000")))), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_cpu_data_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_cpu_data_master_dbs_address)) + (std_logic_vector'("0") & (cpu_data_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= (pre_dbs_count_enable AND (NOT ((cpu_data_master_requests_sdram_s1 AND NOT internal_cpu_data_master_waitrequest)))) AND (NOT ((cpu_data_master_requests_sram_avalon_sram_slave AND NOT internal_cpu_data_master_waitrequest)));
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_data_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_cpu_data_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --unpredictable registered wait state incoming data, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      registered_cpu_data_master_readdata <= std_logic_vector'("00000000000000000000000000000000");
    elsif clk'event and clk = '1' then
      registered_cpu_data_master_readdata <= p1_registered_cpu_data_master_readdata;
    end if;

  end process;

  --registered readdata mux, which is an e_mux
  p1_registered_cpu_data_master_readdata <= (((A_REP(NOT cpu_data_master_requests_jtag_uart_avalon_jtag_slave, 32) OR jtag_uart_avalon_jtag_slave_readdata_from_sa)) AND ((A_REP(NOT cpu_data_master_requests_sdram_s1, 32) OR Std_Logic_Vector'(sdram_s1_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0)))) AND ((A_REP(NOT cpu_data_master_requests_sram_avalon_sram_slave, 32) OR Std_Logic_Vector'(sram_avalon_sram_slave_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0)));
  --input to dbs-16 stored 0, which is an e_mux
  p1_dbs_16_reg_segment_0 <= A_WE_StdLogicVector((std_logic'((cpu_data_master_requests_sdram_s1)) = '1'), sdram_s1_readdata_from_sa, sram_avalon_sram_slave_readdata_from_sa);
  --dbs register for dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_data_master_dbs_address(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
      end if;
    end if;

  end process;

  --mux write dbs 1, which is an e_mux
  cpu_data_master_dbs_write_16 <= A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_dbs_address(1))) = '1'), cpu_data_master_writedata(31 DOWNTO 16), A_WE_StdLogicVector((std_logic'((NOT (internal_cpu_data_master_dbs_address(1)))) = '1'), cpu_data_master_writedata(15 DOWNTO 0), A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_dbs_address(1))) = '1'), cpu_data_master_writedata(31 DOWNTO 16), cpu_data_master_writedata(15 DOWNTO 0))));
  --vhdl renameroo for output signals
  cpu_data_master_address_to_slave <= internal_cpu_data_master_address_to_slave;
  --vhdl renameroo for output signals
  cpu_data_master_dbs_address <= internal_cpu_data_master_dbs_address;
  --vhdl renameroo for output signals
  cpu_data_master_no_byte_enables_and_last_term <= internal_cpu_data_master_no_byte_enables_and_last_term;
  --vhdl renameroo for output signals
  cpu_data_master_waitrequest <= internal_cpu_data_master_waitrequest;

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

entity cpu_instruction_master_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_instruction_master_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_instruction_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_granted_flash_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_granted_sdram_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_granted_sram_avalon_sram_slave : IN STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_flash_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_sdram_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_sram_avalon_sram_slave : IN STD_LOGIC;
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_flash_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sdram_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register : IN STD_LOGIC;
                 signal cpu_instruction_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_requests_flash_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_requests_sdram_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_requests_sram_avalon_sram_slave : IN STD_LOGIC;
                 signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_ext_bus_avalon_slave_end_xfer : IN STD_LOGIC;
                 signal d1_sdram_s1_end_xfer : IN STD_LOGIC;
                 signal d1_sram_avalon_sram_slave_end_xfer : IN STD_LOGIC;
                 signal flash_s1_wait_counter_eq_0 : IN STD_LOGIC;
                 signal flash_s1_wait_counter_eq_1 : IN STD_LOGIC;
                 signal incoming_data_to_and_from_the_flash : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_s1_waitrequest_from_sa : IN STD_LOGIC;
                 signal sram_avalon_sram_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal cpu_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_instruction_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_instruction_master_readdatavalid : OUT STD_LOGIC;
                 signal cpu_instruction_master_waitrequest : OUT STD_LOGIC
              );
end entity cpu_instruction_master_arbitrator;


architecture europa of cpu_instruction_master_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal cpu_instruction_master_address_last_time :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_instruction_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_dbs_rdv_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_dbs_rdv_counter_inc :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_is_granted_some_slave :  STD_LOGIC;
                signal cpu_instruction_master_next_dbs_rdv_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_read_but_no_slave_selected :  STD_LOGIC;
                signal cpu_instruction_master_read_last_time :  STD_LOGIC;
                signal cpu_instruction_master_run :  STD_LOGIC;
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal dbs_latent_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_latent_8_reg_segment_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_latent_8_reg_segment_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_latent_8_reg_segment_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_rdv_count_enable :  STD_LOGIC;
                signal dbs_rdv_counter_overflow :  STD_LOGIC;
                signal internal_cpu_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal internal_cpu_instruction_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_instruction_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_instruction_master_waitrequest :  STD_LOGIC;
                signal latency_load_value :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_cpu_instruction_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_dbs_latent_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal p1_dbs_latent_8_reg_segment_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_latent_8_reg_segment_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_latent_8_reg_segment_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal pre_flush_cpu_instruction_master_readdatavalid :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_instruction_master_requests_cpu_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_granted_cpu_jtag_debug_module OR NOT cpu_instruction_master_qualified_request_cpu_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_instruction_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_instruction_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_cpu_jtag_debug_module_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_read)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_qualified_request_flash_s1 OR NOT cpu_instruction_master_requests_flash_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_granted_flash_s1 OR NOT cpu_instruction_master_qualified_request_flash_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_instruction_master_qualified_request_flash_s1 OR NOT cpu_instruction_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((flash_s1_wait_counter_eq_0 AND NOT d1_ext_bus_avalon_slave_end_xfer)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((internal_cpu_instruction_master_dbs_address(1) AND internal_cpu_instruction_master_dbs_address(0))))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_read)))))))));
  --cascaded wait assignment, which is an e_assign
  cpu_instruction_master_run <= r_0 AND r_1;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_qualified_request_sdram_s1 OR NOT cpu_instruction_master_requests_sdram_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_granted_sdram_s1 OR NOT cpu_instruction_master_qualified_request_sdram_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_instruction_master_qualified_request_sdram_s1 OR NOT cpu_instruction_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_instruction_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_read)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_qualified_request_sram_avalon_sram_slave OR NOT cpu_instruction_master_requests_sram_avalon_sram_slave)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_granted_sram_avalon_sram_slave OR NOT cpu_instruction_master_qualified_request_sram_avalon_sram_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_instruction_master_qualified_request_sram_avalon_sram_slave OR NOT cpu_instruction_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_instruction_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_read)))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_cpu_instruction_master_address_to_slave <= cpu_instruction_master_address(24 DOWNTO 0);
  --cpu_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_instruction_master_read_but_no_slave_selected <= std_logic'('0');
    elsif clk'event and clk = '1' then
      cpu_instruction_master_read_but_no_slave_selected <= (cpu_instruction_master_read AND cpu_instruction_master_run) AND NOT cpu_instruction_master_is_granted_some_slave;
    end if;

  end process;

  --some slave is getting selected, which is an e_mux
  cpu_instruction_master_is_granted_some_slave <= ((cpu_instruction_master_granted_cpu_jtag_debug_module OR cpu_instruction_master_granted_flash_s1) OR cpu_instruction_master_granted_sdram_s1) OR cpu_instruction_master_granted_sram_avalon_sram_slave;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_cpu_instruction_master_readdatavalid <= (((cpu_instruction_master_read_data_valid_flash_s1 AND dbs_rdv_counter_overflow)) OR ((cpu_instruction_master_read_data_valid_sdram_s1 AND dbs_rdv_counter_overflow))) OR ((cpu_instruction_master_read_data_valid_sram_avalon_sram_slave AND dbs_rdv_counter_overflow));
  --latent slave read data valid which is not flushed, which is an e_mux
  cpu_instruction_master_readdatavalid <= (((((((cpu_instruction_master_read_but_no_slave_selected OR pre_flush_cpu_instruction_master_readdatavalid) OR cpu_instruction_master_read_data_valid_cpu_jtag_debug_module) OR cpu_instruction_master_read_but_no_slave_selected) OR pre_flush_cpu_instruction_master_readdatavalid) OR cpu_instruction_master_read_but_no_slave_selected) OR pre_flush_cpu_instruction_master_readdatavalid) OR cpu_instruction_master_read_but_no_slave_selected) OR pre_flush_cpu_instruction_master_readdatavalid;
  --cpu/instruction_master readdata mux, which is an e_mux
  cpu_instruction_master_readdata <= ((((A_REP(NOT ((cpu_instruction_master_qualified_request_cpu_jtag_debug_module AND cpu_instruction_master_read)) , 32) OR cpu_jtag_debug_module_readdata_from_sa)) AND ((A_REP(NOT cpu_instruction_master_read_data_valid_flash_s1, 32) OR Std_Logic_Vector'(incoming_data_to_and_from_the_flash(7 DOWNTO 0) & dbs_latent_8_reg_segment_2 & dbs_latent_8_reg_segment_1 & dbs_latent_8_reg_segment_0)))) AND ((A_REP(NOT cpu_instruction_master_read_data_valid_sdram_s1, 32) OR Std_Logic_Vector'(sdram_s1_readdata_from_sa(15 DOWNTO 0) & dbs_latent_16_reg_segment_0)))) AND ((A_REP(NOT cpu_instruction_master_read_data_valid_sram_avalon_sram_slave, 32) OR Std_Logic_Vector'(sram_avalon_sram_slave_readdata_from_sa(15 DOWNTO 0) & dbs_latent_16_reg_segment_0)));
  --actual waitrequest port, which is an e_assign
  internal_cpu_instruction_master_waitrequest <= NOT cpu_instruction_master_run;
  --latent max counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_instruction_master_latency_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      internal_cpu_instruction_master_latency_counter <= p1_cpu_instruction_master_latency_counter;
    end if;

  end process;

  --latency counter load mux, which is an e_mux
  p1_cpu_instruction_master_latency_counter <= A_EXT (A_WE_StdLogicVector((std_logic'(((cpu_instruction_master_run AND cpu_instruction_master_read))) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (latency_load_value)), A_WE_StdLogicVector((((internal_cpu_instruction_master_latency_counter)) /= std_logic_vector'("00")), ((std_logic_vector'("0000000000000000000000000000000") & (internal_cpu_instruction_master_latency_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))), 2);
  --read latency load values, which is an e_mux
  latency_load_value <= A_EXT (((std_logic_vector'("000000000000000000000000000000") & (A_REP(cpu_instruction_master_requests_flash_s1, 2))) AND std_logic_vector'("00000000000000000000000000000010")), 2);
  --input to latent dbs-8 stored 0, which is an e_mux
  p1_dbs_latent_8_reg_segment_0 <= incoming_data_to_and_from_the_flash;
  --dbs register for latent dbs-8 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_8_reg_segment_0 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((cpu_instruction_master_dbs_rdv_counter(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_latent_8_reg_segment_0 <= p1_dbs_latent_8_reg_segment_0;
      end if;
    end if;

  end process;

  --input to latent dbs-8 stored 1, which is an e_mux
  p1_dbs_latent_8_reg_segment_1 <= incoming_data_to_and_from_the_flash;
  --dbs register for latent dbs-8 segment 1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_8_reg_segment_1 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((cpu_instruction_master_dbs_rdv_counter(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000001")))))) = '1' then 
        dbs_latent_8_reg_segment_1 <= p1_dbs_latent_8_reg_segment_1;
      end if;
    end if;

  end process;

  --input to latent dbs-8 stored 2, which is an e_mux
  p1_dbs_latent_8_reg_segment_2 <= incoming_data_to_and_from_the_flash;
  --dbs register for latent dbs-8 segment 2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_8_reg_segment_2 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((cpu_instruction_master_dbs_rdv_counter(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000010")))))) = '1' then 
        dbs_latent_8_reg_segment_2 <= p1_dbs_latent_8_reg_segment_2;
      end if;
    end if;

  end process;

  --dbs count increment, which is an e_mux
  cpu_instruction_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_instruction_master_requests_flash_s1)) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((cpu_instruction_master_requests_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((cpu_instruction_master_requests_sram_avalon_sram_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000000")))), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_cpu_instruction_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_cpu_instruction_master_dbs_address)) + (std_logic_vector'("0") & (cpu_instruction_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= pre_dbs_count_enable;
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_instruction_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_cpu_instruction_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --p1 dbs rdv counter, which is an e_assign
  cpu_instruction_master_next_dbs_rdv_counter <= A_EXT (((std_logic_vector'("0") & (cpu_instruction_master_dbs_rdv_counter)) + (std_logic_vector'("0") & (cpu_instruction_master_dbs_rdv_counter_inc))), 2);
  --cpu_instruction_master_rdv_inc_mux, which is an e_mux
  cpu_instruction_master_dbs_rdv_counter_inc <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_instruction_master_read_data_valid_flash_s1)) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((cpu_instruction_master_read_data_valid_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000010"))), 2);
  --master any slave rdv, which is an e_mux
  dbs_rdv_count_enable <= (cpu_instruction_master_read_data_valid_flash_s1 OR cpu_instruction_master_read_data_valid_sdram_s1) OR cpu_instruction_master_read_data_valid_sram_avalon_sram_slave;
  --dbs rdv counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_instruction_master_dbs_rdv_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_rdv_count_enable) = '1' then 
        cpu_instruction_master_dbs_rdv_counter <= cpu_instruction_master_next_dbs_rdv_counter;
      end if;
    end if;

  end process;

  --dbs rdv counter overflow, which is an e_assign
  dbs_rdv_counter_overflow <= cpu_instruction_master_dbs_rdv_counter(1) AND NOT cpu_instruction_master_next_dbs_rdv_counter(1);
  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_instruction_master_granted_flash_s1 AND cpu_instruction_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((flash_s1_wait_counter_eq_0 AND NOT d1_ext_bus_avalon_slave_end_xfer))))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_instruction_master_granted_sdram_s1 AND cpu_instruction_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_s1_waitrequest_from_sa)))))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_instruction_master_granted_sram_avalon_sram_slave AND cpu_instruction_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))));
  --input to latent dbs-16 stored 0, which is an e_mux
  p1_dbs_latent_16_reg_segment_0 <= A_WE_StdLogicVector((std_logic'((cpu_instruction_master_read_data_valid_sdram_s1)) = '1'), sdram_s1_readdata_from_sa, sram_avalon_sram_slave_readdata_from_sa);
  --dbs register for latent dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_instruction_master_dbs_rdv_counter(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
      end if;
    end if;

  end process;

  --vhdl renameroo for output signals
  cpu_instruction_master_address_to_slave <= internal_cpu_instruction_master_address_to_slave;
  --vhdl renameroo for output signals
  cpu_instruction_master_dbs_address <= internal_cpu_instruction_master_dbs_address;
  --vhdl renameroo for output signals
  cpu_instruction_master_latency_counter <= internal_cpu_instruction_master_latency_counter;
  --vhdl renameroo for output signals
  cpu_instruction_master_waitrequest <= internal_cpu_instruction_master_waitrequest;
--synthesis translate_off
    --cpu_instruction_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_instruction_master_address_last_time <= std_logic_vector'("0000000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_instruction_master_address_last_time <= cpu_instruction_master_address;
      end if;

    end process;

    --cpu/instruction_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_cpu_instruction_master_waitrequest AND (cpu_instruction_master_read);
      end if;

    end process;

    --cpu_instruction_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line2 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_instruction_master_address /= cpu_instruction_master_address_last_time))))) = '1' then 
          write(write_line2, now);
          write(write_line2, string'(": "));
          write(write_line2, string'("cpu_instruction_master_address did not heed wait!!!"));
          write(output, write_line2.all);
          deallocate (write_line2);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_instruction_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_instruction_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_instruction_master_read_last_time <= cpu_instruction_master_read;
      end if;

    end process;

    --cpu_instruction_master_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line3 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_instruction_master_read) /= std_logic'(cpu_instruction_master_read_last_time)))))) = '1' then 
          write(write_line3, now);
          write(write_line3, string'(": "));
          write(write_line3, string'("cpu_instruction_master_read did not heed wait!!!"));
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

entity cpu_bitswap_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_bitswap_s1_result : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_bitswap_s1_select : IN STD_LOGIC;
                 signal cpu_custom_instruction_master_combo_dataa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_custom_instruction_master_combo_datab : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_bitswap_s1_dataa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_bitswap_s1_datab : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_bitswap_s1_result_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity cpu_bitswap_s1_arbitrator;


architecture europa of cpu_bitswap_s1_arbitrator is

begin

  cpu_bitswap_s1_dataa <= cpu_custom_instruction_master_combo_dataa;
  cpu_bitswap_s1_datab <= cpu_custom_instruction_master_combo_datab;
  --assign cpu_bitswap_s1_result_from_sa = cpu_bitswap_s1_result so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_bitswap_s1_result_from_sa <= cpu_bitswap_s1_result;

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

entity cpu_custominstruction_inst_nios_custom_instruction_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_custom_instruction_master_combo_dataa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_custom_instruction_master_combo_datab : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_result : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_select : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_dataa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_datab : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_result_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity cpu_custominstruction_inst_nios_custom_instruction_slave_0_arbitrator;


architecture europa of cpu_custominstruction_inst_nios_custom_instruction_slave_0_arbitrator is

begin

  cpu_custominstruction_inst_nios_custom_instruction_slave_0_dataa <= cpu_custom_instruction_master_combo_dataa;
  cpu_custominstruction_inst_nios_custom_instruction_slave_0_datab <= cpu_custom_instruction_master_combo_datab;
  --assign cpu_custominstruction_inst_nios_custom_instruction_slave_0_result_from_sa = cpu_custominstruction_inst_nios_custom_instruction_slave_0_result so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_custominstruction_inst_nios_custom_instruction_slave_0_result_from_sa <= cpu_custominstruction_inst_nios_custom_instruction_slave_0_result;

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

entity ext_bus_avalon_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_dbs_write_8 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cpu_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal address_to_the_flash : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
                 signal cpu_data_master_byteenable_flash_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_granted_flash_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_flash_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_flash_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_flash_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_granted_flash_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_flash_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_flash_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_requests_flash_s1 : OUT STD_LOGIC;
                 signal d1_ext_bus_avalon_slave_end_xfer : OUT STD_LOGIC;
                 signal data_to_and_from_the_flash : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal flash_s1_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal flash_s1_wait_counter_eq_1 : OUT STD_LOGIC;
                 signal incoming_data_to_and_from_the_flash : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal incoming_data_to_and_from_the_flash_with_Xs_converted_to_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal read_n_to_the_flash : OUT STD_LOGIC;
                 signal registered_cpu_data_master_read_data_valid_flash_s1 : OUT STD_LOGIC;
                 signal select_n_to_the_flash : OUT STD_LOGIC;
                 signal write_n_to_the_flash : OUT STD_LOGIC
              );
end entity ext_bus_avalon_slave_arbitrator;


architecture europa of ext_bus_avalon_slave_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_byteenable_flash_s1_segment_0 :  STD_LOGIC;
                signal cpu_data_master_byteenable_flash_s1_segment_1 :  STD_LOGIC;
                signal cpu_data_master_byteenable_flash_s1_segment_2 :  STD_LOGIC;
                signal cpu_data_master_byteenable_flash_s1_segment_3 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_flash_s1_shift_register :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_read_data_valid_flash_s1_shift_register_in :  STD_LOGIC;
                signal cpu_data_master_saved_grant_flash_s1 :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_flash_s1_shift_register :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_read_data_valid_flash_s1_shift_register_in :  STD_LOGIC;
                signal cpu_instruction_master_saved_grant_flash_s1 :  STD_LOGIC;
                signal d1_in_a_write_cycle :  STD_LOGIC;
                signal d1_outgoing_data_to_and_from_the_flash :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_ext_bus_avalon_slave :  STD_LOGIC;
                signal ext_bus_avalon_slave_allgrants :  STD_LOGIC;
                signal ext_bus_avalon_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal ext_bus_avalon_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal ext_bus_avalon_slave_any_continuerequest :  STD_LOGIC;
                signal ext_bus_avalon_slave_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ext_bus_avalon_slave_arb_counter_enable :  STD_LOGIC;
                signal ext_bus_avalon_slave_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal ext_bus_avalon_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal ext_bus_avalon_slave_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal ext_bus_avalon_slave_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ext_bus_avalon_slave_arbitration_holdoff_internal :  STD_LOGIC;
                signal ext_bus_avalon_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal ext_bus_avalon_slave_begins_xfer :  STD_LOGIC;
                signal ext_bus_avalon_slave_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal ext_bus_avalon_slave_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ext_bus_avalon_slave_end_xfer :  STD_LOGIC;
                signal ext_bus_avalon_slave_firsttransfer :  STD_LOGIC;
                signal ext_bus_avalon_slave_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ext_bus_avalon_slave_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ext_bus_avalon_slave_non_bursting_master_requests :  STD_LOGIC;
                signal ext_bus_avalon_slave_read_pending :  STD_LOGIC;
                signal ext_bus_avalon_slave_reg_firsttransfer :  STD_LOGIC;
                signal ext_bus_avalon_slave_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal ext_bus_avalon_slave_slavearbiterlockenable :  STD_LOGIC;
                signal ext_bus_avalon_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal ext_bus_avalon_slave_unreg_firsttransfer :  STD_LOGIC;
                signal ext_bus_avalon_slave_write_pending :  STD_LOGIC;
                signal flash_s1_counter_load_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal flash_s1_in_a_read_cycle :  STD_LOGIC;
                signal flash_s1_in_a_write_cycle :  STD_LOGIC;
                signal flash_s1_pretend_byte_enable :  STD_LOGIC;
                signal flash_s1_wait_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal flash_s1_waits_for_read :  STD_LOGIC;
                signal flash_s1_waits_for_write :  STD_LOGIC;
                signal flash_s1_with_write_latency :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal incoming_data_to_and_from_the_flash_bit_0_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_flash_bit_1_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_flash_bit_2_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_flash_bit_3_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_flash_bit_4_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_flash_bit_5_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_flash_bit_6_is_x :  STD_LOGIC;
                signal incoming_data_to_and_from_the_flash_bit_7_is_x :  STD_LOGIC;
                signal internal_cpu_data_master_byteenable_flash_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_granted_flash_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_flash_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_flash_s1 :  STD_LOGIC;
                signal internal_cpu_instruction_master_granted_flash_s1 :  STD_LOGIC;
                signal internal_cpu_instruction_master_qualified_request_flash_s1 :  STD_LOGIC;
                signal internal_cpu_instruction_master_requests_flash_s1 :  STD_LOGIC;
                signal internal_flash_s1_wait_counter_eq_0 :  STD_LOGIC;
                signal internal_incoming_data_to_and_from_the_flash :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal last_cycle_cpu_data_master_granted_slave_flash_s1 :  STD_LOGIC;
                signal last_cycle_cpu_instruction_master_granted_slave_flash_s1 :  STD_LOGIC;
                signal outgoing_data_to_and_from_the_flash :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_address_to_the_flash :  STD_LOGIC_VECTOR (21 DOWNTO 0);
                signal p1_cpu_data_master_read_data_valid_flash_s1_shift_register :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_cpu_instruction_master_read_data_valid_flash_s1_shift_register :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_read_n_to_the_flash :  STD_LOGIC;
                signal p1_select_n_to_the_flash :  STD_LOGIC;
                signal p1_write_n_to_the_flash :  STD_LOGIC;
                signal time_to_write :  STD_LOGIC;
                signal wait_for_flash_s1_counter :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of address_to_the_flash : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of d1_in_a_write_cycle : signal is "FAST_OUTPUT_ENABLE_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of d1_outgoing_data_to_and_from_the_flash : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of internal_incoming_data_to_and_from_the_flash : signal is "FAST_INPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of read_n_to_the_flash : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of select_n_to_the_flash : signal is "FAST_OUTPUT_REGISTER=ON";
attribute ALTERA_ATTRIBUTE of write_n_to_the_flash : signal is "FAST_OUTPUT_REGISTER=ON";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT ext_bus_avalon_slave_end_xfer;
    end if;

  end process;

  ext_bus_avalon_slave_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_data_master_qualified_request_flash_s1 OR internal_cpu_instruction_master_qualified_request_flash_s1));
  internal_cpu_data_master_requests_flash_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 22) & std_logic_vector'("0000000000000000000000")) = std_logic_vector'("1010000000000000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --~select_n_to_the_flash of type chipselect to ~p1_select_n_to_the_flash, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      select_n_to_the_flash <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      select_n_to_the_flash <= p1_select_n_to_the_flash;
    end if;

  end process;

  ext_bus_avalon_slave_write_pending <= std_logic'('0');
  --ext_bus/avalon_slave read pending calc, which is an e_assign
  ext_bus_avalon_slave_read_pending <= std_logic'('0');
  --registered rdv signal_name registered_cpu_data_master_read_data_valid_flash_s1 assignment, which is an e_assign
  registered_cpu_data_master_read_data_valid_flash_s1 <= cpu_data_master_read_data_valid_flash_s1_shift_register(0);
  --ext_bus_avalon_slave_arb_share_counter set values, which is an e_mux
  ext_bus_avalon_slave_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_flash_s1)) = '1'), std_logic_vector'("00000000000000000000000000000100"), A_WE_StdLogicVector((std_logic'((internal_cpu_instruction_master_granted_flash_s1)) = '1'), std_logic_vector'("00000000000000000000000000000100"), A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_flash_s1)) = '1'), std_logic_vector'("00000000000000000000000000000100"), A_WE_StdLogicVector((std_logic'((internal_cpu_instruction_master_granted_flash_s1)) = '1'), std_logic_vector'("00000000000000000000000000000100"), std_logic_vector'("00000000000000000000000000000001"))))), 3);
  --ext_bus_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  ext_bus_avalon_slave_non_bursting_master_requests <= ((internal_cpu_data_master_requests_flash_s1 OR internal_cpu_instruction_master_requests_flash_s1) OR internal_cpu_data_master_requests_flash_s1) OR internal_cpu_instruction_master_requests_flash_s1;
  --ext_bus_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  ext_bus_avalon_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --ext_bus_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  ext_bus_avalon_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(ext_bus_avalon_slave_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (ext_bus_avalon_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(ext_bus_avalon_slave_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (ext_bus_avalon_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --ext_bus_avalon_slave_allgrants all slave grants, which is an e_mux
  ext_bus_avalon_slave_allgrants <= (((or_reduce(ext_bus_avalon_slave_grant_vector)) OR (or_reduce(ext_bus_avalon_slave_grant_vector))) OR (or_reduce(ext_bus_avalon_slave_grant_vector))) OR (or_reduce(ext_bus_avalon_slave_grant_vector));
  --ext_bus_avalon_slave_end_xfer assignment, which is an e_assign
  ext_bus_avalon_slave_end_xfer <= NOT ((flash_s1_waits_for_read OR flash_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_ext_bus_avalon_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_ext_bus_avalon_slave <= ext_bus_avalon_slave_end_xfer AND (((NOT ext_bus_avalon_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --ext_bus_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  ext_bus_avalon_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_ext_bus_avalon_slave AND ext_bus_avalon_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_ext_bus_avalon_slave AND NOT ext_bus_avalon_slave_non_bursting_master_requests));
  --ext_bus_avalon_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ext_bus_avalon_slave_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(ext_bus_avalon_slave_arb_counter_enable) = '1' then 
        ext_bus_avalon_slave_arb_share_counter <= ext_bus_avalon_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --ext_bus_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ext_bus_avalon_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(ext_bus_avalon_slave_master_qreq_vector) AND end_xfer_arb_share_counter_term_ext_bus_avalon_slave)) OR ((end_xfer_arb_share_counter_term_ext_bus_avalon_slave AND NOT ext_bus_avalon_slave_non_bursting_master_requests)))) = '1' then 
        ext_bus_avalon_slave_slavearbiterlockenable <= or_reduce(ext_bus_avalon_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master ext_bus/avalon_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= ext_bus_avalon_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --ext_bus_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  ext_bus_avalon_slave_slavearbiterlockenable2 <= or_reduce(ext_bus_avalon_slave_arb_share_counter_next_value);
  --cpu/data_master ext_bus/avalon_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= ext_bus_avalon_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --cpu/instruction_master ext_bus/avalon_slave arbiterlock, which is an e_assign
  cpu_instruction_master_arbiterlock <= ext_bus_avalon_slave_slavearbiterlockenable AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master ext_bus/avalon_slave arbiterlock2, which is an e_assign
  cpu_instruction_master_arbiterlock2 <= ext_bus_avalon_slave_slavearbiterlockenable2 AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master granted flash/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_instruction_master_granted_slave_flash_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_instruction_master_granted_slave_flash_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_instruction_master_saved_grant_flash_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((ext_bus_avalon_slave_arbitration_holdoff_internal OR NOT internal_cpu_instruction_master_requests_flash_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_instruction_master_granted_slave_flash_s1))))));
    end if;

  end process;

  --cpu_instruction_master_continuerequest continued request, which is an e_mux
  cpu_instruction_master_continuerequest <= last_cycle_cpu_instruction_master_granted_slave_flash_s1 AND internal_cpu_instruction_master_requests_flash_s1;
  --ext_bus_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_mux
  ext_bus_avalon_slave_any_continuerequest <= cpu_instruction_master_continuerequest OR cpu_data_master_continuerequest;
  internal_cpu_data_master_qualified_request_flash_s1 <= internal_cpu_data_master_requests_flash_s1 AND NOT (((((cpu_data_master_read AND (((ext_bus_avalon_slave_write_pending OR (ext_bus_avalon_slave_read_pending)) OR (or_reduce(cpu_data_master_read_data_valid_flash_s1_shift_register)))))) OR (((((ext_bus_avalon_slave_read_pending OR cpu_data_master_no_byte_enables_and_last_term) OR NOT(internal_cpu_data_master_byteenable_flash_s1))) AND cpu_data_master_write))) OR cpu_instruction_master_arbiterlock));
  --cpu_data_master_read_data_valid_flash_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  cpu_data_master_read_data_valid_flash_s1_shift_register_in <= ((internal_cpu_data_master_granted_flash_s1 AND cpu_data_master_read) AND NOT flash_s1_waits_for_read) AND NOT (or_reduce(cpu_data_master_read_data_valid_flash_s1_shift_register));
  --shift register p1 cpu_data_master_read_data_valid_flash_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_cpu_data_master_read_data_valid_flash_s1_shift_register <= A_EXT ((cpu_data_master_read_data_valid_flash_s1_shift_register & A_ToStdLogicVector(cpu_data_master_read_data_valid_flash_s1_shift_register_in)), 2);
  --cpu_data_master_read_data_valid_flash_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_data_master_read_data_valid_flash_s1_shift_register <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      cpu_data_master_read_data_valid_flash_s1_shift_register <= p1_cpu_data_master_read_data_valid_flash_s1_shift_register;
    end if;

  end process;

  --local readdatavalid cpu_data_master_read_data_valid_flash_s1, which is an e_mux
  cpu_data_master_read_data_valid_flash_s1 <= cpu_data_master_read_data_valid_flash_s1_shift_register(1);
  --data_to_and_from_the_flash register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_incoming_data_to_and_from_the_flash <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      internal_incoming_data_to_and_from_the_flash <= data_to_and_from_the_flash;
    end if;

  end process;

  --flash_s1_with_write_latency assignment, which is an e_assign
  flash_s1_with_write_latency <= in_a_write_cycle AND ((internal_cpu_data_master_qualified_request_flash_s1 OR internal_cpu_instruction_master_qualified_request_flash_s1));
  --time to write the data, which is an e_mux
  time_to_write <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((flash_s1_with_write_latency)) = '1'), std_logic_vector'("00000000000000000000000000000001"), std_logic_vector'("00000000000000000000000000000000")));
  --d1_outgoing_data_to_and_from_the_flash register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_outgoing_data_to_and_from_the_flash <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      d1_outgoing_data_to_and_from_the_flash <= outgoing_data_to_and_from_the_flash;
    end if;

  end process;

  --write cycle delayed by 1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_in_a_write_cycle <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_in_a_write_cycle <= time_to_write;
    end if;

  end process;

  --d1_outgoing_data_to_and_from_the_flash tristate driver, which is an e_assign
  data_to_and_from_the_flash <= A_WE_StdLogicVector((std_logic'((d1_in_a_write_cycle)) = '1'), d1_outgoing_data_to_and_from_the_flash, A_REP(std_logic'('Z'), 8));
  --outgoing_data_to_and_from_the_flash mux, which is an e_mux
  outgoing_data_to_and_from_the_flash <= cpu_data_master_dbs_write_8;
  internal_cpu_instruction_master_requests_flash_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_instruction_master_address_to_slave(24 DOWNTO 22) & std_logic_vector'("0000000000000000000000")) = std_logic_vector'("1010000000000000000000000")))) AND (cpu_instruction_master_read))) AND cpu_instruction_master_read;
  --cpu/data_master granted flash/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_data_master_granted_slave_flash_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_data_master_granted_slave_flash_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_data_master_saved_grant_flash_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((ext_bus_avalon_slave_arbitration_holdoff_internal OR NOT internal_cpu_data_master_requests_flash_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_data_master_granted_slave_flash_s1))))));
    end if;

  end process;

  --cpu_data_master_continuerequest continued request, which is an e_mux
  cpu_data_master_continuerequest <= last_cycle_cpu_data_master_granted_slave_flash_s1 AND internal_cpu_data_master_requests_flash_s1;
  internal_cpu_instruction_master_qualified_request_flash_s1 <= internal_cpu_instruction_master_requests_flash_s1 AND NOT ((((cpu_instruction_master_read AND (((((ext_bus_avalon_slave_write_pending OR (ext_bus_avalon_slave_read_pending)) OR to_std_logic(((std_logic_vector'("00000000000000000000000000000010")<(std_logic_vector'("000000000000000000000000000000") & (cpu_instruction_master_latency_counter)))))) OR (cpu_instruction_master_read_data_valid_sdram_s1_shift_register)) OR (cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register))))) OR cpu_data_master_arbiterlock));
  --cpu_instruction_master_read_data_valid_flash_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  cpu_instruction_master_read_data_valid_flash_s1_shift_register_in <= (internal_cpu_instruction_master_granted_flash_s1 AND cpu_instruction_master_read) AND NOT flash_s1_waits_for_read;
  --shift register p1 cpu_instruction_master_read_data_valid_flash_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_cpu_instruction_master_read_data_valid_flash_s1_shift_register <= A_EXT ((cpu_instruction_master_read_data_valid_flash_s1_shift_register & A_ToStdLogicVector(cpu_instruction_master_read_data_valid_flash_s1_shift_register_in)), 2);
  --cpu_instruction_master_read_data_valid_flash_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_instruction_master_read_data_valid_flash_s1_shift_register <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      cpu_instruction_master_read_data_valid_flash_s1_shift_register <= p1_cpu_instruction_master_read_data_valid_flash_s1_shift_register;
    end if;

  end process;

  --local readdatavalid cpu_instruction_master_read_data_valid_flash_s1, which is an e_mux
  cpu_instruction_master_read_data_valid_flash_s1 <= cpu_instruction_master_read_data_valid_flash_s1_shift_register(1);
  --allow new arb cycle for ext_bus/avalon_slave, which is an e_assign
  ext_bus_avalon_slave_allow_new_arb_cycle <= NOT cpu_data_master_arbiterlock AND NOT cpu_instruction_master_arbiterlock;
  --cpu/instruction_master assignment into master qualified-requests vector for flash/s1, which is an e_assign
  ext_bus_avalon_slave_master_qreq_vector(0) <= internal_cpu_instruction_master_qualified_request_flash_s1;
  --cpu/instruction_master grant flash/s1, which is an e_assign
  internal_cpu_instruction_master_granted_flash_s1 <= ext_bus_avalon_slave_grant_vector(0);
  --cpu/instruction_master saved-grant flash/s1, which is an e_assign
  cpu_instruction_master_saved_grant_flash_s1 <= ext_bus_avalon_slave_arb_winner(0) AND internal_cpu_instruction_master_requests_flash_s1;
  --cpu/data_master assignment into master qualified-requests vector for flash/s1, which is an e_assign
  ext_bus_avalon_slave_master_qreq_vector(1) <= internal_cpu_data_master_qualified_request_flash_s1;
  --cpu/data_master grant flash/s1, which is an e_assign
  internal_cpu_data_master_granted_flash_s1 <= ext_bus_avalon_slave_grant_vector(1);
  --cpu/data_master saved-grant flash/s1, which is an e_assign
  cpu_data_master_saved_grant_flash_s1 <= ext_bus_avalon_slave_arb_winner(1) AND internal_cpu_data_master_requests_flash_s1;
  --ext_bus/avalon_slave chosen-master double-vector, which is an e_assign
  ext_bus_avalon_slave_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((ext_bus_avalon_slave_master_qreq_vector & ext_bus_avalon_slave_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT ext_bus_avalon_slave_master_qreq_vector & NOT ext_bus_avalon_slave_master_qreq_vector))) + (std_logic_vector'("000") & (ext_bus_avalon_slave_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  ext_bus_avalon_slave_arb_winner <= A_WE_StdLogicVector((std_logic'(((ext_bus_avalon_slave_allow_new_arb_cycle AND or_reduce(ext_bus_avalon_slave_grant_vector)))) = '1'), ext_bus_avalon_slave_grant_vector, ext_bus_avalon_slave_saved_chosen_master_vector);
  --saved ext_bus_avalon_slave_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ext_bus_avalon_slave_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(ext_bus_avalon_slave_allow_new_arb_cycle) = '1' then 
        ext_bus_avalon_slave_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(ext_bus_avalon_slave_grant_vector)) = '1'), ext_bus_avalon_slave_grant_vector, ext_bus_avalon_slave_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  ext_bus_avalon_slave_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((ext_bus_avalon_slave_chosen_master_double_vector(1) OR ext_bus_avalon_slave_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((ext_bus_avalon_slave_chosen_master_double_vector(0) OR ext_bus_avalon_slave_chosen_master_double_vector(2)))));
  --ext_bus/avalon_slave chosen master rotated left, which is an e_assign
  ext_bus_avalon_slave_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(ext_bus_avalon_slave_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(ext_bus_avalon_slave_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --ext_bus/avalon_slave's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ext_bus_avalon_slave_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(ext_bus_avalon_slave_grant_vector)) = '1' then 
        ext_bus_avalon_slave_arb_addend <= A_WE_StdLogicVector((std_logic'(ext_bus_avalon_slave_end_xfer) = '1'), ext_bus_avalon_slave_chosen_master_rot_left, ext_bus_avalon_slave_grant_vector);
      end if;
    end if;

  end process;

  p1_select_n_to_the_flash <= NOT ((internal_cpu_data_master_granted_flash_s1 OR internal_cpu_instruction_master_granted_flash_s1));
  --ext_bus_avalon_slave_firsttransfer first transaction, which is an e_assign
  ext_bus_avalon_slave_firsttransfer <= A_WE_StdLogic((std_logic'(ext_bus_avalon_slave_begins_xfer) = '1'), ext_bus_avalon_slave_unreg_firsttransfer, ext_bus_avalon_slave_reg_firsttransfer);
  --ext_bus_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  ext_bus_avalon_slave_unreg_firsttransfer <= NOT ((ext_bus_avalon_slave_slavearbiterlockenable AND ext_bus_avalon_slave_any_continuerequest));
  --ext_bus_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ext_bus_avalon_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(ext_bus_avalon_slave_begins_xfer) = '1' then 
        ext_bus_avalon_slave_reg_firsttransfer <= ext_bus_avalon_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --ext_bus_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  ext_bus_avalon_slave_beginbursttransfer_internal <= ext_bus_avalon_slave_begins_xfer;
  --ext_bus_avalon_slave_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  ext_bus_avalon_slave_arbitration_holdoff_internal <= ext_bus_avalon_slave_begins_xfer AND ext_bus_avalon_slave_firsttransfer;
  --~read_n_to_the_flash of type read to ~p1_read_n_to_the_flash, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      read_n_to_the_flash <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      read_n_to_the_flash <= p1_read_n_to_the_flash;
    end if;

  end process;

  --~p1_read_n_to_the_flash assignment, which is an e_mux
  p1_read_n_to_the_flash <= NOT ((((((internal_cpu_data_master_granted_flash_s1 AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_flash_s1 AND cpu_instruction_master_read)))) AND NOT ext_bus_avalon_slave_begins_xfer));
  --~write_n_to_the_flash of type write to ~p1_write_n_to_the_flash, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      write_n_to_the_flash <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      write_n_to_the_flash <= p1_write_n_to_the_flash;
    end if;

  end process;

  --~p1_write_n_to_the_flash assignment, which is an e_mux
  p1_write_n_to_the_flash <= NOT ((((((internal_cpu_data_master_granted_flash_s1 AND cpu_data_master_write)) AND NOT ext_bus_avalon_slave_begins_xfer) AND to_std_logic((((std_logic_vector'("00000000000000000000000000000") & (flash_s1_wait_counter))>=std_logic_vector'("00000000000000000000000000000001"))))) AND flash_s1_pretend_byte_enable));
  --address_to_the_flash of type address to p1_address_to_the_flash, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      address_to_the_flash <= std_logic_vector'("0000000000000000000000");
    elsif clk'event and clk = '1' then
      address_to_the_flash <= p1_address_to_the_flash;
    end if;

  end process;

  --p1_address_to_the_flash mux, which is an e_mux
  p1_address_to_the_flash <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_flash_s1)) = '1'), (Std_Logic_Vector'(A_SRL(cpu_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & cpu_data_master_dbs_address(1 DOWNTO 0))), (Std_Logic_Vector'(A_SRL(cpu_instruction_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & cpu_instruction_master_dbs_address(1 DOWNTO 0)))), 22);
  --d1_ext_bus_avalon_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_ext_bus_avalon_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_ext_bus_avalon_slave_end_xfer <= ext_bus_avalon_slave_end_xfer;
    end if;

  end process;

  --flash_s1_wait_counter_eq_1 assignment, which is an e_assign
  flash_s1_wait_counter_eq_1 <= to_std_logic(((std_logic_vector'("00000000000000000000000000000") & (flash_s1_wait_counter)) = std_logic_vector'("00000000000000000000000000000001")));
  --flash_s1_waits_for_read in a cycle, which is an e_mux
  flash_s1_waits_for_read <= flash_s1_in_a_read_cycle AND wait_for_flash_s1_counter;
  --flash_s1_in_a_read_cycle assignment, which is an e_assign
  flash_s1_in_a_read_cycle <= ((internal_cpu_data_master_granted_flash_s1 AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_flash_s1 AND cpu_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= flash_s1_in_a_read_cycle;
  --flash_s1_waits_for_write in a cycle, which is an e_mux
  flash_s1_waits_for_write <= flash_s1_in_a_write_cycle AND wait_for_flash_s1_counter;
  --flash_s1_in_a_write_cycle assignment, which is an e_assign
  flash_s1_in_a_write_cycle <= internal_cpu_data_master_granted_flash_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= flash_s1_in_a_write_cycle;
  internal_flash_s1_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("00000000000000000000000000000") & (flash_s1_wait_counter)) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      flash_s1_wait_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      flash_s1_wait_counter <= flash_s1_counter_load_value;
    end if;

  end process;

  flash_s1_counter_load_value <= A_EXT (A_WE_StdLogicVector((std_logic'(((flash_s1_in_a_read_cycle AND ext_bus_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000011"), A_WE_StdLogicVector((std_logic'(((flash_s1_in_a_write_cycle AND ext_bus_avalon_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000000100"), A_WE_StdLogicVector((std_logic'((NOT internal_flash_s1_wait_counter_eq_0)) = '1'), ((std_logic_vector'("000000000000000000000000000000") & (flash_s1_wait_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000")))), 3);
  wait_for_flash_s1_counter <= ext_bus_avalon_slave_begins_xfer OR NOT internal_flash_s1_wait_counter_eq_0;
  --flash_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  flash_s1_pretend_byte_enable <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_flash_s1)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_byteenable_flash_s1))), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))));
  (cpu_data_master_byteenable_flash_s1_segment_3, cpu_data_master_byteenable_flash_s1_segment_2, cpu_data_master_byteenable_flash_s1_segment_1, cpu_data_master_byteenable_flash_s1_segment_0) <= cpu_data_master_byteenable;
  internal_cpu_data_master_byteenable_flash_s1 <= A_WE_StdLogic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_data_master_byteenable_flash_s1_segment_0, A_WE_StdLogic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000001"))), cpu_data_master_byteenable_flash_s1_segment_1, A_WE_StdLogic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000010"))), cpu_data_master_byteenable_flash_s1_segment_2, cpu_data_master_byteenable_flash_s1_segment_3)));
  --vhdl renameroo for output signals
  cpu_data_master_byteenable_flash_s1 <= internal_cpu_data_master_byteenable_flash_s1;
  --vhdl renameroo for output signals
  cpu_data_master_granted_flash_s1 <= internal_cpu_data_master_granted_flash_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_flash_s1 <= internal_cpu_data_master_qualified_request_flash_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_flash_s1 <= internal_cpu_data_master_requests_flash_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_granted_flash_s1 <= internal_cpu_instruction_master_granted_flash_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_qualified_request_flash_s1 <= internal_cpu_instruction_master_qualified_request_flash_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_requests_flash_s1 <= internal_cpu_instruction_master_requests_flash_s1;
  --vhdl renameroo for output signals
  flash_s1_wait_counter_eq_0 <= internal_flash_s1_wait_counter_eq_0;
  --vhdl renameroo for output signals
  incoming_data_to_and_from_the_flash <= internal_incoming_data_to_and_from_the_flash;
--synthesis translate_off
    --incoming_data_to_and_from_the_flash_bit_0_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_flash_bit_0_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_flash(0))), '1','0');
    --Crush incoming_data_to_and_from_the_flash_with_Xs_converted_to_0[0] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_flash_with_Xs_converted_to_0(0) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_flash_bit_0_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_flash(0));
    --incoming_data_to_and_from_the_flash_bit_1_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_flash_bit_1_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_flash(1))), '1','0');
    --Crush incoming_data_to_and_from_the_flash_with_Xs_converted_to_0[1] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_flash_with_Xs_converted_to_0(1) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_flash_bit_1_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_flash(1));
    --incoming_data_to_and_from_the_flash_bit_2_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_flash_bit_2_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_flash(2))), '1','0');
    --Crush incoming_data_to_and_from_the_flash_with_Xs_converted_to_0[2] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_flash_with_Xs_converted_to_0(2) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_flash_bit_2_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_flash(2));
    --incoming_data_to_and_from_the_flash_bit_3_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_flash_bit_3_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_flash(3))), '1','0');
    --Crush incoming_data_to_and_from_the_flash_with_Xs_converted_to_0[3] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_flash_with_Xs_converted_to_0(3) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_flash_bit_3_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_flash(3));
    --incoming_data_to_and_from_the_flash_bit_4_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_flash_bit_4_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_flash(4))), '1','0');
    --Crush incoming_data_to_and_from_the_flash_with_Xs_converted_to_0[4] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_flash_with_Xs_converted_to_0(4) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_flash_bit_4_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_flash(4));
    --incoming_data_to_and_from_the_flash_bit_5_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_flash_bit_5_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_flash(5))), '1','0');
    --Crush incoming_data_to_and_from_the_flash_with_Xs_converted_to_0[5] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_flash_with_Xs_converted_to_0(5) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_flash_bit_5_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_flash(5));
    --incoming_data_to_and_from_the_flash_bit_6_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_flash_bit_6_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_flash(6))), '1','0');
    --Crush incoming_data_to_and_from_the_flash_with_Xs_converted_to_0[6] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_flash_with_Xs_converted_to_0(6) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_flash_bit_6_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_flash(6));
    --incoming_data_to_and_from_the_flash_bit_7_is_x x check, which is an e_assign_is_x
    incoming_data_to_and_from_the_flash_bit_7_is_x <= A_WE_StdLogic(is_x(std_ulogic(internal_incoming_data_to_and_from_the_flash(7))), '1','0');
    --Crush incoming_data_to_and_from_the_flash_with_Xs_converted_to_0[7] Xs to 0, which is an e_assign
    incoming_data_to_and_from_the_flash_with_Xs_converted_to_0(7) <= A_WE_StdLogic((std_logic'(incoming_data_to_and_from_the_flash_bit_7_is_x) = '1'), std_logic'('0'), internal_incoming_data_to_and_from_the_flash(7));
    --flash/s1 enable non-zero assertions, which is an e_register
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
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_granted_flash_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_instruction_master_granted_flash_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
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
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_data_master_saved_grant_flash_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_saved_grant_flash_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
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
--synthesis read_comments_as_HDL on
--    
--    incoming_data_to_and_from_the_flash_with_Xs_converted_to_0 <= internal_incoming_data_to_and_from_the_flash;
--synthesis read_comments_as_HDL off

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

entity ext_bus_bridge_arbitrator is 
end entity ext_bus_bridge_arbitrator;


architecture europa of ext_bus_bridge_arbitrator is

begin


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

entity jtag_uart_avalon_jtag_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_irq : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                 signal d1_jtag_uart_avalon_jtag_slave_end_xfer : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_address : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity jtag_uart_avalon_jtag_slave_arbitrator;


architecture europa of jtag_uart_avalon_jtag_slave_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_allgrants :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_any_continuerequest :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_arb_counter_enable :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_begins_xfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_firsttransfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_grant_vector :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_in_a_read_cycle :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_in_a_write_cycle :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_master_qreq_vector :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_non_bursting_master_requests :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_reg_firsttransfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_slavearbiterlockenable :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_unreg_firsttransfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_waits_for_read :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_jtag_uart_avalon_jtag_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT jtag_uart_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  jtag_uart_avalon_jtag_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave);
  --assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_avalon_jtag_slave_readdata_from_sa <= jtag_uart_avalon_jtag_slave_readdata;
  internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("1100100000001000010000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_avalon_jtag_slave_dataavailable_from_sa <= jtag_uart_avalon_jtag_slave_dataavailable;
  --assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_avalon_jtag_slave_readyfordata_from_sa <= jtag_uart_avalon_jtag_slave_readyfordata;
  --assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa <= jtag_uart_avalon_jtag_slave_waitrequest;
  --jtag_uart_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  jtag_uart_avalon_jtag_slave_arb_share_set_values <= std_logic_vector'("001");
  --jtag_uart_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  jtag_uart_avalon_jtag_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  --jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --jtag_uart_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(jtag_uart_avalon_jtag_slave_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (jtag_uart_avalon_jtag_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(jtag_uart_avalon_jtag_slave_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (jtag_uart_avalon_jtag_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --jtag_uart_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  jtag_uart_avalon_jtag_slave_allgrants <= jtag_uart_avalon_jtag_slave_grant_vector;
  --jtag_uart_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_end_xfer <= NOT ((jtag_uart_avalon_jtag_slave_waits_for_read OR jtag_uart_avalon_jtag_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave <= jtag_uart_avalon_jtag_slave_end_xfer AND (((NOT jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --jtag_uart_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  jtag_uart_avalon_jtag_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave AND jtag_uart_avalon_jtag_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave AND NOT jtag_uart_avalon_jtag_slave_non_bursting_master_requests));
  --jtag_uart_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_avalon_jtag_slave_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(jtag_uart_avalon_jtag_slave_arb_counter_enable) = '1' then 
        jtag_uart_avalon_jtag_slave_arb_share_counter <= jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --jtag_uart_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((jtag_uart_avalon_jtag_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave)) OR ((end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave AND NOT jtag_uart_avalon_jtag_slave_non_bursting_master_requests)))) = '1' then 
        jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= or_reduce(jtag_uart_avalon_jtag_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= jtag_uart_avalon_jtag_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 <= or_reduce(jtag_uart_avalon_jtag_slave_arb_share_counter_next_value);
  --cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --jtag_uart_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  jtag_uart_avalon_jtag_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave AND NOT ((((cpu_data_master_read AND (NOT cpu_data_master_waitrequest))) OR (((NOT cpu_data_master_waitrequest) AND cpu_data_master_write))));
  --jtag_uart_avalon_jtag_slave_writedata mux, which is an e_mux
  jtag_uart_avalon_jtag_slave_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  --cpu/data_master saved-grant jtag_uart/avalon_jtag_slave, which is an e_assign
  cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  --allow new arb cycle for jtag_uart/avalon_jtag_slave, which is an e_assign
  jtag_uart_avalon_jtag_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  jtag_uart_avalon_jtag_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  jtag_uart_avalon_jtag_slave_master_qreq_vector <= std_logic'('1');
  --jtag_uart_avalon_jtag_slave_reset_n assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_reset_n <= reset_n;
  jtag_uart_avalon_jtag_slave_chipselect <= internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  --jtag_uart_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  jtag_uart_avalon_jtag_slave_firsttransfer <= A_WE_StdLogic((std_logic'(jtag_uart_avalon_jtag_slave_begins_xfer) = '1'), jtag_uart_avalon_jtag_slave_unreg_firsttransfer, jtag_uart_avalon_jtag_slave_reg_firsttransfer);
  --jtag_uart_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  jtag_uart_avalon_jtag_slave_unreg_firsttransfer <= NOT ((jtag_uart_avalon_jtag_slave_slavearbiterlockenable AND jtag_uart_avalon_jtag_slave_any_continuerequest));
  --jtag_uart_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_avalon_jtag_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(jtag_uart_avalon_jtag_slave_begins_xfer) = '1' then 
        jtag_uart_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --jtag_uart_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  jtag_uart_avalon_jtag_slave_beginbursttransfer_internal <= jtag_uart_avalon_jtag_slave_begins_xfer;
  --~jtag_uart_avalon_jtag_slave_read_n assignment, which is an e_mux
  jtag_uart_avalon_jtag_slave_read_n <= NOT ((internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_read));
  --~jtag_uart_avalon_jtag_slave_write_n assignment, which is an e_mux
  jtag_uart_avalon_jtag_slave_write_n <= NOT ((internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_write));
  shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --jtag_uart_avalon_jtag_slave_address mux, which is an e_mux
  jtag_uart_avalon_jtag_slave_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_jtag_uart_avalon_jtag_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_jtag_uart_avalon_jtag_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_jtag_uart_avalon_jtag_slave_end_xfer <= jtag_uart_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  --jtag_uart_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  jtag_uart_avalon_jtag_slave_waits_for_read <= jtag_uart_avalon_jtag_slave_in_a_read_cycle AND internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  --jtag_uart_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_in_a_read_cycle <= internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= jtag_uart_avalon_jtag_slave_in_a_read_cycle;
  --jtag_uart_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  jtag_uart_avalon_jtag_slave_waits_for_write <= jtag_uart_avalon_jtag_slave_in_a_write_cycle AND internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  --jtag_uart_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_in_a_write_cycle <= internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= jtag_uart_avalon_jtag_slave_in_a_write_cycle;
  wait_for_jtag_uart_avalon_jtag_slave_counter <= std_logic'('0');
  --assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_avalon_jtag_slave_irq_from_sa <= jtag_uart_avalon_jtag_slave_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  --vhdl renameroo for output signals
  jtag_uart_avalon_jtag_slave_waitrequest_from_sa <= internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
--synthesis translate_off
    --jtag_uart/avalon_jtag_slave enable non-zero assertions, which is an e_register
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

entity lcd_control_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal lcd_control_slave_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_lcd_control_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_lcd_control_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_lcd_control_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_lcd_control_slave : OUT STD_LOGIC;
                 signal d1_lcd_control_slave_end_xfer : OUT STD_LOGIC;
                 signal lcd_control_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal lcd_control_slave_begintransfer : OUT STD_LOGIC;
                 signal lcd_control_slave_read : OUT STD_LOGIC;
                 signal lcd_control_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal lcd_control_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                 signal lcd_control_slave_wait_counter_eq_1 : OUT STD_LOGIC;
                 signal lcd_control_slave_write : OUT STD_LOGIC;
                 signal lcd_control_slave_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity lcd_control_slave_arbitrator;


architecture europa of lcd_control_slave_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_lcd_control_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_lcd_control_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_lcd_control_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_lcd_control_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_lcd_control_slave :  STD_LOGIC;
                signal internal_lcd_control_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal lcd_control_slave_allgrants :  STD_LOGIC;
                signal lcd_control_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal lcd_control_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal lcd_control_slave_any_continuerequest :  STD_LOGIC;
                signal lcd_control_slave_arb_counter_enable :  STD_LOGIC;
                signal lcd_control_slave_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal lcd_control_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal lcd_control_slave_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal lcd_control_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal lcd_control_slave_begins_xfer :  STD_LOGIC;
                signal lcd_control_slave_counter_load_value :  STD_LOGIC_VECTOR (5 DOWNTO 0);
                signal lcd_control_slave_end_xfer :  STD_LOGIC;
                signal lcd_control_slave_firsttransfer :  STD_LOGIC;
                signal lcd_control_slave_grant_vector :  STD_LOGIC;
                signal lcd_control_slave_in_a_read_cycle :  STD_LOGIC;
                signal lcd_control_slave_in_a_write_cycle :  STD_LOGIC;
                signal lcd_control_slave_master_qreq_vector :  STD_LOGIC;
                signal lcd_control_slave_non_bursting_master_requests :  STD_LOGIC;
                signal lcd_control_slave_pretend_byte_enable :  STD_LOGIC;
                signal lcd_control_slave_reg_firsttransfer :  STD_LOGIC;
                signal lcd_control_slave_slavearbiterlockenable :  STD_LOGIC;
                signal lcd_control_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal lcd_control_slave_unreg_firsttransfer :  STD_LOGIC;
                signal lcd_control_slave_wait_counter :  STD_LOGIC_VECTOR (5 DOWNTO 0);
                signal lcd_control_slave_waits_for_read :  STD_LOGIC;
                signal lcd_control_slave_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_lcd_control_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_lcd_control_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT lcd_control_slave_end_xfer;
    end if;

  end process;

  lcd_control_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_lcd_control_slave);
  --assign lcd_control_slave_readdata_from_sa = lcd_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  lcd_control_slave_readdata_from_sa <= lcd_control_slave_readdata;
  internal_cpu_data_master_requests_lcd_control_slave <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("1100100000001000001110000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --lcd_control_slave_arb_share_counter set values, which is an e_mux
  lcd_control_slave_arb_share_set_values <= std_logic_vector'("001");
  --lcd_control_slave_non_bursting_master_requests mux, which is an e_mux
  lcd_control_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_lcd_control_slave;
  --lcd_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  lcd_control_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --lcd_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  lcd_control_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(lcd_control_slave_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (lcd_control_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(lcd_control_slave_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (lcd_control_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --lcd_control_slave_allgrants all slave grants, which is an e_mux
  lcd_control_slave_allgrants <= lcd_control_slave_grant_vector;
  --lcd_control_slave_end_xfer assignment, which is an e_assign
  lcd_control_slave_end_xfer <= NOT ((lcd_control_slave_waits_for_read OR lcd_control_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_lcd_control_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_lcd_control_slave <= lcd_control_slave_end_xfer AND (((NOT lcd_control_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --lcd_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  lcd_control_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_lcd_control_slave AND lcd_control_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_lcd_control_slave AND NOT lcd_control_slave_non_bursting_master_requests));
  --lcd_control_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      lcd_control_slave_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(lcd_control_slave_arb_counter_enable) = '1' then 
        lcd_control_slave_arb_share_counter <= lcd_control_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --lcd_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      lcd_control_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((lcd_control_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_lcd_control_slave)) OR ((end_xfer_arb_share_counter_term_lcd_control_slave AND NOT lcd_control_slave_non_bursting_master_requests)))) = '1' then 
        lcd_control_slave_slavearbiterlockenable <= or_reduce(lcd_control_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master lcd/control_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= lcd_control_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --lcd_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  lcd_control_slave_slavearbiterlockenable2 <= or_reduce(lcd_control_slave_arb_share_counter_next_value);
  --cpu/data_master lcd/control_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= lcd_control_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --lcd_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  lcd_control_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_lcd_control_slave <= internal_cpu_data_master_requests_lcd_control_slave;
  --lcd_control_slave_writedata mux, which is an e_mux
  lcd_control_slave_writedata <= cpu_data_master_writedata (7 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_data_master_granted_lcd_control_slave <= internal_cpu_data_master_qualified_request_lcd_control_slave;
  --cpu/data_master saved-grant lcd/control_slave, which is an e_assign
  cpu_data_master_saved_grant_lcd_control_slave <= internal_cpu_data_master_requests_lcd_control_slave;
  --allow new arb cycle for lcd/control_slave, which is an e_assign
  lcd_control_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  lcd_control_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  lcd_control_slave_master_qreq_vector <= std_logic'('1');
  lcd_control_slave_begintransfer <= lcd_control_slave_begins_xfer;
  --lcd_control_slave_firsttransfer first transaction, which is an e_assign
  lcd_control_slave_firsttransfer <= A_WE_StdLogic((std_logic'(lcd_control_slave_begins_xfer) = '1'), lcd_control_slave_unreg_firsttransfer, lcd_control_slave_reg_firsttransfer);
  --lcd_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  lcd_control_slave_unreg_firsttransfer <= NOT ((lcd_control_slave_slavearbiterlockenable AND lcd_control_slave_any_continuerequest));
  --lcd_control_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      lcd_control_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(lcd_control_slave_begins_xfer) = '1' then 
        lcd_control_slave_reg_firsttransfer <= lcd_control_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --lcd_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  lcd_control_slave_beginbursttransfer_internal <= lcd_control_slave_begins_xfer;
  --lcd_control_slave_read assignment, which is an e_mux
  lcd_control_slave_read <= (((internal_cpu_data_master_granted_lcd_control_slave AND cpu_data_master_read)) AND NOT lcd_control_slave_begins_xfer) AND to_std_logic((((std_logic_vector'("00000000000000000000000000") & (lcd_control_slave_wait_counter))<std_logic_vector'("00000000000000000000000000001101"))));
  --lcd_control_slave_write assignment, which is an e_mux
  lcd_control_slave_write <= (((((internal_cpu_data_master_granted_lcd_control_slave AND cpu_data_master_write)) AND NOT lcd_control_slave_begins_xfer) AND to_std_logic((((std_logic_vector'("00000000000000000000000000") & (lcd_control_slave_wait_counter))>=std_logic_vector'("00000000000000000000000000001101"))))) AND to_std_logic((((std_logic_vector'("00000000000000000000000000") & (lcd_control_slave_wait_counter))<std_logic_vector'("00000000000000000000000000011010"))))) AND lcd_control_slave_pretend_byte_enable;
  shifted_address_to_lcd_control_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --lcd_control_slave_address mux, which is an e_mux
  lcd_control_slave_address <= A_EXT (A_SRL(shifted_address_to_lcd_control_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_lcd_control_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_lcd_control_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_lcd_control_slave_end_xfer <= lcd_control_slave_end_xfer;
    end if;

  end process;

  --lcd_control_slave_wait_counter_eq_1 assignment, which is an e_assign
  lcd_control_slave_wait_counter_eq_1 <= to_std_logic(((std_logic_vector'("00000000000000000000000000") & (lcd_control_slave_wait_counter)) = std_logic_vector'("00000000000000000000000000000001")));
  --lcd_control_slave_waits_for_read in a cycle, which is an e_mux
  lcd_control_slave_waits_for_read <= lcd_control_slave_in_a_read_cycle AND wait_for_lcd_control_slave_counter;
  --lcd_control_slave_in_a_read_cycle assignment, which is an e_assign
  lcd_control_slave_in_a_read_cycle <= internal_cpu_data_master_granted_lcd_control_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= lcd_control_slave_in_a_read_cycle;
  --lcd_control_slave_waits_for_write in a cycle, which is an e_mux
  lcd_control_slave_waits_for_write <= lcd_control_slave_in_a_write_cycle AND wait_for_lcd_control_slave_counter;
  --lcd_control_slave_in_a_write_cycle assignment, which is an e_assign
  lcd_control_slave_in_a_write_cycle <= internal_cpu_data_master_granted_lcd_control_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= lcd_control_slave_in_a_write_cycle;
  internal_lcd_control_slave_wait_counter_eq_0 <= to_std_logic(((std_logic_vector'("00000000000000000000000000") & (lcd_control_slave_wait_counter)) = std_logic_vector'("00000000000000000000000000000000")));
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      lcd_control_slave_wait_counter <= std_logic_vector'("000000");
    elsif clk'event and clk = '1' then
      lcd_control_slave_wait_counter <= lcd_control_slave_counter_load_value;
    end if;

  end process;

  lcd_control_slave_counter_load_value <= A_EXT (A_WE_StdLogicVector((std_logic'(((lcd_control_slave_in_a_read_cycle AND lcd_control_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000011000"), A_WE_StdLogicVector((std_logic'(((lcd_control_slave_in_a_write_cycle AND lcd_control_slave_begins_xfer))) = '1'), std_logic_vector'("000000000000000000000000000100101"), A_WE_StdLogicVector((std_logic'((NOT internal_lcd_control_slave_wait_counter_eq_0)) = '1'), ((std_logic_vector'("000000000000000000000000000") & (lcd_control_slave_wait_counter)) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000")))), 6);
  wait_for_lcd_control_slave_counter <= lcd_control_slave_begins_xfer OR NOT internal_lcd_control_slave_wait_counter_eq_0;
  --lcd_control_slave_pretend_byte_enable byte enable port mux, which is an e_mux
  lcd_control_slave_pretend_byte_enable <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_lcd_control_slave)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))));
  --vhdl renameroo for output signals
  cpu_data_master_granted_lcd_control_slave <= internal_cpu_data_master_granted_lcd_control_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_lcd_control_slave <= internal_cpu_data_master_qualified_request_lcd_control_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_lcd_control_slave <= internal_cpu_data_master_requests_lcd_control_slave;
  --vhdl renameroo for output signals
  lcd_control_slave_wait_counter_eq_0 <= internal_lcd_control_slave_wait_counter_eq_0;
--synthesis translate_off
    --lcd/control_slave enable non-zero assertions, which is an e_register
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

entity rdv_fifo_for_cpu_data_master_to_sdram_s1_module is 
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
end entity rdv_fifo_for_cpu_data_master_to_sdram_s1_module;


architecture europa of rdv_fifo_for_cpu_data_master_to_sdram_s1_module is
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

entity rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module is 
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
end entity rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module;


architecture europa of rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module is
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

entity sdram_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_s1_readdatavalid : IN STD_LOGIC;
                 signal sdram_s1_waitrequest : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_byteenable_sdram_s1 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_granted_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sdram_s1_shift_register : OUT STD_LOGIC;
                 signal cpu_data_master_requests_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_granted_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : OUT STD_LOGIC;
                 signal cpu_instruction_master_requests_sdram_s1 : OUT STD_LOGIC;
                 signal d1_sdram_s1_end_xfer : OUT STD_LOGIC;
                 signal sdram_s1_address : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
                 signal sdram_s1_byteenable_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal sdram_s1_chipselect : OUT STD_LOGIC;
                 signal sdram_s1_read_n : OUT STD_LOGIC;
                 signal sdram_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_s1_reset_n : OUT STD_LOGIC;
                 signal sdram_s1_waitrequest_from_sa : OUT STD_LOGIC;
                 signal sdram_s1_write_n : OUT STD_LOGIC;
                 signal sdram_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity sdram_s1_arbitrator;


architecture europa of sdram_s1_arbitrator is
component rdv_fifo_for_cpu_data_master_to_sdram_s1_module is 
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
end component rdv_fifo_for_cpu_data_master_to_sdram_s1_module;

component rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module is 
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
end component rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module;

                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_byteenable_sdram_s1_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_byteenable_sdram_s1_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_rdv_fifo_empty_sdram_s1 :  STD_LOGIC;
                signal cpu_data_master_rdv_fifo_output_from_sdram_s1 :  STD_LOGIC;
                signal cpu_data_master_saved_grant_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_instruction_master_rdv_fifo_empty_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_rdv_fifo_output_from_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_saved_grant_sdram_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_sdram_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_byteenable_sdram_s1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_data_master_granted_sdram_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_sdram_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_read_data_valid_sdram_s1_shift_register :  STD_LOGIC;
                signal internal_cpu_data_master_requests_sdram_s1 :  STD_LOGIC;
                signal internal_cpu_instruction_master_granted_sdram_s1 :  STD_LOGIC;
                signal internal_cpu_instruction_master_qualified_request_sdram_s1 :  STD_LOGIC;
                signal internal_cpu_instruction_master_requests_sdram_s1 :  STD_LOGIC;
                signal internal_sdram_s1_waitrequest_from_sa :  STD_LOGIC;
                signal last_cycle_cpu_data_master_granted_slave_sdram_s1 :  STD_LOGIC;
                signal last_cycle_cpu_instruction_master_granted_slave_sdram_s1 :  STD_LOGIC;
                signal module_input :  STD_LOGIC;
                signal module_input1 :  STD_LOGIC;
                signal module_input2 :  STD_LOGIC;
                signal module_input3 :  STD_LOGIC;
                signal module_input4 :  STD_LOGIC;
                signal module_input5 :  STD_LOGIC;
                signal sdram_s1_allgrants :  STD_LOGIC;
                signal sdram_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal sdram_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal sdram_s1_any_continuerequest :  STD_LOGIC;
                signal sdram_s1_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_arb_counter_enable :  STD_LOGIC;
                signal sdram_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sdram_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sdram_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sdram_s1_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_arbitration_holdoff_internal :  STD_LOGIC;
                signal sdram_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal sdram_s1_begins_xfer :  STD_LOGIC;
                signal sdram_s1_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal sdram_s1_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_end_xfer :  STD_LOGIC;
                signal sdram_s1_firsttransfer :  STD_LOGIC;
                signal sdram_s1_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_in_a_read_cycle :  STD_LOGIC;
                signal sdram_s1_in_a_write_cycle :  STD_LOGIC;
                signal sdram_s1_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_move_on_to_next_transaction :  STD_LOGIC;
                signal sdram_s1_non_bursting_master_requests :  STD_LOGIC;
                signal sdram_s1_readdatavalid_from_sa :  STD_LOGIC;
                signal sdram_s1_reg_firsttransfer :  STD_LOGIC;
                signal sdram_s1_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_slavearbiterlockenable :  STD_LOGIC;
                signal sdram_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal sdram_s1_unreg_firsttransfer :  STD_LOGIC;
                signal sdram_s1_waits_for_read :  STD_LOGIC;
                signal sdram_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_sdram_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal shifted_address_to_sdram_s1_from_cpu_instruction_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_sdram_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT sdram_s1_end_xfer;
    end if;

  end process;

  sdram_s1_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_data_master_qualified_request_sdram_s1 OR internal_cpu_instruction_master_qualified_request_sdram_s1));
  --assign sdram_s1_readdatavalid_from_sa = sdram_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  sdram_s1_readdatavalid_from_sa <= sdram_s1_readdatavalid;
  --assign sdram_s1_readdata_from_sa = sdram_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  sdram_s1_readdata_from_sa <= sdram_s1_readdata;
  internal_cpu_data_master_requests_sdram_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 23) & std_logic_vector'("00000000000000000000000")) = std_logic_vector'("0100000000000000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign sdram_s1_waitrequest_from_sa = sdram_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_sdram_s1_waitrequest_from_sa <= sdram_s1_waitrequest;
  --sdram_s1_arb_share_counter set values, which is an e_mux
  sdram_s1_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_instruction_master_granted_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_instruction_master_granted_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001"))))), 3);
  --sdram_s1_non_bursting_master_requests mux, which is an e_mux
  sdram_s1_non_bursting_master_requests <= ((internal_cpu_data_master_requests_sdram_s1 OR internal_cpu_instruction_master_requests_sdram_s1) OR internal_cpu_data_master_requests_sdram_s1) OR internal_cpu_instruction_master_requests_sdram_s1;
  --sdram_s1_any_bursting_master_saved_grant mux, which is an e_mux
  sdram_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --sdram_s1_arb_share_counter_next_value assignment, which is an e_assign
  sdram_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(sdram_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (sdram_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(sdram_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (sdram_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --sdram_s1_allgrants all slave grants, which is an e_mux
  sdram_s1_allgrants <= (((or_reduce(sdram_s1_grant_vector)) OR (or_reduce(sdram_s1_grant_vector))) OR (or_reduce(sdram_s1_grant_vector))) OR (or_reduce(sdram_s1_grant_vector));
  --sdram_s1_end_xfer assignment, which is an e_assign
  sdram_s1_end_xfer <= NOT ((sdram_s1_waits_for_read OR sdram_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_sdram_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_sdram_s1 <= sdram_s1_end_xfer AND (((NOT sdram_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --sdram_s1_arb_share_counter arbitration counter enable, which is an e_assign
  sdram_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_sdram_s1 AND sdram_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_sdram_s1 AND NOT sdram_s1_non_bursting_master_requests));
  --sdram_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_s1_arb_counter_enable) = '1' then 
        sdram_s1_arb_share_counter <= sdram_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --sdram_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(sdram_s1_master_qreq_vector) AND end_xfer_arb_share_counter_term_sdram_s1)) OR ((end_xfer_arb_share_counter_term_sdram_s1 AND NOT sdram_s1_non_bursting_master_requests)))) = '1' then 
        sdram_s1_slavearbiterlockenable <= or_reduce(sdram_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master sdram/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= sdram_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --sdram_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  sdram_s1_slavearbiterlockenable2 <= or_reduce(sdram_s1_arb_share_counter_next_value);
  --cpu/data_master sdram/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= sdram_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --cpu/instruction_master sdram/s1 arbiterlock, which is an e_assign
  cpu_instruction_master_arbiterlock <= sdram_s1_slavearbiterlockenable AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master sdram/s1 arbiterlock2, which is an e_assign
  cpu_instruction_master_arbiterlock2 <= sdram_s1_slavearbiterlockenable2 AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master granted sdram/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_instruction_master_granted_slave_sdram_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_instruction_master_granted_slave_sdram_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_instruction_master_saved_grant_sdram_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((sdram_s1_arbitration_holdoff_internal OR NOT internal_cpu_instruction_master_requests_sdram_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_instruction_master_granted_slave_sdram_s1))))));
    end if;

  end process;

  --cpu_instruction_master_continuerequest continued request, which is an e_mux
  cpu_instruction_master_continuerequest <= last_cycle_cpu_instruction_master_granted_slave_sdram_s1 AND internal_cpu_instruction_master_requests_sdram_s1;
  --sdram_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  sdram_s1_any_continuerequest <= cpu_instruction_master_continuerequest OR cpu_data_master_continuerequest;
  internal_cpu_data_master_qualified_request_sdram_s1 <= internal_cpu_data_master_requests_sdram_s1 AND NOT (((((cpu_data_master_read AND ((NOT cpu_data_master_waitrequest OR (internal_cpu_data_master_read_data_valid_sdram_s1_shift_register))))) OR (((((NOT cpu_data_master_waitrequest OR cpu_data_master_no_byte_enables_and_last_term) OR NOT(or_reduce(internal_cpu_data_master_byteenable_sdram_s1)))) AND cpu_data_master_write))) OR cpu_instruction_master_arbiterlock));
  --unique name for sdram_s1_move_on_to_next_transaction, which is an e_assign
  sdram_s1_move_on_to_next_transaction <= sdram_s1_readdatavalid_from_sa;
  --rdv_fifo_for_cpu_data_master_to_sdram_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_data_master_to_sdram_s1 : rdv_fifo_for_cpu_data_master_to_sdram_s1_module
    port map(
      data_out => cpu_data_master_rdv_fifo_output_from_sdram_s1,
      empty => open,
      fifo_contains_ones_n => cpu_data_master_rdv_fifo_empty_sdram_s1,
      full => open,
      clear_fifo => module_input,
      clk => clk,
      data_in => internal_cpu_data_master_granted_sdram_s1,
      read => sdram_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input1,
      write => module_input2
    );

  module_input <= std_logic'('0');
  module_input1 <= std_logic'('0');
  module_input2 <= in_a_read_cycle AND NOT sdram_s1_waits_for_read;

  internal_cpu_data_master_read_data_valid_sdram_s1_shift_register <= NOT cpu_data_master_rdv_fifo_empty_sdram_s1;
  --local readdatavalid cpu_data_master_read_data_valid_sdram_s1, which is an e_mux
  cpu_data_master_read_data_valid_sdram_s1 <= ((sdram_s1_readdatavalid_from_sa AND cpu_data_master_rdv_fifo_output_from_sdram_s1)) AND NOT cpu_data_master_rdv_fifo_empty_sdram_s1;
  --sdram_s1_writedata mux, which is an e_mux
  sdram_s1_writedata <= cpu_data_master_dbs_write_16;
  internal_cpu_instruction_master_requests_sdram_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_instruction_master_address_to_slave(24 DOWNTO 23) & std_logic_vector'("00000000000000000000000")) = std_logic_vector'("0100000000000000000000000")))) AND (cpu_instruction_master_read))) AND cpu_instruction_master_read;
  --cpu/data_master granted sdram/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_data_master_granted_slave_sdram_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_data_master_granted_slave_sdram_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_data_master_saved_grant_sdram_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((sdram_s1_arbitration_holdoff_internal OR NOT internal_cpu_data_master_requests_sdram_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_data_master_granted_slave_sdram_s1))))));
    end if;

  end process;

  --cpu_data_master_continuerequest continued request, which is an e_mux
  cpu_data_master_continuerequest <= last_cycle_cpu_data_master_granted_slave_sdram_s1 AND internal_cpu_data_master_requests_sdram_s1;
  internal_cpu_instruction_master_qualified_request_sdram_s1 <= internal_cpu_instruction_master_requests_sdram_s1 AND NOT ((((cpu_instruction_master_read AND ((to_std_logic(((((std_logic_vector'("000000000000000000000000000000") & (cpu_instruction_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))) OR ((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("000000000000000000000000000000") & (cpu_instruction_master_latency_counter)))))) OR (cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register))))) OR cpu_data_master_arbiterlock));
  --rdv_fifo_for_cpu_instruction_master_to_sdram_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_instruction_master_to_sdram_s1 : rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module
    port map(
      data_out => cpu_instruction_master_rdv_fifo_output_from_sdram_s1,
      empty => open,
      fifo_contains_ones_n => cpu_instruction_master_rdv_fifo_empty_sdram_s1,
      full => open,
      clear_fifo => module_input3,
      clk => clk,
      data_in => internal_cpu_instruction_master_granted_sdram_s1,
      read => sdram_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input4,
      write => module_input5
    );

  module_input3 <= std_logic'('0');
  module_input4 <= std_logic'('0');
  module_input5 <= in_a_read_cycle AND NOT sdram_s1_waits_for_read;

  cpu_instruction_master_read_data_valid_sdram_s1_shift_register <= NOT cpu_instruction_master_rdv_fifo_empty_sdram_s1;
  --local readdatavalid cpu_instruction_master_read_data_valid_sdram_s1, which is an e_mux
  cpu_instruction_master_read_data_valid_sdram_s1 <= ((sdram_s1_readdatavalid_from_sa AND cpu_instruction_master_rdv_fifo_output_from_sdram_s1)) AND NOT cpu_instruction_master_rdv_fifo_empty_sdram_s1;
  --allow new arb cycle for sdram/s1, which is an e_assign
  sdram_s1_allow_new_arb_cycle <= NOT cpu_data_master_arbiterlock AND NOT cpu_instruction_master_arbiterlock;
  --cpu/instruction_master assignment into master qualified-requests vector for sdram/s1, which is an e_assign
  sdram_s1_master_qreq_vector(0) <= internal_cpu_instruction_master_qualified_request_sdram_s1;
  --cpu/instruction_master grant sdram/s1, which is an e_assign
  internal_cpu_instruction_master_granted_sdram_s1 <= sdram_s1_grant_vector(0);
  --cpu/instruction_master saved-grant sdram/s1, which is an e_assign
  cpu_instruction_master_saved_grant_sdram_s1 <= sdram_s1_arb_winner(0) AND internal_cpu_instruction_master_requests_sdram_s1;
  --cpu/data_master assignment into master qualified-requests vector for sdram/s1, which is an e_assign
  sdram_s1_master_qreq_vector(1) <= internal_cpu_data_master_qualified_request_sdram_s1;
  --cpu/data_master grant sdram/s1, which is an e_assign
  internal_cpu_data_master_granted_sdram_s1 <= sdram_s1_grant_vector(1);
  --cpu/data_master saved-grant sdram/s1, which is an e_assign
  cpu_data_master_saved_grant_sdram_s1 <= sdram_s1_arb_winner(1) AND internal_cpu_data_master_requests_sdram_s1;
  --sdram/s1 chosen-master double-vector, which is an e_assign
  sdram_s1_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((sdram_s1_master_qreq_vector & sdram_s1_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT sdram_s1_master_qreq_vector & NOT sdram_s1_master_qreq_vector))) + (std_logic_vector'("000") & (sdram_s1_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  sdram_s1_arb_winner <= A_WE_StdLogicVector((std_logic'(((sdram_s1_allow_new_arb_cycle AND or_reduce(sdram_s1_grant_vector)))) = '1'), sdram_s1_grant_vector, sdram_s1_saved_chosen_master_vector);
  --saved sdram_s1_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_s1_allow_new_arb_cycle) = '1' then 
        sdram_s1_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(sdram_s1_grant_vector)) = '1'), sdram_s1_grant_vector, sdram_s1_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  sdram_s1_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((sdram_s1_chosen_master_double_vector(1) OR sdram_s1_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((sdram_s1_chosen_master_double_vector(0) OR sdram_s1_chosen_master_double_vector(2)))));
  --sdram/s1 chosen master rotated left, which is an e_assign
  sdram_s1_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(sdram_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(sdram_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --sdram/s1's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(sdram_s1_grant_vector)) = '1' then 
        sdram_s1_arb_addend <= A_WE_StdLogicVector((std_logic'(sdram_s1_end_xfer) = '1'), sdram_s1_chosen_master_rot_left, sdram_s1_grant_vector);
      end if;
    end if;

  end process;

  --sdram_s1_reset_n assignment, which is an e_assign
  sdram_s1_reset_n <= reset_n;
  sdram_s1_chipselect <= internal_cpu_data_master_granted_sdram_s1 OR internal_cpu_instruction_master_granted_sdram_s1;
  --sdram_s1_firsttransfer first transaction, which is an e_assign
  sdram_s1_firsttransfer <= A_WE_StdLogic((std_logic'(sdram_s1_begins_xfer) = '1'), sdram_s1_unreg_firsttransfer, sdram_s1_reg_firsttransfer);
  --sdram_s1_unreg_firsttransfer first transaction, which is an e_assign
  sdram_s1_unreg_firsttransfer <= NOT ((sdram_s1_slavearbiterlockenable AND sdram_s1_any_continuerequest));
  --sdram_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_s1_begins_xfer) = '1' then 
        sdram_s1_reg_firsttransfer <= sdram_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --sdram_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  sdram_s1_beginbursttransfer_internal <= sdram_s1_begins_xfer;
  --sdram_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  sdram_s1_arbitration_holdoff_internal <= sdram_s1_begins_xfer AND sdram_s1_firsttransfer;
  --~sdram_s1_read_n assignment, which is an e_mux
  sdram_s1_read_n <= NOT ((((internal_cpu_data_master_granted_sdram_s1 AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_sdram_s1 AND cpu_instruction_master_read))));
  --~sdram_s1_write_n assignment, which is an e_mux
  sdram_s1_write_n <= NOT ((internal_cpu_data_master_granted_sdram_s1 AND cpu_data_master_write));
  shifted_address_to_sdram_s1_from_cpu_data_master <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_data_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 25);
  --sdram_s1_address mux, which is an e_mux
  sdram_s1_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_sdram_s1)) = '1'), (A_SRL(shifted_address_to_sdram_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000001"))), (A_SRL(shifted_address_to_sdram_s1_from_cpu_instruction_master,std_logic_vector'("00000000000000000000000000000001")))), 22);
  shifted_address_to_sdram_s1_from_cpu_instruction_master <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_instruction_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_instruction_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 25);
  --d1_sdram_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_sdram_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_sdram_s1_end_xfer <= sdram_s1_end_xfer;
    end if;

  end process;

  --sdram_s1_waits_for_read in a cycle, which is an e_mux
  sdram_s1_waits_for_read <= sdram_s1_in_a_read_cycle AND internal_sdram_s1_waitrequest_from_sa;
  --sdram_s1_in_a_read_cycle assignment, which is an e_assign
  sdram_s1_in_a_read_cycle <= ((internal_cpu_data_master_granted_sdram_s1 AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_sdram_s1 AND cpu_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= sdram_s1_in_a_read_cycle;
  --sdram_s1_waits_for_write in a cycle, which is an e_mux
  sdram_s1_waits_for_write <= sdram_s1_in_a_write_cycle AND internal_sdram_s1_waitrequest_from_sa;
  --sdram_s1_in_a_write_cycle assignment, which is an e_assign
  sdram_s1_in_a_write_cycle <= internal_cpu_data_master_granted_sdram_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= sdram_s1_in_a_write_cycle;
  wait_for_sdram_s1_counter <= std_logic'('0');
  --~sdram_s1_byteenable_n byte enable port mux, which is an e_mux
  sdram_s1_byteenable_n <= A_EXT (NOT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_sdram_s1)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_cpu_data_master_byteenable_sdram_s1)), -SIGNED(std_logic_vector'("00000000000000000000000000000001")))), 2);
  (cpu_data_master_byteenable_sdram_s1_segment_1(1), cpu_data_master_byteenable_sdram_s1_segment_1(0), cpu_data_master_byteenable_sdram_s1_segment_0(1), cpu_data_master_byteenable_sdram_s1_segment_0(0)) <= cpu_data_master_byteenable;
  internal_cpu_data_master_byteenable_sdram_s1 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_data_master_byteenable_sdram_s1_segment_0, cpu_data_master_byteenable_sdram_s1_segment_1);
  --vhdl renameroo for output signals
  cpu_data_master_byteenable_sdram_s1 <= internal_cpu_data_master_byteenable_sdram_s1;
  --vhdl renameroo for output signals
  cpu_data_master_granted_sdram_s1 <= internal_cpu_data_master_granted_sdram_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_sdram_s1 <= internal_cpu_data_master_qualified_request_sdram_s1;
  --vhdl renameroo for output signals
  cpu_data_master_read_data_valid_sdram_s1_shift_register <= internal_cpu_data_master_read_data_valid_sdram_s1_shift_register;
  --vhdl renameroo for output signals
  cpu_data_master_requests_sdram_s1 <= internal_cpu_data_master_requests_sdram_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_granted_sdram_s1 <= internal_cpu_instruction_master_granted_sdram_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_qualified_request_sdram_s1 <= internal_cpu_instruction_master_qualified_request_sdram_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_requests_sdram_s1 <= internal_cpu_instruction_master_requests_sdram_s1;
  --vhdl renameroo for output signals
  sdram_s1_waitrequest_from_sa <= internal_sdram_s1_waitrequest_from_sa;
--synthesis translate_off
    --sdram/s1 enable non-zero assertions, which is an e_register
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
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_granted_sdram_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_instruction_master_granted_sdram_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
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
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_data_master_saved_grant_sdram_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_saved_grant_sdram_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
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

entity rdv_fifo_for_cpu_data_master_to_sram_avalon_sram_slave_module is 
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
end entity rdv_fifo_for_cpu_data_master_to_sram_avalon_sram_slave_module;


architecture europa of rdv_fifo_for_cpu_data_master_to_sram_avalon_sram_slave_module is
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

entity rdv_fifo_for_cpu_instruction_master_to_sram_avalon_sram_slave_module is 
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
end entity rdv_fifo_for_cpu_instruction_master_to_sram_avalon_sram_slave_module;


architecture europa of rdv_fifo_for_cpu_instruction_master_to_sram_avalon_sram_slave_module is
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

entity sram_avalon_sram_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sram_avalon_sram_slave_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sram_avalon_sram_slave_readdatavalid : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_byteenable_sram_avalon_sram_slave : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_granted_sram_avalon_sram_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_sram_avalon_sram_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sram_avalon_sram_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register : OUT STD_LOGIC;
                 signal cpu_data_master_requests_sram_avalon_sram_slave : OUT STD_LOGIC;
                 signal cpu_instruction_master_granted_sram_avalon_sram_slave : OUT STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_sram_avalon_sram_slave : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register : OUT STD_LOGIC;
                 signal cpu_instruction_master_requests_sram_avalon_sram_slave : OUT STD_LOGIC;
                 signal d1_sram_avalon_sram_slave_end_xfer : OUT STD_LOGIC;
                 signal sram_avalon_sram_slave_address : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal sram_avalon_sram_slave_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal sram_avalon_sram_slave_read : OUT STD_LOGIC;
                 signal sram_avalon_sram_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sram_avalon_sram_slave_reset : OUT STD_LOGIC;
                 signal sram_avalon_sram_slave_write : OUT STD_LOGIC;
                 signal sram_avalon_sram_slave_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity sram_avalon_sram_slave_arbitrator;


architecture europa of sram_avalon_sram_slave_arbitrator is
component rdv_fifo_for_cpu_data_master_to_sram_avalon_sram_slave_module is 
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
end component rdv_fifo_for_cpu_data_master_to_sram_avalon_sram_slave_module;

component rdv_fifo_for_cpu_instruction_master_to_sram_avalon_sram_slave_module is 
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
end component rdv_fifo_for_cpu_instruction_master_to_sram_avalon_sram_slave_module;

                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_byteenable_sram_avalon_sram_slave_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_byteenable_sram_avalon_sram_slave_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_rdv_fifo_empty_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_data_master_rdv_fifo_output_from_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_data_master_saved_grant_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_instruction_master_rdv_fifo_empty_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_instruction_master_rdv_fifo_output_from_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_instruction_master_saved_grant_sram_avalon_sram_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_sram_avalon_sram_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_byteenable_sram_avalon_sram_slave :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_data_master_granted_sram_avalon_sram_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_sram_avalon_sram_slave :  STD_LOGIC;
                signal internal_cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register :  STD_LOGIC;
                signal internal_cpu_data_master_requests_sram_avalon_sram_slave :  STD_LOGIC;
                signal internal_cpu_instruction_master_granted_sram_avalon_sram_slave :  STD_LOGIC;
                signal internal_cpu_instruction_master_qualified_request_sram_avalon_sram_slave :  STD_LOGIC;
                signal internal_cpu_instruction_master_requests_sram_avalon_sram_slave :  STD_LOGIC;
                signal last_cycle_cpu_data_master_granted_slave_sram_avalon_sram_slave :  STD_LOGIC;
                signal last_cycle_cpu_instruction_master_granted_slave_sram_avalon_sram_slave :  STD_LOGIC;
                signal module_input10 :  STD_LOGIC;
                signal module_input11 :  STD_LOGIC;
                signal module_input6 :  STD_LOGIC;
                signal module_input7 :  STD_LOGIC;
                signal module_input8 :  STD_LOGIC;
                signal module_input9 :  STD_LOGIC;
                signal shifted_address_to_sram_avalon_sram_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal shifted_address_to_sram_avalon_sram_slave_from_cpu_instruction_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal sram_avalon_sram_slave_allgrants :  STD_LOGIC;
                signal sram_avalon_sram_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal sram_avalon_sram_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal sram_avalon_sram_slave_any_continuerequest :  STD_LOGIC;
                signal sram_avalon_sram_slave_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sram_avalon_sram_slave_arb_counter_enable :  STD_LOGIC;
                signal sram_avalon_sram_slave_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sram_avalon_sram_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sram_avalon_sram_slave_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sram_avalon_sram_slave_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sram_avalon_sram_slave_arbitration_holdoff_internal :  STD_LOGIC;
                signal sram_avalon_sram_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal sram_avalon_sram_slave_begins_xfer :  STD_LOGIC;
                signal sram_avalon_sram_slave_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal sram_avalon_sram_slave_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sram_avalon_sram_slave_end_xfer :  STD_LOGIC;
                signal sram_avalon_sram_slave_firsttransfer :  STD_LOGIC;
                signal sram_avalon_sram_slave_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sram_avalon_sram_slave_in_a_read_cycle :  STD_LOGIC;
                signal sram_avalon_sram_slave_in_a_write_cycle :  STD_LOGIC;
                signal sram_avalon_sram_slave_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sram_avalon_sram_slave_move_on_to_next_transaction :  STD_LOGIC;
                signal sram_avalon_sram_slave_non_bursting_master_requests :  STD_LOGIC;
                signal sram_avalon_sram_slave_readdatavalid_from_sa :  STD_LOGIC;
                signal sram_avalon_sram_slave_reg_firsttransfer :  STD_LOGIC;
                signal sram_avalon_sram_slave_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sram_avalon_sram_slave_slavearbiterlockenable :  STD_LOGIC;
                signal sram_avalon_sram_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal sram_avalon_sram_slave_unreg_firsttransfer :  STD_LOGIC;
                signal sram_avalon_sram_slave_waits_for_read :  STD_LOGIC;
                signal sram_avalon_sram_slave_waits_for_write :  STD_LOGIC;
                signal wait_for_sram_avalon_sram_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT sram_avalon_sram_slave_end_xfer;
    end if;

  end process;

  sram_avalon_sram_slave_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_data_master_qualified_request_sram_avalon_sram_slave OR internal_cpu_instruction_master_qualified_request_sram_avalon_sram_slave));
  --assign sram_avalon_sram_slave_readdatavalid_from_sa = sram_avalon_sram_slave_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  sram_avalon_sram_slave_readdatavalid_from_sa <= sram_avalon_sram_slave_readdatavalid;
  --assign sram_avalon_sram_slave_readdata_from_sa = sram_avalon_sram_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  sram_avalon_sram_slave_readdata_from_sa <= sram_avalon_sram_slave_readdata;
  internal_cpu_data_master_requests_sram_avalon_sram_slave <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 19) & std_logic_vector'("0000000000000000000")) = std_logic_vector'("1100010000000000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --sram_avalon_sram_slave_arb_share_counter set values, which is an e_mux
  sram_avalon_sram_slave_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_sram_avalon_sram_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_instruction_master_granted_sram_avalon_sram_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_sram_avalon_sram_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_instruction_master_granted_sram_avalon_sram_slave)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001"))))), 3);
  --sram_avalon_sram_slave_non_bursting_master_requests mux, which is an e_mux
  sram_avalon_sram_slave_non_bursting_master_requests <= ((internal_cpu_data_master_requests_sram_avalon_sram_slave OR internal_cpu_instruction_master_requests_sram_avalon_sram_slave) OR internal_cpu_data_master_requests_sram_avalon_sram_slave) OR internal_cpu_instruction_master_requests_sram_avalon_sram_slave;
  --sram_avalon_sram_slave_any_bursting_master_saved_grant mux, which is an e_mux
  sram_avalon_sram_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --sram_avalon_sram_slave_arb_share_counter_next_value assignment, which is an e_assign
  sram_avalon_sram_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(sram_avalon_sram_slave_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (sram_avalon_sram_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(sram_avalon_sram_slave_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (sram_avalon_sram_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --sram_avalon_sram_slave_allgrants all slave grants, which is an e_mux
  sram_avalon_sram_slave_allgrants <= (((or_reduce(sram_avalon_sram_slave_grant_vector)) OR (or_reduce(sram_avalon_sram_slave_grant_vector))) OR (or_reduce(sram_avalon_sram_slave_grant_vector))) OR (or_reduce(sram_avalon_sram_slave_grant_vector));
  --sram_avalon_sram_slave_end_xfer assignment, which is an e_assign
  sram_avalon_sram_slave_end_xfer <= NOT ((sram_avalon_sram_slave_waits_for_read OR sram_avalon_sram_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_sram_avalon_sram_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_sram_avalon_sram_slave <= sram_avalon_sram_slave_end_xfer AND (((NOT sram_avalon_sram_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --sram_avalon_sram_slave_arb_share_counter arbitration counter enable, which is an e_assign
  sram_avalon_sram_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_sram_avalon_sram_slave AND sram_avalon_sram_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_sram_avalon_sram_slave AND NOT sram_avalon_sram_slave_non_bursting_master_requests));
  --sram_avalon_sram_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sram_avalon_sram_slave_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(sram_avalon_sram_slave_arb_counter_enable) = '1' then 
        sram_avalon_sram_slave_arb_share_counter <= sram_avalon_sram_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --sram_avalon_sram_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sram_avalon_sram_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(sram_avalon_sram_slave_master_qreq_vector) AND end_xfer_arb_share_counter_term_sram_avalon_sram_slave)) OR ((end_xfer_arb_share_counter_term_sram_avalon_sram_slave AND NOT sram_avalon_sram_slave_non_bursting_master_requests)))) = '1' then 
        sram_avalon_sram_slave_slavearbiterlockenable <= or_reduce(sram_avalon_sram_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master sram/avalon_sram_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= sram_avalon_sram_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --sram_avalon_sram_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  sram_avalon_sram_slave_slavearbiterlockenable2 <= or_reduce(sram_avalon_sram_slave_arb_share_counter_next_value);
  --cpu/data_master sram/avalon_sram_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= sram_avalon_sram_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --cpu/instruction_master sram/avalon_sram_slave arbiterlock, which is an e_assign
  cpu_instruction_master_arbiterlock <= sram_avalon_sram_slave_slavearbiterlockenable AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master sram/avalon_sram_slave arbiterlock2, which is an e_assign
  cpu_instruction_master_arbiterlock2 <= sram_avalon_sram_slave_slavearbiterlockenable2 AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master granted sram/avalon_sram_slave last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_instruction_master_granted_slave_sram_avalon_sram_slave <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_instruction_master_granted_slave_sram_avalon_sram_slave <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_instruction_master_saved_grant_sram_avalon_sram_slave) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((sram_avalon_sram_slave_arbitration_holdoff_internal OR NOT internal_cpu_instruction_master_requests_sram_avalon_sram_slave))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_instruction_master_granted_slave_sram_avalon_sram_slave))))));
    end if;

  end process;

  --cpu_instruction_master_continuerequest continued request, which is an e_mux
  cpu_instruction_master_continuerequest <= last_cycle_cpu_instruction_master_granted_slave_sram_avalon_sram_slave AND internal_cpu_instruction_master_requests_sram_avalon_sram_slave;
  --sram_avalon_sram_slave_any_continuerequest at least one master continues requesting, which is an e_mux
  sram_avalon_sram_slave_any_continuerequest <= cpu_instruction_master_continuerequest OR cpu_data_master_continuerequest;
  internal_cpu_data_master_qualified_request_sram_avalon_sram_slave <= internal_cpu_data_master_requests_sram_avalon_sram_slave AND NOT (((((cpu_data_master_read AND ((NOT cpu_data_master_waitrequest OR (internal_cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register))))) OR (((((NOT cpu_data_master_waitrequest OR cpu_data_master_no_byte_enables_and_last_term) OR NOT(or_reduce(internal_cpu_data_master_byteenable_sram_avalon_sram_slave)))) AND cpu_data_master_write))) OR cpu_instruction_master_arbiterlock));
  --unique name for sram_avalon_sram_slave_move_on_to_next_transaction, which is an e_assign
  sram_avalon_sram_slave_move_on_to_next_transaction <= sram_avalon_sram_slave_readdatavalid_from_sa;
  --rdv_fifo_for_cpu_data_master_to_sram_avalon_sram_slave, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_data_master_to_sram_avalon_sram_slave : rdv_fifo_for_cpu_data_master_to_sram_avalon_sram_slave_module
    port map(
      data_out => cpu_data_master_rdv_fifo_output_from_sram_avalon_sram_slave,
      empty => open,
      fifo_contains_ones_n => cpu_data_master_rdv_fifo_empty_sram_avalon_sram_slave,
      full => open,
      clear_fifo => module_input6,
      clk => clk,
      data_in => internal_cpu_data_master_granted_sram_avalon_sram_slave,
      read => sram_avalon_sram_slave_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input7,
      write => module_input8
    );

  module_input6 <= std_logic'('0');
  module_input7 <= std_logic'('0');
  module_input8 <= in_a_read_cycle AND NOT sram_avalon_sram_slave_waits_for_read;

  internal_cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register <= NOT cpu_data_master_rdv_fifo_empty_sram_avalon_sram_slave;
  --local readdatavalid cpu_data_master_read_data_valid_sram_avalon_sram_slave, which is an e_mux
  cpu_data_master_read_data_valid_sram_avalon_sram_slave <= ((sram_avalon_sram_slave_readdatavalid_from_sa AND cpu_data_master_rdv_fifo_output_from_sram_avalon_sram_slave)) AND NOT cpu_data_master_rdv_fifo_empty_sram_avalon_sram_slave;
  --sram_avalon_sram_slave_writedata mux, which is an e_mux
  sram_avalon_sram_slave_writedata <= cpu_data_master_dbs_write_16;
  internal_cpu_instruction_master_requests_sram_avalon_sram_slave <= ((to_std_logic(((Std_Logic_Vector'(cpu_instruction_master_address_to_slave(24 DOWNTO 19) & std_logic_vector'("0000000000000000000")) = std_logic_vector'("1100010000000000000000000")))) AND (cpu_instruction_master_read))) AND cpu_instruction_master_read;
  --cpu/data_master granted sram/avalon_sram_slave last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_data_master_granted_slave_sram_avalon_sram_slave <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_data_master_granted_slave_sram_avalon_sram_slave <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_data_master_saved_grant_sram_avalon_sram_slave) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((sram_avalon_sram_slave_arbitration_holdoff_internal OR NOT internal_cpu_data_master_requests_sram_avalon_sram_slave))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_data_master_granted_slave_sram_avalon_sram_slave))))));
    end if;

  end process;

  --cpu_data_master_continuerequest continued request, which is an e_mux
  cpu_data_master_continuerequest <= last_cycle_cpu_data_master_granted_slave_sram_avalon_sram_slave AND internal_cpu_data_master_requests_sram_avalon_sram_slave;
  internal_cpu_instruction_master_qualified_request_sram_avalon_sram_slave <= internal_cpu_instruction_master_requests_sram_avalon_sram_slave AND NOT ((((cpu_instruction_master_read AND ((to_std_logic(((((std_logic_vector'("000000000000000000000000000000") & (cpu_instruction_master_latency_counter)) /= std_logic_vector'("00000000000000000000000000000000"))) OR ((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("000000000000000000000000000000") & (cpu_instruction_master_latency_counter)))))) OR (cpu_instruction_master_read_data_valid_sdram_s1_shift_register))))) OR cpu_data_master_arbiterlock));
  --rdv_fifo_for_cpu_instruction_master_to_sram_avalon_sram_slave, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_instruction_master_to_sram_avalon_sram_slave : rdv_fifo_for_cpu_instruction_master_to_sram_avalon_sram_slave_module
    port map(
      data_out => cpu_instruction_master_rdv_fifo_output_from_sram_avalon_sram_slave,
      empty => open,
      fifo_contains_ones_n => cpu_instruction_master_rdv_fifo_empty_sram_avalon_sram_slave,
      full => open,
      clear_fifo => module_input9,
      clk => clk,
      data_in => internal_cpu_instruction_master_granted_sram_avalon_sram_slave,
      read => sram_avalon_sram_slave_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input10,
      write => module_input11
    );

  module_input9 <= std_logic'('0');
  module_input10 <= std_logic'('0');
  module_input11 <= in_a_read_cycle AND NOT sram_avalon_sram_slave_waits_for_read;

  cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register <= NOT cpu_instruction_master_rdv_fifo_empty_sram_avalon_sram_slave;
  --local readdatavalid cpu_instruction_master_read_data_valid_sram_avalon_sram_slave, which is an e_mux
  cpu_instruction_master_read_data_valid_sram_avalon_sram_slave <= ((sram_avalon_sram_slave_readdatavalid_from_sa AND cpu_instruction_master_rdv_fifo_output_from_sram_avalon_sram_slave)) AND NOT cpu_instruction_master_rdv_fifo_empty_sram_avalon_sram_slave;
  --allow new arb cycle for sram/avalon_sram_slave, which is an e_assign
  sram_avalon_sram_slave_allow_new_arb_cycle <= NOT cpu_data_master_arbiterlock AND NOT cpu_instruction_master_arbiterlock;
  --cpu/instruction_master assignment into master qualified-requests vector for sram/avalon_sram_slave, which is an e_assign
  sram_avalon_sram_slave_master_qreq_vector(0) <= internal_cpu_instruction_master_qualified_request_sram_avalon_sram_slave;
  --cpu/instruction_master grant sram/avalon_sram_slave, which is an e_assign
  internal_cpu_instruction_master_granted_sram_avalon_sram_slave <= sram_avalon_sram_slave_grant_vector(0);
  --cpu/instruction_master saved-grant sram/avalon_sram_slave, which is an e_assign
  cpu_instruction_master_saved_grant_sram_avalon_sram_slave <= sram_avalon_sram_slave_arb_winner(0) AND internal_cpu_instruction_master_requests_sram_avalon_sram_slave;
  --cpu/data_master assignment into master qualified-requests vector for sram/avalon_sram_slave, which is an e_assign
  sram_avalon_sram_slave_master_qreq_vector(1) <= internal_cpu_data_master_qualified_request_sram_avalon_sram_slave;
  --cpu/data_master grant sram/avalon_sram_slave, which is an e_assign
  internal_cpu_data_master_granted_sram_avalon_sram_slave <= sram_avalon_sram_slave_grant_vector(1);
  --cpu/data_master saved-grant sram/avalon_sram_slave, which is an e_assign
  cpu_data_master_saved_grant_sram_avalon_sram_slave <= sram_avalon_sram_slave_arb_winner(1) AND internal_cpu_data_master_requests_sram_avalon_sram_slave;
  --sram/avalon_sram_slave chosen-master double-vector, which is an e_assign
  sram_avalon_sram_slave_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((sram_avalon_sram_slave_master_qreq_vector & sram_avalon_sram_slave_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT sram_avalon_sram_slave_master_qreq_vector & NOT sram_avalon_sram_slave_master_qreq_vector))) + (std_logic_vector'("000") & (sram_avalon_sram_slave_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  sram_avalon_sram_slave_arb_winner <= A_WE_StdLogicVector((std_logic'(((sram_avalon_sram_slave_allow_new_arb_cycle AND or_reduce(sram_avalon_sram_slave_grant_vector)))) = '1'), sram_avalon_sram_slave_grant_vector, sram_avalon_sram_slave_saved_chosen_master_vector);
  --saved sram_avalon_sram_slave_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sram_avalon_sram_slave_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(sram_avalon_sram_slave_allow_new_arb_cycle) = '1' then 
        sram_avalon_sram_slave_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(sram_avalon_sram_slave_grant_vector)) = '1'), sram_avalon_sram_slave_grant_vector, sram_avalon_sram_slave_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  sram_avalon_sram_slave_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((sram_avalon_sram_slave_chosen_master_double_vector(1) OR sram_avalon_sram_slave_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((sram_avalon_sram_slave_chosen_master_double_vector(0) OR sram_avalon_sram_slave_chosen_master_double_vector(2)))));
  --sram/avalon_sram_slave chosen master rotated left, which is an e_assign
  sram_avalon_sram_slave_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(sram_avalon_sram_slave_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(sram_avalon_sram_slave_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --sram/avalon_sram_slave's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sram_avalon_sram_slave_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(sram_avalon_sram_slave_grant_vector)) = '1' then 
        sram_avalon_sram_slave_arb_addend <= A_WE_StdLogicVector((std_logic'(sram_avalon_sram_slave_end_xfer) = '1'), sram_avalon_sram_slave_chosen_master_rot_left, sram_avalon_sram_slave_grant_vector);
      end if;
    end if;

  end process;

  --~sram_avalon_sram_slave_reset assignment, which is an e_assign
  sram_avalon_sram_slave_reset <= NOT reset_n;
  --sram_avalon_sram_slave_firsttransfer first transaction, which is an e_assign
  sram_avalon_sram_slave_firsttransfer <= A_WE_StdLogic((std_logic'(sram_avalon_sram_slave_begins_xfer) = '1'), sram_avalon_sram_slave_unreg_firsttransfer, sram_avalon_sram_slave_reg_firsttransfer);
  --sram_avalon_sram_slave_unreg_firsttransfer first transaction, which is an e_assign
  sram_avalon_sram_slave_unreg_firsttransfer <= NOT ((sram_avalon_sram_slave_slavearbiterlockenable AND sram_avalon_sram_slave_any_continuerequest));
  --sram_avalon_sram_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sram_avalon_sram_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(sram_avalon_sram_slave_begins_xfer) = '1' then 
        sram_avalon_sram_slave_reg_firsttransfer <= sram_avalon_sram_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --sram_avalon_sram_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  sram_avalon_sram_slave_beginbursttransfer_internal <= sram_avalon_sram_slave_begins_xfer;
  --sram_avalon_sram_slave_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  sram_avalon_sram_slave_arbitration_holdoff_internal <= sram_avalon_sram_slave_begins_xfer AND sram_avalon_sram_slave_firsttransfer;
  --sram_avalon_sram_slave_read assignment, which is an e_mux
  sram_avalon_sram_slave_read <= ((internal_cpu_data_master_granted_sram_avalon_sram_slave AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_sram_avalon_sram_slave AND cpu_instruction_master_read));
  --sram_avalon_sram_slave_write assignment, which is an e_mux
  sram_avalon_sram_slave_write <= internal_cpu_data_master_granted_sram_avalon_sram_slave AND cpu_data_master_write;
  shifted_address_to_sram_avalon_sram_slave_from_cpu_data_master <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_data_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 25);
  --sram_avalon_sram_slave_address mux, which is an e_mux
  sram_avalon_sram_slave_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_sram_avalon_sram_slave)) = '1'), (A_SRL(shifted_address_to_sram_avalon_sram_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000001"))), (A_SRL(shifted_address_to_sram_avalon_sram_slave_from_cpu_instruction_master,std_logic_vector'("00000000000000000000000000000001")))), 18);
  shifted_address_to_sram_avalon_sram_slave_from_cpu_instruction_master <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_instruction_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_instruction_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 25);
  --d1_sram_avalon_sram_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_sram_avalon_sram_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_sram_avalon_sram_slave_end_xfer <= sram_avalon_sram_slave_end_xfer;
    end if;

  end process;

  --sram_avalon_sram_slave_waits_for_read in a cycle, which is an e_mux
  sram_avalon_sram_slave_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(sram_avalon_sram_slave_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --sram_avalon_sram_slave_in_a_read_cycle assignment, which is an e_assign
  sram_avalon_sram_slave_in_a_read_cycle <= ((internal_cpu_data_master_granted_sram_avalon_sram_slave AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_sram_avalon_sram_slave AND cpu_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= sram_avalon_sram_slave_in_a_read_cycle;
  --sram_avalon_sram_slave_waits_for_write in a cycle, which is an e_mux
  sram_avalon_sram_slave_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(sram_avalon_sram_slave_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --sram_avalon_sram_slave_in_a_write_cycle assignment, which is an e_assign
  sram_avalon_sram_slave_in_a_write_cycle <= internal_cpu_data_master_granted_sram_avalon_sram_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= sram_avalon_sram_slave_in_a_write_cycle;
  wait_for_sram_avalon_sram_slave_counter <= std_logic'('0');
  --sram_avalon_sram_slave_byteenable byte enable port mux, which is an e_mux
  sram_avalon_sram_slave_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_sram_avalon_sram_slave)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_cpu_data_master_byteenable_sram_avalon_sram_slave)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 2);
  (cpu_data_master_byteenable_sram_avalon_sram_slave_segment_1(1), cpu_data_master_byteenable_sram_avalon_sram_slave_segment_1(0), cpu_data_master_byteenable_sram_avalon_sram_slave_segment_0(1), cpu_data_master_byteenable_sram_avalon_sram_slave_segment_0(0)) <= cpu_data_master_byteenable;
  internal_cpu_data_master_byteenable_sram_avalon_sram_slave <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_data_master_byteenable_sram_avalon_sram_slave_segment_0, cpu_data_master_byteenable_sram_avalon_sram_slave_segment_1);
  --vhdl renameroo for output signals
  cpu_data_master_byteenable_sram_avalon_sram_slave <= internal_cpu_data_master_byteenable_sram_avalon_sram_slave;
  --vhdl renameroo for output signals
  cpu_data_master_granted_sram_avalon_sram_slave <= internal_cpu_data_master_granted_sram_avalon_sram_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_sram_avalon_sram_slave <= internal_cpu_data_master_qualified_request_sram_avalon_sram_slave;
  --vhdl renameroo for output signals
  cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register <= internal_cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register;
  --vhdl renameroo for output signals
  cpu_data_master_requests_sram_avalon_sram_slave <= internal_cpu_data_master_requests_sram_avalon_sram_slave;
  --vhdl renameroo for output signals
  cpu_instruction_master_granted_sram_avalon_sram_slave <= internal_cpu_instruction_master_granted_sram_avalon_sram_slave;
  --vhdl renameroo for output signals
  cpu_instruction_master_qualified_request_sram_avalon_sram_slave <= internal_cpu_instruction_master_qualified_request_sram_avalon_sram_slave;
  --vhdl renameroo for output signals
  cpu_instruction_master_requests_sram_avalon_sram_slave <= internal_cpu_instruction_master_requests_sram_avalon_sram_slave;
--synthesis translate_off
    --sram/avalon_sram_slave enable non-zero assertions, which is an e_register
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
    VARIABLE write_line8 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_granted_sram_avalon_sram_slave))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_instruction_master_granted_sram_avalon_sram_slave))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line8, now);
          write(write_line8, string'(": "));
          write(write_line8, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line8.all);
          deallocate (write_line8);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line9 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_data_master_saved_grant_sram_avalon_sram_slave))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_saved_grant_sram_avalon_sram_slave))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line9, now);
          write(write_line9, string'(": "));
          write(write_line9, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line9.all);
          deallocate (write_line9);
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

entity switches_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal switches_s1_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

              -- outputs:
                 signal cpu_data_master_granted_switches_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_switches_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_switches_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_switches_s1 : OUT STD_LOGIC;
                 signal d1_switches_s1_end_xfer : OUT STD_LOGIC;
                 signal switches_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal switches_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal switches_s1_reset_n : OUT STD_LOGIC
              );
end entity switches_s1_arbitrator;


architecture europa of switches_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_switches_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_switches_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_switches_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_switches_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_switches_s1 :  STD_LOGIC;
                signal shifted_address_to_switches_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal switches_s1_allgrants :  STD_LOGIC;
                signal switches_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal switches_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal switches_s1_any_continuerequest :  STD_LOGIC;
                signal switches_s1_arb_counter_enable :  STD_LOGIC;
                signal switches_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal switches_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal switches_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal switches_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal switches_s1_begins_xfer :  STD_LOGIC;
                signal switches_s1_end_xfer :  STD_LOGIC;
                signal switches_s1_firsttransfer :  STD_LOGIC;
                signal switches_s1_grant_vector :  STD_LOGIC;
                signal switches_s1_in_a_read_cycle :  STD_LOGIC;
                signal switches_s1_in_a_write_cycle :  STD_LOGIC;
                signal switches_s1_master_qreq_vector :  STD_LOGIC;
                signal switches_s1_non_bursting_master_requests :  STD_LOGIC;
                signal switches_s1_reg_firsttransfer :  STD_LOGIC;
                signal switches_s1_slavearbiterlockenable :  STD_LOGIC;
                signal switches_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal switches_s1_unreg_firsttransfer :  STD_LOGIC;
                signal switches_s1_waits_for_read :  STD_LOGIC;
                signal switches_s1_waits_for_write :  STD_LOGIC;
                signal wait_for_switches_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT switches_s1_end_xfer;
    end if;

  end process;

  switches_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_switches_s1);
  --assign switches_s1_readdata_from_sa = switches_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  switches_s1_readdata_from_sa <= switches_s1_readdata;
  internal_cpu_data_master_requests_switches_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("1100100000001000001010000")))) AND ((cpu_data_master_read OR cpu_data_master_write)))) AND cpu_data_master_read;
  --switches_s1_arb_share_counter set values, which is an e_mux
  switches_s1_arb_share_set_values <= std_logic_vector'("001");
  --switches_s1_non_bursting_master_requests mux, which is an e_mux
  switches_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_switches_s1;
  --switches_s1_any_bursting_master_saved_grant mux, which is an e_mux
  switches_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --switches_s1_arb_share_counter_next_value assignment, which is an e_assign
  switches_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(switches_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (switches_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(switches_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (switches_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --switches_s1_allgrants all slave grants, which is an e_mux
  switches_s1_allgrants <= switches_s1_grant_vector;
  --switches_s1_end_xfer assignment, which is an e_assign
  switches_s1_end_xfer <= NOT ((switches_s1_waits_for_read OR switches_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_switches_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_switches_s1 <= switches_s1_end_xfer AND (((NOT switches_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --switches_s1_arb_share_counter arbitration counter enable, which is an e_assign
  switches_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_switches_s1 AND switches_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_switches_s1 AND NOT switches_s1_non_bursting_master_requests));
  --switches_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      switches_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(switches_s1_arb_counter_enable) = '1' then 
        switches_s1_arb_share_counter <= switches_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --switches_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      switches_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((switches_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_switches_s1)) OR ((end_xfer_arb_share_counter_term_switches_s1 AND NOT switches_s1_non_bursting_master_requests)))) = '1' then 
        switches_s1_slavearbiterlockenable <= or_reduce(switches_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master switches/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= switches_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --switches_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  switches_s1_slavearbiterlockenable2 <= or_reduce(switches_s1_arb_share_counter_next_value);
  --cpu/data_master switches/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= switches_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --switches_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  switches_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_switches_s1 <= internal_cpu_data_master_requests_switches_s1;
  --master is always granted when requested
  internal_cpu_data_master_granted_switches_s1 <= internal_cpu_data_master_qualified_request_switches_s1;
  --cpu/data_master saved-grant switches/s1, which is an e_assign
  cpu_data_master_saved_grant_switches_s1 <= internal_cpu_data_master_requests_switches_s1;
  --allow new arb cycle for switches/s1, which is an e_assign
  switches_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  switches_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  switches_s1_master_qreq_vector <= std_logic'('1');
  --switches_s1_reset_n assignment, which is an e_assign
  switches_s1_reset_n <= reset_n;
  --switches_s1_firsttransfer first transaction, which is an e_assign
  switches_s1_firsttransfer <= A_WE_StdLogic((std_logic'(switches_s1_begins_xfer) = '1'), switches_s1_unreg_firsttransfer, switches_s1_reg_firsttransfer);
  --switches_s1_unreg_firsttransfer first transaction, which is an e_assign
  switches_s1_unreg_firsttransfer <= NOT ((switches_s1_slavearbiterlockenable AND switches_s1_any_continuerequest));
  --switches_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      switches_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(switches_s1_begins_xfer) = '1' then 
        switches_s1_reg_firsttransfer <= switches_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --switches_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  switches_s1_beginbursttransfer_internal <= switches_s1_begins_xfer;
  shifted_address_to_switches_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --switches_s1_address mux, which is an e_mux
  switches_s1_address <= A_EXT (A_SRL(shifted_address_to_switches_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_switches_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_switches_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_switches_s1_end_xfer <= switches_s1_end_xfer;
    end if;

  end process;

  --switches_s1_waits_for_read in a cycle, which is an e_mux
  switches_s1_waits_for_read <= switches_s1_in_a_read_cycle AND switches_s1_begins_xfer;
  --switches_s1_in_a_read_cycle assignment, which is an e_assign
  switches_s1_in_a_read_cycle <= internal_cpu_data_master_granted_switches_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= switches_s1_in_a_read_cycle;
  --switches_s1_waits_for_write in a cycle, which is an e_mux
  switches_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(switches_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --switches_s1_in_a_write_cycle assignment, which is an e_assign
  switches_s1_in_a_write_cycle <= internal_cpu_data_master_granted_switches_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= switches_s1_in_a_write_cycle;
  wait_for_switches_s1_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_data_master_granted_switches_s1 <= internal_cpu_data_master_granted_switches_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_switches_s1 <= internal_cpu_data_master_qualified_request_switches_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_switches_s1 <= internal_cpu_data_master_requests_switches_s1;
--synthesis translate_off
    --switches/s1 enable non-zero assertions, which is an e_register
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

entity timer_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal timer_s1_irq : IN STD_LOGIC;
                 signal timer_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal cpu_data_master_granted_timer_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_timer_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_timer_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_timer_s1 : OUT STD_LOGIC;
                 signal d1_timer_s1_end_xfer : OUT STD_LOGIC;
                 signal timer_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal timer_s1_chipselect : OUT STD_LOGIC;
                 signal timer_s1_irq_from_sa : OUT STD_LOGIC;
                 signal timer_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal timer_s1_reset_n : OUT STD_LOGIC;
                 signal timer_s1_write_n : OUT STD_LOGIC;
                 signal timer_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity timer_s1_arbitrator;


architecture europa of timer_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_timer_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_timer_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_timer_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_timer_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_timer_s1 :  STD_LOGIC;
                signal shifted_address_to_timer_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal timer_s1_allgrants :  STD_LOGIC;
                signal timer_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal timer_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal timer_s1_any_continuerequest :  STD_LOGIC;
                signal timer_s1_arb_counter_enable :  STD_LOGIC;
                signal timer_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal timer_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal timer_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal timer_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal timer_s1_begins_xfer :  STD_LOGIC;
                signal timer_s1_end_xfer :  STD_LOGIC;
                signal timer_s1_firsttransfer :  STD_LOGIC;
                signal timer_s1_grant_vector :  STD_LOGIC;
                signal timer_s1_in_a_read_cycle :  STD_LOGIC;
                signal timer_s1_in_a_write_cycle :  STD_LOGIC;
                signal timer_s1_master_qreq_vector :  STD_LOGIC;
                signal timer_s1_non_bursting_master_requests :  STD_LOGIC;
                signal timer_s1_reg_firsttransfer :  STD_LOGIC;
                signal timer_s1_slavearbiterlockenable :  STD_LOGIC;
                signal timer_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal timer_s1_unreg_firsttransfer :  STD_LOGIC;
                signal timer_s1_waits_for_read :  STD_LOGIC;
                signal timer_s1_waits_for_write :  STD_LOGIC;
                signal wait_for_timer_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT timer_s1_end_xfer;
    end if;

  end process;

  timer_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_timer_s1);
  --assign timer_s1_readdata_from_sa = timer_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  timer_s1_readdata_from_sa <= timer_s1_readdata;
  internal_cpu_data_master_requests_timer_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("1100100000001000000100000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --timer_s1_arb_share_counter set values, which is an e_mux
  timer_s1_arb_share_set_values <= std_logic_vector'("001");
  --timer_s1_non_bursting_master_requests mux, which is an e_mux
  timer_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_timer_s1;
  --timer_s1_any_bursting_master_saved_grant mux, which is an e_mux
  timer_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --timer_s1_arb_share_counter_next_value assignment, which is an e_assign
  timer_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(timer_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (timer_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(timer_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (timer_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --timer_s1_allgrants all slave grants, which is an e_mux
  timer_s1_allgrants <= timer_s1_grant_vector;
  --timer_s1_end_xfer assignment, which is an e_assign
  timer_s1_end_xfer <= NOT ((timer_s1_waits_for_read OR timer_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_timer_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_timer_s1 <= timer_s1_end_xfer AND (((NOT timer_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --timer_s1_arb_share_counter arbitration counter enable, which is an e_assign
  timer_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_timer_s1 AND timer_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_timer_s1 AND NOT timer_s1_non_bursting_master_requests));
  --timer_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      timer_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(timer_s1_arb_counter_enable) = '1' then 
        timer_s1_arb_share_counter <= timer_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --timer_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      timer_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((timer_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_timer_s1)) OR ((end_xfer_arb_share_counter_term_timer_s1 AND NOT timer_s1_non_bursting_master_requests)))) = '1' then 
        timer_s1_slavearbiterlockenable <= or_reduce(timer_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master timer/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= timer_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --timer_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  timer_s1_slavearbiterlockenable2 <= or_reduce(timer_s1_arb_share_counter_next_value);
  --cpu/data_master timer/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= timer_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --timer_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  timer_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_timer_s1 <= internal_cpu_data_master_requests_timer_s1 AND NOT (((NOT cpu_data_master_waitrequest) AND cpu_data_master_write));
  --timer_s1_writedata mux, which is an e_mux
  timer_s1_writedata <= cpu_data_master_writedata (15 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_data_master_granted_timer_s1 <= internal_cpu_data_master_qualified_request_timer_s1;
  --cpu/data_master saved-grant timer/s1, which is an e_assign
  cpu_data_master_saved_grant_timer_s1 <= internal_cpu_data_master_requests_timer_s1;
  --allow new arb cycle for timer/s1, which is an e_assign
  timer_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  timer_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  timer_s1_master_qreq_vector <= std_logic'('1');
  --timer_s1_reset_n assignment, which is an e_assign
  timer_s1_reset_n <= reset_n;
  timer_s1_chipselect <= internal_cpu_data_master_granted_timer_s1;
  --timer_s1_firsttransfer first transaction, which is an e_assign
  timer_s1_firsttransfer <= A_WE_StdLogic((std_logic'(timer_s1_begins_xfer) = '1'), timer_s1_unreg_firsttransfer, timer_s1_reg_firsttransfer);
  --timer_s1_unreg_firsttransfer first transaction, which is an e_assign
  timer_s1_unreg_firsttransfer <= NOT ((timer_s1_slavearbiterlockenable AND timer_s1_any_continuerequest));
  --timer_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      timer_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(timer_s1_begins_xfer) = '1' then 
        timer_s1_reg_firsttransfer <= timer_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --timer_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  timer_s1_beginbursttransfer_internal <= timer_s1_begins_xfer;
  --~timer_s1_write_n assignment, which is an e_mux
  timer_s1_write_n <= NOT ((internal_cpu_data_master_granted_timer_s1 AND cpu_data_master_write));
  shifted_address_to_timer_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --timer_s1_address mux, which is an e_mux
  timer_s1_address <= A_EXT (A_SRL(shifted_address_to_timer_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_timer_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_timer_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_timer_s1_end_xfer <= timer_s1_end_xfer;
    end if;

  end process;

  --timer_s1_waits_for_read in a cycle, which is an e_mux
  timer_s1_waits_for_read <= timer_s1_in_a_read_cycle AND timer_s1_begins_xfer;
  --timer_s1_in_a_read_cycle assignment, which is an e_assign
  timer_s1_in_a_read_cycle <= internal_cpu_data_master_granted_timer_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= timer_s1_in_a_read_cycle;
  --timer_s1_waits_for_write in a cycle, which is an e_mux
  timer_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(timer_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --timer_s1_in_a_write_cycle assignment, which is an e_assign
  timer_s1_in_a_write_cycle <= internal_cpu_data_master_granted_timer_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= timer_s1_in_a_write_cycle;
  wait_for_timer_s1_counter <= std_logic'('0');
  --assign timer_s1_irq_from_sa = timer_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  timer_s1_irq_from_sa <= timer_s1_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_timer_s1 <= internal_cpu_data_master_granted_timer_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_timer_s1 <= internal_cpu_data_master_qualified_request_timer_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_timer_s1 <= internal_cpu_data_master_requests_timer_s1;
--synthesis translate_off
    --timer/s1 enable non-zero assertions, which is an e_register
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

entity uart_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal uart_s1_dataavailable : IN STD_LOGIC;
                 signal uart_s1_irq : IN STD_LOGIC;
                 signal uart_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal uart_s1_readyfordata : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_uart_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_uart_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_uart_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_uart_s1 : OUT STD_LOGIC;
                 signal d1_uart_s1_end_xfer : OUT STD_LOGIC;
                 signal uart_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                 signal uart_s1_begintransfer : OUT STD_LOGIC;
                 signal uart_s1_chipselect : OUT STD_LOGIC;
                 signal uart_s1_dataavailable_from_sa : OUT STD_LOGIC;
                 signal uart_s1_irq_from_sa : OUT STD_LOGIC;
                 signal uart_s1_read_n : OUT STD_LOGIC;
                 signal uart_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal uart_s1_readyfordata_from_sa : OUT STD_LOGIC;
                 signal uart_s1_reset_n : OUT STD_LOGIC;
                 signal uart_s1_write_n : OUT STD_LOGIC;
                 signal uart_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity uart_s1_arbitrator;


architecture europa of uart_s1_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_uart_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_uart_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_uart_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_uart_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_uart_s1 :  STD_LOGIC;
                signal shifted_address_to_uart_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal uart_s1_allgrants :  STD_LOGIC;
                signal uart_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal uart_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal uart_s1_any_continuerequest :  STD_LOGIC;
                signal uart_s1_arb_counter_enable :  STD_LOGIC;
                signal uart_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal uart_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal uart_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal uart_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal uart_s1_begins_xfer :  STD_LOGIC;
                signal uart_s1_end_xfer :  STD_LOGIC;
                signal uart_s1_firsttransfer :  STD_LOGIC;
                signal uart_s1_grant_vector :  STD_LOGIC;
                signal uart_s1_in_a_read_cycle :  STD_LOGIC;
                signal uart_s1_in_a_write_cycle :  STD_LOGIC;
                signal uart_s1_master_qreq_vector :  STD_LOGIC;
                signal uart_s1_non_bursting_master_requests :  STD_LOGIC;
                signal uart_s1_reg_firsttransfer :  STD_LOGIC;
                signal uart_s1_slavearbiterlockenable :  STD_LOGIC;
                signal uart_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal uart_s1_unreg_firsttransfer :  STD_LOGIC;
                signal uart_s1_waits_for_read :  STD_LOGIC;
                signal uart_s1_waits_for_write :  STD_LOGIC;
                signal wait_for_uart_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT uart_s1_end_xfer;
    end if;

  end process;

  uart_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_uart_s1);
  --assign uart_s1_readdata_from_sa = uart_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  uart_s1_readdata_from_sa <= uart_s1_readdata;
  internal_cpu_data_master_requests_uart_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 5) & std_logic_vector'("00000")) = std_logic_vector'("1100100000001000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign uart_s1_dataavailable_from_sa = uart_s1_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  uart_s1_dataavailable_from_sa <= uart_s1_dataavailable;
  --assign uart_s1_readyfordata_from_sa = uart_s1_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  uart_s1_readyfordata_from_sa <= uart_s1_readyfordata;
  --uart_s1_arb_share_counter set values, which is an e_mux
  uart_s1_arb_share_set_values <= std_logic_vector'("001");
  --uart_s1_non_bursting_master_requests mux, which is an e_mux
  uart_s1_non_bursting_master_requests <= internal_cpu_data_master_requests_uart_s1;
  --uart_s1_any_bursting_master_saved_grant mux, which is an e_mux
  uart_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --uart_s1_arb_share_counter_next_value assignment, which is an e_assign
  uart_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(uart_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (uart_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(uart_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (uart_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --uart_s1_allgrants all slave grants, which is an e_mux
  uart_s1_allgrants <= uart_s1_grant_vector;
  --uart_s1_end_xfer assignment, which is an e_assign
  uart_s1_end_xfer <= NOT ((uart_s1_waits_for_read OR uart_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_uart_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_uart_s1 <= uart_s1_end_xfer AND (((NOT uart_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --uart_s1_arb_share_counter arbitration counter enable, which is an e_assign
  uart_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_uart_s1 AND uart_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_uart_s1 AND NOT uart_s1_non_bursting_master_requests));
  --uart_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      uart_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(uart_s1_arb_counter_enable) = '1' then 
        uart_s1_arb_share_counter <= uart_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --uart_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      uart_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((uart_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_uart_s1)) OR ((end_xfer_arb_share_counter_term_uart_s1 AND NOT uart_s1_non_bursting_master_requests)))) = '1' then 
        uart_s1_slavearbiterlockenable <= or_reduce(uart_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master uart/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= uart_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --uart_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  uart_s1_slavearbiterlockenable2 <= or_reduce(uart_s1_arb_share_counter_next_value);
  --cpu/data_master uart/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= uart_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --uart_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  uart_s1_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_uart_s1 <= internal_cpu_data_master_requests_uart_s1;
  --uart_s1_writedata mux, which is an e_mux
  uart_s1_writedata <= cpu_data_master_writedata (15 DOWNTO 0);
  --master is always granted when requested
  internal_cpu_data_master_granted_uart_s1 <= internal_cpu_data_master_qualified_request_uart_s1;
  --cpu/data_master saved-grant uart/s1, which is an e_assign
  cpu_data_master_saved_grant_uart_s1 <= internal_cpu_data_master_requests_uart_s1;
  --allow new arb cycle for uart/s1, which is an e_assign
  uart_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  uart_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  uart_s1_master_qreq_vector <= std_logic'('1');
  uart_s1_begintransfer <= uart_s1_begins_xfer;
  --uart_s1_reset_n assignment, which is an e_assign
  uart_s1_reset_n <= reset_n;
  uart_s1_chipselect <= internal_cpu_data_master_granted_uart_s1;
  --uart_s1_firsttransfer first transaction, which is an e_assign
  uart_s1_firsttransfer <= A_WE_StdLogic((std_logic'(uart_s1_begins_xfer) = '1'), uart_s1_unreg_firsttransfer, uart_s1_reg_firsttransfer);
  --uart_s1_unreg_firsttransfer first transaction, which is an e_assign
  uart_s1_unreg_firsttransfer <= NOT ((uart_s1_slavearbiterlockenable AND uart_s1_any_continuerequest));
  --uart_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      uart_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(uart_s1_begins_xfer) = '1' then 
        uart_s1_reg_firsttransfer <= uart_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --uart_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  uart_s1_beginbursttransfer_internal <= uart_s1_begins_xfer;
  --~uart_s1_read_n assignment, which is an e_mux
  uart_s1_read_n <= NOT ((internal_cpu_data_master_granted_uart_s1 AND cpu_data_master_read));
  --~uart_s1_write_n assignment, which is an e_mux
  uart_s1_write_n <= NOT ((internal_cpu_data_master_granted_uart_s1 AND cpu_data_master_write));
  shifted_address_to_uart_s1_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --uart_s1_address mux, which is an e_mux
  uart_s1_address <= A_EXT (A_SRL(shifted_address_to_uart_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")), 3);
  --d1_uart_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_uart_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_uart_s1_end_xfer <= uart_s1_end_xfer;
    end if;

  end process;

  --uart_s1_waits_for_read in a cycle, which is an e_mux
  uart_s1_waits_for_read <= uart_s1_in_a_read_cycle AND uart_s1_begins_xfer;
  --uart_s1_in_a_read_cycle assignment, which is an e_assign
  uart_s1_in_a_read_cycle <= internal_cpu_data_master_granted_uart_s1 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= uart_s1_in_a_read_cycle;
  --uart_s1_waits_for_write in a cycle, which is an e_mux
  uart_s1_waits_for_write <= uart_s1_in_a_write_cycle AND uart_s1_begins_xfer;
  --uart_s1_in_a_write_cycle assignment, which is an e_assign
  uart_s1_in_a_write_cycle <= internal_cpu_data_master_granted_uart_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= uart_s1_in_a_write_cycle;
  wait_for_uart_s1_counter <= std_logic'('0');
  --assign uart_s1_irq_from_sa = uart_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  uart_s1_irq_from_sa <= uart_s1_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_uart_s1 <= internal_cpu_data_master_granted_uart_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_uart_s1 <= internal_cpu_data_master_qualified_request_uart_s1;
  --vhdl renameroo for output signals
  cpu_data_master_requests_uart_s1 <= internal_cpu_data_master_requests_uart_s1;
--synthesis translate_off
    --uart/s1 enable non-zero assertions, which is an e_register
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

entity nios32_reset_clk_0_domain_synch_module is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC
              );
end entity nios32_reset_clk_0_domain_synch_module;


architecture europa of nios32_reset_clk_0_domain_synch_module is
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

entity nios32 is 
        port (
              -- 1) global signals:
                 signal clk_0 : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- the_LEDS
                 signal out_port_from_the_LEDS : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);

              -- the_buttons
                 signal in_port_to_the_buttons : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

              -- the_ext_bus_avalon_slave
                 signal address_to_the_flash : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
                 signal data_to_and_from_the_flash : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal read_n_to_the_flash : OUT STD_LOGIC;
                 signal select_n_to_the_flash : OUT STD_LOGIC;
                 signal write_n_to_the_flash : OUT STD_LOGIC;

              -- the_lcd
                 signal LCD_E_from_the_lcd : OUT STD_LOGIC;
                 signal LCD_RS_from_the_lcd : OUT STD_LOGIC;
                 signal LCD_RW_from_the_lcd : OUT STD_LOGIC;
                 signal LCD_data_to_and_from_the_lcd : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);

              -- the_sdram
                 signal zs_addr_from_the_sdram : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                 signal zs_ba_from_the_sdram : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal zs_cas_n_from_the_sdram : OUT STD_LOGIC;
                 signal zs_cke_from_the_sdram : OUT STD_LOGIC;
                 signal zs_cs_n_from_the_sdram : OUT STD_LOGIC;
                 signal zs_dq_to_and_from_the_sdram : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal zs_dqm_from_the_sdram : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal zs_ras_n_from_the_sdram : OUT STD_LOGIC;
                 signal zs_we_n_from_the_sdram : OUT STD_LOGIC;

              -- the_sram
                 signal SRAM_ADDR_from_the_sram : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal SRAM_CE_N_from_the_sram : OUT STD_LOGIC;
                 signal SRAM_DQ_to_and_from_the_sram : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SRAM_LB_N_from_the_sram : OUT STD_LOGIC;
                 signal SRAM_OE_N_from_the_sram : OUT STD_LOGIC;
                 signal SRAM_UB_N_from_the_sram : OUT STD_LOGIC;
                 signal SRAM_WE_N_from_the_sram : OUT STD_LOGIC;

              -- the_switches
                 signal in_port_to_the_switches : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

              -- the_uart
                 signal rxd_to_the_uart : IN STD_LOGIC;
                 signal txd_from_the_uart : OUT STD_LOGIC
              );
end entity nios32;


architecture europa of nios32 is
component LEDS_s1_arbitrator is 
           port (
                 -- inputs:
                    signal LEDS_s1_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal LEDS_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal LEDS_s1_chipselect : OUT STD_LOGIC;
                    signal LEDS_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal LEDS_s1_reset_n : OUT STD_LOGIC;
                    signal LEDS_s1_write_n : OUT STD_LOGIC;
                    signal LEDS_s1_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cpu_data_master_granted_LEDS_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_LEDS_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_LEDS_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_LEDS_s1 : OUT STD_LOGIC;
                    signal d1_LEDS_s1_end_xfer : OUT STD_LOGIC
                 );
end component LEDS_s1_arbitrator;

component LEDS is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component LEDS;

component buttons_s1_arbitrator is 
           port (
                 -- inputs:
                    signal buttons_s1_irq : IN STD_LOGIC;
                    signal buttons_s1_readdata : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal buttons_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal buttons_s1_chipselect : OUT STD_LOGIC;
                    signal buttons_s1_irq_from_sa : OUT STD_LOGIC;
                    signal buttons_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal buttons_s1_reset_n : OUT STD_LOGIC;
                    signal buttons_s1_write_n : OUT STD_LOGIC;
                    signal buttons_s1_writedata : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_granted_buttons_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_buttons_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_buttons_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_buttons_s1 : OUT STD_LOGIC;
                    signal d1_buttons_s1_end_xfer : OUT STD_LOGIC
                 );
end component buttons_s1_arbitrator;

component buttons is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

                 -- outputs:
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
                 );
end component buttons;

component cpu_jtag_debug_module_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_debugaccess : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register : IN STD_LOGIC;
                    signal cpu_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_jtag_debug_module_resetrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_data_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal cpu_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_jtag_debug_module_chipselect : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_write : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_cpu_jtag_debug_module_end_xfer : OUT STD_LOGIC
                 );
end component cpu_jtag_debug_module_arbitrator;

component cpu_custom_instruction_master_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_bitswap_s1_result_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_custom_instruction_master_combo_n : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_result_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_bitswap_s1_select : OUT STD_LOGIC;
                    signal cpu_custom_instruction_master_combo_result : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_custom_instruction_master_reset_n : OUT STD_LOGIC;
                    signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_select : OUT STD_LOGIC
                 );
end component cpu_custom_instruction_master_arbitrator;

component cpu_data_master_arbitrator is 
           port (
                 -- inputs:
                    signal LEDS_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal buttons_s1_irq_from_sa : IN STD_LOGIC;
                    signal buttons_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable_flash_s1 : IN STD_LOGIC;
                    signal cpu_data_master_byteenable_sdram_s1 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_byteenable_sram_avalon_sram_slave : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_granted_LEDS_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_buttons_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_granted_flash_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_lcd_control_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_sdram_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_sram_avalon_sram_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_switches_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_timer_s1 : IN STD_LOGIC;
                    signal cpu_data_master_granted_uart_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_LEDS_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_buttons_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_flash_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_lcd_control_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_sdram_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_sram_avalon_sram_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_switches_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_timer_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_uart_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_LEDS_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_buttons_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_flash_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_lcd_control_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sdram_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sram_avalon_sram_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_switches_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_timer_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_uart_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_LEDS_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_buttons_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_requests_flash_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_lcd_control_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_sdram_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_sram_avalon_sram_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_switches_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_timer_s1 : IN STD_LOGIC;
                    signal cpu_data_master_requests_uart_s1 : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_LEDS_s1_end_xfer : IN STD_LOGIC;
                    signal d1_buttons_s1_end_xfer : IN STD_LOGIC;
                    signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_ext_bus_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_jtag_uart_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                    signal d1_lcd_control_slave_end_xfer : IN STD_LOGIC;
                    signal d1_sdram_s1_end_xfer : IN STD_LOGIC;
                    signal d1_sram_avalon_sram_slave_end_xfer : IN STD_LOGIC;
                    signal d1_switches_s1_end_xfer : IN STD_LOGIC;
                    signal d1_timer_s1_end_xfer : IN STD_LOGIC;
                    signal d1_uart_s1_end_xfer : IN STD_LOGIC;
                    signal flash_s1_wait_counter_eq_0 : IN STD_LOGIC;
                    signal flash_s1_wait_counter_eq_1 : IN STD_LOGIC;
                    signal incoming_data_to_and_from_the_flash_with_Xs_converted_to_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                    signal lcd_control_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal lcd_control_slave_wait_counter_eq_0 : IN STD_LOGIC;
                    signal lcd_control_slave_wait_counter_eq_1 : IN STD_LOGIC;
                    signal registered_cpu_data_master_read_data_valid_flash_s1 : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_s1_waitrequest_from_sa : IN STD_LOGIC;
                    signal sram_avalon_sram_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal switches_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal timer_s1_irq_from_sa : IN STD_LOGIC;
                    signal timer_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal uart_s1_irq_from_sa : IN STD_LOGIC;
                    signal uart_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal cpu_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_dbs_write_8 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cpu_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_no_byte_enables_and_last_term : OUT STD_LOGIC;
                    signal cpu_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_waitrequest : OUT STD_LOGIC
                 );
end component cpu_data_master_arbitrator;

component cpu_instruction_master_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_instruction_master_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_instruction_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_granted_flash_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_granted_sdram_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_granted_sram_avalon_sram_slave : IN STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_flash_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_sdram_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_sram_avalon_sram_slave : IN STD_LOGIC;
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_flash_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sdram_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register : IN STD_LOGIC;
                    signal cpu_instruction_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_requests_flash_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_requests_sdram_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_requests_sram_avalon_sram_slave : IN STD_LOGIC;
                    signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_ext_bus_avalon_slave_end_xfer : IN STD_LOGIC;
                    signal d1_sdram_s1_end_xfer : IN STD_LOGIC;
                    signal d1_sram_avalon_sram_slave_end_xfer : IN STD_LOGIC;
                    signal flash_s1_wait_counter_eq_0 : IN STD_LOGIC;
                    signal flash_s1_wait_counter_eq_1 : IN STD_LOGIC;
                    signal incoming_data_to_and_from_the_flash : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_s1_waitrequest_from_sa : IN STD_LOGIC;
                    signal sram_avalon_sram_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal cpu_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_instruction_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_instruction_master_readdatavalid : OUT STD_LOGIC;
                    signal cpu_instruction_master_waitrequest : OUT STD_LOGIC
                 );
end component cpu_instruction_master_arbitrator;

component cpu is 
           port (
                 -- inputs:
                    signal E_ci_combo_result : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
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
                    signal E_ci_combo_a : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal E_ci_combo_b : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal E_ci_combo_c : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal E_ci_combo_dataa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal E_ci_combo_datab : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal E_ci_combo_estatus : OUT STD_LOGIC;
                    signal E_ci_combo_ipending : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal E_ci_combo_n : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal E_ci_combo_readra : OUT STD_LOGIC;
                    signal E_ci_combo_readrb : OUT STD_LOGIC;
                    signal E_ci_combo_status : OUT STD_LOGIC;
                    signal E_ci_combo_writerc : OUT STD_LOGIC;
                    signal d_address : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal d_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal d_read : OUT STD_LOGIC;
                    signal d_write : OUT STD_LOGIC;
                    signal d_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_address : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal i_read : OUT STD_LOGIC;
                    signal jtag_debug_module_debugaccess_to_roms : OUT STD_LOGIC;
                    signal jtag_debug_module_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_debug_module_resetrequest : OUT STD_LOGIC
                 );
end component cpu;

component cpu_bitswap_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_bitswap_s1_result : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_bitswap_s1_select : IN STD_LOGIC;
                    signal cpu_custom_instruction_master_combo_dataa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_custom_instruction_master_combo_datab : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_bitswap_s1_dataa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_bitswap_s1_datab : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_bitswap_s1_result_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component cpu_bitswap_s1_arbitrator;

component cpu_bitswap is 
           port (
                 -- inputs:
                    signal dataa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal datab : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal result : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component cpu_bitswap;

component cpu_custominstruction_inst_nios_custom_instruction_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_custom_instruction_master_combo_dataa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_custom_instruction_master_combo_datab : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_result : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_select : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_dataa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_datab : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_result_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component cpu_custominstruction_inst_nios_custom_instruction_slave_0_arbitrator;

component cpu_custominstruction_inst is 
           port (
                 -- inputs:
                    signal dataa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal datab : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal result : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component cpu_custominstruction_inst;

component ext_bus_avalon_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_dbs_write_8 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cpu_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal address_to_the_flash : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
                    signal cpu_data_master_byteenable_flash_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_granted_flash_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_flash_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_flash_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_flash_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_granted_flash_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_flash_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_flash_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_requests_flash_s1 : OUT STD_LOGIC;
                    signal d1_ext_bus_avalon_slave_end_xfer : OUT STD_LOGIC;
                    signal data_to_and_from_the_flash : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal flash_s1_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal flash_s1_wait_counter_eq_1 : OUT STD_LOGIC;
                    signal incoming_data_to_and_from_the_flash : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal incoming_data_to_and_from_the_flash_with_Xs_converted_to_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal read_n_to_the_flash : OUT STD_LOGIC;
                    signal registered_cpu_data_master_read_data_valid_flash_s1 : OUT STD_LOGIC;
                    signal select_n_to_the_flash : OUT STD_LOGIC;
                    signal write_n_to_the_flash : OUT STD_LOGIC
                 );
end component ext_bus_avalon_slave_arbitrator;

component ext_bus is 
end component ext_bus;

component ext_bus_bridge_arbitrator is 
end component ext_bus_bridge_arbitrator;

component jtag_uart_avalon_jtag_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_irq : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                    signal d1_jtag_uart_avalon_jtag_slave_end_xfer : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_address : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component jtag_uart_avalon_jtag_slave_arbitrator;

component jtag_uart is 
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
end component jtag_uart;

component lcd_control_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal lcd_control_slave_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_lcd_control_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_lcd_control_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_lcd_control_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_lcd_control_slave : OUT STD_LOGIC;
                    signal d1_lcd_control_slave_end_xfer : OUT STD_LOGIC;
                    signal lcd_control_slave_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal lcd_control_slave_begintransfer : OUT STD_LOGIC;
                    signal lcd_control_slave_read : OUT STD_LOGIC;
                    signal lcd_control_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal lcd_control_slave_wait_counter_eq_0 : OUT STD_LOGIC;
                    signal lcd_control_slave_wait_counter_eq_1 : OUT STD_LOGIC;
                    signal lcd_control_slave_write : OUT STD_LOGIC;
                    signal lcd_control_slave_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component lcd_control_slave_arbitrator;

component lcd is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal begintransfer : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

                 -- outputs:
                    signal LCD_E : OUT STD_LOGIC;
                    signal LCD_RS : OUT STD_LOGIC;
                    signal LCD_RW : OUT STD_LOGIC;
                    signal LCD_data : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component lcd;

component sdram_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_s1_readdatavalid : IN STD_LOGIC;
                    signal sdram_s1_waitrequest : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_byteenable_sdram_s1 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_granted_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sdram_s1_shift_register : OUT STD_LOGIC;
                    signal cpu_data_master_requests_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_granted_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : OUT STD_LOGIC;
                    signal cpu_instruction_master_requests_sdram_s1 : OUT STD_LOGIC;
                    signal d1_sdram_s1_end_xfer : OUT STD_LOGIC;
                    signal sdram_s1_address : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
                    signal sdram_s1_byteenable_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal sdram_s1_chipselect : OUT STD_LOGIC;
                    signal sdram_s1_read_n : OUT STD_LOGIC;
                    signal sdram_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_s1_reset_n : OUT STD_LOGIC;
                    signal sdram_s1_waitrequest_from_sa : OUT STD_LOGIC;
                    signal sdram_s1_write_n : OUT STD_LOGIC;
                    signal sdram_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component sdram_s1_arbitrator;

component sdram is 
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
end component sdram;

component sram_avalon_sram_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_latency_counter : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sram_avalon_sram_slave_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sram_avalon_sram_slave_readdatavalid : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_byteenable_sram_avalon_sram_slave : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_granted_sram_avalon_sram_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_sram_avalon_sram_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sram_avalon_sram_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register : OUT STD_LOGIC;
                    signal cpu_data_master_requests_sram_avalon_sram_slave : OUT STD_LOGIC;
                    signal cpu_instruction_master_granted_sram_avalon_sram_slave : OUT STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_sram_avalon_sram_slave : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register : OUT STD_LOGIC;
                    signal cpu_instruction_master_requests_sram_avalon_sram_slave : OUT STD_LOGIC;
                    signal d1_sram_avalon_sram_slave_end_xfer : OUT STD_LOGIC;
                    signal sram_avalon_sram_slave_address : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal sram_avalon_sram_slave_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal sram_avalon_sram_slave_read : OUT STD_LOGIC;
                    signal sram_avalon_sram_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sram_avalon_sram_slave_reset : OUT STD_LOGIC;
                    signal sram_avalon_sram_slave_write : OUT STD_LOGIC;
                    signal sram_avalon_sram_slave_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component sram_avalon_sram_slave_arbitrator;

component sram is 
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
end component sram;

component switches_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal switches_s1_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

                 -- outputs:
                    signal cpu_data_master_granted_switches_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_switches_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_switches_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_switches_s1 : OUT STD_LOGIC;
                    signal d1_switches_s1_end_xfer : OUT STD_LOGIC;
                    signal switches_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal switches_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal switches_s1_reset_n : OUT STD_LOGIC
                 );
end component switches_s1_arbitrator;

component switches is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal in_port : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component switches;

component timer_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal timer_s1_irq : IN STD_LOGIC;
                    signal timer_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal cpu_data_master_granted_timer_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_timer_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_timer_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_timer_s1 : OUT STD_LOGIC;
                    signal d1_timer_s1_end_xfer : OUT STD_LOGIC;
                    signal timer_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal timer_s1_chipselect : OUT STD_LOGIC;
                    signal timer_s1_irq_from_sa : OUT STD_LOGIC;
                    signal timer_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal timer_s1_reset_n : OUT STD_LOGIC;
                    signal timer_s1_write_n : OUT STD_LOGIC;
                    signal timer_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component timer_s1_arbitrator;

component timer is 
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
end component timer;

component uart_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal uart_s1_dataavailable : IN STD_LOGIC;
                    signal uart_s1_irq : IN STD_LOGIC;
                    signal uart_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal uart_s1_readyfordata : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_uart_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_uart_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_uart_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_uart_s1 : OUT STD_LOGIC;
                    signal d1_uart_s1_end_xfer : OUT STD_LOGIC;
                    signal uart_s1_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal uart_s1_begintransfer : OUT STD_LOGIC;
                    signal uart_s1_chipselect : OUT STD_LOGIC;
                    signal uart_s1_dataavailable_from_sa : OUT STD_LOGIC;
                    signal uart_s1_irq_from_sa : OUT STD_LOGIC;
                    signal uart_s1_read_n : OUT STD_LOGIC;
                    signal uart_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal uart_s1_readyfordata_from_sa : OUT STD_LOGIC;
                    signal uart_s1_reset_n : OUT STD_LOGIC;
                    signal uart_s1_write_n : OUT STD_LOGIC;
                    signal uart_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component uart_s1_arbitrator;

component uart is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                    signal begintransfer : IN STD_LOGIC;
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read_n : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal rxd : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal dataavailable : OUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal readyfordata : OUT STD_LOGIC;
                    signal txd : OUT STD_LOGIC
                 );
end component uart;

component nios32_reset_clk_0_domain_synch_module is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC
                 );
end component nios32_reset_clk_0_domain_synch_module;

                signal LEDS_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal LEDS_s1_chipselect :  STD_LOGIC;
                signal LEDS_s1_readdata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal LEDS_s1_readdata_from_sa :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal LEDS_s1_reset_n :  STD_LOGIC;
                signal LEDS_s1_write_n :  STD_LOGIC;
                signal LEDS_s1_writedata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal buttons_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal buttons_s1_chipselect :  STD_LOGIC;
                signal buttons_s1_irq :  STD_LOGIC;
                signal buttons_s1_irq_from_sa :  STD_LOGIC;
                signal buttons_s1_readdata :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal buttons_s1_readdata_from_sa :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal buttons_s1_reset_n :  STD_LOGIC;
                signal buttons_s1_write_n :  STD_LOGIC;
                signal buttons_s1_writedata :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal clk_0_reset_n :  STD_LOGIC;
                signal cpu_bitswap_s1_dataa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_bitswap_s1_datab :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_bitswap_s1_result :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_bitswap_s1_result_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_bitswap_s1_select :  STD_LOGIC;
                signal cpu_custom_instruction_master_combo_a :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal cpu_custom_instruction_master_combo_b :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal cpu_custom_instruction_master_combo_c :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal cpu_custom_instruction_master_combo_dataa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custom_instruction_master_combo_datab :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custom_instruction_master_combo_estatus :  STD_LOGIC;
                signal cpu_custom_instruction_master_combo_ipending :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custom_instruction_master_combo_n :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal cpu_custom_instruction_master_combo_readra :  STD_LOGIC;
                signal cpu_custom_instruction_master_combo_readrb :  STD_LOGIC;
                signal cpu_custom_instruction_master_combo_result :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custom_instruction_master_combo_status :  STD_LOGIC;
                signal cpu_custom_instruction_master_combo_writerc :  STD_LOGIC;
                signal cpu_custom_instruction_master_reset_n :  STD_LOGIC;
                signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_dataa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_datab :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_result :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_result_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custominstruction_inst_nios_custom_instruction_slave_0_select :  STD_LOGIC;
                signal cpu_data_master_address :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_data_master_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_data_master_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_data_master_byteenable_flash_s1 :  STD_LOGIC;
                signal cpu_data_master_byteenable_sdram_s1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_byteenable_sram_avalon_sram_slave :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_dbs_write_16 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal cpu_data_master_dbs_write_8 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal cpu_data_master_debugaccess :  STD_LOGIC;
                signal cpu_data_master_granted_LEDS_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_buttons_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_granted_flash_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_granted_lcd_control_slave :  STD_LOGIC;
                signal cpu_data_master_granted_sdram_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_data_master_granted_switches_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_timer_s1 :  STD_LOGIC;
                signal cpu_data_master_granted_uart_s1 :  STD_LOGIC;
                signal cpu_data_master_irq :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_data_master_no_byte_enables_and_last_term :  STD_LOGIC;
                signal cpu_data_master_qualified_request_LEDS_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_buttons_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_qualified_request_flash_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_lcd_control_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_sdram_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_switches_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_timer_s1 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_uart_s1 :  STD_LOGIC;
                signal cpu_data_master_read :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_LEDS_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_buttons_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_flash_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_lcd_control_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_sdram_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_sdram_s1_shift_register :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_switches_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_timer_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_uart_s1 :  STD_LOGIC;
                signal cpu_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_data_master_requests_LEDS_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_buttons_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_requests_flash_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_requests_lcd_control_slave :  STD_LOGIC;
                signal cpu_data_master_requests_sdram_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_data_master_requests_switches_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_timer_s1 :  STD_LOGIC;
                signal cpu_data_master_requests_uart_s1 :  STD_LOGIC;
                signal cpu_data_master_waitrequest :  STD_LOGIC;
                signal cpu_data_master_write :  STD_LOGIC;
                signal cpu_data_master_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_instruction_master_address :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_instruction_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_granted_flash_s1 :  STD_LOGIC;
                signal cpu_instruction_master_granted_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_granted_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_instruction_master_latency_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_qualified_request_flash_s1 :  STD_LOGIC;
                signal cpu_instruction_master_qualified_request_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_qualified_request_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_instruction_master_read :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_flash_s1 :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register :  STD_LOGIC;
                signal cpu_instruction_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_instruction_master_readdatavalid :  STD_LOGIC;
                signal cpu_instruction_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_requests_flash_s1 :  STD_LOGIC;
                signal cpu_instruction_master_requests_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_requests_sram_avalon_sram_slave :  STD_LOGIC;
                signal cpu_instruction_master_waitrequest :  STD_LOGIC;
                signal cpu_jtag_debug_module_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal cpu_jtag_debug_module_begintransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_jtag_debug_module_chipselect :  STD_LOGIC;
                signal cpu_jtag_debug_module_debugaccess :  STD_LOGIC;
                signal cpu_jtag_debug_module_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_jtag_debug_module_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_jtag_debug_module_resetrequest :  STD_LOGIC;
                signal cpu_jtag_debug_module_resetrequest_from_sa :  STD_LOGIC;
                signal cpu_jtag_debug_module_write :  STD_LOGIC;
                signal cpu_jtag_debug_module_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal d1_LEDS_s1_end_xfer :  STD_LOGIC;
                signal d1_buttons_s1_end_xfer :  STD_LOGIC;
                signal d1_cpu_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal d1_ext_bus_avalon_slave_end_xfer :  STD_LOGIC;
                signal d1_jtag_uart_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal d1_lcd_control_slave_end_xfer :  STD_LOGIC;
                signal d1_sdram_s1_end_xfer :  STD_LOGIC;
                signal d1_sram_avalon_sram_slave_end_xfer :  STD_LOGIC;
                signal d1_switches_s1_end_xfer :  STD_LOGIC;
                signal d1_timer_s1_end_xfer :  STD_LOGIC;
                signal d1_uart_s1_end_xfer :  STD_LOGIC;
                signal flash_s1_wait_counter_eq_0 :  STD_LOGIC;
                signal flash_s1_wait_counter_eq_1 :  STD_LOGIC;
                signal incoming_data_to_and_from_the_flash :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal incoming_data_to_and_from_the_flash_with_Xs_converted_to_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_LCD_E_from_the_lcd :  STD_LOGIC;
                signal internal_LCD_RS_from_the_lcd :  STD_LOGIC;
                signal internal_LCD_RW_from_the_lcd :  STD_LOGIC;
                signal internal_SRAM_ADDR_from_the_sram :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_SRAM_CE_N_from_the_sram :  STD_LOGIC;
                signal internal_SRAM_LB_N_from_the_sram :  STD_LOGIC;
                signal internal_SRAM_OE_N_from_the_sram :  STD_LOGIC;
                signal internal_SRAM_UB_N_from_the_sram :  STD_LOGIC;
                signal internal_SRAM_WE_N_from_the_sram :  STD_LOGIC;
                signal internal_address_to_the_flash :  STD_LOGIC_VECTOR (21 DOWNTO 0);
                signal internal_out_port_from_the_LEDS :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_read_n_to_the_flash :  STD_LOGIC;
                signal internal_select_n_to_the_flash :  STD_LOGIC;
                signal internal_txd_from_the_uart :  STD_LOGIC;
                signal internal_write_n_to_the_flash :  STD_LOGIC;
                signal internal_zs_addr_from_the_sdram :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal internal_zs_ba_from_the_sdram :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_zs_cas_n_from_the_sdram :  STD_LOGIC;
                signal internal_zs_cke_from_the_sdram :  STD_LOGIC;
                signal internal_zs_cs_n_from_the_sdram :  STD_LOGIC;
                signal internal_zs_dqm_from_the_sdram :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_zs_ras_n_from_the_sdram :  STD_LOGIC;
                signal internal_zs_we_n_from_the_sdram :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_address :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_chipselect :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_dataavailable :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_irq :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_irq_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_read_n :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_readyfordata :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_reset_n :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_waitrequest :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_write_n :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal lcd_control_slave_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal lcd_control_slave_begintransfer :  STD_LOGIC;
                signal lcd_control_slave_read :  STD_LOGIC;
                signal lcd_control_slave_readdata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal lcd_control_slave_readdata_from_sa :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal lcd_control_slave_wait_counter_eq_0 :  STD_LOGIC;
                signal lcd_control_slave_wait_counter_eq_1 :  STD_LOGIC;
                signal lcd_control_slave_write :  STD_LOGIC;
                signal lcd_control_slave_writedata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal module_input12 :  STD_LOGIC;
                signal registered_cpu_data_master_read_data_valid_flash_s1 :  STD_LOGIC;
                signal reset_n_sources :  STD_LOGIC;
                signal sdram_s1_address :  STD_LOGIC_VECTOR (21 DOWNTO 0);
                signal sdram_s1_byteenable_n :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_chipselect :  STD_LOGIC;
                signal sdram_s1_read_n :  STD_LOGIC;
                signal sdram_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sdram_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sdram_s1_readdatavalid :  STD_LOGIC;
                signal sdram_s1_reset_n :  STD_LOGIC;
                signal sdram_s1_waitrequest :  STD_LOGIC;
                signal sdram_s1_waitrequest_from_sa :  STD_LOGIC;
                signal sdram_s1_write_n :  STD_LOGIC;
                signal sdram_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sram_avalon_sram_slave_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal sram_avalon_sram_slave_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sram_avalon_sram_slave_read :  STD_LOGIC;
                signal sram_avalon_sram_slave_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sram_avalon_sram_slave_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sram_avalon_sram_slave_readdatavalid :  STD_LOGIC;
                signal sram_avalon_sram_slave_reset :  STD_LOGIC;
                signal sram_avalon_sram_slave_write :  STD_LOGIC;
                signal sram_avalon_sram_slave_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal switches_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal switches_s1_readdata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal switches_s1_readdata_from_sa :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal switches_s1_reset_n :  STD_LOGIC;
                signal timer_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal timer_s1_chipselect :  STD_LOGIC;
                signal timer_s1_irq :  STD_LOGIC;
                signal timer_s1_irq_from_sa :  STD_LOGIC;
                signal timer_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal timer_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal timer_s1_reset_n :  STD_LOGIC;
                signal timer_s1_write_n :  STD_LOGIC;
                signal timer_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal uart_s1_address :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal uart_s1_begintransfer :  STD_LOGIC;
                signal uart_s1_chipselect :  STD_LOGIC;
                signal uart_s1_dataavailable :  STD_LOGIC;
                signal uart_s1_dataavailable_from_sa :  STD_LOGIC;
                signal uart_s1_irq :  STD_LOGIC;
                signal uart_s1_irq_from_sa :  STD_LOGIC;
                signal uart_s1_read_n :  STD_LOGIC;
                signal uart_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal uart_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal uart_s1_readyfordata :  STD_LOGIC;
                signal uart_s1_readyfordata_from_sa :  STD_LOGIC;
                signal uart_s1_reset_n :  STD_LOGIC;
                signal uart_s1_write_n :  STD_LOGIC;
                signal uart_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);

begin

  --the_LEDS_s1, which is an e_instance
  the_LEDS_s1 : LEDS_s1_arbitrator
    port map(
      LEDS_s1_address => LEDS_s1_address,
      LEDS_s1_chipselect => LEDS_s1_chipselect,
      LEDS_s1_readdata_from_sa => LEDS_s1_readdata_from_sa,
      LEDS_s1_reset_n => LEDS_s1_reset_n,
      LEDS_s1_write_n => LEDS_s1_write_n,
      LEDS_s1_writedata => LEDS_s1_writedata,
      cpu_data_master_granted_LEDS_s1 => cpu_data_master_granted_LEDS_s1,
      cpu_data_master_qualified_request_LEDS_s1 => cpu_data_master_qualified_request_LEDS_s1,
      cpu_data_master_read_data_valid_LEDS_s1 => cpu_data_master_read_data_valid_LEDS_s1,
      cpu_data_master_requests_LEDS_s1 => cpu_data_master_requests_LEDS_s1,
      d1_LEDS_s1_end_xfer => d1_LEDS_s1_end_xfer,
      LEDS_s1_readdata => LEDS_s1_readdata,
      clk => clk_0,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => clk_0_reset_n
    );


  --the_LEDS, which is an e_ptf_instance
  the_LEDS : LEDS
    port map(
      out_port => internal_out_port_from_the_LEDS,
      readdata => LEDS_s1_readdata,
      address => LEDS_s1_address,
      chipselect => LEDS_s1_chipselect,
      clk => clk_0,
      reset_n => LEDS_s1_reset_n,
      write_n => LEDS_s1_write_n,
      writedata => LEDS_s1_writedata
    );


  --the_buttons_s1, which is an e_instance
  the_buttons_s1 : buttons_s1_arbitrator
    port map(
      buttons_s1_address => buttons_s1_address,
      buttons_s1_chipselect => buttons_s1_chipselect,
      buttons_s1_irq_from_sa => buttons_s1_irq_from_sa,
      buttons_s1_readdata_from_sa => buttons_s1_readdata_from_sa,
      buttons_s1_reset_n => buttons_s1_reset_n,
      buttons_s1_write_n => buttons_s1_write_n,
      buttons_s1_writedata => buttons_s1_writedata,
      cpu_data_master_granted_buttons_s1 => cpu_data_master_granted_buttons_s1,
      cpu_data_master_qualified_request_buttons_s1 => cpu_data_master_qualified_request_buttons_s1,
      cpu_data_master_read_data_valid_buttons_s1 => cpu_data_master_read_data_valid_buttons_s1,
      cpu_data_master_requests_buttons_s1 => cpu_data_master_requests_buttons_s1,
      d1_buttons_s1_end_xfer => d1_buttons_s1_end_xfer,
      buttons_s1_irq => buttons_s1_irq,
      buttons_s1_readdata => buttons_s1_readdata,
      clk => clk_0,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => clk_0_reset_n
    );


  --the_buttons, which is an e_ptf_instance
  the_buttons : buttons
    port map(
      irq => buttons_s1_irq,
      readdata => buttons_s1_readdata,
      address => buttons_s1_address,
      chipselect => buttons_s1_chipselect,
      clk => clk_0,
      in_port => in_port_to_the_buttons,
      reset_n => buttons_s1_reset_n,
      write_n => buttons_s1_write_n,
      writedata => buttons_s1_writedata
    );


  --the_cpu_jtag_debug_module, which is an e_instance
  the_cpu_jtag_debug_module : cpu_jtag_debug_module_arbitrator
    port map(
      cpu_data_master_granted_cpu_jtag_debug_module => cpu_data_master_granted_cpu_jtag_debug_module,
      cpu_data_master_qualified_request_cpu_jtag_debug_module => cpu_data_master_qualified_request_cpu_jtag_debug_module,
      cpu_data_master_read_data_valid_cpu_jtag_debug_module => cpu_data_master_read_data_valid_cpu_jtag_debug_module,
      cpu_data_master_requests_cpu_jtag_debug_module => cpu_data_master_requests_cpu_jtag_debug_module,
      cpu_instruction_master_granted_cpu_jtag_debug_module => cpu_instruction_master_granted_cpu_jtag_debug_module,
      cpu_instruction_master_qualified_request_cpu_jtag_debug_module => cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
      cpu_instruction_master_read_data_valid_cpu_jtag_debug_module => cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
      cpu_instruction_master_requests_cpu_jtag_debug_module => cpu_instruction_master_requests_cpu_jtag_debug_module,
      cpu_jtag_debug_module_address => cpu_jtag_debug_module_address,
      cpu_jtag_debug_module_begintransfer => cpu_jtag_debug_module_begintransfer,
      cpu_jtag_debug_module_byteenable => cpu_jtag_debug_module_byteenable,
      cpu_jtag_debug_module_chipselect => cpu_jtag_debug_module_chipselect,
      cpu_jtag_debug_module_debugaccess => cpu_jtag_debug_module_debugaccess,
      cpu_jtag_debug_module_readdata_from_sa => cpu_jtag_debug_module_readdata_from_sa,
      cpu_jtag_debug_module_resetrequest_from_sa => cpu_jtag_debug_module_resetrequest_from_sa,
      cpu_jtag_debug_module_write => cpu_jtag_debug_module_write,
      cpu_jtag_debug_module_writedata => cpu_jtag_debug_module_writedata,
      d1_cpu_jtag_debug_module_end_xfer => d1_cpu_jtag_debug_module_end_xfer,
      clk => clk_0,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_debugaccess => cpu_data_master_debugaccess,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_read => cpu_instruction_master_read,
      cpu_instruction_master_read_data_valid_sdram_s1_shift_register => cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
      cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register => cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register,
      cpu_jtag_debug_module_readdata => cpu_jtag_debug_module_readdata,
      cpu_jtag_debug_module_resetrequest => cpu_jtag_debug_module_resetrequest,
      reset_n => clk_0_reset_n
    );


  --the_cpu_custom_instruction_master, which is an e_instance
  the_cpu_custom_instruction_master : cpu_custom_instruction_master_arbitrator
    port map(
      cpu_bitswap_s1_select => cpu_bitswap_s1_select,
      cpu_custom_instruction_master_combo_result => cpu_custom_instruction_master_combo_result,
      cpu_custom_instruction_master_reset_n => cpu_custom_instruction_master_reset_n,
      cpu_custominstruction_inst_nios_custom_instruction_slave_0_select => cpu_custominstruction_inst_nios_custom_instruction_slave_0_select,
      clk => clk_0,
      cpu_bitswap_s1_result_from_sa => cpu_bitswap_s1_result_from_sa,
      cpu_custom_instruction_master_combo_n => cpu_custom_instruction_master_combo_n,
      cpu_custominstruction_inst_nios_custom_instruction_slave_0_result_from_sa => cpu_custominstruction_inst_nios_custom_instruction_slave_0_result_from_sa,
      reset_n => clk_0_reset_n
    );


  --the_cpu_data_master, which is an e_instance
  the_cpu_data_master : cpu_data_master_arbitrator
    port map(
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_dbs_address => cpu_data_master_dbs_address,
      cpu_data_master_dbs_write_16 => cpu_data_master_dbs_write_16,
      cpu_data_master_dbs_write_8 => cpu_data_master_dbs_write_8,
      cpu_data_master_irq => cpu_data_master_irq,
      cpu_data_master_no_byte_enables_and_last_term => cpu_data_master_no_byte_enables_and_last_term,
      cpu_data_master_readdata => cpu_data_master_readdata,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      LEDS_s1_readdata_from_sa => LEDS_s1_readdata_from_sa,
      buttons_s1_irq_from_sa => buttons_s1_irq_from_sa,
      buttons_s1_readdata_from_sa => buttons_s1_readdata_from_sa,
      clk => clk_0,
      cpu_data_master_address => cpu_data_master_address,
      cpu_data_master_byteenable_flash_s1 => cpu_data_master_byteenable_flash_s1,
      cpu_data_master_byteenable_sdram_s1 => cpu_data_master_byteenable_sdram_s1,
      cpu_data_master_byteenable_sram_avalon_sram_slave => cpu_data_master_byteenable_sram_avalon_sram_slave,
      cpu_data_master_granted_LEDS_s1 => cpu_data_master_granted_LEDS_s1,
      cpu_data_master_granted_buttons_s1 => cpu_data_master_granted_buttons_s1,
      cpu_data_master_granted_cpu_jtag_debug_module => cpu_data_master_granted_cpu_jtag_debug_module,
      cpu_data_master_granted_flash_s1 => cpu_data_master_granted_flash_s1,
      cpu_data_master_granted_jtag_uart_avalon_jtag_slave => cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
      cpu_data_master_granted_lcd_control_slave => cpu_data_master_granted_lcd_control_slave,
      cpu_data_master_granted_sdram_s1 => cpu_data_master_granted_sdram_s1,
      cpu_data_master_granted_sram_avalon_sram_slave => cpu_data_master_granted_sram_avalon_sram_slave,
      cpu_data_master_granted_switches_s1 => cpu_data_master_granted_switches_s1,
      cpu_data_master_granted_timer_s1 => cpu_data_master_granted_timer_s1,
      cpu_data_master_granted_uart_s1 => cpu_data_master_granted_uart_s1,
      cpu_data_master_qualified_request_LEDS_s1 => cpu_data_master_qualified_request_LEDS_s1,
      cpu_data_master_qualified_request_buttons_s1 => cpu_data_master_qualified_request_buttons_s1,
      cpu_data_master_qualified_request_cpu_jtag_debug_module => cpu_data_master_qualified_request_cpu_jtag_debug_module,
      cpu_data_master_qualified_request_flash_s1 => cpu_data_master_qualified_request_flash_s1,
      cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave => cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
      cpu_data_master_qualified_request_lcd_control_slave => cpu_data_master_qualified_request_lcd_control_slave,
      cpu_data_master_qualified_request_sdram_s1 => cpu_data_master_qualified_request_sdram_s1,
      cpu_data_master_qualified_request_sram_avalon_sram_slave => cpu_data_master_qualified_request_sram_avalon_sram_slave,
      cpu_data_master_qualified_request_switches_s1 => cpu_data_master_qualified_request_switches_s1,
      cpu_data_master_qualified_request_timer_s1 => cpu_data_master_qualified_request_timer_s1,
      cpu_data_master_qualified_request_uart_s1 => cpu_data_master_qualified_request_uart_s1,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_read_data_valid_LEDS_s1 => cpu_data_master_read_data_valid_LEDS_s1,
      cpu_data_master_read_data_valid_buttons_s1 => cpu_data_master_read_data_valid_buttons_s1,
      cpu_data_master_read_data_valid_cpu_jtag_debug_module => cpu_data_master_read_data_valid_cpu_jtag_debug_module,
      cpu_data_master_read_data_valid_flash_s1 => cpu_data_master_read_data_valid_flash_s1,
      cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave => cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
      cpu_data_master_read_data_valid_lcd_control_slave => cpu_data_master_read_data_valid_lcd_control_slave,
      cpu_data_master_read_data_valid_sdram_s1 => cpu_data_master_read_data_valid_sdram_s1,
      cpu_data_master_read_data_valid_sdram_s1_shift_register => cpu_data_master_read_data_valid_sdram_s1_shift_register,
      cpu_data_master_read_data_valid_sram_avalon_sram_slave => cpu_data_master_read_data_valid_sram_avalon_sram_slave,
      cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register => cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register,
      cpu_data_master_read_data_valid_switches_s1 => cpu_data_master_read_data_valid_switches_s1,
      cpu_data_master_read_data_valid_timer_s1 => cpu_data_master_read_data_valid_timer_s1,
      cpu_data_master_read_data_valid_uart_s1 => cpu_data_master_read_data_valid_uart_s1,
      cpu_data_master_requests_LEDS_s1 => cpu_data_master_requests_LEDS_s1,
      cpu_data_master_requests_buttons_s1 => cpu_data_master_requests_buttons_s1,
      cpu_data_master_requests_cpu_jtag_debug_module => cpu_data_master_requests_cpu_jtag_debug_module,
      cpu_data_master_requests_flash_s1 => cpu_data_master_requests_flash_s1,
      cpu_data_master_requests_jtag_uart_avalon_jtag_slave => cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
      cpu_data_master_requests_lcd_control_slave => cpu_data_master_requests_lcd_control_slave,
      cpu_data_master_requests_sdram_s1 => cpu_data_master_requests_sdram_s1,
      cpu_data_master_requests_sram_avalon_sram_slave => cpu_data_master_requests_sram_avalon_sram_slave,
      cpu_data_master_requests_switches_s1 => cpu_data_master_requests_switches_s1,
      cpu_data_master_requests_timer_s1 => cpu_data_master_requests_timer_s1,
      cpu_data_master_requests_uart_s1 => cpu_data_master_requests_uart_s1,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      cpu_jtag_debug_module_readdata_from_sa => cpu_jtag_debug_module_readdata_from_sa,
      d1_LEDS_s1_end_xfer => d1_LEDS_s1_end_xfer,
      d1_buttons_s1_end_xfer => d1_buttons_s1_end_xfer,
      d1_cpu_jtag_debug_module_end_xfer => d1_cpu_jtag_debug_module_end_xfer,
      d1_ext_bus_avalon_slave_end_xfer => d1_ext_bus_avalon_slave_end_xfer,
      d1_jtag_uart_avalon_jtag_slave_end_xfer => d1_jtag_uart_avalon_jtag_slave_end_xfer,
      d1_lcd_control_slave_end_xfer => d1_lcd_control_slave_end_xfer,
      d1_sdram_s1_end_xfer => d1_sdram_s1_end_xfer,
      d1_sram_avalon_sram_slave_end_xfer => d1_sram_avalon_sram_slave_end_xfer,
      d1_switches_s1_end_xfer => d1_switches_s1_end_xfer,
      d1_timer_s1_end_xfer => d1_timer_s1_end_xfer,
      d1_uart_s1_end_xfer => d1_uart_s1_end_xfer,
      flash_s1_wait_counter_eq_0 => flash_s1_wait_counter_eq_0,
      flash_s1_wait_counter_eq_1 => flash_s1_wait_counter_eq_1,
      incoming_data_to_and_from_the_flash_with_Xs_converted_to_0 => incoming_data_to_and_from_the_flash_with_Xs_converted_to_0,
      jtag_uart_avalon_jtag_slave_irq_from_sa => jtag_uart_avalon_jtag_slave_irq_from_sa,
      jtag_uart_avalon_jtag_slave_readdata_from_sa => jtag_uart_avalon_jtag_slave_readdata_from_sa,
      jtag_uart_avalon_jtag_slave_waitrequest_from_sa => jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
      lcd_control_slave_readdata_from_sa => lcd_control_slave_readdata_from_sa,
      lcd_control_slave_wait_counter_eq_0 => lcd_control_slave_wait_counter_eq_0,
      lcd_control_slave_wait_counter_eq_1 => lcd_control_slave_wait_counter_eq_1,
      registered_cpu_data_master_read_data_valid_flash_s1 => registered_cpu_data_master_read_data_valid_flash_s1,
      reset_n => clk_0_reset_n,
      sdram_s1_readdata_from_sa => sdram_s1_readdata_from_sa,
      sdram_s1_waitrequest_from_sa => sdram_s1_waitrequest_from_sa,
      sram_avalon_sram_slave_readdata_from_sa => sram_avalon_sram_slave_readdata_from_sa,
      switches_s1_readdata_from_sa => switches_s1_readdata_from_sa,
      timer_s1_irq_from_sa => timer_s1_irq_from_sa,
      timer_s1_readdata_from_sa => timer_s1_readdata_from_sa,
      uart_s1_irq_from_sa => uart_s1_irq_from_sa,
      uart_s1_readdata_from_sa => uart_s1_readdata_from_sa
    );


  --the_cpu_instruction_master, which is an e_instance
  the_cpu_instruction_master : cpu_instruction_master_arbitrator
    port map(
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_dbs_address => cpu_instruction_master_dbs_address,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_readdata => cpu_instruction_master_readdata,
      cpu_instruction_master_readdatavalid => cpu_instruction_master_readdatavalid,
      cpu_instruction_master_waitrequest => cpu_instruction_master_waitrequest,
      clk => clk_0,
      cpu_instruction_master_address => cpu_instruction_master_address,
      cpu_instruction_master_granted_cpu_jtag_debug_module => cpu_instruction_master_granted_cpu_jtag_debug_module,
      cpu_instruction_master_granted_flash_s1 => cpu_instruction_master_granted_flash_s1,
      cpu_instruction_master_granted_sdram_s1 => cpu_instruction_master_granted_sdram_s1,
      cpu_instruction_master_granted_sram_avalon_sram_slave => cpu_instruction_master_granted_sram_avalon_sram_slave,
      cpu_instruction_master_qualified_request_cpu_jtag_debug_module => cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
      cpu_instruction_master_qualified_request_flash_s1 => cpu_instruction_master_qualified_request_flash_s1,
      cpu_instruction_master_qualified_request_sdram_s1 => cpu_instruction_master_qualified_request_sdram_s1,
      cpu_instruction_master_qualified_request_sram_avalon_sram_slave => cpu_instruction_master_qualified_request_sram_avalon_sram_slave,
      cpu_instruction_master_read => cpu_instruction_master_read,
      cpu_instruction_master_read_data_valid_cpu_jtag_debug_module => cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
      cpu_instruction_master_read_data_valid_flash_s1 => cpu_instruction_master_read_data_valid_flash_s1,
      cpu_instruction_master_read_data_valid_sdram_s1 => cpu_instruction_master_read_data_valid_sdram_s1,
      cpu_instruction_master_read_data_valid_sdram_s1_shift_register => cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
      cpu_instruction_master_read_data_valid_sram_avalon_sram_slave => cpu_instruction_master_read_data_valid_sram_avalon_sram_slave,
      cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register => cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register,
      cpu_instruction_master_requests_cpu_jtag_debug_module => cpu_instruction_master_requests_cpu_jtag_debug_module,
      cpu_instruction_master_requests_flash_s1 => cpu_instruction_master_requests_flash_s1,
      cpu_instruction_master_requests_sdram_s1 => cpu_instruction_master_requests_sdram_s1,
      cpu_instruction_master_requests_sram_avalon_sram_slave => cpu_instruction_master_requests_sram_avalon_sram_slave,
      cpu_jtag_debug_module_readdata_from_sa => cpu_jtag_debug_module_readdata_from_sa,
      d1_cpu_jtag_debug_module_end_xfer => d1_cpu_jtag_debug_module_end_xfer,
      d1_ext_bus_avalon_slave_end_xfer => d1_ext_bus_avalon_slave_end_xfer,
      d1_sdram_s1_end_xfer => d1_sdram_s1_end_xfer,
      d1_sram_avalon_sram_slave_end_xfer => d1_sram_avalon_sram_slave_end_xfer,
      flash_s1_wait_counter_eq_0 => flash_s1_wait_counter_eq_0,
      flash_s1_wait_counter_eq_1 => flash_s1_wait_counter_eq_1,
      incoming_data_to_and_from_the_flash => incoming_data_to_and_from_the_flash,
      reset_n => clk_0_reset_n,
      sdram_s1_readdata_from_sa => sdram_s1_readdata_from_sa,
      sdram_s1_waitrequest_from_sa => sdram_s1_waitrequest_from_sa,
      sram_avalon_sram_slave_readdata_from_sa => sram_avalon_sram_slave_readdata_from_sa
    );


  --the_cpu, which is an e_ptf_instance
  the_cpu : cpu
    port map(
      E_ci_combo_a => cpu_custom_instruction_master_combo_a,
      E_ci_combo_b => cpu_custom_instruction_master_combo_b,
      E_ci_combo_c => cpu_custom_instruction_master_combo_c,
      E_ci_combo_dataa => cpu_custom_instruction_master_combo_dataa,
      E_ci_combo_datab => cpu_custom_instruction_master_combo_datab,
      E_ci_combo_estatus => cpu_custom_instruction_master_combo_estatus,
      E_ci_combo_ipending => cpu_custom_instruction_master_combo_ipending,
      E_ci_combo_n => cpu_custom_instruction_master_combo_n,
      E_ci_combo_readra => cpu_custom_instruction_master_combo_readra,
      E_ci_combo_readrb => cpu_custom_instruction_master_combo_readrb,
      E_ci_combo_status => cpu_custom_instruction_master_combo_status,
      E_ci_combo_writerc => cpu_custom_instruction_master_combo_writerc,
      d_address => cpu_data_master_address,
      d_byteenable => cpu_data_master_byteenable,
      d_read => cpu_data_master_read,
      d_write => cpu_data_master_write,
      d_writedata => cpu_data_master_writedata,
      i_address => cpu_instruction_master_address,
      i_read => cpu_instruction_master_read,
      jtag_debug_module_debugaccess_to_roms => cpu_data_master_debugaccess,
      jtag_debug_module_readdata => cpu_jtag_debug_module_readdata,
      jtag_debug_module_resetrequest => cpu_jtag_debug_module_resetrequest,
      E_ci_combo_result => cpu_custom_instruction_master_combo_result,
      clk => clk_0,
      d_irq => cpu_data_master_irq,
      d_readdata => cpu_data_master_readdata,
      d_waitrequest => cpu_data_master_waitrequest,
      i_readdata => cpu_instruction_master_readdata,
      i_readdatavalid => cpu_instruction_master_readdatavalid,
      i_waitrequest => cpu_instruction_master_waitrequest,
      jtag_debug_module_address => cpu_jtag_debug_module_address,
      jtag_debug_module_begintransfer => cpu_jtag_debug_module_begintransfer,
      jtag_debug_module_byteenable => cpu_jtag_debug_module_byteenable,
      jtag_debug_module_debugaccess => cpu_jtag_debug_module_debugaccess,
      jtag_debug_module_select => cpu_jtag_debug_module_chipselect,
      jtag_debug_module_write => cpu_jtag_debug_module_write,
      jtag_debug_module_writedata => cpu_jtag_debug_module_writedata,
      reset_n => cpu_custom_instruction_master_reset_n
    );


  --the_cpu_bitswap_s1, which is an e_instance
  the_cpu_bitswap_s1 : cpu_bitswap_s1_arbitrator
    port map(
      cpu_bitswap_s1_dataa => cpu_bitswap_s1_dataa,
      cpu_bitswap_s1_datab => cpu_bitswap_s1_datab,
      cpu_bitswap_s1_result_from_sa => cpu_bitswap_s1_result_from_sa,
      clk => clk_0,
      cpu_bitswap_s1_result => cpu_bitswap_s1_result,
      cpu_bitswap_s1_select => cpu_bitswap_s1_select,
      cpu_custom_instruction_master_combo_dataa => cpu_custom_instruction_master_combo_dataa,
      cpu_custom_instruction_master_combo_datab => cpu_custom_instruction_master_combo_datab,
      reset_n => clk_0_reset_n
    );


  --the_cpu_bitswap, which is an e_ptf_instance
  the_cpu_bitswap : cpu_bitswap
    port map(
      result => cpu_bitswap_s1_result,
      dataa => cpu_bitswap_s1_dataa,
      datab => cpu_bitswap_s1_datab
    );


  --the_cpu_custominstruction_inst_nios_custom_instruction_slave_0, which is an e_instance
  the_cpu_custominstruction_inst_nios_custom_instruction_slave_0 : cpu_custominstruction_inst_nios_custom_instruction_slave_0_arbitrator
    port map(
      cpu_custominstruction_inst_nios_custom_instruction_slave_0_dataa => cpu_custominstruction_inst_nios_custom_instruction_slave_0_dataa,
      cpu_custominstruction_inst_nios_custom_instruction_slave_0_datab => cpu_custominstruction_inst_nios_custom_instruction_slave_0_datab,
      cpu_custominstruction_inst_nios_custom_instruction_slave_0_result_from_sa => cpu_custominstruction_inst_nios_custom_instruction_slave_0_result_from_sa,
      clk => clk_0,
      cpu_custom_instruction_master_combo_dataa => cpu_custom_instruction_master_combo_dataa,
      cpu_custom_instruction_master_combo_datab => cpu_custom_instruction_master_combo_datab,
      cpu_custominstruction_inst_nios_custom_instruction_slave_0_result => cpu_custominstruction_inst_nios_custom_instruction_slave_0_result,
      cpu_custominstruction_inst_nios_custom_instruction_slave_0_select => cpu_custominstruction_inst_nios_custom_instruction_slave_0_select,
      reset_n => clk_0_reset_n
    );


  --the_cpu_custominstruction_inst, which is an e_ptf_instance
  the_cpu_custominstruction_inst : cpu_custominstruction_inst
    port map(
      result => cpu_custominstruction_inst_nios_custom_instruction_slave_0_result,
      dataa => cpu_custominstruction_inst_nios_custom_instruction_slave_0_dataa,
      datab => cpu_custominstruction_inst_nios_custom_instruction_slave_0_datab
    );


  --the_ext_bus_avalon_slave, which is an e_instance
  the_ext_bus_avalon_slave : ext_bus_avalon_slave_arbitrator
    port map(
      address_to_the_flash => internal_address_to_the_flash,
      cpu_data_master_byteenable_flash_s1 => cpu_data_master_byteenable_flash_s1,
      cpu_data_master_granted_flash_s1 => cpu_data_master_granted_flash_s1,
      cpu_data_master_qualified_request_flash_s1 => cpu_data_master_qualified_request_flash_s1,
      cpu_data_master_read_data_valid_flash_s1 => cpu_data_master_read_data_valid_flash_s1,
      cpu_data_master_requests_flash_s1 => cpu_data_master_requests_flash_s1,
      cpu_instruction_master_granted_flash_s1 => cpu_instruction_master_granted_flash_s1,
      cpu_instruction_master_qualified_request_flash_s1 => cpu_instruction_master_qualified_request_flash_s1,
      cpu_instruction_master_read_data_valid_flash_s1 => cpu_instruction_master_read_data_valid_flash_s1,
      cpu_instruction_master_requests_flash_s1 => cpu_instruction_master_requests_flash_s1,
      d1_ext_bus_avalon_slave_end_xfer => d1_ext_bus_avalon_slave_end_xfer,
      data_to_and_from_the_flash => data_to_and_from_the_flash,
      flash_s1_wait_counter_eq_0 => flash_s1_wait_counter_eq_0,
      flash_s1_wait_counter_eq_1 => flash_s1_wait_counter_eq_1,
      incoming_data_to_and_from_the_flash => incoming_data_to_and_from_the_flash,
      incoming_data_to_and_from_the_flash_with_Xs_converted_to_0 => incoming_data_to_and_from_the_flash_with_Xs_converted_to_0,
      read_n_to_the_flash => internal_read_n_to_the_flash,
      registered_cpu_data_master_read_data_valid_flash_s1 => registered_cpu_data_master_read_data_valid_flash_s1,
      select_n_to_the_flash => internal_select_n_to_the_flash,
      write_n_to_the_flash => internal_write_n_to_the_flash,
      clk => clk_0,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_dbs_address => cpu_data_master_dbs_address,
      cpu_data_master_dbs_write_8 => cpu_data_master_dbs_write_8,
      cpu_data_master_no_byte_enables_and_last_term => cpu_data_master_no_byte_enables_and_last_term,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_dbs_address => cpu_instruction_master_dbs_address,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_read => cpu_instruction_master_read,
      cpu_instruction_master_read_data_valid_sdram_s1_shift_register => cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
      cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register => cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register,
      reset_n => clk_0_reset_n
    );


  --the_jtag_uart_avalon_jtag_slave, which is an e_instance
  the_jtag_uart_avalon_jtag_slave : jtag_uart_avalon_jtag_slave_arbitrator
    port map(
      cpu_data_master_granted_jtag_uart_avalon_jtag_slave => cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
      cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave => cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
      cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave => cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
      cpu_data_master_requests_jtag_uart_avalon_jtag_slave => cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
      d1_jtag_uart_avalon_jtag_slave_end_xfer => d1_jtag_uart_avalon_jtag_slave_end_xfer,
      jtag_uart_avalon_jtag_slave_address => jtag_uart_avalon_jtag_slave_address,
      jtag_uart_avalon_jtag_slave_chipselect => jtag_uart_avalon_jtag_slave_chipselect,
      jtag_uart_avalon_jtag_slave_dataavailable_from_sa => jtag_uart_avalon_jtag_slave_dataavailable_from_sa,
      jtag_uart_avalon_jtag_slave_irq_from_sa => jtag_uart_avalon_jtag_slave_irq_from_sa,
      jtag_uart_avalon_jtag_slave_read_n => jtag_uart_avalon_jtag_slave_read_n,
      jtag_uart_avalon_jtag_slave_readdata_from_sa => jtag_uart_avalon_jtag_slave_readdata_from_sa,
      jtag_uart_avalon_jtag_slave_readyfordata_from_sa => jtag_uart_avalon_jtag_slave_readyfordata_from_sa,
      jtag_uart_avalon_jtag_slave_reset_n => jtag_uart_avalon_jtag_slave_reset_n,
      jtag_uart_avalon_jtag_slave_waitrequest_from_sa => jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
      jtag_uart_avalon_jtag_slave_write_n => jtag_uart_avalon_jtag_slave_write_n,
      jtag_uart_avalon_jtag_slave_writedata => jtag_uart_avalon_jtag_slave_writedata,
      clk => clk_0,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      jtag_uart_avalon_jtag_slave_dataavailable => jtag_uart_avalon_jtag_slave_dataavailable,
      jtag_uart_avalon_jtag_slave_irq => jtag_uart_avalon_jtag_slave_irq,
      jtag_uart_avalon_jtag_slave_readdata => jtag_uart_avalon_jtag_slave_readdata,
      jtag_uart_avalon_jtag_slave_readyfordata => jtag_uart_avalon_jtag_slave_readyfordata,
      jtag_uart_avalon_jtag_slave_waitrequest => jtag_uart_avalon_jtag_slave_waitrequest,
      reset_n => clk_0_reset_n
    );


  --the_jtag_uart, which is an e_ptf_instance
  the_jtag_uart : jtag_uart
    port map(
      av_irq => jtag_uart_avalon_jtag_slave_irq,
      av_readdata => jtag_uart_avalon_jtag_slave_readdata,
      av_waitrequest => jtag_uart_avalon_jtag_slave_waitrequest,
      dataavailable => jtag_uart_avalon_jtag_slave_dataavailable,
      readyfordata => jtag_uart_avalon_jtag_slave_readyfordata,
      av_address => jtag_uart_avalon_jtag_slave_address,
      av_chipselect => jtag_uart_avalon_jtag_slave_chipselect,
      av_read_n => jtag_uart_avalon_jtag_slave_read_n,
      av_write_n => jtag_uart_avalon_jtag_slave_write_n,
      av_writedata => jtag_uart_avalon_jtag_slave_writedata,
      clk => clk_0,
      rst_n => jtag_uart_avalon_jtag_slave_reset_n
    );


  --the_lcd_control_slave, which is an e_instance
  the_lcd_control_slave : lcd_control_slave_arbitrator
    port map(
      cpu_data_master_granted_lcd_control_slave => cpu_data_master_granted_lcd_control_slave,
      cpu_data_master_qualified_request_lcd_control_slave => cpu_data_master_qualified_request_lcd_control_slave,
      cpu_data_master_read_data_valid_lcd_control_slave => cpu_data_master_read_data_valid_lcd_control_slave,
      cpu_data_master_requests_lcd_control_slave => cpu_data_master_requests_lcd_control_slave,
      d1_lcd_control_slave_end_xfer => d1_lcd_control_slave_end_xfer,
      lcd_control_slave_address => lcd_control_slave_address,
      lcd_control_slave_begintransfer => lcd_control_slave_begintransfer,
      lcd_control_slave_read => lcd_control_slave_read,
      lcd_control_slave_readdata_from_sa => lcd_control_slave_readdata_from_sa,
      lcd_control_slave_wait_counter_eq_0 => lcd_control_slave_wait_counter_eq_0,
      lcd_control_slave_wait_counter_eq_1 => lcd_control_slave_wait_counter_eq_1,
      lcd_control_slave_write => lcd_control_slave_write,
      lcd_control_slave_writedata => lcd_control_slave_writedata,
      clk => clk_0,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      lcd_control_slave_readdata => lcd_control_slave_readdata,
      reset_n => clk_0_reset_n
    );


  --the_lcd, which is an e_ptf_instance
  the_lcd : lcd
    port map(
      LCD_E => internal_LCD_E_from_the_lcd,
      LCD_RS => internal_LCD_RS_from_the_lcd,
      LCD_RW => internal_LCD_RW_from_the_lcd,
      LCD_data => LCD_data_to_and_from_the_lcd,
      readdata => lcd_control_slave_readdata,
      address => lcd_control_slave_address,
      begintransfer => lcd_control_slave_begintransfer,
      read => lcd_control_slave_read,
      write => lcd_control_slave_write,
      writedata => lcd_control_slave_writedata
    );


  --the_sdram_s1, which is an e_instance
  the_sdram_s1 : sdram_s1_arbitrator
    port map(
      cpu_data_master_byteenable_sdram_s1 => cpu_data_master_byteenable_sdram_s1,
      cpu_data_master_granted_sdram_s1 => cpu_data_master_granted_sdram_s1,
      cpu_data_master_qualified_request_sdram_s1 => cpu_data_master_qualified_request_sdram_s1,
      cpu_data_master_read_data_valid_sdram_s1 => cpu_data_master_read_data_valid_sdram_s1,
      cpu_data_master_read_data_valid_sdram_s1_shift_register => cpu_data_master_read_data_valid_sdram_s1_shift_register,
      cpu_data_master_requests_sdram_s1 => cpu_data_master_requests_sdram_s1,
      cpu_instruction_master_granted_sdram_s1 => cpu_instruction_master_granted_sdram_s1,
      cpu_instruction_master_qualified_request_sdram_s1 => cpu_instruction_master_qualified_request_sdram_s1,
      cpu_instruction_master_read_data_valid_sdram_s1 => cpu_instruction_master_read_data_valid_sdram_s1,
      cpu_instruction_master_read_data_valid_sdram_s1_shift_register => cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
      cpu_instruction_master_requests_sdram_s1 => cpu_instruction_master_requests_sdram_s1,
      d1_sdram_s1_end_xfer => d1_sdram_s1_end_xfer,
      sdram_s1_address => sdram_s1_address,
      sdram_s1_byteenable_n => sdram_s1_byteenable_n,
      sdram_s1_chipselect => sdram_s1_chipselect,
      sdram_s1_read_n => sdram_s1_read_n,
      sdram_s1_readdata_from_sa => sdram_s1_readdata_from_sa,
      sdram_s1_reset_n => sdram_s1_reset_n,
      sdram_s1_waitrequest_from_sa => sdram_s1_waitrequest_from_sa,
      sdram_s1_write_n => sdram_s1_write_n,
      sdram_s1_writedata => sdram_s1_writedata,
      clk => clk_0,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_dbs_address => cpu_data_master_dbs_address,
      cpu_data_master_dbs_write_16 => cpu_data_master_dbs_write_16,
      cpu_data_master_no_byte_enables_and_last_term => cpu_data_master_no_byte_enables_and_last_term,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_dbs_address => cpu_instruction_master_dbs_address,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_read => cpu_instruction_master_read,
      cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register => cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register,
      reset_n => clk_0_reset_n,
      sdram_s1_readdata => sdram_s1_readdata,
      sdram_s1_readdatavalid => sdram_s1_readdatavalid,
      sdram_s1_waitrequest => sdram_s1_waitrequest
    );


  --the_sdram, which is an e_ptf_instance
  the_sdram : sdram
    port map(
      za_data => sdram_s1_readdata,
      za_valid => sdram_s1_readdatavalid,
      za_waitrequest => sdram_s1_waitrequest,
      zs_addr => internal_zs_addr_from_the_sdram,
      zs_ba => internal_zs_ba_from_the_sdram,
      zs_cas_n => internal_zs_cas_n_from_the_sdram,
      zs_cke => internal_zs_cke_from_the_sdram,
      zs_cs_n => internal_zs_cs_n_from_the_sdram,
      zs_dq => zs_dq_to_and_from_the_sdram,
      zs_dqm => internal_zs_dqm_from_the_sdram,
      zs_ras_n => internal_zs_ras_n_from_the_sdram,
      zs_we_n => internal_zs_we_n_from_the_sdram,
      az_addr => sdram_s1_address,
      az_be_n => sdram_s1_byteenable_n,
      az_cs => sdram_s1_chipselect,
      az_data => sdram_s1_writedata,
      az_rd_n => sdram_s1_read_n,
      az_wr_n => sdram_s1_write_n,
      clk => clk_0,
      reset_n => sdram_s1_reset_n
    );


  --the_sram_avalon_sram_slave, which is an e_instance
  the_sram_avalon_sram_slave : sram_avalon_sram_slave_arbitrator
    port map(
      cpu_data_master_byteenable_sram_avalon_sram_slave => cpu_data_master_byteenable_sram_avalon_sram_slave,
      cpu_data_master_granted_sram_avalon_sram_slave => cpu_data_master_granted_sram_avalon_sram_slave,
      cpu_data_master_qualified_request_sram_avalon_sram_slave => cpu_data_master_qualified_request_sram_avalon_sram_slave,
      cpu_data_master_read_data_valid_sram_avalon_sram_slave => cpu_data_master_read_data_valid_sram_avalon_sram_slave,
      cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register => cpu_data_master_read_data_valid_sram_avalon_sram_slave_shift_register,
      cpu_data_master_requests_sram_avalon_sram_slave => cpu_data_master_requests_sram_avalon_sram_slave,
      cpu_instruction_master_granted_sram_avalon_sram_slave => cpu_instruction_master_granted_sram_avalon_sram_slave,
      cpu_instruction_master_qualified_request_sram_avalon_sram_slave => cpu_instruction_master_qualified_request_sram_avalon_sram_slave,
      cpu_instruction_master_read_data_valid_sram_avalon_sram_slave => cpu_instruction_master_read_data_valid_sram_avalon_sram_slave,
      cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register => cpu_instruction_master_read_data_valid_sram_avalon_sram_slave_shift_register,
      cpu_instruction_master_requests_sram_avalon_sram_slave => cpu_instruction_master_requests_sram_avalon_sram_slave,
      d1_sram_avalon_sram_slave_end_xfer => d1_sram_avalon_sram_slave_end_xfer,
      sram_avalon_sram_slave_address => sram_avalon_sram_slave_address,
      sram_avalon_sram_slave_byteenable => sram_avalon_sram_slave_byteenable,
      sram_avalon_sram_slave_read => sram_avalon_sram_slave_read,
      sram_avalon_sram_slave_readdata_from_sa => sram_avalon_sram_slave_readdata_from_sa,
      sram_avalon_sram_slave_reset => sram_avalon_sram_slave_reset,
      sram_avalon_sram_slave_write => sram_avalon_sram_slave_write,
      sram_avalon_sram_slave_writedata => sram_avalon_sram_slave_writedata,
      clk => clk_0,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_dbs_address => cpu_data_master_dbs_address,
      cpu_data_master_dbs_write_16 => cpu_data_master_dbs_write_16,
      cpu_data_master_no_byte_enables_and_last_term => cpu_data_master_no_byte_enables_and_last_term,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_dbs_address => cpu_instruction_master_dbs_address,
      cpu_instruction_master_latency_counter => cpu_instruction_master_latency_counter,
      cpu_instruction_master_read => cpu_instruction_master_read,
      cpu_instruction_master_read_data_valid_sdram_s1_shift_register => cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
      reset_n => clk_0_reset_n,
      sram_avalon_sram_slave_readdata => sram_avalon_sram_slave_readdata,
      sram_avalon_sram_slave_readdatavalid => sram_avalon_sram_slave_readdatavalid
    );


  --the_sram, which is an e_ptf_instance
  the_sram : sram
    port map(
      SRAM_ADDR => internal_SRAM_ADDR_from_the_sram,
      SRAM_CE_N => internal_SRAM_CE_N_from_the_sram,
      SRAM_DQ => SRAM_DQ_to_and_from_the_sram,
      SRAM_LB_N => internal_SRAM_LB_N_from_the_sram,
      SRAM_OE_N => internal_SRAM_OE_N_from_the_sram,
      SRAM_UB_N => internal_SRAM_UB_N_from_the_sram,
      SRAM_WE_N => internal_SRAM_WE_N_from_the_sram,
      readdata => sram_avalon_sram_slave_readdata,
      readdatavalid => sram_avalon_sram_slave_readdatavalid,
      address => sram_avalon_sram_slave_address,
      byteenable => sram_avalon_sram_slave_byteenable,
      clk => clk_0,
      read => sram_avalon_sram_slave_read,
      reset => sram_avalon_sram_slave_reset,
      write => sram_avalon_sram_slave_write,
      writedata => sram_avalon_sram_slave_writedata
    );


  --the_switches_s1, which is an e_instance
  the_switches_s1 : switches_s1_arbitrator
    port map(
      cpu_data_master_granted_switches_s1 => cpu_data_master_granted_switches_s1,
      cpu_data_master_qualified_request_switches_s1 => cpu_data_master_qualified_request_switches_s1,
      cpu_data_master_read_data_valid_switches_s1 => cpu_data_master_read_data_valid_switches_s1,
      cpu_data_master_requests_switches_s1 => cpu_data_master_requests_switches_s1,
      d1_switches_s1_end_xfer => d1_switches_s1_end_xfer,
      switches_s1_address => switches_s1_address,
      switches_s1_readdata_from_sa => switches_s1_readdata_from_sa,
      switches_s1_reset_n => switches_s1_reset_n,
      clk => clk_0,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      reset_n => clk_0_reset_n,
      switches_s1_readdata => switches_s1_readdata
    );


  --the_switches, which is an e_ptf_instance
  the_switches : switches
    port map(
      readdata => switches_s1_readdata,
      address => switches_s1_address,
      clk => clk_0,
      in_port => in_port_to_the_switches,
      reset_n => switches_s1_reset_n
    );


  --the_timer_s1, which is an e_instance
  the_timer_s1 : timer_s1_arbitrator
    port map(
      cpu_data_master_granted_timer_s1 => cpu_data_master_granted_timer_s1,
      cpu_data_master_qualified_request_timer_s1 => cpu_data_master_qualified_request_timer_s1,
      cpu_data_master_read_data_valid_timer_s1 => cpu_data_master_read_data_valid_timer_s1,
      cpu_data_master_requests_timer_s1 => cpu_data_master_requests_timer_s1,
      d1_timer_s1_end_xfer => d1_timer_s1_end_xfer,
      timer_s1_address => timer_s1_address,
      timer_s1_chipselect => timer_s1_chipselect,
      timer_s1_irq_from_sa => timer_s1_irq_from_sa,
      timer_s1_readdata_from_sa => timer_s1_readdata_from_sa,
      timer_s1_reset_n => timer_s1_reset_n,
      timer_s1_write_n => timer_s1_write_n,
      timer_s1_writedata => timer_s1_writedata,
      clk => clk_0,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => clk_0_reset_n,
      timer_s1_irq => timer_s1_irq,
      timer_s1_readdata => timer_s1_readdata
    );


  --the_timer, which is an e_ptf_instance
  the_timer : timer
    port map(
      irq => timer_s1_irq,
      readdata => timer_s1_readdata,
      address => timer_s1_address,
      chipselect => timer_s1_chipselect,
      clk => clk_0,
      reset_n => timer_s1_reset_n,
      write_n => timer_s1_write_n,
      writedata => timer_s1_writedata
    );


  --the_uart_s1, which is an e_instance
  the_uart_s1 : uart_s1_arbitrator
    port map(
      cpu_data_master_granted_uart_s1 => cpu_data_master_granted_uart_s1,
      cpu_data_master_qualified_request_uart_s1 => cpu_data_master_qualified_request_uart_s1,
      cpu_data_master_read_data_valid_uart_s1 => cpu_data_master_read_data_valid_uart_s1,
      cpu_data_master_requests_uart_s1 => cpu_data_master_requests_uart_s1,
      d1_uart_s1_end_xfer => d1_uart_s1_end_xfer,
      uart_s1_address => uart_s1_address,
      uart_s1_begintransfer => uart_s1_begintransfer,
      uart_s1_chipselect => uart_s1_chipselect,
      uart_s1_dataavailable_from_sa => uart_s1_dataavailable_from_sa,
      uart_s1_irq_from_sa => uart_s1_irq_from_sa,
      uart_s1_read_n => uart_s1_read_n,
      uart_s1_readdata_from_sa => uart_s1_readdata_from_sa,
      uart_s1_readyfordata_from_sa => uart_s1_readyfordata_from_sa,
      uart_s1_reset_n => uart_s1_reset_n,
      uart_s1_write_n => uart_s1_write_n,
      uart_s1_writedata => uart_s1_writedata,
      clk => clk_0,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => clk_0_reset_n,
      uart_s1_dataavailable => uart_s1_dataavailable,
      uart_s1_irq => uart_s1_irq,
      uart_s1_readdata => uart_s1_readdata,
      uart_s1_readyfordata => uart_s1_readyfordata
    );


  --the_uart, which is an e_ptf_instance
  the_uart : uart
    port map(
      dataavailable => uart_s1_dataavailable,
      irq => uart_s1_irq,
      readdata => uart_s1_readdata,
      readyfordata => uart_s1_readyfordata,
      txd => internal_txd_from_the_uart,
      address => uart_s1_address,
      begintransfer => uart_s1_begintransfer,
      chipselect => uart_s1_chipselect,
      clk => clk_0,
      read_n => uart_s1_read_n,
      reset_n => uart_s1_reset_n,
      rxd => rxd_to_the_uart,
      write_n => uart_s1_write_n,
      writedata => uart_s1_writedata
    );


  --reset is asserted asynchronously and deasserted synchronously
  nios32_reset_clk_0_domain_synch : nios32_reset_clk_0_domain_synch_module
    port map(
      data_out => clk_0_reset_n,
      clk => clk_0,
      data_in => module_input12,
      reset_n => reset_n_sources
    );

  module_input12 <= std_logic'('1');

  --reset sources mux, which is an e_mux
  reset_n_sources <= Vector_To_Std_Logic(NOT (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT reset_n))) OR std_logic_vector'("00000000000000000000000000000000")) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_resetrequest_from_sa)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_resetrequest_from_sa))))));
  --vhdl renameroo for output signals
  LCD_E_from_the_lcd <= internal_LCD_E_from_the_lcd;
  --vhdl renameroo for output signals
  LCD_RS_from_the_lcd <= internal_LCD_RS_from_the_lcd;
  --vhdl renameroo for output signals
  LCD_RW_from_the_lcd <= internal_LCD_RW_from_the_lcd;
  --vhdl renameroo for output signals
  SRAM_ADDR_from_the_sram <= internal_SRAM_ADDR_from_the_sram;
  --vhdl renameroo for output signals
  SRAM_CE_N_from_the_sram <= internal_SRAM_CE_N_from_the_sram;
  --vhdl renameroo for output signals
  SRAM_LB_N_from_the_sram <= internal_SRAM_LB_N_from_the_sram;
  --vhdl renameroo for output signals
  SRAM_OE_N_from_the_sram <= internal_SRAM_OE_N_from_the_sram;
  --vhdl renameroo for output signals
  SRAM_UB_N_from_the_sram <= internal_SRAM_UB_N_from_the_sram;
  --vhdl renameroo for output signals
  SRAM_WE_N_from_the_sram <= internal_SRAM_WE_N_from_the_sram;
  --vhdl renameroo for output signals
  address_to_the_flash <= internal_address_to_the_flash;
  --vhdl renameroo for output signals
  out_port_from_the_LEDS <= internal_out_port_from_the_LEDS;
  --vhdl renameroo for output signals
  read_n_to_the_flash <= internal_read_n_to_the_flash;
  --vhdl renameroo for output signals
  select_n_to_the_flash <= internal_select_n_to_the_flash;
  --vhdl renameroo for output signals
  txd_from_the_uart <= internal_txd_from_the_uart;
  --vhdl renameroo for output signals
  write_n_to_the_flash <= internal_write_n_to_the_flash;
  --vhdl renameroo for output signals
  zs_addr_from_the_sdram <= internal_zs_addr_from_the_sdram;
  --vhdl renameroo for output signals
  zs_ba_from_the_sdram <= internal_zs_ba_from_the_sdram;
  --vhdl renameroo for output signals
  zs_cas_n_from_the_sdram <= internal_zs_cas_n_from_the_sdram;
  --vhdl renameroo for output signals
  zs_cke_from_the_sdram <= internal_zs_cke_from_the_sdram;
  --vhdl renameroo for output signals
  zs_cs_n_from_the_sdram <= internal_zs_cs_n_from_the_sdram;
  --vhdl renameroo for output signals
  zs_dqm_from_the_sdram <= internal_zs_dqm_from_the_sdram;
  --vhdl renameroo for output signals
  zs_ras_n_from_the_sdram <= internal_zs_ras_n_from_the_sdram;
  --vhdl renameroo for output signals
  zs_we_n_from_the_sdram <= internal_zs_we_n_from_the_sdram;

end europa;


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity flash_lane0_module is 
        port (
              -- inputs:
                 signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal rdaddress : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
                 signal rdclken : IN STD_LOGIC;
                 signal wraddress : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
                 signal wrclock : IN STD_LOGIC;
                 signal wren : IN STD_LOGIC;

              -- outputs:
                 signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity flash_lane0_module;


architecture europa of flash_lane0_module is
              signal internal_q :  STD_LOGIC_VECTOR (7 DOWNTO 0);
              TYPE mem_array is ARRAY( 4194303 DOWNTO 0) of STD_LOGIC_VECTOR(7 DOWNTO 0);
              signal memory_has_been_read :  STD_LOGIC;
              signal read_address :  STD_LOGIC_VECTOR (21 DOWNTO 0);

      
FUNCTION convert_string_to_number(string_to_convert : STRING;
      final_char_index : NATURAL := 0)
RETURN NATURAL IS
   VARIABLE result: NATURAL := 0;
   VARIABLE current_index : NATURAL := 1;
   VARIABLE the_char : CHARACTER;

   BEGIN
      IF final_char_index = 0 THEN
         result := 0;
	 ELSE
         WHILE current_index <= final_char_index LOOP
            the_char := string_to_convert(current_index);
            IF    '0' <= the_char AND the_char <= '9' THEN
               result := result * 16 + character'pos(the_char) - character'pos('0');
            ELSIF 'A' <= the_char AND the_char <= 'F' THEN
               result := result * 16 + character'pos(the_char) - character'pos('A') + 10;
            ELSIF 'a' <= the_char AND the_char <= 'f' THEN
               result := result * 16 + character'pos(the_char) - character'pos('a') + 10;
            ELSE
               report "Ack, a formatting error!";
            END IF;
            current_index := current_index + 1;
         END LOOP;
      END IF; 
   RETURN result;
END convert_string_to_number;

 FUNCTION convert_string_to_std_logic(value : STRING; num_chars : INTEGER; mem_width_bits : INTEGER)
 RETURN STD_LOGIC_VECTOR is			   
     VARIABLE conv_string: std_logic_vector((mem_width_bits + 4)-1 downto 0);
     VARIABLE result : std_logic_vector((mem_width_bits -1) downto 0);
     VARIABLE curr_char : integer;
              
     BEGIN
     result := (others => '0');
     conv_string := (others => '0');
     
          FOR I IN 1 TO num_chars LOOP
	     curr_char := num_chars - (I-1);

             CASE value(I) IS
               WHEN '0' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0000";
               WHEN '1' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0001";
               WHEN '2' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0010";
               WHEN '3' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0011";
               WHEN '4' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0100";
               WHEN '5' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0101";
               WHEN '6' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0110";
               WHEN '7' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "0111";
               WHEN '8' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1000";
               WHEN '9' =>  conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1001";
               WHEN 'A' | 'a' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1010";
               WHEN 'B' | 'b' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1011";
               WHEN 'C' | 'c' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1100";
               WHEN 'D' | 'd' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1101";
               WHEN 'E' | 'e' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1110";
               WHEN 'F' | 'f' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "1111";
               WHEN 'X' | 'x' => conv_string((4*curr_char)-1  DOWNTO 4*(curr_char-1)) := "XXXX";
               WHEN ' ' => EXIT;
               WHEN HT  => exit;
               WHEN others =>
                  ASSERT False
                  REPORT "function From_Hex: string """ & value & """ contains non-hex character"
                       severity Error;
                  EXIT;
               END case;
            END loop;

          -- convert back to normal bit size
          result(mem_width_bits - 1 downto 0) := conv_string(mem_width_bits - 1 downto 0);

          RETURN result;
        END convert_string_to_std_logic;



begin
   process (wrclock, rdaddress) -- MG
    VARIABLE data_line : LINE;
    VARIABLE the_character_from_data_line : CHARACTER;
    VARIABLE b_munging_address : BOOLEAN := FALSE;
    VARIABLE converted_number : NATURAL := 0;
    VARIABLE found_string_array : STRING(1 TO 128);
    VARIABLE string_index : NATURAL := 0;
    VARIABLE line_length : NATURAL := 0;
    VARIABLE b_convert : BOOLEAN := FALSE;
    VARIABLE b_found_new_val : BOOLEAN := FALSE;
    VARIABLE load_address : NATURAL := 0;
    VARIABLE mem_index : NATURAL := 0;
    VARIABLE mem_init : BOOLEAN := FALSE;

    VARIABLE wr_address_internal : STD_LOGIC_VECTOR (21 DOWNTO 0) := (others => '0');
    FILE memory_contents_file : TEXT OPEN read_mode IS "flash.dat";  
    variable Marc_Gaucherons_Memory_Variable : mem_array; -- MG
    
    begin
   -- need an initialization process
   -- this process initializes the whole memory array from a named file by copying the
   -- contents of the *.dat file to the memory array.

   -- find the @<address> thingy to load the memory from this point 
IF(NOT mem_init) THEN
   WHILE NOT(endfile(memory_contents_file)) LOOP

      readline(memory_contents_file, data_line);
      line_length := data_line'LENGTH;


      WHILE line_length > 0 LOOP
         read(data_line, the_character_from_data_line);

	       -- check for the @ character indicating a new address wad
 	       -- if not found, we're either still reading the new address _or_loading data
         IF '@' = the_character_from_data_line AND NOT b_munging_address THEN
  	    b_munging_address := TRUE;
            b_found_new_val := TRUE; 
	    -- get the rest of characters before white space and then convert them
	    -- to a number
	 ELSE 

            IF (' ' = the_character_from_data_line AND b_found_new_val) 
		OR (line_length = 1) THEN
               b_convert := TRUE;
	    END IF;

            IF NOT(' ' = the_character_from_data_line) THEN
               string_index := string_index + 1;
               found_string_array(string_index) := the_character_from_data_line;
--               IF NOT(b_munging_address) THEN
--                 dat_string_array(string_index) := the_character_from_data_line;
--               END IF;
	       b_found_new_val := TRUE;
            END IF;
	 END IF;

     IF b_convert THEN

       IF b_munging_address THEN
          converted_number := convert_string_to_number(found_string_array, string_index);    
          load_address := converted_number;
          mem_index := load_address;
--          mem_index := load_address / 1;
          b_munging_address := FALSE;
       ELSE
	  IF (mem_index < 4194304) THEN
	    Marc_Gaucherons_Memory_Variable(mem_index) := convert_string_to_std_logic(found_string_array, string_index, 8);
            mem_index := mem_index + 1;
          END IF;
       END IF; 
       b_convert := FALSE;
       b_found_new_val := FALSE;
       string_index := 0;
    END IF;
    line_length := line_length - 1; 
    END LOOP;

END LOOP;
-- get the first _real_ block of data, sized to our memory width
-- and keep on loading.
  mem_init := TRUE;
END IF;
-- END OF READMEM



      -- Write data
      if wrclock'event and wrclock = '1' then
        wr_address_internal := wraddress;
        if wren = '1' then 
          Marc_Gaucherons_Memory_Variable(CONV_INTEGER(UNSIGNED(wr_address_internal))) := data;
        end if;
      end if;

      -- read data
      q <= Marc_Gaucherons_Memory_Variable(CONV_INTEGER(UNSIGNED(rdaddress)));
      


    end process;
end europa;

--synthesis translate_on


--synthesis read_comments_as_HDL on
--library altera;
--use altera.altera_europa_support_lib.all;
--
--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--
--library std;
--use std.textio.all;
--
--entity flash_lane0_module is 
--        port (
--              
--                 signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--                 signal rdaddress : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
--                 signal rdclken : IN STD_LOGIC;
--                 signal wraddress : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
--                 signal wrclock : IN STD_LOGIC;
--                 signal wren : IN STD_LOGIC;
--
--              
--                 signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
--              );
--end entity flash_lane0_module;
--
--
--architecture europa of flash_lane0_module is
--  component lpm_ram_dp is
--GENERIC (
--      lpm_file : STRING;
--        lpm_hint : STRING;
--        lpm_indata : STRING;
--        lpm_outdata : STRING;
--        lpm_rdaddress_control : STRING;
--        lpm_width : NATURAL;
--        lpm_widthad : NATURAL;
--        lpm_wraddress_control : STRING;
--        suppress_memory_conversion_warnings : STRING
--      );
--    PORT (
--    signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--        signal rdaddress : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
--        signal wren : IN STD_LOGIC;
--        signal wrclock : IN STD_LOGIC;
--        signal wraddress : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
--        signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
--        signal rdclken : IN STD_LOGIC
--      );
--  end component lpm_ram_dp;
--                signal internal_q :  STD_LOGIC_VECTOR (7 DOWNTO 0);
--                TYPE mem_array is ARRAY( 4194303 DOWNTO 0) of STD_LOGIC_VECTOR(7 DOWNTO 0);
--                signal memory_has_been_read :  STD_LOGIC;
--                signal read_address :  STD_LOGIC_VECTOR (21 DOWNTO 0);
--
--begin
--
--  process (rdaddress)
--  begin
--      read_address <= rdaddress;
--
--  end process;
--
--  lpm_ram_dp_component : lpm_ram_dp
--    generic map(
--      lpm_file => "flash.mif",
--      lpm_hint => "USE_EAB=ON",
--      lpm_indata => "REGISTERED",
--      lpm_outdata => "UNREGISTERED",
--      lpm_rdaddress_control => "UNREGISTERED",
--      lpm_width => 8,
--      lpm_widthad => 22,
--      lpm_wraddress_control => "REGISTERED",
--      suppress_memory_conversion_warnings => "ON"
--    )
--    port map(
--            data => data,
--            q => internal_q,
--            rdaddress => read_address,
--            rdclken => rdclken,
--            wraddress => wraddress,
--            wrclock => wrclock,
--            wren => wren
--    );
--
--  
--  q <= internal_q;
--end europa;
--
--synthesis read_comments_as_HDL off


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity flash is 
        port (
              -- inputs:
                 signal address : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
                 signal read_n : IN STD_LOGIC;
                 signal select_n : IN STD_LOGIC;
                 signal write_n : IN STD_LOGIC;

              -- outputs:
                 signal data : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity flash;


architecture europa of flash is
--synthesis translate_off
component flash_lane0_module is 
           port (
                 -- inputs:
                    signal data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal rdaddress : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
                    signal rdclken : IN STD_LOGIC;
                    signal wraddress : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
                    signal wrclock : IN STD_LOGIC;
                    signal wren : IN STD_LOGIC;

                 -- outputs:
                    signal q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component flash_lane0_module;

--synthesis translate_on
                signal data_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal logic_vector_gasket :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal module_input13 :  STD_LOGIC;
                signal module_input14 :  STD_LOGIC;
                signal q_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);

begin

  --s1, which is an e_ptf_slave
--synthesis translate_off
    logic_vector_gasket <= data;
    data_0 <= logic_vector_gasket(7 DOWNTO 0);
    --flash_lane0, which is an e_ram
    flash_lane0 : flash_lane0_module
      port map(
        q => q_0,
        data => data_0,
        rdaddress => address,
        rdclken => module_input13,
        wraddress => address,
        wrclock => write_n,
        wren => module_input14
      );

    module_input13 <= std_logic'('1');
    module_input14 <= NOT select_n;

    data <= A_WE_StdLogicVector((std_logic'(((NOT select_n AND NOT read_n))) = '1'), q_0, A_REP(std_logic'('Z'), 8));
--synthesis translate_on

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
component nios32 is 
           port (
                 -- 1) global signals:
                    signal clk_0 : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- the_LEDS
                    signal out_port_from_the_LEDS : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);

                 -- the_buttons
                    signal in_port_to_the_buttons : IN STD_LOGIC_VECTOR (3 DOWNTO 0);

                 -- the_ext_bus_avalon_slave
                    signal address_to_the_flash : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
                    signal data_to_and_from_the_flash : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal read_n_to_the_flash : OUT STD_LOGIC;
                    signal select_n_to_the_flash : OUT STD_LOGIC;
                    signal write_n_to_the_flash : OUT STD_LOGIC;

                 -- the_lcd
                    signal LCD_E_from_the_lcd : OUT STD_LOGIC;
                    signal LCD_RS_from_the_lcd : OUT STD_LOGIC;
                    signal LCD_RW_from_the_lcd : OUT STD_LOGIC;
                    signal LCD_data_to_and_from_the_lcd : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);

                 -- the_sdram
                    signal zs_addr_from_the_sdram : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal zs_ba_from_the_sdram : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_cas_n_from_the_sdram : OUT STD_LOGIC;
                    signal zs_cke_from_the_sdram : OUT STD_LOGIC;
                    signal zs_cs_n_from_the_sdram : OUT STD_LOGIC;
                    signal zs_dq_to_and_from_the_sdram : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal zs_dqm_from_the_sdram : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_ras_n_from_the_sdram : OUT STD_LOGIC;
                    signal zs_we_n_from_the_sdram : OUT STD_LOGIC;

                 -- the_sram
                    signal SRAM_ADDR_from_the_sram : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal SRAM_CE_N_from_the_sram : OUT STD_LOGIC;
                    signal SRAM_DQ_to_and_from_the_sram : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SRAM_LB_N_from_the_sram : OUT STD_LOGIC;
                    signal SRAM_OE_N_from_the_sram : OUT STD_LOGIC;
                    signal SRAM_UB_N_from_the_sram : OUT STD_LOGIC;
                    signal SRAM_WE_N_from_the_sram : OUT STD_LOGIC;

                 -- the_switches
                    signal in_port_to_the_switches : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

                 -- the_uart
                    signal rxd_to_the_uart : IN STD_LOGIC;
                    signal txd_from_the_uart : OUT STD_LOGIC
                 );
end component nios32;

component flash is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
                    signal read_n : IN STD_LOGIC;
                    signal select_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;

                 -- outputs:
                    signal data : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component flash;

component sdram_test_component is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal zs_addr : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal zs_ba : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_cas_n : IN STD_LOGIC;
                    signal zs_cke : IN STD_LOGIC;
                    signal zs_cs_n : IN STD_LOGIC;
                    signal zs_dqm : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_ras_n : IN STD_LOGIC;
                    signal zs_we_n : IN STD_LOGIC;

                 -- outputs:
                    signal zs_dq : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component sdram_test_component;

                signal LCD_E_from_the_lcd :  STD_LOGIC;
                signal LCD_RS_from_the_lcd :  STD_LOGIC;
                signal LCD_RW_from_the_lcd :  STD_LOGIC;
                signal LCD_data_to_and_from_the_lcd :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal SRAM_ADDR_from_the_sram :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal SRAM_CE_N_from_the_sram :  STD_LOGIC;
                signal SRAM_DQ_to_and_from_the_sram :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SRAM_LB_N_from_the_sram :  STD_LOGIC;
                signal SRAM_OE_N_from_the_sram :  STD_LOGIC;
                signal SRAM_UB_N_from_the_sram :  STD_LOGIC;
                signal SRAM_WE_N_from_the_sram :  STD_LOGIC;
                signal address_to_the_flash :  STD_LOGIC_VECTOR (21 DOWNTO 0);
                signal clk :  STD_LOGIC;
                signal clk_0 :  STD_LOGIC;
                signal cpu_custom_instruction_master_combo_a :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal cpu_custom_instruction_master_combo_b :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal cpu_custom_instruction_master_combo_c :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal cpu_custom_instruction_master_combo_estatus :  STD_LOGIC;
                signal cpu_custom_instruction_master_combo_ipending :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_custom_instruction_master_combo_readra :  STD_LOGIC;
                signal cpu_custom_instruction_master_combo_readrb :  STD_LOGIC;
                signal cpu_custom_instruction_master_combo_status :  STD_LOGIC;
                signal cpu_custom_instruction_master_combo_writerc :  STD_LOGIC;
                signal data_to_and_from_the_flash :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal in_port_to_the_buttons :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal in_port_to_the_switches :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal out_port_from_the_LEDS :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal read_n_to_the_flash :  STD_LOGIC;
                signal reset_n :  STD_LOGIC;
                signal rxd_to_the_uart :  STD_LOGIC;
                signal select_n_to_the_flash :  STD_LOGIC;
                signal txd_from_the_uart :  STD_LOGIC;
                signal uart_s1_dataavailable_from_sa :  STD_LOGIC;
                signal uart_s1_readyfordata_from_sa :  STD_LOGIC;
                signal write_n_to_the_flash :  STD_LOGIC;
                signal zs_addr_from_the_sdram :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal zs_ba_from_the_sdram :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal zs_cas_n_from_the_sdram :  STD_LOGIC;
                signal zs_cke_from_the_sdram :  STD_LOGIC;
                signal zs_cs_n_from_the_sdram :  STD_LOGIC;
                signal zs_dq_to_and_from_the_sdram :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal zs_dqm_from_the_sdram :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal zs_ras_n_from_the_sdram :  STD_LOGIC;
                signal zs_we_n_from_the_sdram :  STD_LOGIC;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your component and signal declaration here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


begin

  --Set us up the Dut
  DUT : nios32
    port map(
      LCD_E_from_the_lcd => LCD_E_from_the_lcd,
      LCD_RS_from_the_lcd => LCD_RS_from_the_lcd,
      LCD_RW_from_the_lcd => LCD_RW_from_the_lcd,
      LCD_data_to_and_from_the_lcd => LCD_data_to_and_from_the_lcd,
      SRAM_ADDR_from_the_sram => SRAM_ADDR_from_the_sram,
      SRAM_CE_N_from_the_sram => SRAM_CE_N_from_the_sram,
      SRAM_DQ_to_and_from_the_sram => SRAM_DQ_to_and_from_the_sram,
      SRAM_LB_N_from_the_sram => SRAM_LB_N_from_the_sram,
      SRAM_OE_N_from_the_sram => SRAM_OE_N_from_the_sram,
      SRAM_UB_N_from_the_sram => SRAM_UB_N_from_the_sram,
      SRAM_WE_N_from_the_sram => SRAM_WE_N_from_the_sram,
      address_to_the_flash => address_to_the_flash,
      data_to_and_from_the_flash => data_to_and_from_the_flash,
      out_port_from_the_LEDS => out_port_from_the_LEDS,
      read_n_to_the_flash => read_n_to_the_flash,
      select_n_to_the_flash => select_n_to_the_flash,
      txd_from_the_uart => txd_from_the_uart,
      write_n_to_the_flash => write_n_to_the_flash,
      zs_addr_from_the_sdram => zs_addr_from_the_sdram,
      zs_ba_from_the_sdram => zs_ba_from_the_sdram,
      zs_cas_n_from_the_sdram => zs_cas_n_from_the_sdram,
      zs_cke_from_the_sdram => zs_cke_from_the_sdram,
      zs_cs_n_from_the_sdram => zs_cs_n_from_the_sdram,
      zs_dq_to_and_from_the_sdram => zs_dq_to_and_from_the_sdram,
      zs_dqm_from_the_sdram => zs_dqm_from_the_sdram,
      zs_ras_n_from_the_sdram => zs_ras_n_from_the_sdram,
      zs_we_n_from_the_sdram => zs_we_n_from_the_sdram,
      clk_0 => clk_0,
      in_port_to_the_buttons => in_port_to_the_buttons,
      in_port_to_the_switches => in_port_to_the_switches,
      reset_n => reset_n,
      rxd_to_the_uart => rxd_to_the_uart
    );


  --the_flash, which is an e_ptf_instance
  the_flash : flash
    port map(
      data => data_to_and_from_the_flash,
      address => address_to_the_flash,
      read_n => read_n_to_the_flash,
      select_n => select_n_to_the_flash,
      write_n => write_n_to_the_flash
    );


  --the_sdram_test_component, which is an e_instance
  the_sdram_test_component : sdram_test_component
    port map(
      zs_dq => zs_dq_to_and_from_the_sdram,
      clk => clk_0,
      zs_addr => zs_addr_from_the_sdram,
      zs_ba => zs_ba_from_the_sdram,
      zs_cas_n => zs_cas_n_from_the_sdram,
      zs_cke => zs_cke_from_the_sdram,
      zs_cs_n => zs_cs_n_from_the_sdram,
      zs_dqm => zs_dqm_from_the_sdram,
      zs_ras_n => zs_ras_n_from_the_sdram,
      zs_we_n => zs_we_n_from_the_sdram
    );


  process
  begin
    clk_0 <= '0';
    loop
       wait for 10 ns;
       clk_0 <= not clk_0;
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
