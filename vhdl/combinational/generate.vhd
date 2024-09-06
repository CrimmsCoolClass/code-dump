library ieee;
use ieee.std_logic_1164.all; --for standard logic
use ieee.numeric_std.all; --for sequential stuff

entity demo is
    port(
        c,d: in std_logic_vector(7 downto 0);
        y: out std_logic_vector(7 downto 0)
    );
end demo;

architecture rtl of demo is
    signal a,b,x: std_logic_vector(7 downto 0);
begin

    gen: for i in 0 to 7 generate
        x(i) <= a(i) xor b(7-i);
    end generate;
    
    a <= c;
    b <= d;
    y <= x;
end architecture;
