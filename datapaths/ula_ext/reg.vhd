library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity reg is
  generic
  (
    BIT_WIDTH : integer := 4
  );
  port
  (
    i_CLK   : in std_logic; -- Clock input
    i_RESET : in std_logic; -- i_RESET input
    i_LD    : in std_logic; -- load input
    i_D     : in std_logic_vector(BIT_WIDTH - 1 downto 0); -- Data input
    o_Q     : out std_logic_vector(BIT_WIDTH - 1 downto 0) -- Data output
  );
end reg;

architecture Behavioral of reg is
  signal r_REG_DATA : std_logic_vector(BIT_WIDTH - 1 downto 0) := (others => '0');
begin
  process (i_CLK, i_RESET, i_LD)
  begin
    if i_RESET = '1' then
      r_REG_DATA <= (others => '0'); -- i_RESET the reg
    elsif rising_edge(i_CLK) and i_LD = '1' then
      r_REG_DATA <= i_D; -- Update the reg on the rising edge of the clock
    end if;
  end process;

  o_Q <= r_REG_DATA; -- Output the current contents of the reg
end Behavioral;