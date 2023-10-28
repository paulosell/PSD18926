library ieee;
use ieee.std_logic_1164.all;

entity rgb_to_cmky is
generic ( N : integer := 8 );
port ( i_R : in std_logic_vector(N-1 downto 0);
       i_G : in std_logic_vector(N-1 downto 0);
		 i_B : in std_logic_vector(N-1 downto 0);
		 o_C : out std_logic_vector(N-1 downto 0);
		 o_M : out std_logic_vector(N-1 downto 0);
		 o_K : out std_logic_vector(N-1 downto 0);
		 o_Y : out std_logic_vector(N-1 downto 0));
end rgb_to_cmky; 

architecture rgb_to_cmky_arch of rgb_to_cmky is
begin

end rgb_to_cmky_arch;