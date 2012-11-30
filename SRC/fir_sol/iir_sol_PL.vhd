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

-- Pipe-Lined version

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

  signal y : array32_t (0 to 9);
  signal s : array32_t (0 to 92);

begin

  y(0) <= s(92);
  Output <= y(0);              
  f1: for i in 0 to 8 generate 
    R: reg port map (          
      Reset => Reset,          
      Clk => Clk,              
      Load => '1',             
      Din => y(i),             
      Dout => y(i+1)           
    );                         
  end generate f1;             

  S92: adder port map(
    A => sh(91),
    B => sh(90),
    O => s(92)
  );

  S91: adder port map(
    A => sh(89),
    B => sh(88),
    O => s(91)
  );

  S89: adder port map(
    A => sh(85),
    B => sh(84),
    O => s(89)
  );

  S85: adder port map(
    A => sh(42),
    B => sh(43),
    O => s(85)
  );

  s(42 <= y(2)(29 downto 0) & "000";

  s(43 <= y(1)(30 downto 0) & "00";

  S84: adder port map(
    A => sh(40),
    B => sh(41),
    O => s(84)
  );

  s(40 <= y(2)(29 downto 0) & "000";

  s(41 <= y(2)(29 downto 0) & "000";

  S88: adder port map(
    A => sh(87),
    B => sh(86),
    O => s(88)
  );

  S87: adder port map(
    A => sh(82),
    B => sh(81),
    O => s(87)
  );

  S82: adder port map(
    A => sh(78),
    B => sh(77),
    O => s(82)
  );

  S78: adder port map(
    A => sh(71),
    B => sh(70),
    O => s(78)
  );

  S71: adder port map(
    A => sh(55),
    B => sh(54),
    O => s(71)
  );

  S55: adder port map(
    A => sh(14),
    B => sh(26),
    O => s(55)
  );

  s(14 <= x(4)(28 downto 0) & "0000";

  s(26 <= y(5)(24 downto 0) & "00000000";

  S54: adder port map(
    A => sh(12),
    B => sh(13),
    O => s(54)
  );

  s(12 <= x(4)(28 downto 0) & "0000";

  s(13 <= x(4)(28 downto 0) & "0000";

  S70: adder port map(
    A => sh(57),
    B => sh(56),
    O => s(70)
  );

  S57: adder port map(
    A => sh(16),
    B => sh(28),
    O => s(57)
  );

  s(16 <= x(3)(29 downto 0) & "000";

  s(28 <= y(4)(25 downto 0) & "0000000";

  S56: adder port map(
    A => sh(27),
    B => sh(15),
    O => s(56)
  );

  s(27 <= y(5)(24 downto 0) & "00000000";

  s(15 <= x(3)(29 downto 0) & "000";

  S77: adder port map(
    A => sh(73),
    B => sh(72),
    O => s(77)
  );

  S73: adder port map(
    A => sh(51),
    B => sh(50),
    O => s(73)
  );

  S51: adder port map(
    A => sh(8),
    B => sh(9),
    O => s(51)
  );

  s(8 <= x(6)(26 downto 0) & "000000";

  s(9 <= x(5)(27 downto 0) & "00000";

  S50: adder port map(
    A => sh(6),
    B => sh(7),
    O => s(50)
  );

  s(6 <= x(7)(25 downto 0) & "0000000";

  s(7 <= x(6)(26 downto 0) & "000000";

  S72: adder port map(
    A => sh(53),
    B => sh(52),
    O => s(72)
  );

  S53: adder port map(
    A => sh(24),
    B => sh(25),
    O => s(53)
  );

  s(24 <= y(6)(23 downto 0) & "000000000";

  s(25 <= y(6)(23 downto 0) & "000000000";

  S52: adder port map(
    A => sh(10),
    B => sh(11),
    O => s(52)
  );

  s(10 <= x(5)(27 downto 0) & "00000";

  s(11 <= x(5)(27 downto 0) & "00000";

  S81: adder port map(
    A => sh(80),
    B => sh(79),
    O => s(81)
  );

  S80: adder port map(
    A => sh(67),
    B => sh(66),
    O => s(80)
  );

  S67: adder port map(
    A => sh(63),
    B => sh(62),
    O => s(67)
  );

  S63: adder port map(
    A => sh(34),
    B => sh(35),
    O => s(63)
  );

  s(34 <= y(2)(27 downto 0) & "00000";

  s(35 <= y(2)(27 downto 0) & "00000";

  S62: adder port map(
    A => sh(20),
    B => sh(21),
    O => s(62)
  );

  s(20 <= x(1)(31 downto 0) & "0";

  s(21 <= x(1)(31 downto 0) & "0";

  S66: adder port map(
    A => sh(65),
    B => sh(64),
    O => s(66)
  );

  S65: adder port map(
    A => sh(23),
    B => sh(37),
    O => s(65)
  );

  s(23 <= x(0)(32 downto 0);

  s(37 <= y(1)(28 downto 0) & "0000";

  S64: adder port map(
    A => sh(36),
    B => sh(22),
    O => s(64)
  );

  s(36 <= y(2)(27 downto 0) & "00000";

  s(22 <= x(0)(32 downto 0);

  S79: adder port map(
    A => sh(69),
    B => sh(68),
    O => s(79)
  );

  S69: adder port map(
    A => sh(59),
    B => sh(58),
    O => s(69)
  );

  S59: adder port map(
    A => sh(17),
    B => sh(18),
    O => s(59)
  );

  s(17 <= x(2)(30 downto 0) & "00";

  s(18 <= x(2)(30 downto 0) & "00";

  S58: adder port map(
    A => sh(29),
    B => sh(30),
    O => s(58)
  );

  s(29 <= y(4)(25 downto 0) & "0000000";

  s(30 <= y(4)(25 downto 0) & "0000000";

  S68: adder port map(
    A => sh(61),
    B => sh(60),
    O => s(68)
  );

  S61: adder port map(
    A => sh(33),
    B => sh(19),
    O => s(61)
  );

  s(33 <= y(3)(26 downto 0) & "000000";

  s(19 <= x(1)(31 downto 0) & "0";

  S60: adder port map(
    A => sh(31),
    B => sh(32),
    O => s(60)
  );

  s(31 <= y(3)(26 downto 0) & "000000";

  s(32 <= y(3)(26 downto 0) & "000000";

  S86: adder port map(
    A => sh(44),
    B => sh(83),
    O => s(86)
  );

  s(44 <= y(1)(30 downto 0) & "00";

  S83: adder port map(
    A => sh(76),
    B => sh(75),
    O => s(83)
  );

  S76: adder port map(
    A => sh(47),
    B => sh(74),
    O => s(76)
  );

  S47: adder port map(
    A => sh(0),
    B => sh(1),
    O => s(47)
  );

  s(0 <= x(9)(23 downto 0) & "000000000";

  s(1 <= x(9)(23 downto 0) & "000000000";

  S74: adder port map(
    A => sh(49),
    B => sh(48),
    O => s(74)
  );

  S49: adder port map(
    A => sh(4),
    B => sh(5),
    O => s(49)
  );

  s(4 <= x(8)(24 downto 0) & "00000000";

  s(5 <= x(7)(25 downto 0) & "0000000";

  S48: adder port map(
    A => sh(2),
    B => sh(3),
    O => s(48)
  );

  s(2 <= x(8)(24 downto 0) & "00000000";

  s(3 <= x(8)(24 downto 0) & "00000000";

  S75: adder port map(
    A => sh(38),
    B => sh(39),
    O => s(75)
  );

  s(38 <= y(2)(28 downto 0) & "0000";

  s(39 <= y(2)(28 downto 0) & "0000";

  S90: adder port map(
    A => sh(45),
    B => sh(46),
    O => s(90)
  );

  s(45 <= y(1)(31 downto 0) & "0";

  s(46 <= y(1)(31 downto 0) & "0";

end Structural;