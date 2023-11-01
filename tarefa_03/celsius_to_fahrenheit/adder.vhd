library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
generic ( N : integer := 16);
port ( i_A   : in std_logic_vector(N-1 downto 0);
       i_B   : in std_logic_vector(N-1 downto 0);
		 o_OUT : out std_logic_vector(N-1 downto 0));
end entity;

architecture adder_arch of adder is
begin

  o_OUT <= std_logic_vector(unsigned(i_A) + unsigned(i_B));

end adder_arch;