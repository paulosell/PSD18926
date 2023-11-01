library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bit_shifter is
generic (N      : integer := 16);
port ( i_IN        : in std_logic_vector(N-1 downto 0);
       i_PLACES    : in std_logic_vector(2 downto 0);
       i_DIRECTION : in std_logic;
       o_OUT       : out std_logic_vector(N-1 downto 0));
end entity;

architecture bit_shifter_arch of bit_shifter is
begin
 
 process (i_DIRECTION, i_IN, i_PLACES)
 begin
   if i_DIRECTION = '1' then
	  if i_PLACES = "001" then
	    o_OUT <=  std_logic_vector(shift_left(unsigned(i_IN), 1));
	  elsif i_PLACES = "010" then
	    o_OUT <=  std_logic_vector(shift_left(unsigned(i_IN), 2));
	  elsif i_PLACES = "101" then
	    o_OUT <=  std_logic_vector(shift_left(unsigned(i_IN), 5));
	  elsif i_PLACES = "110" then
	    o_OUT <=  std_logic_vector(shift_left(unsigned(i_IN), 6));
	  else
	    o_OUT <= i_IN;
	  end if;
	else
     o_OUT <=  std_logic_vector(shift_right(unsigned(i_IN), 7));
   end if;
 end process;

end bit_shifter_arch;