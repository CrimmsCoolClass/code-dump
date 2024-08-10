library ieee;
use ieee.std_logic_1164.all;

entity fullAdder is
    port(
        a,b,c: in std_logic; --input/output declaration
        sum,carry: out std_logic
    );
end fullAdder;

architecture behavior of fullAdder is
    signal w1,w2,w3: std_logic; --intermediate variables
begin

  w1 <= a xor b; --logic 
  w2 <= w1 and c;
  w3 <= a and b;
  sum <= w1 xor c;
  carry <= w2 or w3;
  
end behavior;
