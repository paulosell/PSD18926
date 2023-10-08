library ieee;
use ieee.std_logic_1164.all;

entity secure_car_key is
port ( i_CLK : in std_logic;
		 i_A   : in std_logic;
		 o_R   : out std_logic);
end secure_car_key;

architecture secure_car_key_fsm of secure_car_key is
type t_STATE is (s_WAIT, s_K1, s_K2, s_K3, s_K4);
signal w_NEXT : t_STATE; -- next state
signal r_STATE : t_STATE; -- current state


begin
  process(i_CLK, i_A, r_STATE)
  begin
    if rising_edge(i_CLK) then
	   if (i_A='1' and r_STATE = s_WAIT) then
		  r_STATE <= s_K1;
		else 
		  r_STATE <= w_NEXT;
		end if;
	 end if;
  end process; 
  
  process(r_STATE)
  begin
    case r_STATE is
	   when s_K1 => w_NEXT <= s_K2;
		when s_K2 => w_NEXT <= s_K3;
		when s_K3 => w_NEXT <= s_K4;
		when s_K4 => w_NEXT <= s_WAIT;
		when others => w_NEXT <= s_WAIT;
    end case;
  end process; 
  
  o_R <= '1' when (r_STATE = s_K1) else
         '1' when (r_STATE = s_K2) else
         '0' when (r_STATE = s_K3) else
			'1' when (r_STATE = s_K4) else
         '0';
		 
end secure_car_key_fsm;