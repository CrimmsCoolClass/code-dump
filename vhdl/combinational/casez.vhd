library ieee;
use ieee.std_logic_1164.all;

entity priority_casez is
    port(
        a: in std_logic_vector(3 downto 0);
        y: out std_logic_vector(3 downto 0)
    );
end priority_casez;

architecture dontcare of priority_casez is
signal b: std_logic_vector(3 downto 0);

begin
    process(all)
    begin
        case? b is --note the question mark. This makes it recognize don't cares
            when "1---" =>
                y <= "1000";
            when "01--" =>
                y <= "0100";
            when "001-" =>
                y <= "0010";
            when "0001" =>
                y <= "0001";
            when others =>
                y <= "0000";
        end case?;
    end process;
    b <= a;
end architecture;
