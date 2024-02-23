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
IF[#03EQ#0]GOTO800
IF[#03LT0.1]GOTO800
IF[#18EQ#0]GOTO800
IF[#18LT0.1]GOTO800
IF[#13EQ#0]GOTO800
IF[#13LT0]GOTO800
(if D = #0, go to N800)
(if X < 10 or #0, go to N800)
(if Y < 10 or #0, go to N800)
(if Z = #0, go to N800)
(if C < 0.1 or #0, go to N800)
(if R <= 0.1 or #0, go to N800)
(if M < 0 or #0, go to N800)

IF[#4012EQ57]THEN #33=#429
IF[#4012EQ55]THEN #33=#445
(Top: #33=#429. Bot: #33=#445)
(#33: X +hosei)

N002
IF[#19EQ#0]THEN #19=1800
(default: S=1800)

N006
IF[#690EQ#0]GOTO800
IF[#690LE10]GOTO800
IF[#691EQ#0]GOTO800
IF[#691LE10]GOTO800
IF[#19LT200]GOTO800
(if #690 <= 10 or #0, go to N800)
(if #691 <= 10 or #0, go to N800)
(if S < 200, go to N800)

N007
IF[#07LT11]GOTO800
IF[#07GT15]GOTO800
IF[[FIX[#07]]NE#07]GOTO800
IF[[#26-#03]LE[#901011/2]]GOTO800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO800
IF[#13GE#18]GOTO800
IF[[ABS[#33]]GE#18]GOTO800
IF[#606EQ#0]GOTO800
IF[#606LT1]GOTO800
IF[#606GE[#25/2]]GOTO800
IF[#634GT#633]GOTO800
(if D < 11 or D > 15 or D is not integer, go to N800)
(if Z-C <= #901011/2, go to N800)
(if R >= min[X/4, Y/4], go to N800)
(if M >= R, go to N800)
(if |#33| >= R, go to N800)
(if #606 < 1 or #606 >= Y/2 or #0, go to N800)
(if #634 > #633, go to N800)

IF[#07EQ11]THEN #32=#03*TAN[15]
IF[#07EQ12]THEN #32=#03*TAN[30]
IF[#07EQ13]THEN #32=#03

IF[#32LE#634]GOTO017
(if #32 <= #634, go to Shiage)
#103=FUP[[[#32*2]-#634]/#633]
IF[#103LT0]GOTO800
(#103: kakou kaisuu)


(kokokara G00)


N009
G90 G00 X#33 Y0
G90 G43 G01 H#07 Z[#26+#600] F#650
G90 G01 Z[#26-#03] S#19 F#677
(hosei kouguChou: #07)
(hosei Z: Z-C)

N010
M03 (spindle on)
M08 (coolant #1 on)

N100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#24-#634-#633*#103
#105=#25-#634-#633*#103

G65 P490007 D#07 X#104 Y#105 R#18 M#13 A#606 F#690 E#691 S#19
END1

N011 (pause)
IF[#4012EQ56]GOTO012
IF[#446EQ1]GOTO013
IF[#446EQ2]GOTO014
GOTO017
N013 (if #446=1)
M05 (spindle off)
M09 (coolant off)
G90 G01 Z[#26+#600] F#650
M00 (OK?)
GOTO017
N014 (if #446=2)
M05 (spindle off)
M09 (coolant off)
G65 P900003 (for Bot)
GOTO017

N012 (for Top)
IF[#430EQ1]GOTO015
IF[#430EQ2]GOTO016
GOTO017
N015 (if #430=1)
M05 (spindle off)
M09 (coolant off)
G90 G01 Z[#26+#600] F#650
M00 (OK?)
GOTO017
N016 (if #430=2)
M05 (spindle off)
M09 (coolant off)
G65 P900003 (for Top)


N017 (Shiage)
IF[#4012EQ57]THEN #33=#429
IF[#4012EQ55]THEN #33=#445
(Top: #33=#429, Bot: #33=#445)
(#33: X +hosei)

IF[#4012EQ57]THEN #106=FUP[#431]
IF[#4012EQ55]THEN #106=FUP[#447]
(Top: #106=FUP[#431], Bot: #106=FUP[#447])

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#634LE0]THEN #106=#106-1
(#106: Shiage kakou kaisuu)

G90 G00 X#33 Y0
G90 G43 G01 H#07 Z[#26+#600] F#650
G90 G01 Z[#26-#03] S#19 F#677
(hosei kouguChou: #07)
(hosei Z: Z-C)

M03 (spindle on)
M08 (coolant #1 on)


N200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

G65 P490007 D#07 X#24 Y#25 R#18 M#13 A#606 F#690 E#691 S#19
END2

G90 G01 X#33 Y0 F#677

N990
M05 (spindle off)
M09 (coolant off)

N991
S200
G90 G43 G01 H#07 Z[#26+#600] F#650
G90 G53 G01 Z0 F#650
GOTO999

N800
M05 (spindle off)
M09 (coolant off)
#3000=100 (are the arguments OK?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#03:C: mentori length C)
(#07:D: hosei kouguKei)
(#13:M: mekki mm)
(#18:R: corner R)
(#24:X: AC naikei)
(#25:Y: BD naikei)
(#26:Z: sai-furiwake)
(as received hidden arguments)
(#19:S: kaitenSuu)

(as LHS)
(#32, #33)


(Common variable)
(as LHS)
(#103, #104, #105, #106)
(as RHS)
(#429, #430, #431, #445, #446, #447, #600, #606, #633, #634, #650, #677, #691)
(#901011)


(System variables)
(#3000: alarm)
(#4012)


(Subprograms)
(O490007, O900003)


(Passed arguments)
(#07, #13, #18, #19, #24, #25, #104, #105, #606, #690, #691)
%