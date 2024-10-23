library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity UARTrx is
    generic (
        g_CLKS_PER_BIT: integer := 217
    );
    port (
        i_Clk: in std_logic;
        i_RX_Serial: in std_logic;
        o_RX_DV: out std_logic;
        o_RX_Byte: out std_logic_vector(7 downto 0);
        o_DataBits_flag: out std_logic
    );
end entity;

architecture rtl of UARTrx is
    type state_type is (Idle, StartBit, DataBits, StopBit, Cleanup);
    signal state:  state_type := Idle;
    signal clk_count: integer range 0 to g_CLKS_PER_BIT - 1;
    signal bit_index: integer range 0 to 7 := 0;
    signal rx_byte: std_logic_vector(7 downto 0) := (others => '0');
    signal r_rx_dv: std_logic := '0';
begin
    p_UART: process(i_Clk)
    begin
        if rising_edge(i_Clk) then
            case state is
                when Idle =>
                    r_rx_dv <= '0';
                    clk_count <= 0;
                    bit_index <= 0;
                    if i_RX_Serial = '0' then
                        state <= StartBit;
                    else
                        state <= Idle;
                    end if;
                when StartBit =>
                    if clk_count = (g_CLKS_PER_BIT-1)/2 then
                        if i_RX_Serial = '0' then
                            clk_count <= 0;
                            state <= DataBits;
                        else
                            state <= Idle;
                        end if;
                    else
                        clk_count <= clk_count + 1;
                        state <= StartBit;
                    end if;
                when DataBits =>
                    if clk_count < g_CLKS_PER_BIT-1 then
                        clk_count <= clk_count + 1;
                        state <= DataBits;
                    else 
                        clk_count <= 0;
                        rx_byte(bit_index) <= i_RX_Serial;
                        if bit_index < 7 then
                            bit_index <= bit_index + 1;
                            state <= DataBits;
                        else
                            bit_index <= 0;
                            o_DataBits_flag <= '1';
                            state <= StopBit;
                        end if;
                    end if;
                when StopBit => 
                    if clk_count < g_CLKS_PER_BIT-1 then
                        clk_count <= clk_count + 1;
                        state <= StopBit;
                    else
                        r_rx_dv <= '1';
                        clk_count <= 0;
                        state <= CleanUp;
                    end if;
                when CleanUp =>
                    o_DataBits_flag <= '0';
                    state <= Idle;
                    r_rx_dv <= '0';
                when others => 
                    state <= Idle;
            end case;
        end if;
    end process;
    --o_DataBits_flag <= '1' when state = DataBits else '0';
    o_RX_DV <= r_rx_dv;
    o_RX_Byte <= rx_byte;
end architecture;
