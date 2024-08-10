library ieee;
use ieee.std_logic_1164.all;

entity tristate is
    generic(
        NUM_BITS: natural := 16
    );
    port(
        inp: in std_logic_vector(NUM_BITS-1 downto 0);
        ena: in std_logic;
        outp: out std_logic_vector(NUM_BITS-1 downto 0)
    );
end tristate;

architecture rtl of tristate is

begin
    outp <= inp when ena else (others => 'Z');
end architecture;
