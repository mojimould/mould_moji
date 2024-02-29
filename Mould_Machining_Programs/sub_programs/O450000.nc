%
O450000
(Uchigawa Mentori Corner R, ac HidariMawari 1shuu)

N001
IF[#07EQ#0]GOTO800
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#25EQ#0]GOTO800
IF[#25LT10]GOTO800
IF[#26EQ#0]GOTO800
IF[#18EQ#0]GOTO800
IF[#18LT0.1]GOTO800
IF[#13EQ#0]GOTO800
IF[#13LT0]GOTO800
IF[#03EQ#0]GOTO800
IF[#03LT0.1]GOTO800
IF[#17EQ#0]GOTO800
IF[#17LT1000]GOTO800
(if D = #0, go to N800)
(if X < 10 or #0, go to N800)
(if Y < 10 or #0, go to N800)
(if Z = #0, go to N800)
(if R <= 0.1 or #0, go to N800)
(if M < 0 or #0, go to N800)
(if C < 0.1 or #0, go to N800)
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

N006
IF[#4012EQ57]THEN #33=1
IF[#4012EQ55]THEN #33=-1
IF[#4012EQ57]THEN #32=#429
IF[#4012EQ55]THEN #32=#445
(Top: #33=1, Bot: #33=-1)
(Top: #32=#429, Bot: #32=#445)
(#32: X +hosei)

#31=SQRT[#17*#17-[#23-#03]*[#23-#03]]-SQRT[#17*#17-#23*#23]
(#29: X hosei from C)

N007
IF[#07LT11]GOTO800
IF[#07GT15]GOTO800
IF[[FIX[#07]]NE#07]GOTO800
IF[[#26-#03]LE[#901011/2]]GOTO800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO800
IF[#13GE#18]GOTO800
IF[[ABS[#32]]GE#18]GOTO800
IF[[ABS[#31]]GE[#24/4]]GOTO800
IF[#606GE[#25/2]]GOTO800
IF[#634GT#633]GOTO800
(if D < 11 or D > 15 or D is not integer, go to N800)
(if Z-C <= #901011/2, go to N800)
(if R >= min[X/4, Y/4], go to N800)
(if M >= R, go to N800)
(if |#32| >= R, go to N800)
(if |#31| >= X/4, go to N800)
(if #606 >= Y/2, go to N800)
(if #634 > #633, go to N800)

IF[#07EQ11]THEN #30=#03*TAN[15]
IF[#07EQ12]THEN #30=#03*TAN[30]
IF[#07EQ13]THEN #30=#03

IF[#30LE#634]GOTO017
(if #30 <= #634, go to Shiage)
#103=FUP[[[#30*2]-#634]/#633]
IF[#103LT0]GOTO800
(#103: kakou kaisuu)


(kokokara G00)


N009
G90 G00 X[#33*#32] Y0
G90 G43 G01 H#07 Z[#26+#600] F#650
G90 G01 Z#26 F#651
(X to hosei #32)
(hosei kouguChou: #07)
(Z: Z)

G91 G01 X[#33*#31] Z-#03 S#679 F#651
(X to hosei #31)
(Z: Z-C)

N010
M03 (spindle on)
M08 (coolant #1 on)

N100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#24-#634-#633*#103
#105=#25-#634-#633*#103

G65 P490007 D#07 X#104 Y#105 R#18 M#13 A#606 F#666 E#667 S#679
END1

N011 (pause)
IF[#4012EQ56]GOTO012
IF[#446EQ1]GOTO013
IF[#446EQ2]GOTO014
GOTO017
N013 (if #446=1)
M09 (coolant off)
S6000
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S200
M00 (OK?)
GOTO017
N014 (if #446=2)
G65 P900003 (for Bot)
GOTO017

N012 (for Top)
IF[#430EQ1]GOTO015
IF[#430EQ2]GOTO016
GOTO017
N015 (if #430=1)
M09 (coolant off)
S6000
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
M00 (OK?)
GOTO017
N016 (if #430=2)
G65 P900003 (for Top)


N017 (Shiage)
IF[#4012EQ57]THEN #32=#429
IF[#4012EQ55]THEN #32=#445
(Top: #32=#429, Bot: #32=#445)
(#32: X +hosei)

IF[#4012EQ57]THEN #106=FUP[#431]
IF[#4012EQ55]THEN #106=FUP[#447]
(Top: #106=FUP[#431], Bot: #106=FUP[#447])

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#634LE0]THEN #106=#106-1
(#106: Shiage kakou kaisuu)

G90 G00 X[#33*#32] Y0
G90 G43 G01 H#07 Z[#26+#600] F#650
G90 G01 Z#26 F#651
(X to hosei #32)
(hosei kouguChou: #07)
(Z: Z)

G91 G01 X[#33*#31] Z-#03 S#679 F#651
(X to hosei #31)
(Z: Z-C)

M03 (spindle on)
M08 (coolant #1 on)


N200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

G65 P490007 D#07 X#24 Y#25 R#18 M#13 A#606 F#666 E#667 S#679
END2

N990
M09 (coolant off)
S6000

N991
G90 G43 G01 H#07 Z[#26+#600] F#650
G90 G53 G01 Z0 F#650
M05 (spindle off)
S200
GOTO999

N800
M09 (coolant off)
S6000
G04 X1.0 (wait 2.0s)
M05 (spindle off)
S200
#3000=100 (are the arguments OK?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#03:C: mentori length C)
(#07:D: hosei kouguKei)
(#13:M: mekki mm)
(#17:Q: central curvature)
(#18:R: corner R)
(#23:W: Bot ori_furiwake)
(#24:X: AC naikei)
(#25:Y: BD naikei)
(#26:Z: sai-furiwake)

(as LHS)
(#30, #31, #32, #33)


(Common variable)
(as LHS)
(#103, #104, #105, #106)
(as RHS)
(#429, #430, #431, #445, #446, #447, #600, #606, #633, #634, #650, #651, #666, #667, #679)
(#901011)


(System variables)
(#3000: alarm)
(#4012)


(Subprograms)
(O490007, O900003)


(Passed arguments)
(#07, #13, #18, #24, #25, #104, #105, #606, #666, #667, #679)
%