library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tiplab2_tb is
end entity;

architecture test of tiplab2_tb is
    signal sw:  std_logic_vector(2 downto 0);
    signal lb:  std_logic;
    signal rb:  std_logic;
    signal led: std_logic_vector(15 downto 0); --output
    signal seg: std_logic_vector(6 downto 0); --output

    function to_ssdca(input: integer) return std_logic_vector is
    begin
        case input is
            when 0      => return "0000001";
            when 1      => return "1001111";
            when 2      => return "0010010";
            when 3      => return "0000110";
            when 4      => return "1001100";
            when 5      => return "0100100";
            when 6      => return "0100000";
            when 7      => return "0001111";
            when 8      => return "0000000";
            when 9      => return "0001100";
            when 10     => return "0001000";
            when 11     => return "1100000";
            when 12     => return "0110001";
            when 13     => return "1000010";
            when 14     => return "0110000";
            when 15     => return "0111000";
            when others => return "1111111";
        end case;
    end function to_ssdca;

    procedure assert_eq(observed, expected: in std_logic_vector; message: in string) is
    begin
        if observed = expected then
            report "- " & message;
        else
            report "Error in test: '" & message & "'" & LF & "     " &
                   "observed: " & to_string(observed) & ", " &
                   "expected: " & to_string(expected) 
            severity error;
        end if;
    end procedure;

    type testvectors is record
        sw:  std_logic_vector(2 downto 0);
        lb : std_logic;
        rb : std_logic;
        led: std_logic_vector(15 downto 0);
        seg: std_logic_vector(6 downto 0);
    end record;

    type testvectorarray is array (natural range <>) of testvectors;

    constant VECTORS: testvectorarray := (
    ("000",'0','0',                              (others => '0'), to_ssdca(0)),
    ("000",'0','1',                              (others => '0'), to_ssdca(0)),
    ("000",'1','0',                              (others => '0'), to_ssdca(0)),
    ("000",'1','1',                              (others => '0'), to_ssdca(0)),

    ("001",'0','0',                              (others => '0'), to_ssdca(1)),
    ("001",'0','1',                    (0 => '1', others => '0'), to_ssdca(1)),
    ("001",'1','0',                   (15 => '1', others => '0'), to_ssdca(1)),
    ("001",'1','1',                 (15|0 => '1', others => '0'), to_ssdca(1)),

    ("010",'0','0',                              (others => '0'), to_ssdca(2)),
    ("010",'0','1',               (0 to 1 => '1', others => '0'), to_ssdca(2)),
    ("010",'1','0',         (15 downto 14 => '1', others => '0'), to_ssdca(2)),
    ("010",'1','1',(15 downto 14 | 0 to 1 => '1', others => '0'), to_ssdca(2)),

    ("011",'0','0',                              (others => '0'), to_ssdca(3)),
    ("011",'0','1',               (0 to 2 => '1', others => '0'), to_ssdca(3)),
    ("011",'1','0',         (15 downto 13 => '1', others => '0'), to_ssdca(3)),
    ("011",'1','1',(15 downto 13 | 0 to 2 => '1', others => '0'), to_ssdca(3)),

    ("100",'0','0',                              (others => '0'), to_ssdca(4)),
    ("100",'0','1',               (0 to 3 => '1', others => '0'), to_ssdca(4)),
    ("100",'1','0',         (15 downto 12 => '1', others => '0'), to_ssdca(4)),
    ("100",'1','1',(15 downto 12 | 0 to 3 => '1', others => '0'), to_ssdca(4)),

    ("101",'0','0',                              (others => '0'), to_ssdca(5)),
    ("101",'0','1',               (0 to 4 => '1', others => '0'), to_ssdca(5)),
    ("101",'1','0',         (15 downto 11 => '1', others => '0'), to_ssdca(5)),
    ("101",'1','1',(15 downto 11 | 0 to 4 => '1', others => '0'), to_ssdca(5)),

    ("110",'0','0',                              (others => '0'), to_ssdca(6)),
    ("110",'0','1',               (0 to 5 => '1', others => '0'), to_ssdca(6)),
    ("110",'1','0',         (15 downto 10 => '1', others => '0'), to_ssdca(6)),
    ("110",'1','1',(15 downto 10 | 0 to 5 => '1', others => '0'), to_ssdca(6)),

    ("111",'0','0',                              (others => '0'), to_ssdca(7)),
    ("111",'0','1',               (0 to 6 => '1', others => '0'), to_ssdca(7)),
    ("111",'1','0',         (15 downto 9  => '1', others => '0'), to_ssdca(7)),
    ("111",'1','1',(15 downto 9 | 0 to 6  => '1', others => '0'), to_ssdca(7))
    );

    constant TESTDELAY: time := 10 ns;
    constant REPORTDEL: time := 5 ns;
    signal   testindex: integer := 0;
begin
    tiplab2_inst: entity work.tiplab2
    port map (
      sw   => sw,
      lb   => lb,
      rb   => rb,
      leds => led,
      seg  => seg
    );

    signalstim:process begin
        for i in VECTORS'range loop
            sw <= VECTORS(i).sw;
            lb <= VECTORS(i).lb;
            rb <= VECTORS(i).rb;
            testindex <= i;
            wait for TESTDELAY;
        end loop;
        report "All done!";
        wait;
    end process;

    reporting:process
    begin
        wait on testindex'transaction;
        wait for REPORTDEL;
        assert_eq(led,VECTORS(testindex).led,"Check");
    end process;

end architecture;
