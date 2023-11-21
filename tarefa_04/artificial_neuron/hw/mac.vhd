library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mac is
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_START_MAC : in std_logic;
  i_X : in std_logic_vector(N-1 downto 0);
  i_W : in std_logic_vector(N-1 downto 0);
  i_OLD_MAC : in std_logic_vector((N*2)-1 downto 0);
  o_NEW_MAC : out std_logic_vector((N*2)-1 downto 0));
end mac;

architecture mac_arch of mac is
signal w_NEW_MAC  : signed((N*2)-1 downto 0) := (others => '0');
signal w_X_W : signed((N*2)-1 downto 0) := (others => '0');
signal w_MAC_FINISHED : std_logic := '0';
begin
  
  process(i_CLK, i_OLD_MAC, i_X, i_W)
  begin
	if rising_edge(i_CLK) then
	  if i_START_MAC = '1' then
	    w_NEW_MAC <= signed(i_OLD_MAC) + (signed(i_X) * signed(i_W));
	  end if;
	else
	end if;
  end process;
  
  o_NEW_MAC <= std_logic_vector(w_NEW_MAC);
end mac_arch;
  

