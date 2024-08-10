library ieee; 
use ieee.std_logic_1164.all;

entity comparator is
    generic(n: integer := 8);
    port(a, b: in std_logic_vector(n-1 downto 0);
        eq, neq, lt, lte, gt, gte: out std_logic
        );
end;

architecture synth of comparator is

begin
    eq <= '1' when (a = b) else '0'; --equal to
    neq <= '1' when (a /= b) else '0'; --not equal to
    lt <= '1' when (a < b) else '0'; --less than
    lte <= '1' when (a <= b) else '0'; --less than equal to
    gt <= '1' when (a > b) else '0'; --greater than
    gte <= '1' when (a >= b) else '0'; --greater than equal to
end;
