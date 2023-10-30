library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rgb_to_cmy is
generic ( N : integer := 8 );
port ( i_R : in std_logic_vector(N-1 downto 0);
       i_G : in std_logic_vector(N-1 downto 0);
		 i_B : in std_logic_vector(N-1 downto 0);
		 o_C : out std_logic_vector(N-1 downto 0);
		 o_M : out std_logic_vector(N-1 downto 0);
		 o_Y : out std_logic_vector(N-1 downto 0));
end rgb_to_cmy; 

architecture rgb_to_cmy_arch of rgb_to_cmy is
begin

  o_C <= std_logic_vector(255 - unsigned(i_R));
  o_M <= std_logic_vector(255 - unsigned(i_G));
  o_Y <= std_logic_vector(255 - unsigned(i_B));

end rgb_to_cmy_arch;