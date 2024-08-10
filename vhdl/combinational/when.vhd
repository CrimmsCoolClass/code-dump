library ieee;
use ieee.std_logic_1164.all;

entity whenTest is
    port(
        Q: in std_logic_vector(3 downto 0);
        segs: out std_logic_vector(6 downto 0)
    );
end whenTest;

architecture rtl of whenTest is

begin
    segs <= "0000001" when Q = "0000" else --0  = /= >= <= < > ?=
            "1001111" when Q = "0001" else --1
            "0010010" when Q = "0010" else --2
            "0000110" when Q = "0011" else --3
            "1001100" when Q = "0100" else --4
            "0100100" when Q = "0101" else --5
            "0100000" when Q = "0110" else --6
            "0001111" when Q = "0111" else --7
            "0000000" when Q = "1000" else --8
            "0000100" when Q = "1001" else --9
            "0001000" when Q = "1010" else --10
            "1100000" when Q = "1011" else --11
            "0110001" when Q = "1100" else --12
            "1000010" when Q = "1101" else --13
            "0110000" when Q = "1110" else --14
            "0111000" when Q = "1111" else "0000001";

end architecture;
            
