%
O9726(REN*BASIC*MEASURE)
#29=0
#32=.3(DWELL*SG*PROBE-SECONDS)
#33=1.1(OPTIMISED BOF)
#28=0
#149=0
M98P9723
#1=#5041
IF[#24NE#0]GOTO5
#24=#1
N5
#2=#5042
IF[#25NE#0]GOTO10
#25=#2
N10
#3=#5043-#116
IF[#26NE#0]GOTO15
#26=#3
N15
#8=#[#111+8]*#129
IF[#9EQ#0]GOTO20
#8=#9
N20
#11=#24-#1
#12=#25-#2
#13=#26-#3
#10=SQRT[[#11*#11]+[#12*#12]+[#13*#13]]
#10=FIX[#10*10000]/10000
#149=370
IF[#10EQ0]GOTO140
#11=#11/#10
#12=#12/#10
#13=#13/#10
IF[#17NE#0]GOTO25
#17=5*#129
#9=10*#129
#17=#9-[[#9-#17]*ABS[#13]]
N25
IF[[#[#111+5]AND1024]EQ1024]GOTO30
IF[#15EQ3]GOTO30
#31=0(*Z*RAD)
#9=#[#111+19]*#129(*XY*RAD)
#31=[#9-#31]*ABS[#13]
#5=[#10+#17-[#[#111+19]*#129]+#31]/#129
#5=[[900-300]*[#5-2]/[20-2]]+300
#5=#5*#129
IF[#8GT#5]GOTO90
()
N30(2-TOUCH)
#9=#119
IF[#13EQ0]GOTO40
#9=#113
N40
IF[[#[#111+5]AND1024]EQ1024]GOTO43
IF[#9LT[3000*#129]]GOTO43
#9=3000*#129
N43
IF[#15NE3]GOTO44
#9=80*#129
N44
#24=#24+[[#17-[#[#111+19]*#129]]*#11]
#25=#25+[[#17-[#[#111+19]*#129]]*#12]
#26=#26+[[#17-[#[#111+19]*#129]]*#13]-#19
IF[[#[#111+5]AND512]NE512]GOTO50
#9=#9*.5(50*PERCENT*FEED*-*2TCH)
N45
M00(PROVEOUT*STOP)
N50
#3004=2
G31R1X#24Y#25Z#26F#9
#3004=0
#149=0
#4=#5061-#24
#5=#5062-#25
#6=[#5063-#116]-#26
#10=SQRT[[#4*#4]+[#5*#5]+[#6*#6]]
IF[#10GE#123]GOTO55
#149=2
GOTO145
N55
#4=#5061-#1
#5=#5062-#2
#6=[#5063-#116]-#3
#10=SQRT[[#4*#4]+[#5*#5]+[#6*#6]]
IF[#10GE#123]GOTO60
#149=1
GOTO140
N60
IF[[#[#111+5]AND2048]EQ2048]GOTO65
#30=[8*#[#111+6]]*#129
IF[#15NE3]GOTO75
#30=[4*#[#111+6]]*#129
GOTO75
N65
IF[#15NE3]GOTO70
#9=500*#129
N70
G53
#30=#9/60/1000*[#[#111+6]*#33]
IF[#15EQ3]GOTO75
#30=#30+[#9/60/1000*4]
#30=#30+[#8*#118/1000]
N75
#21=#5061-[#30*#11]
#22=#5062-[#30*#12]
#23=#5063-#116-[#30*#13]
#4=#24-#21
#5=#25-#22
#6=#26-#23
#10=SQRT[[#4*#4]+[#5*#5]+[#6*#6]]
#21=#24-[#10*#11]
#22=#25-[#10*#12]
#23=#26-[#10*#13]
G01X#21Y#22Z#23F#9
#149=0
G04X#32
IF[#15NE3]GOTO80
#8=3*#129
N80
#3004=2
G31R1X#24Y#25Z#26F#8
#3004=0
#149=0
#4=#5061-#24
#5=#5062-#25
#6=[#5063-#116]-#26
#10=SQRT[[#4*#4]+[#5*#5]+[#6*#6]]
IF[#10GE#123]GOTO85
#149=2
GOTO145
N85
#4=#5061-#21
#5=#5062-#22
#6=[#5063-#116]-#23
#10=SQRT[[#4*#4]+[#5*#5]+[#6*#6]]
IF[#10GE#123]GOTO135
#149=1
GOTO140
N90
(1-TOUCH)
#24=#24+[[#17-[#[#111+19]*#129]]*#11]
#25=#25+[[#17-[#[#111+19]*#129]]*#12]
#26=#26+[[#17-[#[#111+19]*#129]]*#13]-#19
IF[[#[#111+5]AND2560]NE2560]GOTO100
#8=#8*.5(50*PERCENT*FEED*-*2TCH)
N95
M00(PROVEOUT*STOP)
N100
#3004=2
G31R1X#24Y#25Z#26F#8
#3004=0
#149=0
#4=#5061-#24
#5=#5062-#25
#6=[#5063-#116]-#26
#10=SQRT[[#4*#4]+[#5*#5]+[#6*#6]]
IF[#10GE#123]GOTO105
#149=2
GOTO145
N105
#4=#5061-#1
#5=#5062-#2
#6=[#5063-#116]-#3
#10=SQRT[[#4*#4]+[#5*#5]+[#6*#6]]
IF[#10GE#123]GOTO110
#149=1
GOTO140
N110
IF[#29EQ0]GOTO115
M98P9723
#4=#5041
#5=#5042
#6=#5043
#31=.1*#129
#21=#4-[#31*#11]
#22=#5-[#31*#12]
#23=#6-#116-[#31*#13]
G04X#32
G31R1X#21Y#22Z#23F[100*#129]
IF[ABS[#5061-#21]GT#123]GOTO115
IF[ABS[#5062-#22]GT#123]GOTO115
IF[ABS[[#5063-#116]-#23]GT#123]GOTO115
#31=#8*#118/1000
#21=#4-[#31*#11*2]
#22=#5-[#31*#12*2]
#23=#6-#116-[#31*#13*2]
G01X#21Y#22Z#23F#113
M98P9723
#28=#28+1
IF[#28LE#29]GOTO100
#149=10.
GOTO135
N115
(CHECK 1T FOR ACC/DEC)
#31=#8*#118/1000
#30=#8/60/1000*#[#111+6]
#21=#5061-#24
#22=#5062-#25
#23=#5063-#116-#26
#10=SQRT[[#21*#21]+[#22*#22]+[#23*#23]]
#10=#10+#30
IF[#10LT#31]GOTO120
#21=#5061-#1
#22=#5062-#2
#23=#5063-#116-#3
#10=SQRT[[#21*#21]+[#22*#22]+[#23*#23]]
#10=#10-#30
IF[#10LT#31]GOTO120
GOTO135
N120(RECOVERY)
IF[#[#111+5]AND128EQ0]GOTO122
G65P9700E390.
N122
#30=#8/60/1000*[#[#111+6]*#33]
#14=100*#129
#30=#30+[#14*#118/1000]
#21=#5061-[#30*#11]
#22=#5062-[#30*#12]
#23=#5063-#116-[#30*#13]
#4=#24-#21
#5=#25-#22
#6=#26-#23
#10=[#4*#4]+[#5*#5]+[#6*#6]
#10=SQRT[#10]
#21=#24-[#10*#11]
#22=#25-[#10*#12]
#23=#26-[#10*#13]
G01X#21Y#22Z#23F#113
#149=0
G04X#32
#3004=2
G31R1X#24Y#25Z#26F#14
#3004=0
#4=#5061-#24
#5=#5062-#25
#6=[#5063-#116]-#26
#10=SQRT[[#4*#4]+[#5*#5]+[#6*#6]]
IF[#10GE#123]GOTO125
#149=2
GOTO145
N125
#4=#5061-#21
#5=#5062-#22
#6=[#5063-#116]-#23
#10=SQRT[[#4*#4]+[#5*#5]+[#6*#6]]
IF[#10GE#123]GOTO130
#149=1
GOTO140
N130
#124=#5061
#125=#5062
#126=#5063
G53
#124=#124-[#[#111+4]*#11*#129]
#125=#125-[#[#111+4]*#12*#129]
#126=#126-[#[#111+4]*#13*#129]
GOTO150
N135
#124=#5061
#125=#5062
#126=#5063
GOTO150
N140(PO)
#124=#1
#125=#2
#126=#3
GOTO150
N145(PF)
#124=#24
#125=#25
#126=#26
N150(MOVE TO START POS)
#4=#1-#5041
#5=#2-#5042
#6=#3-[#5043-#116]
#10=SQRT[[#4*#4]+[#5*#5]+[#6*#6]]
#30=ABS[#4]+ABS[#5]+ABS[#6]
IF[[#30-#10]GT[1*#129]]GOTO155
G00X#1Y#2Z#3
GOTO160
N155
G01X#1Y#2Z#3F#113
N160
M99
%
