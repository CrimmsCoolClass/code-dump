library ieee;
use ieee.std_logic_1164.all; --for standard logic
use ieee.numeric_std.all; --for sequential stuff

entity demo is
    port(
       vec1: in std_logic_vector(2 downto 0);
       vec2: in std_logic_vector(2 downto 0);
       single1: out std_logic;
       bigvec: out std_logic_vector(5 downto 0);
       operatevec: out std_logic_vector(2 downto 0);
       indexvec: out std_logic_vector(8 downto 0)
    );
end demo;

architecture rtl of demo is

begin
    bigvec <= vec1 & vec2; --concatenation
    operatevec <= vec1 xor vec2; --operate on each bit of vector
    single1 <= and vec1; -- same as vec1(0) and vec1(1) and vec1(2) and vec1(3)
    indexvec <= (8|7 =>'1', 3 to 5 => 'Z', others => '0');
    --index(0 and 2) = vec2(2)
    --index(3 to 5) = vec1(3)
    --rest are '0'

end architecture;
