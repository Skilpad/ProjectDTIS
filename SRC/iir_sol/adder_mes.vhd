library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
use work.array_t.all;

entity iir_sol is
   Port ( 
      Reset   : in  STD_LOGIC;
    Clk     : in  STD_LOGIC;
    Input   : in  array32_t(0 to 9);    -- Input(i) = x[n-i]
    Output  : out STD_LOGIC_VECTOR (31 downto 0)
   );
end iir_sol;

architecture Structural of iir_sol is
   
  component reg 
    port ( Reset  : in  STD_LOGIC;
           Clk    : in  STD_LOGIC;
           Load   : in  STD_LOGIC;
           Din    : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout   : out STD_LOGIC_VECTOR (31 downto 0));
   end component;
  
  component adder
    port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           O : out  STD_LOGIC_VECTOR (31 downto 0));
  end component;
  
begin
  

  SA: adder port map(
    A => Input(0),
    B => Input(1),
    O => Output
  );

end Structural;
