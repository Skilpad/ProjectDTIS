library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
use work.array_t.all;

entity adder_wrapper is
   Port ( 
      Reset   : in  STD_LOGIC;
      Clk     : in  STD_LOGIC;
      Input   : in  STD_LOGIC_VECTOR (31 downto 0);
      Output  : out STD_LOGIC_VECTOR (31 downto 0)
   );
end adder_wrapper;

-- Pipe-Lined version

architecture Structural of adder_wrapper is

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

   signal y  : array32_t (0 to 100);
   signal yin, yout : STD_LOGIC_VECTOR (31 downto 0);

begin

   yin <= Input;
   Output <= yout;
   
   R1: reg port map (          
      Reset => Reset,          
      Clk => Clk,              
      Load => '1',             
      Din => yin,             
      Dout => y(0)           
   );
   R2: reg port map (          
      Reset => Reset,          
      Clk => Clk,              
      Load => '1',             
      Din => y(100),             
      Dout => yout           
   );
   
   f1: for i in 1 to 100 generate 
      SA: adder port map(
         A => y(i-1),
         B => y(i-1),
         O => y(i)
      );
   end generate f1;

end architecture Structural;