-- Implemente um circuito demultiplexador 1-para-2 com canal de dados de 1 bit.
library ieee;
use ieee.std_logic_1164.all;

entity mux_1_to_2_bits is
  port (
    i_SEL  : in std_logic;   -- selector
    i_A    : in std_logic;   -- data input
    o_S1   : out std_logic;   -- data input
    o_S2   : out std_logic); -- data output
end mux_1_to_2_bits;

architecture arch_1 of mux_1_to_2_bits is
begin
    process (i_SEL, i_A)
    begin
        if i_SEL = '0' then
            o_S1 <= i_A;
            o_S2 <= '0';
        else
            o_S1 <= '0';
            o_S2 <= i_A;
        end if;
    end process;
end arch_1;
