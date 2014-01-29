entity hw5_testbench is
end hw5_testbench;
-------------------------------
architecture Test of hw5_testbench is
-------------------------------
component hw5
  port(A, B: in bit_vector(3 downto 0); 
       Ci: in bit;
       S: out bit_vector(3 downto 0); 
       Co: out bit);
end component;
--------------------------------
signal addend, augend, sum: bit_vector(3 downto 0);
signal cin, cout: bit;
constant N: integer := 6;
type bv_arr is array(1 to N) of 
               bit_vector(3 downto 0);
type bit_arr is array(1 to N) of bit;
constant addend_array: bv_arr := 
  ( "0011", "0011", "0011", "1101", "1110", "1110");
constant augend_array: bv_arr := 
  ( "0010", "1110", "1101", "0010", "1101", "1100");
constant cin_array: bit_arr := 
  (    '0',    '0',    '1',    '0',    '0',    '1');
constant cout_array: bit_arr := 
  ('0',    '1',    '1',    '0',    '1',    '1');
constant sum_array: bv_arr := 
  ( "0101", "0001", "0001", "1111", "1011", "1011");
  begin
  add1: hw5 port map (addend, augend, cin, sum, cout);
  process
	  begin
		for i in 1 to N loop
		  addend <= addend_array(i);
		  augend <= augend_array(i);
		  cin <= cin_array(i);
		  wait for 10 ns;
assert (sum = sum_array(i) and 
              cout = cout_array(i))
        report "Wrong Answer"
        severity error;
    end loop;
    report "Test Finished";
  end process;
end Test;