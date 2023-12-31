-- circuito multiplexador 2-para-1 com canal de dados de 1 bit.
library ieee;
use ieee.std_logic_1164.all;

entity mux_2_to_1_bit is
  port
  (
    i_SEL : in std_logic; -- selector
    i_A   : in std_logic; -- data input
    i_B   : in std_logic; -- data input
    o_S   : out std_logic); -- data output
end mux_2_to_1_bit;

architecture arch_1 of mux_2_to_1_bit is
begin
  process (i_SEL, i_A, i_B)
  begin
    if (i_SEL = '0') then
      o_S <= i_A;
    else
      o_S <= i_B;
    end if;
  end process;
end arch_1;