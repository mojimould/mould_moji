%
O9727(REN*VECTOR*OD-ID)
#135=#1
#140=#26
M98P9723
#137=#5043-#116
#138=#5041
#136=#5042
IF[#26NE#0]GOTO1
IF[#18EQ#0]GOTO4
N1
#19=#[#111+19]*#129
IF[#18GE0]GOTO2
IF[#26EQ#0]GOTO2
#19=-#19
N2
#142=-[#19+ABS[#18]]
IF[#26EQ#0]GOTO3
#142=#18+#19
N3
#141=#138+[[[#7/2]+#142]*COS[#135]]
#31=#136+[[[#7/2]+#142]*SIN[#135]]
#9=#119
#24=#141
#25=#31
#26=#137
M98P9725
IF[#149NE2]GOTO5
IF[#26EQ#0]GOTO4
#9=#113
#26=#140
M98P9725
IF[#149NE2]GOTO5
N4
#9=#0
#24=#138+[[#7/2]*COS[#135]]
#25=#136+[[#7/2]*SIN[#135]]
#26=#140
#19=#0
M98P9726
GOTO6
N5
#149=1
N6
G01Z#137F#119
G01X#138Y#136
#9=135
WHILE[#9LE142]DO1
#[#9]=#0
#9=#9+1
END1
M99
%
