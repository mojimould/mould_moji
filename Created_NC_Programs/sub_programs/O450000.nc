%
O450000 (last update on 20240625)
(Uchigawa Mentori Corner R, ac HidariMawari 1shuu)

N0001
IF[#4012EQ55]GOTO0002
IF[#4012EQ57]GOTO0002
GOTO0800

N0002
IF[#26EQ#0]GOTO0800
IF[#18EQ#0]GOTO0800
IF[#18LT1]GOTO0800
IF[#13LT0]GOTO0800
IF[#13GE1]GOTO0800
IF[#06EQ#0]GOTO0800
IF[#06LT0.1]GOTO0800
IF[#17EQ#0]GOTO0800
IF[#17LT1000]GOTO0800
(if Z = #0, go to N0800)
(if R < 1 or #0, go to N0800)
(if M < 0 or >= 1, go to N0800)
(if K < 0.1 or #0, go to N0800)
(if Q < 1000 or #0, go to N0800)

N0003
IF[ABS[#195]GE1]GOTO0800
IF[ABS[#196]GE1]GOTO0800
IF[#606EQ#0]GOTO0800
IF[#606LT1]GOTO0800
IF[#666EQ#0]GOTO0800
IF[#666LE10]GOTO0800
IF[#667EQ#0]GOTO0800
IF[#667LE10]GOTO0800
IF[#679EQ#0]GOTO0800
IF[#679LE200]GOTO0800
(if |#195| >= 1, go to N0800)
(if |#196| >= 1, go to N0800)
(if #606 < 1 or #0, go to N0800)
(if #666 <= 10 or #0, go to N0800)
(if #667 <= 10 or #0, go to N0800)
(if #679 <= 200, go to N0800)

N0004
IF[#24LE30]THEN #24=#0
IF[#25LE30]THEN #25=#0

N0005
IF[#01EQ#0]GOTO0006
IF[#01EQ0]GOTO0006
IF[#01EQ1]GOTO0006
GOTO0800

N0006
IF[#02EQ0]GOTO0007
IF[#02EQ1]GOTO0007
GOTO0800

N0007
IF[#01EQ1]GOTO0008
#24=#900018
#25=#900024
IF[#4012EQ55]THEN #24=#900019
IF[#4012EQ55]THEN #25=#900025
IF[#24EQ#0]GOTO0800
IF[#24LT10]GOTO0800
IF[#25EQ#0]GOTO0800
IF[#25LT10]GOTO0800
(XY into measurement values)
(if X < 10 or #0, go to N0800)
(if Y < 10 or #0, go to N0800)

N0008
#33=1
#32=#430
IF[#4012EQ55]THEN #33=-1
IF[#4012EQ55]THEN #32=#446
(Top: #33=1, Bot: #33=-1)
(Top: #32=#430, Bot: #32=#446)
(#32: X +hosei)

IF[#02NE0]GOTO0009
#31=#06
GOTO0010
N0009 (if B=1)
IF[#4120EQ11]THEN #31=#06*[3+SQRT[3]-SQRT[6]-SQRT[2]]
IF[#4120EQ12]THEN #31=#06*[SQRT[3]-1]
IF[#4120EQ13]THEN #31=#06*[2-SQRT[2]]

N0010
#30=SQRT[#17*#17-[#23-#31]*[#23-#31]]-SQRT[#17*#17-#23*#23]
IF[#01EQ1]THEN #30=0
(#30: X hosei from K)

N0011
IF[ABS[#431]GE10]GOTO0800
IF[ABS[#447]GE10]GOTO0800
IF[#4120EQ#0]GOTO0800
IF[#4120LT11]GOTO0800
IF[#4120GT15]GOTO0800
IF[[FIX[#4120]]NE#4120]GOTO0800
IF[[#26-#31]LE[#901011/2]]GOTO0800
IF[[#18+#13]GE[[#24+#25-ABS[#24-#25]]/8]]GOTO0800
IF[[ABS[#32]]GE[#18+#13]]GOTO0800
IF[[ABS[#30]]GE[#24/4]]GOTO0800
IF[#606GE[#25/2]]GOTO0800
IF[#634GT#633]GOTO0800
(if T# < 11 or > 15 or not integer or #0, go to N0800)
(if Z-#31 <= #901011/2, go to N0800)
(if R+M >= min[X/4, Y/4], go to N0800)
(if |#32| >= R+M, go to N0800)
(if |#30| >= X/4, go to N0800)
(if #606 >= Y/2, go to N0800)
(if #634 > #633, go to N0800)

N0012
#29=#24+#431
#28=#25+#431
IF[#4012EQ55]THEN #29=#24+#447
IF[#4012EQ55]THEN #28=#25+#447
(mentoriKei: +hosei)

N0013
IF[#4120EQ11]THEN #27=#31*TAN[15]
IF[#4120EQ12]THEN #27=#31*TAN[30]
IF[#4120EQ13]THEN #27=#31

N0014
IF[#27LE#634]GOTO0030
(if #27 <= #634, go to Shiage)
#103=FUP[[[#27*2]-#634]/#633]
IF[#103LT0]GOTO0800
(#103: kakou kaisuu)


(kokokara G00)


N0015
G90 G00 X#32 Y0
G90 G43 G01 H#4120 Z[#26+#600] F#650
G90 G01 Z#26 F#651
(X to hosei #32)
(hosei kouguChou: #4120)
(Z: Z)

N0016
G91 G01 X[#33*#30] Z-#31 S#679 F#651
(X to hosei #30)
(Z: Z-#31)

N0017
M03 (spindle on)
M08 (coolant #1 on)

N0100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#29-#634-#633*#103
#105=#28-#634-#633*#103

N0101 (for Top)
IF[#4012EQ55]GOTO0102
G65 P490007 D#4120 X#104 Y#105 R[#18+#13+#195] A#606 F#666 E#667 S#679
GOTO0103
N0102 (for Bot)
G65 P490007 D#4120 X#104 Y#105 R[#18+#13+#196] A#606 F#666 E#667 S#679
N0103
END1

N0024 (pause)
IF[#4012EQ57]GOTO0025
IF[#448EQ0]GOTO0026
IF[#448EQ2]GOTO0027
GOTO0030
N0026 (if #448=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00 (OK?)
GOTO0030
N0027 (if #448=2)
M09 (coolant off)
G90 G01 Z[#26+#600] F#650
G65 P900003 (for Bot)
GOTO0030

N0025 (for Top)
IF[#432EQ0]GOTO0028
IF[#432EQ2]GOTO0029
GOTO0030
N0028 (if #432=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
M00 (OK?)
GOTO0030
N0029 (if #432=2)
M09 (coolant off)
G90 G01 Z[#26+#600] F#650
G65 P900003 (for Top)


N0030 (Shiage)
#32=#430
IF[#4012EQ55]THEN #32=#446
(Top: #32=#430, Bot: #32=#446)
(#32: X +hosei)

N0031
#29=#24+#431
#28=#25+#431
IF[#4012EQ55]THEN #29=#24+#447
IF[#4012EQ55]THEN #28=#25+#447
(mentoriKei: +hosei)

N0032
#106=FUP[#185]
IF[#4012EQ55]THEN #106=FUP[#191]
(Top: #106=FUP[#185], Bot: #106=FUP[#191])

N0033
IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#634LE0]THEN #106=#106-1
(#106: Shiage kakou kaisuu)

N0034
G90 G00 X#32 Y0
G90 G43 G01 H#4120 Z[#26+#600] F#650
G90 G01 Z#26 F#651
(X to hosei #32)
(hosei kouguChou: #4120)
(Z: Z)

N0035
G91 G01 X[#33*#30] Z-#31 S#679 F#651
(X to hosei #30)
(Z: Z-#31)

N0036
M03 (spindle on)
M08 (coolant #1 on)


N0200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

N0201 (for Top)
IF[#4012EQ55]GOTO0202
G65 P490007 D#4120 X#29 Y#28 R[#18+#13+#195] A#606 F#666 E#667 S#679
GOTO0203
N0202 (for Bot)
G65 P490007 D#4120 X#29 Y#28 R[#18+#13+#196] A#606 F#666 E#667 S#679
N0203
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


N0800
M09 (coolant off)
S2599
G04 X2.0 (wait 2.0s)
M05 (spindle off)
S35
#3000=100 (are*the*arguments*OK?)

N9999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#01:A: naisaku: 0:none, 1:exist)
(#02:B: mentori type: 0:C, 1:R)
(#06:K: mentori C or R length)
(#13:M: mekki thickness mm)
(#17:Q: central curvature)
(#18:R: corner R)
(#23:W: ori_furiwake)
(#24*:X: AC naisakuKei)
(#25*:Y: BD naisakuKei)
(#26:Z: sai-furiwake)

(as LHS)
(#27, #28, #29, #30, #31, #32, #33)

(Common variable)
(as LHS)
(#103, #104, #105, #106)
(as RHS)
(#185, #191)
(#430, #431, #432, #446, #447, #448)
(#600, #606, #633, #634, #650, #651, #666, #667, #679)
(#901011, #900018, #900019, #900024, #900025)

(System variables)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4120: current T#)

(Subprograms)
(O490007, O900003)

(Passed arguments)
(#07, #18, #28, #29, #104, #105, #606, #666, #667, #679)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%