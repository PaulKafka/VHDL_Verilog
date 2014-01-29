Library ieee; USE ieee.std_logic_1164.all;
ENTITY bin_to_hex IS
	PORT (
	i7, i6, i5, i4, i3, i2, i1, i0 : IN STD_LOGIC;
	lseg, rseg : OUT STD_LOGIC_VECTOR (6 downto 0)
	);
END bin_to_hex;

ARCHITECTURE logic OF bin_to_hex IS
BEGIN
P1: PROCESS (i7, i6, i5, i4)
BEGIN
	IF (((i7='0' and i6='0') and i5='0') and i4='0') THEN
	lseg <= "1000000";
	ELSIF (((i7='0' and i6='0') and i5='0') and i4='1') THEN
	lseg <= "1111001";
	ELSIF (((i7='0' and i6='0') and i5='1') and i4='0') THEN
	lseg <= "0100100";
	ELSIF (((i7='0' and i6='0') and i5='1') and i4='1') THEN
	lseg <= "0110000";
	ELSIF (((i7='0' and i6='1') and i5='0') and i4='0') THEN
	lseg <= "0011001";
	ELSIF (((i7='0' and i6='1') and i5='0') and i4='1') THEN
	lseg <= "0010010";
	ELSIF (((i7='0' and i6='1') and i5='1') and i4='0') THEN
	lseg <= "0000010";
	ELSIF (((i7='0' and i6='1') and i5='1') and i4='1') THEN
	lseg <= "1111000";
	ELSIF (((i7='1' and i6='0') and i5='0') and i4='0') THEN
	lseg <= "0000000";
	ELSIF (((i7='1' and i6='0') and i5='0') and i4='1') THEN
	lseg <= "0010000";
	ELSIF (((i7='1' and i6='0') and i5='1') and i4='0') THEN
	lseg <= "0001000";
	ELSIF (((i7='1' and i6='0') and i5='1') and i4='1') THEN
	lseg <= "0000011";
	ELSIF (((i7='1' and i6='1') and i5='0') and i4='0') THEN
	lseg <= "1000110";
	ELSIF (((i7='1' and i6='1') and i5='0') and i4='1') THEN
	lseg <= "0100001";
	ELSIF (((i7='1' and i6='1') and i5='1') and i4='0') THEN
	lseg <= "0000110";
	ELSIF (((i7='1' and i6='1') and i5='1') and i4='1') THEN
	lseg <= "0001110";
	ELSE 
	lseg <= "0110110";
	END IF;
END PROCESS P1;
P2: PROCESS (i3, i2, i1, i0)
BEGIN
	IF i3='0' and i2='0' and i1='0' and i0='0' THEN
	rseg <= "1000000";
	ELSIF i3='0' and i2='0' and i1='0' and i0='1' THEN
	rseg <= "1111001";
	ELSIF i3='0' and i2='0' and i1='1' and i0='0' THEN
	rseg <= "0100100";
	ELSIF i3='0' and i2='0' and i1='1' and i0='1' THEN
	rseg <= "0110000";
	ELSIF i3='0' and i2='1' and i1='0' and i0='0' THEN
	rseg <= "0011001";
	ELSIF i3='0' and i2='1' and i1='0' and i0='1' THEN
	rseg <= "0010010";
	ELSIF i3='0' and i2='1' and i1='1' and i0='0' THEN
	rseg <= "0000010";
	ELSIF i3='0' and i2='1' and i1='1' and i0='1' THEN
	rseg <= "1111000";
	ELSIF i3='1' and i2='0' and i1='0' and i0='0' THEN
	rseg <= "0000000";
	ELSIF i3='1' and i2='0' and i1='0' and i0='1' THEN
	rseg <= "0010000";
	ELSIF i3='1' and i2='0' and i1='1' and i0='0' THEN
	rseg <= "0001000";
	ELSIF i3='1' and i2='0' and i1='1' and i0='1' THEN
	rseg <= "0000011";
	ELSIF i3='1' and i2='1' and i1='0' and i0='0' THEN
	rseg <= "1000110";
	ELSIF i3='1' and i2='1' and i1='0' and i0='1' THEN
	rseg <= "0100001";
	ELSIF i3='1' and i2='1' and i1='1' and i0='0' THEN
	rseg <= "0000110";
	ELSIF i3='1' and i2='1' and i1='1' and i0='1' THEN
	rseg <= "0001110";
	ELSE 
	lseg <= "0110110";
	END IF;
END PROCESS P2;
END logic;	