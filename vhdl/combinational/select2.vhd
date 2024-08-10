library ieee;
use ieee.std_logic_1164.all;

entity truthTable is
port(
    seals: in std_logic;
    husks: in std_logic;
    mats: in std_logic;
    catfoodsop: out std_logic;
    catfoodbeh: out std_logic
);
end truthTable;

architecture flow of truthTable is
signal shm: std_logic_vector (2 downto 0);
begin
catfoodsop <= (seals and husks) or (seals and mats);
shm(2) <= seals;
shm(1) <= husks;
shm(0) <= mats;
with shm select
    catfoodbeh <= '0' when "000",
                  '0' when "001",
                  '0' when "010",
                  '0' when "011",
                  '0' when "100",
                  '1' when "101",
                  '1' when "110",
                  '1' when "111",
                  '0' when others;
end architecture;
