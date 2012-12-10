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

  signal y  : array32_t (0 to 9);
  signal s  : array32_t (0 to 92);
  signal sr : array32_t (0 to 14);

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
    A => s(91),
    B => s(90),
    O => s(92)
  );

  R0: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(89),
    Dout => sr(0)
  );

  R1: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(88),
    Dout => sr(1)
  );

  S91: adder port map(
    A => sr(0),
    B => sr(1),
    O => s(91)
  );

  S89: adder port map(
    A => s(85),
    B => s(84),
    O => s(89)
  );

  S85: adder port map(
    A => s(42),
    B => s(43),
    O => s(85)
  );

  s(42) <= y(2)(25 downto 0) & "000000";

  s(43) <= y(1)(27 downto 0) & "0000";

  S84: adder port map(
    A => s(40),
    B => s(41),
    O => s(84)
  );

  s(40) <= y(2)(29 downto 0) & "00";

  s(41) <= y(2)(28 downto 0) & "000";

  S88: adder port map(
    A => s(87),
    B => s(86),
    O => s(88)
  );

  R2: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(82),
    Dout => sr(2)
  );

  R3: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(81),
    Dout => sr(3)
  );

  S87: adder port map(
    A => sr(2),
    B => sr(3),
    O => s(87)
  );

  S82: adder port map(
    A => s(78),
    B => s(77),
    O => s(82)
  );

  R4: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(71),
    Dout => sr(4)
  );

  R5: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(70),
    Dout => sr(5)
  );

  S78: adder port map(
    A => sr(4),
    B => sr(5),
    O => s(78)
  );

  S71: adder port map(
    A => s(55),
    B => s(54),
    O => s(71)
  );

  S55: adder port map(
    A => s(14),
    B => s(26),
    O => s(55)
  );

  s(14) <= Input(4)(20 downto 0) & "00000000000";

  s(26) <= y(5)(27 downto 0) & "0000";

  S54: adder port map(
    A => s(12),
    B => s(13),
    O => s(54)
  );

  s(12) <= Input(4)(31 downto 0);

  s(13) <= Input(4)(21 downto 0) & "0000000000";

  S70: adder port map(
    A => s(57),
    B => s(56),
    O => s(70)
  );

  S57: adder port map(
    A => s(16),
    B => s(28),
    O => s(57)
  );

  s(16) <= Input(3)(23 downto 0) & "00000000";

  s(28) <= y(4)(29 downto 0) & "00";

  S56: adder port map(
    A => s(27),
    B => s(15),
    O => s(56)
  );

  s(27) <= y(5)(26 downto 0) & "00000";

  s(15) <= Input(3)(24 downto 0) & "0000000";

  R6: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(73),
    Dout => sr(6)
  );

  R7: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(72),
    Dout => sr(7)
  );

  S77: adder port map(
    A => sr(6),
    B => sr(7),
    O => s(77)
  );

  S73: adder port map(
    A => s(51),
    B => s(50),
    O => s(73)
  );

  S51: adder port map(
    A => s(8),
    B => s(9),
    O => s(51)
  );

  s(8) <= Input(6)(23 downto 0) & "00000000";

  s(9) <= Input(5)(31 downto 0);

  S50: adder port map(
    A => s(6),
    B => s(7),
    O => s(50)
  );

  s(6) <= Input(7)(25 downto 0) & "000000";

  s(7) <= Input(6)(24 downto 0) & "0000000";

  S72: adder port map(
    A => s(53),
    B => s(52),
    O => s(72)
  );

  S53: adder port map(
    A => s(24),
    B => s(25),
    O => s(53)
  );

  s(24) <= y(6)(31 downto 0);

  s(25) <= y(6)(29 downto 0) & "00";

  S52: adder port map(
    A => s(10),
    B => s(11),
    O => s(52)
  );

  s(10) <= Input(5)(21 downto 0) & "0000000000";

  s(11) <= Input(5)(20 downto 0) & "00000000000";

  S81: adder port map(
    A => s(80),
    B => s(79),
    O => s(81)
  );

  R8: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(67),
    Dout => sr(8)
  );

  R9: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(66),
    Dout => sr(9)
  );

  S80: adder port map(
    A => sr(8),
    B => sr(9),
    O => s(80)
  );

  S67: adder port map(
    A => s(63),
    B => s(62),
    O => s(67)
  );

  S63: adder port map(
    A => s(34),
    B => s(35),
    O => s(63)
  );

  s(34) <= y(2)(29 downto 0) & "00";

  s(35) <= y(2)(22 downto 0) & "000000000";

  S62: adder port map(
    A => s(20),
    B => s(21),
    O => s(62)
  );

  s(20) <= Input(1)(28 downto 0) & "000";

  s(21) <= Input(1)(27 downto 0) & "0000";

  S66: adder port map(
    A => s(65),
    B => s(64),
    O => s(66)
  );

  S65: adder port map(
    A => s(23),
    B => s(37),
    O => s(65)
  );

  s(23) <= Input(0)(30 downto 0) & "0";

  s(37) <= y(1)(31 downto 0);

  S64: adder port map(
    A => s(36),
    B => s(22),
    O => s(64)
  );

  s(36) <= y(2)(21 downto 0) & "0000000000";

  s(22) <= Input(0)(31 downto 0);

  R10: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(69),
    Dout => sr(10)
  );

  R11: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(68),
    Dout => sr(11)
  );

  S79: adder port map(
    A => sr(10),
    B => sr(11),
    O => s(79)
  );

  S69: adder port map(
    A => s(59),
    B => s(58),
    O => s(69)
  );

  S59: adder port map(
    A => s(17),
    B => s(18),
    O => s(59)
  );

  s(17) <= Input(2)(26 downto 0) & "00000";

  s(18) <= Input(2)(25 downto 0) & "000000";

  S58: adder port map(
    A => s(29),
    B => s(30),
    O => s(58)
  );

  s(29) <= y(4)(28 downto 0) & "000";

  s(30) <= y(4)(25 downto 0) & "000000";

  S68: adder port map(
    A => s(61),
    B => s(60),
    O => s(68)
  );

  S61: adder port map(
    A => s(33),
    B => s(19),
    O => s(61)
  );

  s(33) <= y(3)(23 downto 0) & "00000000";

  s(19) <= Input(1)(31 downto 0);

  S60: adder port map(
    A => s(31),
    B => s(32),
    O => s(60)
  );

  s(31) <= y(3)(31 downto 0);

  s(32) <= y(3)(25 downto 0) & "000000";

  R12: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(83),
    Dout => sr(12)
  );

  S86: adder port map(
    A => s(44),
    B => sr(12),
    O => s(86)
  );

  s(44) <= y(1)(26 downto 0) & "00000";

  S83: adder port map(
    A => s(76),
    B => s(75),
    O => s(83)
  );

  R13: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(47),
    Dout => sr(13)
  );

  R14: reg port map (
    Reset => Reset,
    Clk => Clk,
    Load => '1',
    Din => s(74),
    Dout => sr(14)
  );

  S76: adder port map(
    A => sr(13),
    B => sr(14),
    O => s(76)
  );

  S47: adder port map(
    A => s(0),
    B => s(1),
    O => s(47)
  );

  s(0) <= Input(9)(31 downto 0);

  s(1) <= Input(9)(30 downto 0) & "0";

  S74: adder port map(
    A => s(49),
    B => s(48),
    O => s(74)
  );

  S49: adder port map(
    A => s(4),
    B => s(5),
    O => s(49)
  );

  s(4) <= Input(8)(27 downto 0) & "0000";

  s(5) <= Input(7)(26 downto 0) & "00000";

  S48: adder port map(
    A => s(2),
    B => s(3),
    O => s(48)
  );

  s(2) <= Input(8)(31 downto 0);

  s(3) <= Input(8)(28 downto 0) & "000";

  S75: adder port map(
    A => s(38),
    B => s(39),
    O => s(75)
  );

  s(38) <= y(2)(25 downto 0) & "000000";

  s(39) <= y(2)(23 downto 0) & "00000000";

  S90: adder port map(
    A => s(45),
    B => s(46),
    O => s(90)
  );

  s(45) <= y(1)(31 downto 0);

  s(46) <= y(1)(29 downto 0) & "00";

end Structural;
