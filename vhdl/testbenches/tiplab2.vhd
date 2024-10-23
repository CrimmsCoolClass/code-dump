
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tiplab2 is
    port(
        sw: in std_logic_vector(2 downto 0);
        lb: in std_logic;
        rb: in std_logic;
        leds: out std_logic_vector(15 downto 0);
        seg: out std_logic_vector(6 downto 0)
    );
end tiplab2;

architecture rtl of tiplab2 is
    function to_ssdca(input: std_logic_vector) return std_logic_vector is
    begin
        case input is
            when "0000" => return "0000001";
            when "0001" => return "1001111";
            when "0010" => return "0010010";
            when "0011" => return "0000110";
            when "0100" => return "1001100";
            when "0101" => return "0100100";
            when "0110" => return "0100000";
            when "0111" => return "0001111";
            when "1000" => return "0000000";
            when "1001" => return "0001100";
            when "1010" => return "0001000";
            when "1011" => return "1100000";
            when "1100" => return "0110001";
            when "1101" => return "1000010";
            when "1110" => return "0110000";
            when "1111" => return "0111000";
            when others => return "1111111";
        end case;
    end function to_ssdca;

    function reverse_bits(input: std_logic_vector) return std_logic_vector is
        variable result: std_logic_vector(input'range); --makes vector of same range as input
    begin
        for i in input'range loop --iterates over range of input
            result(i) := input(input'left-i); --result(0) := input(7-0) etc etc
        end loop;
        return result;
    end function reverse_bits;


    signal switchtemp: std_logic_vector(3 downto 0);
    signal templeds: std_logic_vector(7 downto 0);
begin
    switchtemp <= ('0',sw); --concatenates '0' and sw to make it 4 bits in order it interface with function
    seg <= to_ssdca(switchtemp);
    
    templeds <= "00000000" when sw = "000" else
                "00000001" when sw = "001" else
                "00000011" when sw = "010" else
                "00000111" when sw = "011" else
                "00001111" when sw = "100" else
                "00011111" when sw = "101" else
                "00111111" when sw = "110" else
                "01111111" when sw = "111" else (others =>'0');

    leds <= reverse_bits(templeds) & templeds   when rb = '1' and lb = '1' else
            "00000000" & templeds               when rb = '1' and lb = '0' else
            reverse_bits(templeds) & "00000000" when lb = '1' and rb = '0' else (others => '0');
end architecture;
