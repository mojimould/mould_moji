%
O9021(PALLET #1 CHECK)
(PALLET CHANGE V.3.0 HX400G)
IF[#1000EQ1]GOTO1
IF[#1001EQ0]GOTO2
M99
N1#3000=12(WRONG PALLET ALARM)
M30
N2#3000=10(MACRO PALLET CHECK ALARM)
M30
%