library ieee;
use ieee.std_logic_1164.all;

entity minimum_comparator is
generic ( N : integer := 8 );
port ( i_A : in std_logic_vector(N-1 downto 0);
       i_B : in std_logic_vector(N-1 downto 0);
		 o_C : out std_logic_vector(N-1 downto 0));
end minimum_comparator;

architecture minimum_comparator_arch of minimum_comparator is

signal w_LT  : std_logic_vector(N downto 0) := (others => '0');
signal w_EQ  : std_logic_vector(N downto 0) := (others => '0');
signal w_GT  : std_logic_vector(N downto 0) := (others => '0');

component magnitude_comparator is
port (
  i_A  : in std_logic;
  i_B  : in std_logic;
  i_GT : in std_logic ;
  i_EQ : in std_logic ;
  i_LT : in std_logic ;
  o_GT : out std_logic;
  o_EQ : out std_logic;
  o_LT : out std_logic
);
end component;
begin
  w_EQ(N) <= '1';
  gen_mag_comp : for i in N downto 1 generate
    mag_comp_inst : magnitude_comparator 
	   port map (
		  i_A => i_A(i-1),
		  i_B => i_B(i-1),
		  i_EQ => w_EQ(i),
		  i_GT => w_GT(i),
		  i_LT => w_LT(i),
		  o_EQ => w_EQ(i-1),
		  o_GT => w_GT(i-1),
		  o_LT => w_LT(i-1));
  end generate;
  
  o_C <= i_B when w_GT(0) = '1' else i_A;  

end minimum_comparator_arch;
