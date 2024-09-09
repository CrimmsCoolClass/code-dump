library ieee;
use ieee.std_logic_1164.all;
--https://www.ti.com/lit/ds/symlink/sn54ls47.pdf?ts=1725817341418&ref_url=https%253A%252F%252Fwww.google.com%252F
entity showoff is
    port(
        binary: in std_logic_vector(3 downto 0);
        LT, RBI: in std_logic;
        segs: out std_logic_vector(6 downto 0);
        BIRBO: inout std_logic
    );
end entity;

architecture rtl of showoff is
    signal temp_segs: std_logic_vector(6 downto 0);

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
            when "1010" => return "1110010";
            when "1011" => return "1100110";
            when "1100" => return "1011100";
            when "1101" => return "0110100";
            when "1110" => return "1110000";
            when "1111" => return "1111111";
            when others => return "1111111";
        end case;
    end function to_ssdca;
begin
    temp_segs <= to_ssdca(binary);
    segs <= (others => '1') when BIRBO = '0' else 
            (others => '1') when binary = "0000" and RBI = '0' and LT = '1' else 
            (others => '0') when LT = '1' and BIRBO = '1' else temp_segs;
    BIRBO <= '0' when binary = "0000" and RBI = '0' and LT = '1' else 'Z';
    
end architecture;
