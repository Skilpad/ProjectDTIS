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
  
  signal s      : array32_t (0 to 44);
  signal y      : array32_t (0 to 9);    -- y(0) = y[n-0]
  
begin
  
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
  
  S0: adder port map(
    A => Input(0) sll 1,
    B => Input(0) sll 0,
    O => s(0)
  );
  
  S1: adder port map(
    A => Input(1) sll 4,
    B => Input(1) sll 3,
    O => s(1)
  );

  S2: adder port map(
    A => Input(1) sll 0,
    B => Input(2) sll 6,
    O => s(2)
  );

  S3: adder port map(
    A => Input(2) sll 5,
    B => Input(3) sll 8,
    O => s(3)
  );

  S4: adder port map(
    A => Input(3) sll 7,
    B => Input(4) sll 11,
    O => s(4)
  );

  S5: adder port map(
    A => Input(4) sll 10,
    B => Input(4) sll 0,
    O => s(5)
  );

  S6: adder port map(
    A => Input(5) sll 11,
    B => Input(5) sll 10,
    O => s(6)
  );

  S7: adder port map(
    A => Input(5) sll 0,
    B => Input(6) sll 8,
    O => s(7)
  );

  S8: adder port map(
    A => Input(6) sll 7,
    B => Input(7) sll 6,
    O => s(8)
  );

  S9: adder port map(
    A => Input(7) sll 5,
    B => Input(8) sll 4,
    O => s(9)
  );

  S10: adder port map(
    A => Input(8) sll 3,
    B => Input(8) sll 0,
    O => s(10)
  );

  S11: adder port map(
    A => Input(9) sll 1,
    B => Input(9) sll 0,
    O => s(11)
  );

  S12: adder port map(
    A => y(9) sll 2,
    B => y(9) sll 0,
    O => s(12)
  );

  S13: adder port map(
    A => y(8) sll 5,
    B => y(8) sll 4,
    O => s(13)
  );

  S14: adder port map(
    A => y(7) sll 6,
    B => y(7) sll 3,
    O => s(14)
  );

  S15: adder port map(
    A => y(7) sll 2,
    B => y(6) sll 8,
    O => s(15)
  );

  S16: adder port map(
    A => y(6) sll 6,
    B => y(6) sll 0,
    O => s(16)
  );

  S17: adder port map(
    A => y(5) sll 10,
    B => y(5) sll 9,
    O => s(17)
  );

  S18: adder port map(
    A => y(5) sll 2,
    B => y(4) sll 8,
    O => s(18)
  );

  S19: adder port map(
    A => y(4) sll 6,
    B => y(4) sll 0,
    O => s(19)
  );

  S20: adder port map(
    A => y(3) sll 6,
    B => y(3) sll 3,
    O => s(20)
  );

  S21: adder port map(
    A => y(3) sll 2,
    B => y(2) sll 5,
    O => s(21)
  );

  S22: adder port map(
    A => y(2) sll 4,
    B => y(1) sll 2,
    O => s(22)
  );

  S23: adder port map(
    A => s(0),
    B => s(1),
    O => s(23)
  );

  S24: adder port map(
    A => s(2),
    B => s(3),
    O => s(24)
  );

  S25: adder port map(
    A => s(4),
    B => s(5),
    O => s(25)
  );

  S26: adder port map(
    A => s(6),
    B => s(7),
    O => s(26)
  );

  S27: adder port map(
    A => s(8),
    B => s(9),
    O => s(27)
  );

  S28: adder port map(
    A => s(10),
    B => s(11),
    O => s(28)
  );

  S29: adder port map(
    A => s(12),
    B => s(13),
    O => s(29)
  );

  S30: adder port map(
    A => s(14),
    B => s(15),
    O => s(30)
  );

  S31: adder port map(
    A => s(16),
    B => s(17),
    O => s(31)
  );

  S32: adder port map(
    A => s(18),
    B => s(19),
    O => s(32)
  );

  S33: adder port map(
    A => s(20),
    B => s(21),
    O => s(33)
  );

  S34: adder port map(
    A => s(22),
    B => y(1),
    O => s(34)
  );

  S35: adder port map(
    A => s(23),
    B => s(24),
    O => s(35)
  );

  S36: adder port map(
    A => s(25),
    B => s(26),
    O => s(36)
  );

  S37: adder port map(
    A => s(27),
    B => s(28),
    O => s(37)
  );

  S38: adder port map(
    A => s(29),
    B => s(30),
    O => s(38)
  );

  S39: adder port map(
    A => s(31),
    B => s(32),
    O => s(39)
  );

  S40: adder port map(
    A => s(33),
    B => s(34),
    O => s(40)
  );

  S41: adder port map(
    A => s(35),
    B => s(36),
    O => s(41)
  );

  S42: adder port map(
    A => s(37),
    B => s(38),
    O => s(42)
  );

  S43: adder port map(
    A => s(39),
    B => s(40),
    O => s(43)
  );

  S44: adder port map(
    A => s(42),
    B => s(43),
    O => s(44)
  );

  S45: adder port map(
    A => s(41),
    B => s(44),
    O => y(0)
  );

end Structural;

