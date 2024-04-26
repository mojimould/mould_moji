%
O440000
(Sotogawa Mentori Corner R, ar HidariMawari 1shuu)

N001
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#25EQ#0]GOTO800
IF[#25LT10]GOTO800
IF[#26EQ#0]GOTO800
IF[#06EQ#0]GOTO800
IF[#06LT0.1]GOTO800
IF[#13LT0]GOTO800
IF[#18EQ#0]GOTO800
IF[#18LT0.1]GOTO800
(if X < 10 or #0, go to N800)
(if Y < 10 or #0, go to N800)
(if Z = #0, go to N800)
(if K < 0.1 or #0, go to N800)
(if R < 0.1 or #0, go to N800)

N003
IF[#01EQ0]GOTO004
IF[#01EQ1]GOTO004
GOTO800

N004
IF[#02EQ0]GOTO005
IF[#02EQ1]GOTO005
GOTO800

N005
IF[#01EQ1]GOTO006
IF[#4012EQ56]THEN #24=#900003
IF[#4012EQ54]THEN #24=#900004
IF[#4012EQ56]THEN #25=#900009
IF[#4012EQ54]THEN #25=#900010
(XY into measurement values)

N006
IF[#4012EQ56]THEN #33=#425
IF[#4012EQ54]THEN #33=#441
(Top: #33=#425. Bot: #33=#441)
(#33: X +hosei)


IF[#664EQ#0]GOTO800
IF[#664LE10]GOTO800
IF[#665EQ#0]GOTO800
IF[#665LE10]GOTO800
IF[#678EQ#0]GOTO800
IF[#678LE200]GOTO800
(if #664 <= 10 or #0, go to N800)
(if #665 <= 10 or #0, go to N800)
(if #678 <= 200 or #0, go to N800)

N007
IF[ABS[#426]GE10]GOTO800
IF[ABS[#442]GE10]GOTO800
IF[#4120EQ#0]GOTO800
IF[#4120LT11]GOTO800
IF[#4120GT15]GOTO800
IF[[FIX[#4120]]NE#4120]GOTO800
IF[[#26-#06]LE[#901011/2]]GOTO800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO800
IF[ABS[#33]GE#18]GOTO800
IF[#632GT#631]GOTO800
(if |#426| >= 10, go to N800)
(if T# < 11 or > 15 or not integer or #0, go to N800)
(if Z-K <= #901011/2, go to N800)
(if R >= min[X/4, Y/4], go to N800)
(if |#33| >= R, go to N800)
(if #632 > #631, go to N800)

N008
IF[#02NE0]GOTO009
#32=#06
GOTO010
N009 (if B=1)
IF[#4120EQ11]THEN #32=#06*[3+SQRT[3]-SQRT[6]-SQRT[2]]
IF[#4120EQ12]THEN #32=#06*[SQRT[3]-1]
IF[#4120EQ13]THEN #32=#06*[2-SQRT[2]]

N010
#31=[#605+#[2400+#4120]+#[2600+#4120]+ABS[#605-[#[2400+#4120]+#[2600+#4120]]]]/2
IF[#31LE0]GOTO800
(#31: max[#605, hosei kouguKei])

IF[#4012EQ56]THEN #30=SQRT[#17*#17-[#23-#32]*[#23-#32]]-SQRT[#17*#17-#23*#23]
IF[#4012EQ54]THEN #30=-SQRT[#17*#17-[#23-#32]*[#23-#32]]+SQRT[#17*#17-#23*#23]
IF[#01EQ1]THEN #30=0
(#30: X hosei from K)

IF[#4012EQ56]THEN #29=#24+#426
IF[#4012EQ54]THEN #29=#24+#442
IF[#4012EQ56]THEN #28=#25+#426
IF[#4012EQ54]THEN #28=#25+#442
(mentoriKei: +hosei)

IF[#4120EQ11]THEN #27=#32*TAN[15]
IF[#4120EQ12]THEN #27=#32*TAN[30]
IF[#4120EQ13]THEN #27=#32

N011
IF[#27LE#632]GOTO019
(if #27 <= #632, go to N019)
#103=FUP[[[#27*2]-#632]/#631]
IF[#103LT0]GOTO800
(#103: kakou kaisuu)


(kokokara G00)


N012
G90 G43 G01 H#4120 Z[#26+#600] F#650

N100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#29+#632+#631*#103
#105=#28+#632+#631*#103

N101
G90 G00 X[[#104/2]+#31*3+#30+#33] Y[#105/2]
G42 D#4120
G91 G00 X-[#31/2]
G90 G01 Z[#26-#32] S#678 F#651

N102
M03 (spindle on)
M08 (coolant on)

N103
G90 G01 X[[#104/2]+#31*2+#30+#33] Y[#105/2] F#651
G65 P490005 K1. R#18 X#104 Y#105 D#31 F#664 E#665 S#678
G90 G40 G00 X[[#104/2]+#31*3+#30+#33]
END1


N013 (pause)
IF[#4012EQ56]GOTO014
IF[#443EQ0]GOTO015
IF[#443EQ2]GOTO016
GOTO019
N015 (if #443=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00 (OK?)
GOTO019
N016 (if #443=2)
G65 P900003 (for Bot)
GOTO019

N014 (for Top)
IF[#427EQ0]GOTO017
IF[#427EQ2]GOTO018
GOTO019
N017 (if #427=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00 (OK?)
GOTO019
N018 (if #427=2)
G65 P900003 (for Top)


N019 (Shiage)
IF[#4012EQ56]THEN #33=#425
IF[#4012EQ54]THEN #33=#441
(Top: #33=#425, Bot: #33=#441)
(#33: X +hosei)

IF[#4012EQ56]THEN #29=#24+#426
IF[#4012EQ54]THEN #29=#24+#442
IF[#4012EQ56]THEN #28=#25+#426
IF[#4012EQ54]THEN #28=#25+#442
(mentoriKei: +hosei)

IF[#4012EQ56]THEN #106=FUP[#184]
IF[#4012EQ54]THEN #106=FUP[#189]
(Top: #106=FUP[#184], Bot: #106=FUP[#189])

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#632LE0]THEN #106=#106-1
(#106: Shiage kakou kaisuu)

N020
G90 G43 G01 H#4120 Z[#26+#600] F#650

N200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

N201
G90 G00 X[[#29/2]+#31*3+#30+#33] Y[#28/2]
G42 D#4120
G91 G00 X-[#31/2]
G90 G01 Z[#26-#32] S#678 F#651

N202
M03 (spindle on)
M08 (coolant on)

N203
G90 G01 X[[#29/2]+#31*2+#30+#33] Y[#28/2] F#651
G65 P490005 K1. R#18 X#29 Y#28 D#31 F#664 E#665 S#678
G90 G40 G00 X[[#29/2]+#31*3+#30+#33]
END2

N990
M09 (coolant off)
G90 G43 G01 H#4120 Z[#26+#600] F#650
S2599
G90 G53 G01 Z0 F#650
G04 X1.5 (wait 1.5s)
M05 (spindle off)
S35
GOTO999


N800
M09 (coolant off)
S2599
G04 X2.0 (wait 2.0s)
M05 (spindle off)
S35
#3000=100 (are the arguments OK?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#01:A: Top gaisaku: 0:not exists, 1:exists)
(#02:B: mentori type: 0:C, 1:R)
(#06:K: mentori C or R length)
(#17:Q: central curvature)
(#18:R: corner R)
(#23:W: Top ori_furiwake)
(#24:X: AC gaikei)
(#25:Y: BD gaikei)
(#26:Z: sai-furiwake)

(as LHS)
(#27, #28, #29, #30, #31, #32, #33)


(Common variable)
(as LHS)
(#103, #104, #105, #106)
(as RHS)
(#184, #189, #425, #426, #427, #441, #442, #443, #600, #605, #631, #632, #650, #651, #664, #665, #678)
(#901011)


(System variables)
(#24xx: #xx kouguKei)
(#26xx: #xx kouguKeiMamou)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4120: current T#)


(Subprograms)
(O490005, O900003)


(Passed arguments)
(#18, #28, #29, #31, #104, #105, #664, #665, #678)
%