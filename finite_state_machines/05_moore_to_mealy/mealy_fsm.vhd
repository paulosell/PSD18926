library ieee;
use ieee.std_logic_1164.all;
entity mealy_fsm is
  port
  (
    i_CLK : in std_logic; -- clock
    i_A   : in std_logic;
    i_B   : in std_logic;
    o_Y   : out std_logic); -- data output
end mealy_fsm;

architecture mealy of mealy_fsm is
  type t_STATE is (s_A, s_B, s_C, s_D);
  signal w_NEXT  : t_STATE; -- next state
  signal r_STATE : t_STATE; -- current state

begin
  -- State Register
  p_STATE : process (i_CLK)
  begin
    if (rising_edge(i_CLK)) then
      r_STATE <= w_NEXT;
    end if;
  end process;

  -- Next State Function
  p_NEXT_STATE : process (r_STATE, i_A, i_B)
  begin
    case r_STATE is
      when s_A =>
        if i_A = '1' then
          w_NEXT <= s_A;
        elsif i_B = '1' then
          w_NEXT <= s_B;
        else
          w_NEXT <= s_C;
        end if;
      when s_B =>
        if i_A = '0' then
          w_NEXT <= s_B;
        else
          w_NEXT <= s_C;
        end if;
      when s_C =>
        if i_B = '0' then
          w_NEXT <= s_C;
        else
          w_NEXT <= s_D;
        end if;
      when s_D =>
        w_NEXT <= s_A;
      when others =>
        w_NEXT <= s_A;
    end case;
  end process;

  -- Output Function
  o_Y <= '1' when (w_NEXT = s_B or w_NEXT = s_C) else
    '0';

end mealy;