library ieee;
use ieee.std_logic_1164.all;

entity reg is
generic ( N : integer := 16);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_LOAD : in std_logic;
  i_D   : in std_logic_vector(N-1 downto 0);
  o_Q   : out std_logic_vector(N-1 downto 0));
end entity;

architecture reg_arch of reg is
signal w_Q : std_logic_vector(N-1 downto 0) := (others => '0');
begin

  process(i_RST, i_CLK, i_D, i_LOAD)
  begin
    if (i_RST='1') then
	   w_Q <= (others => '0');
	 elsif (rising_edge(i_CLK)) then
	   if (i_LOAD = '1') then
	     w_Q <= i_D;
		end if;
	 end if;
  end process;

  o_Q <= w_Q;

end architecture;
    