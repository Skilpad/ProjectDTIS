LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

library work;
use work.array_t.all;

ENTITY tb_iir_sol IS
END tb_iir_sol;

ARCHITECTURE testbench OF tb_iir_sol IS 
  
  constant period : time := 5 ns;
  constant lat : integer := 1;
  
	-- Component Declaration for the Unit Under Test (UUT)
	component iir_sol_wrapper
	port(
        Reset : in  STD_LOGIC;
        Clk : in  STD_LOGIC;
        Input : in  STD_LOGIC_VECTOR (31 downto 0);
        Output : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;

	--Inputs
	signal Reset : std_logic := '1';
	signal Clk   : std_logic := '0';
--	signal I     : std_logic_vector(31 downto 0) := (others=>'0');
  signal I     : array_int_t(0 to 9);
  signal Input : std_logic_vector(31 downto 0);
  
	--Outputs
--	signal O     : std_logic_vector(31 downto 0);
  signal Output : std_logic_vector(31 downto 0);
	signal O      : array_int_t(0 to 9);
  
	constant sin : array_int_t(0 to 19) := (
		   0,   50,  195,  422,  707, 1024, 1340, 1626, 1852, 1998,  
    2048, 1998, 1852, 1625, 1340, 1024,  708,  422,  196,   50 );
	
  constant a : array_int_t(0 to 9) := (
    3, 25, 96, 384, 3073, 3073, 384, 96, 25 3 );
  
  constant b : array_int_t(1 to 9) := (
    5, 48, 76, 321, 1540, 321, 76, 48, 5 );
  
BEGIN

  Reset <= '0' after period*10.5;

	Clk <= not Clk after period/2;
	
  Input <= std_logic_vector(to_unsigned(I(0), 32));
  
	-- Instantiate the Unit Under Test (UUT)
	uut: iir_sol_wrapper PORT MAP(
		Reset => Reset,
		Clk => Clk,
		Input => Input,
		Output => Output
	);
  
	tb : process(Clk)
		variable it : integer := 0;
    variable oth: integer := 0;
	begin
		if Clk'event and Clk = '1' then
      
      if Reset = '1' then
        it := 0;
        init: for i in 1 to 9 loop
          I(i) <= 0;
          O(i) <= 0;
        end loop init;
      else
      
        I(0) <= sin(it);
        it := it + 1;
        if it = 20 then
          it := 0;
        end if;
        
        rec: for i in 1 to 9 loop
          I(i) <= I(i-1);
          O(i) <= O(i-1);
        end loop rec;
        
        oth := a(0) * I(0);
        calc: for i in 1 to 9 loop
          oth := oth + a(i) * I(i) + b(i) * O(i);
        end loop calc;
        O(0) <= oth;
        
        assert unsigned(to_integer(Output)) = O(lat);
      
      end if;
      
		end if;
	end process;
  
END testbench;
