%
O440000
(Sotogawa Mentori Corner R, ar HidariMawari 1shuu)

N001
IF[#07EQ#0]GOTO800
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#25EQ#0]GOTO800
IF[#25LT10]GOTO800
IF[#26EQ#0]GOTO800
IF[#03EQ#0]GOTO800
IF[#03LT0.1]GOTO800
IF[#13LT0]GOTO800
IF[#18EQ#0]GOTO800
IF[#18LT0.1]GOTO800
(if D = #0, go to N800)
(if X < 10 or #0, go to N800)
(if Y < 10 or #0, go to N800)
(if Z = #0, go to N800)
(if C < 0.1 or #0, go to N800)
(if R < 0.1 or #0, go to N800)

N002
IF[#4012EQ56]THEN #33=#425
IF[#4012EQ54]THEN #33=#441
(Top: #33=#425. Bot: #33=#441)
(#33: X +hosei)

N004
IF[#664EQ#0]GOTO800
IF[#664LE10]GOTO800
IF[#665EQ#0]GOTO800
IF[#665LE10]GOTO800
IF[#678EQ#0]GOTO800
IF[#678LE200]GOTO800
(if #664 <= 10 or #0, go to N800)
(if #665 <= 10 or #0, go to N800)
(if #678 <= 200 or #0, go to N800)

N005
IF[#07LT11]GOTO800
IF[#07GT15]GOTO800
IF[[FIX[#07]]NE#07]GOTO800
IF[[#26-#03]LE[#901011/2]]GOTO800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO800
IF[ABS[#33]GE#18]GOTO800
IF[#632GT#631]GOTO800
(if D < 11 or D > 15 or D is not integer, go to N800)
(if Z-C <= #901011/2, go to N800)
(if R >= min[X/4, Y/4], go to N800)
(if |#33| >= R, go to N800)
(if #632 > #631, go to N800)

N006
#32=#[#2400+#07]+#[#2600+#07]
#31=[#605+#32+ABS[#605-#32]]/2
IF[#31LE0]GOTO800
(#31: max[#605, hosei kouguKei])

IF[#07EQ11]THEN #30=#03*TAN[15]
IF[#07EQ12]THEN #30=#03*TAN[30]
IF[#07EQ13]THEN #30=#03

N007
IF[#30LE#632]GOTO016
(if #30 <= #632, go to N016)
#103=FUP[[[#30*2]-#632]/#631]
IF[#103LT0]GOTO800
(#103: kakou kaisuu)


(kokokara G00)


N008
G90 G43 G01 H#07 Z[#26+#600] F#650

N100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#24+#632+#631*#103
#105=#25+#632+#631*#103

N101
G90 G00 X[[#104/2]+#31*3+#33] Y[#105/2]
G42 D#07
G91 G00 X-[#31/2]
G90 G01 Z[#26-#03] S#678 F#651

N102
M03 (spindle on)
M08 (coolant on)

N103
G90 G01 X[[#104/2]+#31*2+#33] Y[#105/2] F#651
G65 P490005 K1. R#18 X#104 Y#105 D#31 F#664 E#665 S#678
G90 G40 G00 X[[#104/2]+#31*3+#33]
END1


N010 (pause)
IF[#4012EQ56]GOTO011
IF[#442EQ1]GOTO012
IF[#442EQ2]GOTO013
GOTO016
N012 (if #442=1)
M09 (coolant off)
S6000
G90 G01 Z[#26+#600] F#650
G04 X1.0s (wait 1.0s)
M05 (spindle off)
S200
M00 (OK?)
GOTO016
N013 (if #442=2)
G65 P900003 (for Bot)
GOTO016
N011 (for Top)
IF[#426EQ1]GOTO014
IF[#426EQ2]GOTO015
GOTO016
N014 (if #426=1)
M09 (coolant off)
S6000
G90 G01 Z[#26+#600] F#650
G04 X1.0s (wait 1.0s)
M05 (spindle off)
S200
M00 (OK?)
GOTO016
N015 (if #426=2)
G65 P900003 (for Top)


N016 (Shiage)
IF[#4012EQ56]THEN #33=#425
IF[#4012EQ54]THEN #33=#441
(Top: #33=#425, Bot: #33=#441)
(#33: X +hosei)

IF[#4012EQ56]THEN #106=FUP[#427]
IF[#4012EQ54]THEN #106=FUP[#443]
(Top: #106=FUP[#427], Bot: #106=FUP[#443])

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#632LE0]THEN #106=#106-1
(#106: Shiage kakou kaisuu)

N017
G90 G43 G01 H#07 Z[#26+#600] F#650

N200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

N201
G90 G00 X[[#24/2]+#31*3+#33] Y[#25/2]
G42 D#07
G91 G00 X-[#31/2]
G90 G01 Z[#26-#03] S#678 F#651

N202
M03 (spindle on)
M08 (coolant on)

N203
G90 G01 X[[#24/2]+#31*2+#33] Y[#25/2] F#651
G65 P490005 K1. R#18 X#24 Y#25 D#31 F#664 E#665 S#678
G90 G40 G00 X[[#24/2]+#31*3+#33]
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
(#03:C: mentori C)
(#07:D: kouguKei&Chou hosei)
(#18:R: corner R)
(#24:X: AC gaikei)
(#25:Y: BD gaikei)
(#26:Z: sai-furiwake)

(as LHS)
(#30, #31, #32, #33)


(Common variable)
(as LHS)
(#103, #104, #105, #106)
(as RHS)
(#425, #426, #427, #441, #442, #443, #600, #605, #631, #632, #650, #651, #664, #665, #678)
(#901011)


(System variables)
(#24xx: #xx kouguKei)
(#26xx: #xx kouguKeiMamou)
(#3000: alarm)
(#4012: current work coordinate G#)


(Subprograms)
(O490005, O900003)


(Passed arguments)
(#18, #24, #25, #31, #104, #105, #664, #665, #678)
%