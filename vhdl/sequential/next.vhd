library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity forthi is
    port(
        clk   : in  std_logic;
        reset : in  std_logic;
        load  : in  std_logic;
        lbtn  : in  std_logic;
        rbtn  : in  std_logic;
        swts  : in  std_logic_vector(7 downto 0);
        leds  : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of forthi is
    signal reg   : std_logic_vector(7 downto 0) := (others => '0');
    signal loadt : std_logic := '0';
    signal rbtnt : std_logic := '0';
    signal lbtnt : std_logic := '0';
begin
    process(clk, reset)
    begin
        if reset = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            loadt <= load;
            rbtnt <= rbtn;
            lbtnt <= lbtn;
            if load = '1' and loadt = '0' then
                reg <= swts;
            elsif lbtn = '1' and lbtnt = '0' then
                reg <= reg(6 downto 0) & '0';
            elsif rbtn = '1' and rbtnt = '0' then
                for i in 0 to 7 loop --EXAMPLE OF NEXT STATEMENT!
                    if i mod 2 = 0 then --switch 0 to 1 if you want odds
                        next; --If the index is divisible by 2, skip the loop.
                    end if;
                    reg(i) <= '0';
                end loop;
            end if;
        end if;
    end process;

    leds <= reg;

end architecture;
