%
O441000 (last update on 20240611)
(Sotogawa Mentori Corner R, ar HidariMawari 1shuu)

N0001
IF[#4012EQ54]GOTO0002
IF[#4012EQ55]GOTO0002
IF[#4012EQ56]GOTO0002
IF[#4012EQ57]GOTO0002
GOTO0800

N0002
IF[#24EQ#0]GOTO0800
IF[#24LT50]GOTO0800
IF[#25EQ#0]GOTO0800
IF[#25LT50]GOTO0800
IF[#26EQ#0]GOTO0800
IF[#06EQ#0]GOTO0800
IF[#06LT0.1]GOTO0800
IF[#18EQ#0]GOTO0800
IF[#18LT0.1]GOTO0800
(if X < 10 or #0, go to N0800)
(if Y < 10 or #0, go to N0800)
(if Z = #0, go to N0800)
(if K < 0.1 or #0, go to N0800)
(if R < 0.1 or #0, go to N0800)

N0003
IF[#02EQ0]GOTO0005
IF[#02EQ1]GOTO0005
GOTO0800

N0005
IF[#664EQ#0]GOTO0800
IF[#664LE10]GOTO0800
IF[#665EQ#0]GOTO0800
IF[#665LE10]GOTO0800
IF[#678EQ#0]GOTO0800
IF[#678LE200]GOTO0800
(if #664 <= 10 or #0, go to N0800)
(if #665 <= 10 or #0, go to N0800)
(if #678 <= 200 or #0, go to N0800)

N0007
IF[ABS[#426]GE10]GOTO0800
IF[ABS[#442]GE10]GOTO0800
IF[#4120EQ#0]GOTO0800
IF[#4120LT11]GOTO0800
IF[#4120GT15]GOTO0800
IF[[FIX[#4120]]NE#4120]GOTO0800
IF[[#26-#06]LE[#901011/2]]GOTO0800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO0800
IF[ABS[#425]GE5]GOTO0800
IF[ABS[#441]GE5]GOTO0800
IF[#632GT#631]GOTO0800
(if |#426| >= 10, go to N0800)
(if T# < 11 or > 15 or not integer or #0, go to N0800)
(if Z-K <= #901011/2, go to N0800)
(if R >= min[X/4, Y/4], go to N0800)
(if |#425| >= 5, go to N0800)
(if |#441| >= 5, go to N0800)
(if #632 > #631, go to N0800)

N0008
IF[#02NE0]GOTO0009
#33=#06
GOTO010
N0009 (if B=1)
IF[#4120EQ11]THEN #33=#06*[3+SQRT[3]-SQRT[6]-SQRT[2]]
IF[#4120EQ12]THEN #33=#06*[SQRT[3]-1]
IF[#4120EQ13]THEN #33=#06*[2-SQRT[2]]

N0010
#32=[#605+#[2400+#4120]+#[2600+#4120]+ABS[#605-[#[2400+#4120]+#[2600+#4120]]]]/2
IF[#32LE0]GOTO0800
(#32: max[#605, hosei kouguKei])

#31=#24+#426
#30=#25+#426
IF[#4012LE55]THEN #31=#24+#442
IF[#4012LE55]THEN #30=#25+#442
(mentoriKei: +hosei)

IF[#4120EQ11]THEN #29=#33*TAN[15]
IF[#4120EQ12]THEN #29=#33*TAN[30]
IF[#4120EQ13]THEN #29=#33

N0011
IF[#29LE#632]GOTO0019
(if #29 <= #632, go to N0019)
#103=FUP[[[#29*2]-#632]/#631]
IF[#103LT0]GOTO0800
(#103: kakou kaisuu)


(kokokara G01)


N0012
G17
M11 (B-axis unclamp)
IF[#4012GE56]GOTO0017
IF[#4012LE55]GOTO0018
N0017
G91 G#4012 G00 B#900038
GOTO0019
N0018
G91 G#4012 G00 B#900039
N0019
M10 (B-axis clamp)
G90 G43 G00 H#4120 Z[#26+#600]

N0100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#31+#632+#631*#103
#105=#30+#632+#631*#103

N0101 (for Top)
IF[#4012LE55]GOTO0102
G90 G00 X[#900040-[#5261-#901001]+[#104/2]+#32*3+#425] Y[#105/2]
G90 G01 Z[#900041-#33] F#650
GOTO0103
N0102 (for Bot)
G90 G00 X[#900042-[#5221-#901005]+[#104/2]+#32*3+#441] Y[#105/2]
G90 G01 Z[#900043+#33] F#650

N0103
G42 D#4120
G91 G00 X-[#32/2] S#678

N0104
M03 (spindle on)
M08 (coolant on)

N0105 (for Top)
IF[#4012LE55]GOTO0106
G90 G01 X[#900040-[#5261-#901001]+[#104/2]+#425] Y[#105/2] Z[#900041-#33] F#651
G65 P491005 K1.0 B#900038 C#03 R#18 X#104 Y#105 D#32 F#664 E#665 S#678
G90 G40 G00 X[#900040-[#5261-#901001]+[#104/2]+#32*3+#425] Z[#900041-#33]
GOTO0017
N0106 (for Bot)
G90 G01 X[#900042-[#5221-#901005]+[#104/2]+#441] Y[#105/2] Z[#900043+#33] F#651
G65 P491005 K1.0 B#900039 C#03 R#18 X#104 Y#105 D#32 F#664 E#665 S#678
G90 G40 G00 X[#900042-[#5221-#901005]+[#104/2]+#32*3+#441] Z[#900043+#33]
N0017
END1

N0013 (pause)
IF[#4012GE56]GOTO0014
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


N0019 (Shiage)
IF[#4012EQ56]THEN #31=#24+#426
IF[#4012EQ54]THEN #31=#24+#442
IF[#4012EQ56]THEN #30=#25+#426
IF[#4012EQ54]THEN #30=#25+#442
(mentoriKei: +hosei)

IF[#4012EQ56]THEN #106=FUP[#184]
IF[#4012EQ54]THEN #106=FUP[#190]
(Top: #106=FUP[#184], Bot: #106=FUP[#190])

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#632LE0]THEN #106=#106-1
(#106: Shiage kakou kaisuu)

N0020
G90 G43 G01 H#4120 Z[#26+#600] F#650

N0200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

N0201 (for top)
IF[#4012LE55]GOTO0202
G90 G00 X[#900040-[#5261-#901001]+[#31/2]+#32*3+#425] Y[#30/2]
G90 G01 Z[#900041-#33] F#650
GOTO0203
N0202 (for Bot)
G90 G00 X[#900042-[#5221-#901005]+[#31/2]+#32*3+#441] Y[#30/2]
G90 G01 Z[#900043+#33] F#650

N0203
G42 D#4120
G91 G00 X-[#32/2] S#676

N0204
M03 (spindle on)
M08 (coolant on)

N0205 (for Top)
IF[#4012LE55]GOTO0106
G90 G01 X[#900040-[#5261-#901001]+[#31/2]+#425] Y[#30/2] Z[#900041-#33] F#651
G65 P491005 K1.0 B#900038 C#03 R#18 X#31 Y#30 D#32 F#664 E#665 S#678
G90 G40 G00 X[#900040-[#5261-#901001]+[#31/2]+#32*3+#425] Z[#900041-#33]
GOTO0017
N0106 (for Bot)
G90 G01 X[#900042-[#5221-#901005]+[#31/2]+#441] Y[#30/2] Z[#900043+#33] F#651
G65 P491005 K1.0 B#900039 C#03 R#18 X#31 Y#30 D#32 F#664 E#665 S#678
G90 G40 G00 X[#900042-[#5221-#901005]+[#31/2]+#32*3+#441] Z[#900043+#33]
N0017
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
(#02:B: mentori type: 0:C, 1:R)
(#06:K: mentori C or R length)
(#18:R: gaisaku corner R)
(#24:X: AC gaisakuKei)
(#25:Y: BD gaisakuKei)
(#26:Z: sai-furiwake)

(as LHS)
(#29, #30, #31, #32, #33)

(Common variable)
(as LHS)
(#103, #104, #105, #106)
(as RHS)
(#184, #190)
(#425, #426, #427, #441, #442, #443)
(#600, #605, #631, #632, #650, #651, #664, #665, #678)
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
(#18, #30, #31, #32, #104, #105, #664, #665, #678)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%