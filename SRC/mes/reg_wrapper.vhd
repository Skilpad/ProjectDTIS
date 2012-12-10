library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
use work.array_t.all;

entity reg_wrapper is
   Port ( 
      Reset   : in  STD_LOGIC;
      Clk     : in  STD_LOGIC;
      Input   : in  STD_LOGIC_VECTOR (31 downto 0);
      Output  : out STD_LOGIC_VECTOR (31 downto 0)
   );
end reg_wrapper;

-- Pipe-Lined version

architecture Structural of reg_wrapper is

  component reg
    port ( Reset  : in  STD_LOGIC;               
           Clk    : in  STD_LOGIC;                      
           Load   : in  STD_LOGIC;                      
           Din    : in  STD_LOGIC_VECTOR (31 downto 0); 
           Dout   : out STD_LOGIC_VECTOR (31 downto 0));
  end component;

   signal y  : array32_t (0 to 102);

begin

   y(0) <= Input;
   Output <= y(102);
   
   f1: for i in 1 to 102 generate 
      R1: reg port map (          
         Reset => Reset,          
         Clk => Clk,              
         Load => '1',             
         Din => y(i-1),             
         Dout => y(i)           
      );
   end generate f1;

end architecture Structural;