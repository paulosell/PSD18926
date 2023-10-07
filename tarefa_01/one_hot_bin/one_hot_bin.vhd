-- Implemente uma extensão ao codificador de prioridades estáticas do Circuito 4
-- que apresente o identificador da requisição selecionada utilizando codificação binária de
-- dois bits. 
library ieee;
use ieee.std_logic_1164.all;


entity one_hot_bin is
  port
  (
    i_REQ       : in std_logic_vector(3 downto 0);
    o_GRANT     : out std_logic_vector(3 downto 0);
    o_GRANT_BIN : out std_logic_vector(1 downto 0)
  );
end one_hot_bin;

architecture arch of one_hot_bin is
  -- Components declaration
  component one_hot is
    port
    (
      i_REQ   : in std_logic_vector(3 downto 0);
      o_GRANT : out std_logic_vector(3 downto 0)
    );
  end component;
begin
  process (i_REQ)
  begin
    o_GRANT_BIN <= (others => '0');
    if (i_REQ(0) = '1') then
      o_GRANT_BIN <= "00";
    elsif (i_REQ(1) = '1') then
      o_GRANT_BIN <= "01";
    elsif (i_REQ(2) = '1') then
      o_GRANT_BIN <= "10";
    elsif (i_REQ(3) = '1') then
      o_GRANT_BIN <= "11";
    end if;
  end process;

  u_1 : one_hot port map
  (
    i_REQ   => i_REQ,
    o_GRANT => o_GRANT);

end arch;