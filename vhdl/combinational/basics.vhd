library ieee;
use ieee.std_logic_1164.all;

entity bitwise is
    port(a: in std_logic_vector(3 downto 0);
        y: out std_logic_vector(3 downto 0)
    );
end bitwise;

architecture rtl of bitwise is

begin
    y <= not a;
end architecture;
