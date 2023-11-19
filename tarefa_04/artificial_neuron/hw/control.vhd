library ieee;
use ieee.std_logic_1164.all;

entity control is 
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic; 
  i_MAC_FINISHED : in std_logic;
  o_LOAD : out std_logic;
  o_START_MAC  : out std_logic;
  o_START_RELU : out std_logic);
end control;

architecture control_arch of control is
type t_STATE is (s_IDLE, s_LOAD, s_MAC, s_RELU);
signal w_STATE, w_NEXT : t_STATE;

begin 

  process(i_RST, i_CLK)
  begin
    if (i_RST = '1') then
	   w_STATE <= s_IDLE;
	 elsif rising_edge(i_CLK) then
	   w_STATE <= w_NEXT;
	 end if;
  end process;
  
  process(w_STATE, i_MAC_FINISHED)
  begin
    case w_STATE is
	   when s_IDLE => w_NEXT <= s_LOAD;
		when s_LOAD => w_NEXT <= s_MAC;
		when s_MAC => if (i_MAC_FINISHED = '1') then
		  w_NEXT <= s_RELU;
		else
		  w_NEXT <= s_MAC;
		end if;
		when s_RELU => w_NEXT <= S_IDLE;
		when others => w_NEXT <= s_IDLE;
	 end case;
  end process;
  
  o_LOAD <= '1' when w_STATE = s_LOAD else '0';
  o_START_MAC <= '1' when w_STATE = s_MAC else '0';
  o_START_RELU <= '1' when w_STATE = s_RELU else '0';
end architecture;
  
  