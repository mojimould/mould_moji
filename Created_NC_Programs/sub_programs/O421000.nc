%
O421000 (last update on 20240611)
(Curved Gaisaku, ar HidariMawari 1shuu)

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
IF[#21EQ#0]GOTO0800
IF[#22EQ#0]GOTO0800
IF[#26EQ#0]GOTO0800
IF[#06EQ#0]GOTO0800
IF[#06LT1]GOTO0800
IF[#17EQ#0]GOTO0800
IF[#17LT100]GOTO0800
IF[#18EQ#0]GOTO0800
IF[#18LT1]GOTO0800
(if X < 50 or #0, go to N0800)
(if Y < 50 or #0, go to N0800)
(if U = #0, go to N0800)
(if V = #0, go to N0800)
(if Z = #0, go to N0800)
(if Q < 100 or #0, go to N0800)
(if K < 1 or #0, go to N0800)
(if R < 1 or #0, go to N0800)

N0003
IF[#4012GE56]THEN #900038=ROUND[1000*ASIN[[#26-[#06/2]]/#17]]/1000
IF[#4012LE55]THEN #900039=-ROUND[1000*ASIN[[#26-[#06/2]]/#17]]/1000
IF[#900038GT0]GOTO0800
IF[#900039LT0]GOTO0800
(#900038: Top angle)
(#900039: Bot angle)
(if #900038 > 0, go to N0800)
(if #900039 < 0, go to N0800)

N0004
IF[#1000NE0]GOTO0005
IF[#4012EQ57]THEN #900040=[#5281-#901001]*COS[#900038]-#26*SIN[#900038]
IF[#4012EQ57]THEN #900041=[#5281-#901001]*SIN[#900038]+#26*COS[#900038]
IF[#4012EQ56]THEN #900040=[#5261-#901001]*COS[#900038]-#26*SIN[#900038]
IF[#4012EQ56]THEN #900041=[#5261-#901001]*SIN[#900038]+#26*COS[#900038]
IF[#4012EQ55]THEN #900042=[#5241-#901001]*COS[#900039]-#26*SIN[#900039]
IF[#4012EQ55]THEN #900043=[#5241-#901001]*SIN[#900039]+#26*COS[#900039]
IF[#4012EQ54]THEN #900042=[#5221-#901001]*COS[#900039]-#26*SIN[#900039]
IF[#4012EQ54]THEN #900043=[#5221-#901001]*SIN[#900039]+#26*COS[#900039]
GOTO0006
N0005
IF[#4012EQ57]THEN #900040=[#5281-#901005]*COS[#900038]-#26*SIN[#900038]
IF[#4012EQ57]THEN #900041=[#5281-#901005]*SIN[#900038]+#26*COS[#900038]
IF[#4012EQ56]THEN #900040=[#5261-#901005]*COS[#900038]-#26*SIN[#900038]
IF[#4012EQ56]THEN #900041=[#5261-#901005]*SIN[#900038]+#26*COS[#900038]
IF[#4012EQ55]THEN #900042=[#5241-#901005]*COS[#900039]-#26*SIN[#900039]
IF[#4012EQ55]THEN #900043=[#5241-#901005]*SIN[#900039]+#26*COS[#900039]
IF[#4012EQ54]THEN #900042=[#5221-#901005]*COS[#900039]-#26*SIN[#900039]
IF[#4012EQ54]THEN #900043=[#5221-#901005]*SIN[#900039]+#26*COS[#900039]
(#900040: Top center X)
(#900041: Top center Z)
(#900042: Bot center X)
(#900043: Bot center Z)

N0006
IF[#13EQ#0]THEN #13=0
IF[#23EQ#0]THEN #23=0
IF[#13LT0]GOTO0800
IF[#23LT0]GOTO0800
(default: M=0)
(default: W=0)
(if M < 0, go to N0800)
(if W < 0, go to N0800)

N0008
IF[#660EQ#0]GOTO0800
IF[#660LE10]GOTO0800
IF[#661EQ#0]GOTO0800
IF[#661LE10]GOTO0800
IF[#676EQ#0]GOTO0800
IF[#676LE200]GOTO0800
(if #660 <= 10 or #0, go to N0800)
(if #661 <= 10 or #0, go to N0800)
(if #676 <= 200 or #0, go to N0800)

N0011
IF[#24GE#21]GOTO0800
IF[#25GE#22]GOTO0800
IF[ABS[#415]GE10]GOTO0800
IF[ABS[#437]GE10]GOTO0800
IF[#4120EQ#0]GOTO0800
IF[#4120LT16]GOTO0800
IF[#4120GT20]GOTO0800
IF[[FIX[#4120]]NE#4120]GOTO0800
IF[[#26-#06]LE[#901011/2]]GOTO0800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO0800
IF[ABS[#414]GE5]GOTO0800
IF[ABS[#436]GE5]GOTO0800
(if X >= U, go to N0800)
(if Y >= V, go to N0800)
(if |#415| >= 10, go to N0800)
(if |#437| >= 10, go to N0800)
(if T# < 16 or > 20 or not integer or #0, go to N0800)
(if Z-K <= #901011/2, go to N0800)
(if R >= min[X/4, Y/4], go to N0800)
(if |#414| >= 5, go to N0800)
(if |#436| >= 5, go to N0800)

N0012
#33=#06
IF[#06LE[#13+#23]]THEN #33=#13+1
(#33=K)
(if K <= M+W, #33=M+1)

N0013
#32=[#605+#[2400+#4120]+#[2600+#4120]+ABS[#605-[#[2400+#4120]+#[2600+#4120]]]]/2
IF[#32LE0]GOTO0800
(#32: max[#605, hosei kouguKei])

N0014
#31=#24+#415
#30=#25+#415
IF[#4012LE55]THEN #31=#24+#437
IF[#4012LE55]THEN #30=#25+#437
(hosei: gaisakuKei +hosei)

N0015
#100=[#21-#31]*COS[#900038]
IF[#4012LE55]THEN #100=[#21-#31]*COS[#900039]
#101=#22-#30
#102=[#100+#101+ABS[#100-#101]]/2
#103=FUP[[#102-#628]/#627]
IF[#102LE#628]GOTO0026
IF[#103LT0]GOTO0800
(#102=max[#100, #101])
(#103: kakou kaisuu)
(if #102 <= #628, go to N0026)
(if #103 < 0, go to N0026)


(kokokara G01)


N0016
G17
M11 (B-axis unclamp)
IF[#4012GE56]GOTO0017
IF[#4012LE55]GOTO0018
N0017 (for Top)
G91 G#4012 G00 B-#900038
GOTO0019
N0018 (for Bot)
G91 G#4012 G00 B-#900039
N0019
M10 (B-axis clamp)
G90 G43 G00 H#4120 Z[#26+#600]

N0100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#31+#628+#627*#103
#105=#30+#628+#627*#103

N0101 (for Top)
IF[#4012LE55]GOTO0102
G90 G00 X[#900040+[#104/2]+#32*3+#414] Y[#105/2] Z[#900041-#33]
GOTO0103
N0102 (for Bot)
G90 G00 X[#900042+[#104/2]+#32*3-#436] Y[#105/2] Z[#900043+#33]

N0103
G42 D#4120
G91 G00 X-[#32/2] S#676

N0104
M03 (spindle on)
M08 (coolant on)

N0105 (for Top)
IF[#4012LE55]GOTO0106
G90 G01 X[#900040+[#104/2]+#414] Y[#105/2] Z[#900041-#33] F#651
G65 P491005 K1.0 B-#900038 C#03 R#18 X#104 Y#105 D#32 F#660 E#661 S#676
G90 G40 G00 X[#900040+[#104/2]+#32*3+#414] Z[#900041-#33]
GOTO0017
N0106 (for Bot)
G90 G01 X[#900042+[#104/2]-#436] Y[#105/2] Z[#900043+#33] F#651
G65 P491005 K1.0 B-#900039 C#03 R#18 X#104 Y#105 D#32 F#660 E#661 S#676
G90 G40 G00 X[#900042+[#104/2]+#32*3-#436] Z[#900043+#33]
N0017
END1

N0020 (pause)
IF[#4012GE56]GOTO0021
IF[#438EQ0]GOTO0022
IF[#438EQ2]GOTO0023
GOTO0026

N0022 (if #438=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00 (for Bot)
N0023 (if #438=2)
M09 (coolant off)
G65 P900003 (for Bot)
GOTO0026

N0021 (for Top)
IF[#416EQ0]GOTO0024
IF[#416EQ2]GOTO0025
GOTO0026

N0024 (if #416=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00 (for Top)
N0025 (if #416=2)
G65 P900003 (for Top)


N0026 (Shiage)
IF[#4012GE56]THEN #31=#24+#415
IF[#4012LE55]THEN #31=#24+#437
IF[#4012GE56]THEN #30=#25+#415
IF[#4012LE55]THEN #30=#25+#437
(sai-hosei: gaisakuKei +hosei)

IF[#4012GE56]THEN #106=FUP[#182]
IF[#4012LE55]THEN #106=FUP[#189]
(Top: #106=FUP[#182]. Bot: #106=FUP[#189])

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#628LE0]THEN #106=#106-1
(#106: Shiage kakou kaisuu)


G90 G43 G01 H#4120 Z[#26+#600] F#650

N0200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

N0201 (for top)
IF[#4012LE55]GOTO0202
G90 G00 X[#900040+[#31/2]+#32*3+#414] Y[#30/2] Z[#900041-#33]
GOTO0203
N0202 (for Bot)
G90 G00 X[#900042+[#31/2]+#32*3-#436] Y[#30/2] Z[#900043+#33]

N0203
G42 D#4120
G91 G00 X-[#32/2] S#676

N0204
M03 (spindle on)
M08 (coolant on)

N0205 (for Top)
IF[#4012LE55]GOTO0206
G90 G01 X[#900040+[#31/2]+#414] Y[#30/2] Z[#900041-#33] F#651
G65 P491005 K1.0 B-#900038 C#03 R#18 X#31 Y#30 D#32 F#660 E#661 S#676
G90 G40 G00 X[#900040+[#31/2]+#32*3+#414] Z[#900041-#33]
GOTO0027
N0206 (for Bot)
G90 G01 X[#900042+[#31/2]-#436] Y[#30/2] Z[#900043+#33] F#651
G65 P491005 K1.0 B-#900039 C#03 R#18 X#31 Y#30 D#32 F#660 E#661 S#676
G90 G40 G00 X[#900042+[#31/2]+#32*3-#436] Z[#900043+#33]
N0027
END2

N9990
M09 (coolant off)
G90 G43 G01 H#4120 Z[#26+#600] F#650
S2599
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
(#03:C: gaisaku corner C)
(#06:K: gaisaku Length)
(#17:Q: center curvature)
(#18:R: gaisaku corner R)
(#21:U: AC gaiKei)
(#22:V: BD gaiKei)
(#24:X: AC gaisakukei)
(#25:Y: BD gaisakukei)
(#26:Z: sai-furiwake)
(as received hidden arguments)
(#13:M: mizoIchi)
(#23:W: mizoHaba)

(as LHS)
(#30, #31, #32, #33)

(Common variable)
(as LHS)
(#102, #103, #104, #105, #106)
(as RHS)
(#182, #189)
(#414, #415, #416, #436, #437, #438)
(#600, #605, #627, #628, #650, #651, #660, #661, #676)
(#900038-#900043)
(#901001, #901005, #901011)

(System variables)
(#24xx: #xx kouguKei)
(#26xx: #xx kouguKeiMamou)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4120: current T#)

(Subprograms)
(O491005, O900003)

(Passed arguments)
(#18, #30, #31, #32, #104, #105, #660, #661, #676)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%