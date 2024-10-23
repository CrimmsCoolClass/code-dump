library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity priorityencode is
    port(
        a1: in std_logic_vector(7 downto 0);
        b1: out std_logic_vector(2 downto 0)
    );
end priorityencode;

architecture rtl of priorityencode is
    function priority_encode(input: std_logic_vector) return std_logic_vector is
        variable result: std_logic_vector(integer(ceil(log2(real(input'length)))) - 1 downto 0) := (others => '0');
        --math stuff figures out how many bits are required to represent the input length integer ie) 8 becomes 3
        --real conversion is necessary because ints are always floored, we don't want it to be floored.
        --flow: real(input'length) = result1 -> log2(result1) = result2 -> ceil(result2) = result3 -> integer(result3) = final
    begin
        for i in input'range loop --make absolutely sure its downto not to
            if input(i) = '1' then
                result := std_logic_vector(to_unsigned(i,result'length));
                exit; --nifty little feature that makes it stop the loop. Makes the repeated if's more like an if elsif chain
            end if;
        end loop;
        return result; --returns the encoded binary vector of the length
    end function priority_encode;

begin
    b1 <= priority_encode(a1);
end architecture;
