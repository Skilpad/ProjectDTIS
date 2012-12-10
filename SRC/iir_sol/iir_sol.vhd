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
  
  signal y  : array32_t (0 to 9);    -- y(0) = y[n-0]
  signal s  : array32_t (0 to 44);   -- outputs of the adders
  signal sh : array32_t (0 to 45);    -- shifted signals
  
begin
  
  -- Define registers for old outputs
  
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
  
  -- Define shifted signals
  
  sh(0) <= Input(0)(30 downto 0) & "0";
  sh(1) <= Input(0);
  sh(2) <= Input(1)(27 downto 0) & "0000";
  sh(3) <= Input(1)(28 downto 0) & "000";
  sh(4) <= Input(1);
  sh(5) <= Input(2)(25 downto 0) & "000000";
  sh(6) <= Input(2)(26 downto 0) & "00000";
  sh(7) <= Input(3)(23 downto 0) & "00000000";
  sh(8) <= Input(3)(24 downto 0) & "0000000";
  sh(9) <= Input(4)(20 downto 0) & "00000000000";
  sh(10) <= Input(4)(21 downto 0) & "0000000000";
  sh(11) <= Input(4);
  sh(12) <= Input(5)(20 downto 0) & "00000000000";
  sh(13) <= Input(5)(21 downto 0) & "0000000000";
  sh(14) <= Input(5);
  sh(15) <= Input(6)(23 downto 0) & "00000000";
  sh(16) <= Input(6)(24 downto 0) & "0000000";
  sh(17) <= Input(7)(25 downto 0) & "000000";
  sh(18) <= Input(7)(26 downto 0) & "00000";
  sh(19) <= Input(8)(27 downto 0) & "0000";
  sh(20) <= Input(8)(28 downto 0) & "000";
  sh(21) <= Input(8);
  sh(22) <= Input(9)(30 downto 0) & "0";
  sh(23) <= Input(9);
  sh(24) <= y(9)(29 downto 0) & "00";
  sh(25) <= y(9);
  sh(26) <= y(8)(26 downto 0) & "00000";
  sh(27) <= y(8)(27 downto 0) & "0000";
  sh(28) <= y(7)(25 downto 0) & "000000";
  sh(29) <= y(7)(28 downto 0) & "000";
  sh(30) <= y(7)(29 downto 0) & "00";
  sh(31) <= y(6)(23 downto 0) & "00000000";
  sh(32) <= y(6)(25 downto 0) & "000000";
  sh(33) <= y(6);
  sh(34) <= y(5)(21 downto 0) & "0000000000";
  sh(35) <= y(5)(22 downto 0) & "000000000";
  sh(36) <= y(5)(29 downto 0) & "00";
  sh(37) <= y(4)(23 downto 0) & "00000000";
  sh(38) <= y(4)(25 downto 0) & "000000";
  sh(39) <= y(4);
  sh(40) <= y(3)(25 downto 0) & "000000";
  sh(41) <= y(3)(28 downto 0) & "000";
  sh(42) <= y(3)(29 downto 0) & "00";
  sh(43) <= y(2)(26 downto 0) & "00000";
  sh(44) <= y(2)(27 downto 0) & "0000";
  sh(45) <= y(1)(29 downto 0) & "00";
  
  -- Define every adders
  
  S0: adder port map(
    A => sh(0),
    B => sh(1),
    O => s(0)
  );

  S1: adder port map(
    A => sh(2),
    B => sh(3),
    O => s(1)
  );

  S2: adder port map(
    A => sh(4),
    B => sh(5),
    O => s(2)
  );

  S3: adder port map(
    A => sh(6),
    B => sh(7),
    O => s(3)
  );

  S4: adder port map(
    A => sh(8),
    B => sh(9),
    O => s(4)
  );

  S5: adder port map(
    A => sh(10),
    B => sh(11),
    O => s(5)
  );

  S6: adder port map(
    A => sh(12),
    B => sh(13),
    O => s(6)
  );

  S7: adder port map(
    A => sh(14),
    B => sh(15),
    O => s(7)
  );

  S8: adder port map(
    A => sh(16),
    B => sh(17),
    O => s(8)
  );

  S9: adder port map(
    A => sh(18),
    B => sh(19),
    O => s(9)
  );

  S10: adder port map(
    A => sh(20),
    B => sh(21),
    O => s(10)
  );

  S11: adder port map(
    A => sh(22),
    B => sh(23),
    O => s(11)
  );

  S12: adder port map(
    A => sh(24),
    B => sh(25),
    O => s(12)
  );

  S13: adder port map(
    A => sh(26),
    B => sh(27),
    O => s(13)
  );

  S14: adder port map(
    A => sh(28),
    B => sh(29),
    O => s(14)
  );

  S15: adder port map(
    A => sh(30),
    B => sh(31),
    O => s(15)
  );

  S16: adder port map(
    A => sh(32),
    B => sh(33),
    O => s(16)
  );

  S17: adder port map(
    A => sh(34),
    B => sh(35),
    O => s(17)
  );

  S18: adder port map(
    A => sh(36),
    B => sh(37),
    O => s(18)
  );

  S19: adder port map(
    A => sh(38),
    B => sh(39),
    O => s(19)
  );

  S20: adder port map(
    A => sh(40),
    B => sh(41),
    O => s(20)
  );

  S21: adder port map(
    A => sh(42),
    B => sh(43),
    O => s(21)
  );

  S22: adder port map(
    A => sh(44),
    B => sh(45),
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
