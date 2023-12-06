library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity counter is
generic ( N : integer := 2);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_COUNT : in std_logic;
  o_FINISHED : out std_logic;
  o_OUT : out std_logic_vector( N -1 downto 0));
end counter;

architecture counter_arch of counter is
signal w_CNT : std_logic_vector(N-1 downto 0) := "00";
signal w_FINISHED : std_logic := '0';

begin

  process(i_CLK, i_RST)
  begin
  if i_RST = '1' then
    w_FINISHED <= '0';
	 w_CNT <= "00";
  elsif rising_edge(i_CLK) then
    if (i_COUNT ='1') then 
      if w_CNT = "11" then
	     w_FINISHED <= '1';
		  w_CNT <= "00";
	    else
	      w_CNT <= w_CNT + 1;
	    end if;
	  end if;
	end if;
  end process;
  
  o_FINISHED <= w_FINISHED;
  o_OUT <= w_CNT;
end architecture;
  