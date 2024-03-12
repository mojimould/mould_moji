%
O450000
(Uchigawa Mentori Corner R, ac HidariMawari 1shuu)

N001
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#25EQ#0]GOTO800
IF[#25LT10]GOTO800
IF[#26EQ#0]GOTO800
IF[#18EQ#0]GOTO800
IF[#18LT0.1]GOTO800
IF[#13EQ#0]GOTO800
IF[#13LT0]GOTO800
IF[#06EQ#0]GOTO800
IF[#06LT0.1]GOTO800
IF[#17EQ#0]GOTO800
IF[#17LT1000]GOTO800
(if X < 10 or #0, go to N800)
(if Y < 10 or #0, go to N800)
(if Z = #0, go to N800)
(if R <= 0.1 or #0, go to N800)
(if M < 0 or #0, go to N800)
(if K < 0.1 or #0, go to N800)
(if Q < 1000 or #0, go to N800)

N002
IF[#606EQ#0]GOTO800
IF[#606LT1]GOTO800
IF[#666EQ#0]GOTO800
IF[#666LE10]GOTO800
IF[#667EQ#0]GOTO800
IF[#667LE10]GOTO800
IF[#679EQ#0]GOTO800
IF[#679LE200]GOTO800
(if #606 < 1 or #0, go to N800)
(if #666 <= 10 or #0, go to N800)
(if #667 <= 10 or #0, go to N800)
(if #679 <= 200, go to N800)

N003
IF[#02EQ0]GOTO004
IF[#02EQ1]GOTO004
GOTO800

N004
IF[#4012EQ57]THEN #33=1
IF[#4012EQ55]THEN #33=-1
IF[#4012EQ57]THEN #32=#430
IF[#4012EQ55]THEN #32=#446
(Top: #33=1, Bot: #33=-1)
(Top: #32=#430, Bot: #32=#446)
(#32: X +hosei)

IF[#02NE0]GOTO005
#31=#06
GOTO006
N005 (if B=1)
IF[#4120EQ11]THEN #31=#06*[3+SQRT[3]-SQRT[6]-SQRT[2]]
IF[#4120EQ12]THEN #31=#06*[SQRT[3]-1]
IF[#4120EQ13]THEN #31=#06*[2-SQRT[2]]

N006
#30=SQRT[#17*#17-[#23-#31]*[#23-#31]]-SQRT[#17*#17-#23*#23]
(#30: X hosei from K)

N007
IF[ABS[#431]GE10]GOTO800
IF[ABS[#447]GE10]GOTO800
IF[#4120EQ#0]GOTO800
IF[#4120LT11]GOTO800
IF[#4120GT15]GOTO800
IF[[FIX[#4120]]NE#4120]GOTO800
IF[[#26-#31]LE[#901011/2]]GOTO800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO800
IF[#13GE#18]GOTO800
IF[[ABS[#32]]GE#18]GOTO800
IF[[ABS[#30]]GE[#24/4]]GOTO800
IF[#606GE[#25/2]]GOTO800
IF[#634GT#633]GOTO800
(if T# < 11 or > 15 or not integer or #0, go to N800)
(if Z-#31 <= #901011/2, go to N800)
(if R >= min[X/4, Y/4], go to N800)
(if M >= R, go to N800)
(if |#32| >= R, go to N800)
(if |#30| >= X/4, go to N800)
(if #606 >= Y/2, go to N800)
(if #634 > #633, go to N800)

IF[#4012EQ57]THEN #29=#24+#431
IF[#4012EQ55]THEN #29=#24+#447
IF[#4012EQ57]THEN #28=#25+#431
IF[#4012EQ55]THEN #28=#25+#447
(mentoriKei: +hosei)

IF[#4120EQ11]THEN #27=#31*TAN[15]
IF[#4120EQ12]THEN #27=#31*TAN[30]
IF[#4120EQ13]THEN #27=#31

IF[#27LE#634]GOTO017
(if #27 <= #634, go to Shiage)
#103=FUP[[[#27*2]-#634]/#633]
IF[#103LT0]GOTO800
(#103: kakou kaisuu)


(kokokara G00)


N009
G90 G00 X[#33*#32] Y0
G90 G43 G01 H#4120 Z[#26+#600] F#650
G90 G01 Z#26 F#651
(X to hosei #32)
(hosei kouguChou: #4120)
(Z: Z)

G91 G01 X[#33*#30] Z-#31 S#679 F#651
(X to hosei #30)
(Z: Z-#31)

N010
M03 (spindle on)
M08 (coolant #1 on)

N100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#29-#634-#633*#103
#105=#28-#634-#633*#103

G65 P490007 D#4120 X#104 Y#105 R#18 M#13 A#606 F#666 E#667 S#679
END1

N011 (pause)
IF[#4012EQ57]GOTO012
IF[#448EQ0]GOTO013
IF[#448EQ2]GOTO014
GOTO017
N013 (if #448=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00 (OK?)
GOTO017
N014 (if #448=2)
G90 G01 Z[#26+#600] F#650
G65 P900003 (for Bot)
GOTO017

N012 (for Top)
IF[#432EQ0]GOTO015
IF[#432EQ2]GOTO016
GOTO017
N015 (if #432=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
M00 (OK?)
GOTO017
N016 (if #432=2)
G90 G01 Z[#26+#600] F#650
G65 P900003 (for Top)


N017 (Shiage)
IF[#4012EQ57]THEN #32=#430
IF[#4012EQ55]THEN #32=#446
(Top: #32=#430, Bot: #32=#446)
(#32: X +hosei)

IF[#4012EQ57]THEN #29=#24+#431
IF[#4012EQ55]THEN #29=#24+#447
IF[#4012EQ57]THEN #28=#25+#431
IF[#4012EQ55]THEN #28=#25+#447
(mentoriKei: +hosei)

IF[#4012EQ57]THEN #106=FUP[#185]
IF[#4012EQ55]THEN #106=FUP[#190]
(Top: #106=FUP[#185], Bot: #106=FUP[#190])

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#634LE0]THEN #106=#106-1
(#106: Shiage kakou kaisuu)

G90 G00 X[#33*#32] Y0
G90 G43 G01 H#4120 Z[#26+#600] F#650
G90 G01 Z#26 F#651
(X to hosei #32)
(hosei kouguChou: #4120)
(Z: Z)

G91 G01 X[#33*#30] Z-#31 S#679 F#651
(X to hosei #30)
(Z: Z-#31)

M03 (spindle on)
M08 (coolant #1 on)


N200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

G65 P490007 D#4120 X#29 Y#28 R#18 M#13 A#606 F#666 E#667 S#679
END2

N990
M09 (coolant off)

N991
G90 G43 G01 H#4120 Z[#26+#600] F#650
G90 G53 G01 Z0 F#650
M05 (spindle off)
GOTO999


N800
M09 (coolant off)
S2599
G04 X1.0 (wait 2.0s)
M05 (spindle off)
S35
#3000=100 (are the arguments OK?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#06:K: mentori C or R length)
(#13:M: mekki mm)
(#17:Q: central curvature)
(#18:R: corner R)
(#23:W: Bot ori_furiwake)
(#24:X: AC naikei)
(#25:Y: BD naikei)
(#26:Z: sai-furiwake)

(as LHS)
(#27, #30, #32, #33)


(Common variable)
(as LHS)
(#103, #104, #105, #106)
(as RHS)
(#185, #190, #430, #431, #432, #446, #447, #448, #600, #606, #633, #634, #650, #651, #666, #667, #679)
(#901011)


(System variables)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4120: current T#)


(Subprograms)
(O490007, O900003)


(Passed arguments)
(#07, #13, #18, #28, #29, #104, #105, #606, #666, #667, #679)
%