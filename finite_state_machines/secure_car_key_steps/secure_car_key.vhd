library ieee;
use ieee.std_logic_1164.all;

entity secure_car_key is
port ( i_CLK : in std_logic;
		 i_A   : in std_logic;
		 o_R   : out std_logic);
end secure_car_key;

architecture secure_car_key_fsm of secure_car_key is
signal w_S0, w_S1, w_S2 : std_logic := '0';
signal w_N0, w_N1, w_N2 : std_logic := '0';

begin
  process(i_CLK, w_N0, w_N1, w_N2)
  begin
    if rising_edge(i_CLK) then
	   w_S0 <= w_N0;
		w_S1 <= w_N1;
		w_S2 <= w_N2;
	 end if;
  end process; 
  
  process(i_A, w_S0, w_S1, w_S2)
  begin
	 w_N0 <= ((not w_S2) and (not w_s0) and (w_S1)) or ((not w_S2) and (not w_S0) and (i_A));
	 w_N1 <= ((not w_S2) and (not w_S1) and (w_s0)) or ((not w_S2) and (w_S1) and (not w_s0));
	 w_N2 <= ((not w_S2) and (w_S1) and (w_s0));
  end process;
  
  o_R <= ((not w_S2) and (not w_S1) and (w_S0)) or ((not w_S2) and (w_S1) and (not w_S0)) or ((w_S2) and (not w_S1) and (not w_S0));
end architecture secure_car_key_fsm;
