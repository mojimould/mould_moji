%
O9811(REN*X/Y/Z*MEASURE)
(F-4012-0519-AV)
(COPYRIGHT*1990-2022*RENISHAW*PLC.*ALL*RIGHTS*RESERVED)
G65P9724
#31=#5041
#32=#5042
#149=330
IF[#19EQ#0]GOTO1
IF[#20EQ#0]GOTO1
GOTO15
N1
#149=320
IF[#19EQ#0]GOTO2
IF[#11EQ#0]GOTO2
GOTO15
N2
#149=340
IF[#20EQ#0]GOTO3
IF[#13EQ#0]GOTO3
GOTO15
N3
#1=135
WHILE[#1LE149]DO1
#[#1]=#0
#1=#1+1
END1
G31R1X[#31-[#[#111+2]*#129]]Y[#32-[#[#111+3]*#129]]F#119
IF[ABS[#5061-[#31-[#[#111+2]]*#129]]GE#123]GOTO14
IF[ABS[#5062-[#32-[#[#111+3]]*#129]]GE#123]GOTO14
#30=-1
IF[#24NE#0]GOTO6
IF[#25NE#0]GOTO9
#149=210
IF[#26EQ#0]GOTO15
IF[[#5043-#116]LT#26]GOTO4
#30=1
N4
G65P9726Z#26Q#17S[#[#111+19]*#129]
IF[#149NE0]GOTO15
#135=#31
#136=#32
#137=#126-#116+[[#[#111+19]-#[#111+18]]*#129]
#138=#137
IF[#8EQ#0]GOTO5
#138=#138+#[11000+#8]
N5
#142=#137-#26
(TWPZ=#142)
#143=#138-#26
#145=ABS[#142]
#146=#143*#30
GOTO12
N6
#149=350
IF[#25NE#0]GOTO15
IF[#26NE#0]GOTO15
#6=#[#111]*#129
IF[#5041LT#24]GOTO7
#6=-#6
#30=1
N7
G65P9726X#24Q#17
IF[#149NE0]GOTO15
#135=#124+#6+[#[#111+2]*#129]
#136=#32
#138=#135
IF[#8EQ#0]GOTO8
#138=#138+#[11000+#8]
N8
#140=#135-#24
(TWPX=#140)
#143=#138-#24
#145=ABS[#140]
#146=#143*#30
GOTO12
N9
#149=350
IF[#26NE#0]GOTO15
#6=#[#111+1]*#129
IF[#5042LT#25]GOTO10
#6=-#6
#30=1
N10
G65P9726Y#25Q#17
IF[#149NE0]GOTO15
#135=#31
#136=#125+#6+[#[#111+3]*#129]
#138=#136
IF[#8EQ#0]GOTO11
#138=#138+#[11000+#8]
N11
#141=#136-#25
(TWPY=#141)
#143=#138-#25
#145=ABS[#141]
#146=#143*#30
N12
#147=#30
IF[#23EQ#0]GOTO13
IF[#24NE#0]GOTO20
IF[#26EQ#0]GOTO30
IF[#26NE#0]GOTO40
N20
#15=100.
GOTO50
N30
#15=101.
GOTO50
N40
#15=102.
GOTO50
N41
#15=#0
N50
G65P9730F#15H#11M#13S#19T#20W#23X#24Y#25Z#26
N13
#147=#26
#26=1
M98P9701
#147=#30
GOTO16
N14
#149=1
N15
G01X#31Y#32F#119
G65P9700
N16
G01X#31Y#32F#119
M99
%
