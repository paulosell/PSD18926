library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity register_file is
generic ( N : integer := 8);
port (
  i_CLK : in std_logic;
  i_RST : in std_logic;
  i_START_MAC : in std_logic;
  i_MUX : in std_logic_vector(1 downto 0);
  o_W : out std_logic_vector(N-1 downto 0);
  o_X : out std_logic_vector(N-1 downto 0));
end entity;

architecture register_file_arch of register_file is
type t_REGISTER_ARRAY is array (0 to 3) of signed(7 downto 0);
type t_MUX is array (0 to 3) of std_logic_vector(7 downto 0);

signal w_X : t_REGISTER_ARRAY := (to_signed(2,N),to_signed(4,N),to_signed(6,N), to_signed(8,N));
signal w_W : t_REGISTER_ARRAY := (to_signed(1,N),to_signed(3,N),to_signed(5,N), to_signed(7,N));
signal w_OX, w_OY : std_logic_vector(N-1 downto 0) := (others => '0');

begin
  
  process(i_CLK, i_MUX, i_START_MAC)
  begin
    if rising_edge(i_CLK) then
	   if i_START_MAC = '1' then
	     if i_MUX = "00" then
		    w_OX <= std_logic_vector(w_X(0));
		    w_OY <= std_logic_vector(w_W(0));
		  elsif i_MUX = "01" then
		    w_OX <= std_logic_vector(w_X(1));
		    w_OY <= std_logic_vector(w_W(1));
		  elsif i_MUX = "10" then
		    w_OX <= std_logic_vector(w_X(2));
		    w_OY <= std_logic_vector(w_W(2));
		  elsif i_MUX = "11" then
		    w_OX <= std_logic_vector(w_X(3));
		    w_OY <= std_logic_vector(w_W(3));
		  end if;	
      end if;	
    end if;
  end process;
	 
  o_X <= w_OX;
  o_W <= w_OY;

end architecture;
