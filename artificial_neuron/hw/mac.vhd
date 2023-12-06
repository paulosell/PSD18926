library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mac is
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_START_MAC : in std_logic;
  i_X0 : in std_logic_vector(N-1 downto 0);
  i_X1 : in std_logic_vector(N-1 downto 0);
  i_X2 : in std_logic_vector(N-1 downto 0);
  i_X3 : in std_logic_vector(N-1 downto 0);
  i_W0 : in std_logic_vector(N-1 downto 0);
  i_W1 : in std_logic_vector(N-1 downto 0);
  i_W2 : in std_logic_vector(N-1 downto 0);
  i_W3 : in std_logic_vector(N-1 downto 0);
  o_MAC_FINISHED : out  std_logic;
  o_MAC : out std_logic_vector((N*2)-1 downto 0));
end mac;

architecture mac_arch of mac is
signal w_MAC  : signed((N*2)-1 downto 0) := (others => '0');
signal w_MAC_FINISHED : std_logic := '0';

begin
  
  process(i_CLK, i_RST, i_START_MAC)
  begin
   if (i_RST = '1') then
	  w_MAC_FINISHED <= '0';
	  w_MAC <= (others => '0');
	elsif rising_edge(i_CLK) then
	  if i_START_MAC = '1' then
		 w_MAC <= signed(i_X0) * signed(i_W0) + signed(i_X1) * signed(i_W1) + signed(i_X2) * signed(i_W2) + signed(i_X3) * signed(i_W3);
		 w_MAC_FINISHED <= '1';
	  end if;
	else
	end if;
  end process;
  
  o_MAC <= std_logic_vector(w_MAC);
  o_MAC_FINISHED <= w_MAC_FINISHED;
end mac_arch;
  

