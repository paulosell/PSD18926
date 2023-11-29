library ieee;
use ieee.std_logic_1164.all;

entity control is 
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic; 
  i_GO : in std_logic;
  i_MAC_FINISHED : in std_logic;
  i_RELU_FINISHED : in std_logic;
  o_START_MAC  : out std_logic;
  o_START_RELU : out std_logic);
end control;

architecture control_arch of control is
type t_STATE is (s_IDLE, s_MAC, s_RELU);
signal w_STATE, w_NEXT : t_STATE;

begin 

  process(i_RST, i_CLK, i_GO)
  begin
    if (i_RST = '1') then
	   w_STATE <= s_IDLE;
	 elsif rising_edge(i_CLK) then
	   w_STATE <= w_NEXT;
	 end if;
  end process;
  
  process(w_STATE, i_MAC_FINISHED, i_RELU_FINISHED)
  begin
    case w_STATE is
	   when s_IDLE => if (i_GO = '1') then
		  w_NEXT <= s_MAC;
		else
		  w_NEXT <= s_IDLE;
		end if;
		when s_MAC => if (i_MAC_FINISHED = '1') then
		  w_NEXT <= s_RELU;
		else
		  w_NEXT <= s_MAC;
		end if;
		when s_RELU =>  if (i_RELU_FINISHED = '1') THEN
		  w_NEXT <= s_IDLE;
		else
		  w_NEXT <= s_RELU;
		end if;  
		when others => w_NEXT <= s_IDLE;
	 end case;
  end process;
  
  o_START_MAC <= '1' when w_STATE = s_MAC else '0';
  o_START_RELU <= '1' when w_STATE = s_RELU else '0';
end architecture;
  
  