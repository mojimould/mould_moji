%
O440000 (last update on 20241018)
(Outer Chamfer, ar, counterclockwise)

N0001
IF[#26EQ#0]GOTO8000
IF[#06EQ#0]GOTO8000
IF[#06LT0.1]GOTO8000
IF[#18EQ#0]GOTO8000
IF[#18LT0.1]GOTO8000
(if X < 10 or #0, go to N8000)
(if Y < 10 or #0, go to N8000)
(if Z = #0, go to N8000)
(if K < 0.1 or #0, go to N8000)
(if R < 0.1 or #0, go to N8000)

N0003
IF[#01EQ0]GOTO0004
IF[#01EQ1]GOTO0004
GOTO8000

N0004
IF[#02EQ0]GOTO0005
IF[#02EQ1]GOTO0005
GOTO8000

N0005
IF[#01EQ1]GOTO0006
IF[#4012EQ56]THEN #24=#900003
IF[#4012EQ54]THEN #24=#900004
IF[#4012EQ56]THEN #25=#900009
IF[#4012EQ54]THEN #25=#900010
(XY into measurement values)

N0006
IF[#24EQ#0]GOTO8000
IF[#24LT50]GOTO8000
IF[#25EQ#0]GOTO8000
IF[#25LT50]GOTO8000

IF[#4012EQ56]THEN #33=#425
IF[#4012EQ54]THEN #33=#441
(Top: #33=#425, Bot: #33=#441)
(#33: X +compensation)


IF[#664EQ#0]GOTO8000
IF[#664LE10]GOTO8000
IF[#665EQ#0]GOTO8000
IF[#665LE10]GOTO8000
IF[#678EQ#0]GOTO8000
IF[#678LE200]GOTO8000
(if #664 <= 10 or #0, go to N8000)
(if #665 <= 10 or #0, go to N8000)
(if #678 <= 200 or #0, go to N8000)

N0007
IF[ABS[#426]GE10]GOTO8000
IF[ABS[#442]GE10]GOTO8000
IF[#4120EQ#0]GOTO8000
IF[#4120LT11]GOTO8000
IF[#4120GT15]GOTO8000
IF[[FIX[#4120]]NE#4120]GOTO8000
IF[[#26-#06]LE[#901011/2]]GOTO8000
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO8000
IF[ABS[#33]GE#18]GOTO8000
IF[#632GT#631]GOTO8000
(if |#426| >= 10, go to N8000)
(if T# < 11 or > 15 or not integer or #0, go to N8000)
(if Z-K <= #901011/2, go to N8000)
(if R >= min[X/4, Y/4], go to N8000)
(if |#33| >= R, go to N8000)
(if #632 > #631, go to N8000)

N0008
IF[#02NE0]GOTO0009
#32=#06
GOTO010

N0009 (if B=1)
IF[#4120EQ11]THEN #32=#06*[3+SQRT[3]-SQRT[6]-SQRT[2]]
IF[#4120EQ12]THEN #32=#06*[SQRT[3]-1]
IF[#4120EQ13]THEN #32=#06*[2-SQRT[2]]

N0010
#31=[#605+#[2400+#4120]+#[2600+#4120]+ABS[#605-[#[2400+#4120]+#[2600+#4120]]]]/2
IF[#31LE0]GOTO8000
(#31: max[#605, tool diameter compensation])

IF[#4012EQ56]THEN #30=SQRT[#17*#17-[#23-#32]*[#23-#32]]-SQRT[#17*#17-#23*#23]
IF[#4012EQ54]THEN #30=-SQRT[#17*#17-[#23-#32]*[#23-#32]]+SQRT[#17*#17-#23*#23]
IF[#01EQ1]THEN #30=0
(#30: X compensation from K)

IF[#4012EQ56]THEN #29=#24+#426
IF[#4012EQ54]THEN #29=#24+#442
IF[#4012EQ56]THEN #28=#25+#426
IF[#4012EQ54]THEN #28=#25+#442
(chamfer diameter: +compensation)

IF[#4120EQ11]THEN #27=#32*TAN[15]
IF[#4120EQ12]THEN #27=#32*TAN[30]
IF[#4120EQ13]THEN #27=#32

N0011
IF[#27LE#632]GOTO0019
(if #27 <= #632, go to N0019)
#103=FUP[[[#27*2]-#632]/#631]
IF[#103LT0]GOTO8000
(#103: number of operations)


(kokokara G01)


N0012
G90 G43 G01 H#4120 Z[#26+#600] F#650

N1000 (pre-finishing operation loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#29+#632+#631*#103
#105=#28+#632+#631*#103

N1001
G90 G00 X[[#104/2]+#31*3+#30+#33] Y[#105/2]
G42 D#4120
G91 G00 X-[#31/2]
G90 G01 Z[#26-#32] S#678 F#651

N1002
M03 (spindle on)
M08 (coolant on)

N1003
G90 G01 X[[#104/2]+#31*2+#30+#33] Y[#105/2] F#651
G65 P490005 K1.0 R#18 X#104 Y#105 D#31 F#664 E#665 S#678
G90 G40 G00 X[[#104/2]+#31*3+#30+#33]
END1


N0013 (pause)
IF[#4012EQ56]GOTO0014
IF[#443EQ0]GOTO0015
IF[#443EQ2]GOTO0016
GOTO0019
N0015 (if #443=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00 (OK?)
GOTO0019
N0016 (if #443=2)
G65 P900003 (for Bot)
GOTO0019

N0014 (for Top)
IF[#427EQ0]GOTO0017
IF[#427EQ2]GOTO0018
GOTO0019
N0017 (if #427=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00 (OK?)
GOTO0019
N0018 (if #427=2)
G65 P900003 (for Top)


N0019 (finishing operation)
IF[#4012EQ56]THEN #33=#425
IF[#4012EQ54]THEN #33=#441
(Top: #33=#425, Bot: #33=#441)
(#33: X +compensation)

IF[#4012EQ56]THEN #29=#24+#426
IF[#4012EQ54]THEN #29=#24+#442
IF[#4012EQ56]THEN #28=#25+#426
IF[#4012EQ54]THEN #28=#25+#442
(out chamfer diameter: +compensation)

IF[#4012EQ56]THEN #106=FUP[#184]
IF[#4012EQ54]THEN #106=FUP[#190]
(Top: #106=FUP[#184], Bot: #106=FUP[#190])

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#632LE0]THEN #106=#106-1
(#106: number of finishing operation)

N0020
G90 G43 G01 H#4120 Z[#26+#600] F#650

N2000 (finishing operation loop)
WHILE[#106GE0]DO2
#106=#106-1

N2001
G90 G00 X[[#29/2]+#31*3+#30+#33] Y[#28/2]
G42 D#4120
G91 G00 X-[#31/2]
G90 G01 Z[#26-#32] S#678 F#651

N2002
M03 (spindle on)
M08 (coolant on)

N2003
G90 G01 X[[#29/2]+#31*2+#30+#33] Y[#28/2] F#651
G65 P490005 K1.0 R#18 X#29 Y#28 D#31 F#664 E#665 S#678
G90 G40 G00 X[[#29/2]+#31*3+#30+#33]
END2

N9990
M09 (coolant off)
G90 G43 G01 H#4120 Z[#26+#600] F#650
IF[#4119GE2600]GOTO9991
S2599
GOTO9992
N9991
S6000

N9992
G90 G53 G01 Z0 F#650
G04 X1.5 (wait 1.5s)
M05 (spindle off)
S35
GOTO9999


N8000
M09 (coolant off)
S2599
G04 X2.0 (wait 2.0s)
M05 (spindle off)
S35
#3000=100 (are*the*arguments*OK?)

N9999
M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#01:A: outcut: 0:not exists, 1:exists)
(#02:B: chamfer type: 0:C, 1:R)
(#06:K: chamfer C or R length)
(#17:Q: central curvature)
(#18:R: outer or outcut corner R)
(#23:W: ori-alocation length)
(#24*:X: outcut AC OD)
(#25*:Y: outcut BD OD)
(#26:Z: re-alocation length)

(as LHS)
(#27, #28, #29, #30, #31, #32, #33)

(Common variable)
(as LHS)
(#103, #104, #105, #106)
(as RHS)
(#184, #190)
(#425, #426, #427, #441, #442, #443)
(#600, #605, #631, #632, #650, #651, #664, #665, #678)
(#900003, #900004, #900009, #900010, #901011)

(System variables)
(#24xx: #xx tool diameter)
(#26xx: #xx tool diameter wear)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4120: current T#)

(Subprograms)
(O490005, O900003)

(Passed arguments)
(#18, #28, #29, #31, #104, #105, #664, #665, #678)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%