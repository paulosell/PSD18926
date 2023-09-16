-- Circuito codificador de prioridades estáticas que receba quatro
-- requisições (req) de entrada, selecione uma delas e informe a requisição selecionada por
-- meio de sinais de confirmação (grant). O circuito deve ter 4 entradas de requisição e 4
-- saídas de confirmação (identificadas de 0 a 3) e adotar a seguinte política de prioridades:
-- p(0) > p(1) > p(2) > p(3). A identificação da requisição selecionada deve ser feita utilizando
-- codificação one-hot, na qual um único bit é ligado indicando a requisição selecionada. 

library ieee;
use ieee.std_logic_1164.all;

entity one_hot is
  port
  (
    i_REQ   : in std_logic_vector(3 downto 0);
    o_GRANT : out std_logic_vector(3 downto 0)
  );
end one_hot;

architecture arch of one_hot is
begin
  process (i_REQ)
  begin
    o_GRANT <= (others => '0');
    if (i_REQ(0) = '1') then
      o_GRANT(0) <= '1';
    elsif (i_REQ(1) = '1') then
      o_GRANT(1) <= '1';
    elsif (i_REQ(2) = '1') then
      o_GRANT(2) <= '1';
    elsif (i_REQ(3) = '1') then
      o_GRANT(3) <= '1';
    end if;
  end process;
end arch;