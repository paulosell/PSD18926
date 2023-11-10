library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
  generic
    (N : integer := 8);
  port
  (
    i_CIN : in std_logic;
    i_A   : in std_logic_vector(N - 1 downto 0);
    i_B   : in std_logic_vector(N - 1 downto 0);
    o_O   : out std_logic_vector(N - 1 downto 0));
end entity;

architecture adder_arch of adder is
begin
  -- trying to use cin
  o_O <= std_logic_vector(unsigned(i_A) + unsigned(i_B) + ("" & i_CIN));
end adder_arch;