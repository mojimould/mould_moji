%
O9821(REN*XYZ*MEASURE)
(F-4012-0519-AV)
(COPYRIGHT*1990-2022*RENISHAW*PLC.*ALL*RIGHTS*RESERVED)
G65P9724
#148=0
#149=0
#31=#5041
#32=#5042
IF[#24NE#0]GOTO20
IF[#25NE#0]GOTO20
IF[#26NE#0]GOTO20
#3=#5043-#116
IF[#1NE#0]GOTO1
G65P9700E80.
N1
IF[#7NE#0]GOTO2
G65P9700E110.
N2
IF[#19EQ#0]GOTO3
IF[#11EQ#0]GOTO3
G65P9700E320.
N3
IF[#20EQ#0]GOTO4
IF[#13EQ#0]GOTO4
G65P9700E340.
N4
IF[#19EQ#0]GOTO5
IF[#20EQ#0]GOTO5
G65P9700E330.
N5
#14=135
WHILE[#14LT149]DO1
#[#14]=#0
#14=#14+1
END1
G65P9725X[#31-[#[#111+2]*#129]]Y[#32-[#[#111+3]*#129]]F#119M1.
IF[#149NE2]GOTO17
#148=0
N6
#28=#1
G65P9731A#28
#30=-1
#24=#5041+[#7*COS[#28]]
#25=#5042+[#7*SIN[#28]]
G65P9726X#24Y#25Q#17
IF[#149NE0]GOTO16
#135=#124+[#112*COS[#28]]+[#[#111+2]*#129]
#135=[ROUND[#135*10000]]/10000
#136=#125+[#112*SIN[#28]]+[#[#111+3]*#129]
#136=[ROUND[#136*10000]]/10000
#138=SQRT[[#135-#31]*[#135-#31]+[#136-#32]*[#136-#32]]
IF[#8EQ#0]GOTO7
#138=#138+#[11000+#8]
N7
#140=#135-#31-[#7*COS[#28]]
#141=#136-#32-[#7*SIN[#28]]
(TWPX=#140)
(TWPY=#141)
#143=#138-#7
#145=SQRT[[#140*#140]+[#141*#141]]
#146=#143*#30(METAL*CON)
#147=#30
IF[#23EQ#0]GOTO8
#15=118.
G65P9730D#7F#15H#11M#13S#19T#20W#23X#24Y#25
N8
IF[#21EQ#0]GOTO9
IF[ABS[#143]GE#21]GOTO18
IF[#145GE#21]GOTO18
N9
IF[#11EQ#0]GOTO11
IF[ABS[#143]LT#11]GOTO10
#148=1
N10
IF[ABS[#143]LT#11]GOTO11
G01X#31Y#32F#119
G65P9700E500.
N11
IF[#13EQ#0]GOTO13
IF[ABS[#145]LT[#13/2]]GOTO12
#148=2
N12
IF[ABS[#145]LT[#13/2]]GOTO13
G01X#31Y#32F#119
G65P9700E510.
N13
IF[#20EQ#0]GOTO15
IF[ABS[#146]LT#22]GOTO15
IF[#9NE#0]GOTO14
#9=1
N14
G65P9732T#20C[#146*#9]
N15
IF[#19EQ#0]GOTO19
G65P9732S#19W1.
GOTO19
N16
G01X#31Y#32F#119
IF[#149NE2]GOTO17
G65P9700E2.
N17
G65P9700E1.
N18
G01X#31Y#32F#119
#148=3
G65P9700E540.
N19
G01X#31Y#32F#119
GOTO38
N20
#149=260
IF[#20NE#0]GOTO36
#149=320
IF[#19EQ#0]GOTO21
IF[#11EQ#0]GOTO21
GOTO36
N21
#149=370
IF[#1NE#0]GOTO36
IF[#7NE#0]GOTO36
#149=210
IF[#24NE#0]GOTO22
IF[#25NE#0]GOTO22
IF[#26NE#0]GOTO22
GOTO36
N22
#12=7
IF[#24NE#0]GOTO23
#12=-1
#24=#5041
N23
IF[#25NE#0]GOTO24
#12=#12-2
#25=#5042
N24
#10=#[#111+19]*#129
IF[#26NE#0]GOTO25
#12=#12-4
#10=0
#26=#5043-#116
N25
#27=135
WHILE[#27LE149]DO1
#[#27]=#0
#27=#27+1
END1
#14=#5043-#116
#15=#31-[#[#111+2]*#129]
#16=#32-[#[#111+3]*#129]
#27=#14-#10
G65P9725X#15Y#16Z#27F#113
IF[#149NE2]GOTO36
G65P9726X[#24-[#[#111+2]*#129]]Y[#25-[#[#111+3]*#129]]Z[#26-#10]Q#17
G01X#31Y#32Z#14F#113
IF[#149NE0]GOTO36
#28=#31-#24
#29=#32-#25
#30=#14-#26
#144=SQRT[[#28*#28]+[#29*#29]+[#30*#30]]
G65P9731Y[-#29]X[-#28]K2.
#6=ABS[#30/#144]
#1=90
IF[#6EQ1]GOTO26
#1=ATAN[#6/SQRT[1-[#6*#6]]]/[1]
N26
#6=[[#1]/90.]*[#[#111+18]*#129]
#5=[[90.-#1]/90.]*#112
#112=#6+#5
#126=#126-#116
#135=[#124+[#[#111+2]*#129]]-[#28/#144*#112]
#136=[#125+[#[#111+3]*#129]]-[#29/#144*#112]
#137=[#126+#10]-[#30/#144*#112]
#140=#135-#24
#141=#136-#25
#142=#137-#26
IF[#3LT1]GOTO28
#124=#135+[[#[#111+19]*#129]*[#28/#144]]
#125=#136+[[#[#111+19]*#129]*[#29/#144]]
IF[#10EQ0]GOTO27
#126=#137+[[#[#111+19]*#129]*[#30/#144]]
N27
IF[#3NE2]GOTO28
#124=#135
#125=#136
#126=#137
N28
IF[#12AND1EQ1]GOTO29
#24=#0
#124=#0
#135=#0
#140=#0
N29
IF[#12AND2EQ2]GOTO30
#25=#0
#125=#0
#136=#0
#141=#0
N30
IF[#12AND4EQ4]GOTO31
#26=#0
#126=#0
#137=#0
#142=#0
N31
#138=SQRT[[#135*#135]+[#136*#136]+[#137*#137]]
#143=SQRT[[#140*#140]+[#141*#141]+[#142*#142]]
N32
IF[#8EQ#0]GOTO33
#138=#138+#[11000+#8]
N33
(TWPX=#140)
(TWPY=#141)
(TWPZ=#142)
#145=ABS[#143]
#146=-#143/2
#147=#0
IF[#12EQ#0]GOTO34
#146=-#143
#147=-1
N34
IF[#23EQ#0]GOTO35
#15=119.
G65P9730H#11F#15M#13W#23X#24Y#25Z#26E3.(D#144E1.)
N35
M98P9701
GOTO37
N36
G65P9700
N37
#144=#0
G01X#31Y#32Z#14F#119
N38
#147=#0
M99
%
