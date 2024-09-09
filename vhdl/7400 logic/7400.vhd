library ieee;
use ieee.std_logic_1164.all;
--https://www.ti.com/lit/ds/symlink/sn7400.pdf?ts=1725819014735&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FSN7400
entity integratedcircuit is
    port(
        A1,B1,A2,B2,A3,B3,A4,B4: in std_logic;
        Y1,Y2,Y3,Y4: out std_logic
    );
end entity;

architecture rtl of integratedcircuit is

begin
    Y1 <= A1 nand B1;
    Y2 <= A2 nand B2;
    Y3 <= A3 nand B3;
    Y4 <= A4 nand B4;
end architecture;
