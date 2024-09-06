library ieee;
use ieee.std_logic_1164.all; --for standard logic
use ieee.numeric_std.all; --for sequential stuff

entity combogen is
    port(
        input: in std_logic_vector(2 downto 0);
        output: out std_logic_vector(7 downto 0)
    );
end combogen;

architecture rtl of combogen is
    signal counter: integer := 0;
begin
    gen: for i in 0 to 7 generate
        output(i) <= '1' when counter = i else '0';
        end generate;
    counter <= to_integer(unsigned(input));
end architecture;
