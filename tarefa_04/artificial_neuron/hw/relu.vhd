library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity relu is
generic ( N : integer := 16);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_START_RELU : in std_logic;
  i_MAC   : in std_logic_vector(N-1 downto 0);
  o_VALUE : out std_logic_vector(N-1 downto 0);
  o_RELU_FINISHED : out std_logic);
end relu;
 
architecture relu_arch of relu is
signal w_VALUE : signed(N-1 downto 0) := (others => '0');
signal w_RELU_FINISHED : std_logic := '0';

begin
  
  process(i_CLK, i_RST, i_MAC, i_START_RELU)
  begin
  if i_RST = '1' then
    w_RELU_FINISHED <= '0';
	 w_VALUE <= (others => '0');
  elsif rising_edge(i_CLK) then
    if (i_START_RELU = '1') then 
     if (signed(i_MAC) < 0) then
	     w_VALUE <= (others => '0');
	   else
	     w_VALUE <= signed(i_MAC);
	   end if;
	   w_RELU_FINISHED <= '1';
    end if;
  end if;
  end process;
  
  o_VALUE <= std_logic_vector(w_VALUE);
  o_RELU_FINISHED <= w_RELU_FINISHED;
  
end architecture;

