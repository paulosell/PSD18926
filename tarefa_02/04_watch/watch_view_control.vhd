library ieee;
use ieee.std_logic_1164.all;
entity watch_view_control is
  port
  (
    i_CLK : in std_logic; -- clock
    i_B_n   : in std_logic; -- input B, works like a clock
    o_S0  : out std_logic; -- data output
    o_S1  : out std_logic); -- data output
end watch_view_control;

architecture arch_1 of watch_view_control is
  type t_STATE is (s_H, s_A, s_C, s_D);
  signal w_NEXT  : t_STATE; -- next state
  signal r_STATE : t_STATE; -- current state
  signal r_B     : std_logic;

begin
  -- State Register
  p_STATE : process (r_B)
  begin
    if (rising_edge(r_B)) then
      r_STATE <= w_NEXT;
    end if;
  end process;

  -- input Register
  p_INPUT : process (i_CLK, i_B_n)
  begin
    if (rising_edge(i_CLK)) then
      if (i_B_n = '0') then
        r_B <= '1';
      else
        r_B <= '0';
      end if;
    end if;
  end process;

  -- Next State Function
  p_NEXT_STATE : process (r_STATE)
  begin
    case r_STATE is
      when s_H    => w_NEXT    <= s_A;
      when s_A    => w_NEXT    <= s_C;
      when s_C    => w_NEXT    <= s_D;
      when s_D    => w_NEXT    <= s_H;
      when others => w_NEXT <= s_H;
    end case;
  end process;

  -- Output Function
  o_S0 <= '1' when (r_STATE = s_A or r_STATE = s_D) else
    '0';
  o_S1 <= '1' when (r_STATE = s_C or r_STATE = s_D) else
    '0';

end arch_1;