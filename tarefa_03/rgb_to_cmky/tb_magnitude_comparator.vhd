library ieee;
use ieee.std_logic_1164.all;
entity tb_magnitude_comparator is
end tb_magnitude_comparator; 

architecture testbench of tb_magnitude_comparator is
signal w_A, w_B, w_IGT, w_IEQ, w_ILT, w_OGT, w_OEQ, w_OLT : std_logic; 

begin

  DUT : entity work.magnitude_comparator
  port map ( i_A => w_A,
             i_B => w_B,
				 i_GT => w_IGT,
				 i_EQ => w_IEQ,
				 i_LT => w_ILT,
				 o_GT => w_OGT,
				 o_EQ => w_OEQ,
				 o_LT => w_OLT);
            
  process
  begin
	
    w_A <= '1';
	 w_B <= '0';
	 w_IGT <= '0';
	 w_IEQ <= '1';
	 w_ILT <= '0';
	 wait for 10ps;
	 assert(w_OGT = '1') report "Unexpected value at o_GT" severity error;
	 assert(w_OEQ = '0') report "Unexpected value at o_EQ" severity error;
	 assert(w_OLT = '0') report "Unexpected value at o_LT" severity error;
	 
    
	 w_A <= '0';
	 w_B <= '1';
	 w_IGT <= '0';
	 w_IEQ <= '1';
	 w_ILT <= '0';
	 wait for 10ps;
	 assert(w_OGT = '0') report "Unexpected value at o_GT" severity error;
	 assert(w_OEQ = '0') report "Unexpected value at o_EQ" severity error;
	 assert(w_OLT = '1') report "Unexpected value at o_LT" severity error;
	
    
	 w_A <= '1';
	 w_B <= '1';
	 w_IGT <= '0';
	 w_IEQ <= '1';
	 w_ILT <= '0';
	 wait for 10ps;
	 assert(w_OGT = '0') report "Unexpected value at o_GT" severity error;
	 assert(w_OEQ = '1') report "Unexpected value at o_EQ" severity error;
	 assert(w_OLT = '0') report "Unexpected value at o_LT" severity error;
	
    
	 w_A <= '0';
	 w_B <= '0';
	 w_IGT <= '0';
	 w_IEQ <= '1';
	 w_iLT <= '0';
	 wait for 10ps;
	 assert(w_OGT = '0') report "Unexpected value at o_GT" severity error;
	 assert(w_OEQ = '1') report "Unexpected value at o_EQ" severity error;
	 assert(w_OLT = '0') report "Unexpected value at o_LT" severity error;
    
	 w_A <= '1';
	 w_B <= '1';
	 w_IGT <= '1';
	 w_IEQ <= '1';
	 w_iLT <= '0';
	 wait for 10ps;
	 assert(w_OGT = '1') report "Unexpected value at o_GT" severity error;
	 assert(w_OEQ = '1') report "Unexpected value at o_EQ" severity error;
	 assert(w_OLT = '0') report "Unexpected value at o_LT" severity error;
    
	 w_A <= '1';
	 w_B <= '1';
	 w_ILT <= '1';
	 w_IGT <= '0';
	 w_IEQ <= '1';
	 wait for 10ps;
	 assert(w_OGT = '0') report "Unexpected value at o_GT" severity error;
	 assert(w_OEQ = '1') report "Unexpected value at o_EQ" severity error;
	 assert(w_OLT = '1') report "Unexpected value at o_LT" severity error;
	 
	 wait;
	 end process;
end testbench;