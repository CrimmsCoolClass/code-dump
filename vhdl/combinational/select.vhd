library ieee;
use ieee.std_logic_1164.all;

entity mux is
    port(
      D: in std_logic_vector(3 downto 0);
      sel: in std_logic_vector(1 downto 0);
      mux_out: out std_logic  
    );
end mux;

architecture rtl of mux is

begin
with SEL select
    mux_out <= D(3) when "11",
               D(2) when "10",
               D(1) when "01",
               D(0) when "00",
               '0' when others;
end architecture;
