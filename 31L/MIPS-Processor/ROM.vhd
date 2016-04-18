LIBRARY ieee;
	USE ieee.std_logic_1164.all;
	USE IEEE.STD_LOGIC_ARITH.ALL;
	USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY rom IS
	GENERIC (ABIT : INTEGER := 6;
		 NBIT : INTEGER := 32);
	PORT (clk: IN BIT; 
	      address: IN STD_LOGIC_VECTOR (ABIT-1 DOWNTO 0);
	      data_out: OUT STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0));
END rom;

-------------------------------
ARCHITECTURE rom OF rom IS
	SIGNAL reg_address: STD_LOGIC_VECTOR (ABIT-1 DOWNTO 0);
	TYPE memory IS ARRAY ((2**ABIT-1) DOWNTO 0) OF STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0);
	CONSTANT myrom: memory := (
		--    R    rs    rd   f    rt      imm 
		1 => "00000010000001011111111111111111", -- $s0 = 255
		2 => "00000000000011011000000000000001", -- $s1 = 1
		3 => "00000000000101011000000000000010", -- $s2 = 2
		4 => "00000100000111011000000000000000", -- $s3 = 0
		5 => "00000010001001011000000000000011", -- $s4 = 3
		6 => "00001010001011011000000000000100", -- $s5 = 4
		7 => "10000010001100001000000000000001", -- $s6 = $s1 + $s0 (0)
		8 => "10001000001110111000100000000001", -- $s7 = NOT $s4 (1111111....1100)
		9 => "10000000010000010000001000000001", -- $s8 = $s0 - $s1 (254)
		10 =>"10000010010000001001000000000001", -- $s8 = $s1 + $s8 (255)
		11 =>"10010000010010010000010000000001", -- $s9 = $s8 - $s2 (253)
		12 =>"00010000010101000111111111111111", -- $s10 = $s0 XOR 11111...111 (0)
		13 =>"10000100010100101000100111111111", -- $s10 = $s2 AND $s4 (2)
		14 =>"00000110010100011111111111111111", -- $s10 = $s3 COMP (1111.11) (0)
		15 =>"10001010010111011111111111111111", -- $s11 = $s5 (4)
		16 =>"10000000010111001111111111111111", -- $s11 = $s0 SLL 1 (1111..110)
		OTHERS => (OTHERS => 'X'));
BEGIN
	PROCESS (clk)
	BEGIN
		IF (clk'EVENT AND clk = '1') THEN
			reg_address <= address;
		END IF;
	END PROCESS;
	data_out <= myrom(CONV_INTEGER(reg_address));
END rom;