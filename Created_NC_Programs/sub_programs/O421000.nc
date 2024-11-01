%
O421000 (last update on 20241101)
(Curved Outcut, ar, counterclockwise)

N0001
IF[#4012EQ54]GOTO0002
IF[#4012EQ55]GOTO0002
IF[#4012EQ56]GOTO0002
IF[#4012EQ57]GOTO0002
GOTO8000

N0002
IF[#24EQ#0]GOTO8000
IF[#24LT50]GOTO8000
IF[#25EQ#0]GOTO8000
IF[#25LT50]GOTO8000
IF[#21EQ#0]GOTO8000
IF[#22EQ#0]GOTO8000
IF[#26EQ#0]GOTO8000
IF[#06EQ#0]GOTO8000
IF[#06LT1]GOTO8000
IF[#17EQ#0]GOTO8000
IF[#17LT100]GOTO8000
IF[#18EQ#0]GOTO8000
IF[#18LT1]GOTO8000
(if X < 50 or #0, go to N8000)
(if Y < 50 or #0, go to N8000)
(if U = #0, go to N8000)
(if V = #0, go to N8000)
(if Z = #0, go to N8000)
(if Q < 100 or #0, go to N8000)
(if K < 1 or #0, go to N8000)
(if R < 1 or #0, go to N8000)

N0003
IF[#4012GE56]THEN #900038=-ROUND[1000*ASIN[[#26-[#06/2]]/#17]]/1000
IF[#4012LE55]THEN #900039=ROUND[1000*ASIN[[#26-[#06/2]]/#17]]/1000
IF[#900038GT0]GOTO8000
IF[#900039LT0]GOTO8000
(#900038: Top angle)
(#900039: Bot angle)
(if #900038 > 0, go to N8000)
(if #900039 < 0, go to N8000)

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

N0008
IF[#677EQ#0]GOTO8000
IF[#677LE10]GOTO8000
IF[#678EQ#0]GOTO8000
IF[#678LE10]GOTO8000
IF[#701EQ#0]GOTO8000
IF[#701LE200]GOTO8000
(if #677 <= 10 or #0, go to N8000)
(if #678 <= 10 or #0, go to N8000)
(if #701 <= 200 or #0, go to N8000)

N0011
IF[#24GE#21]GOTO8000
IF[#25GE#22]GOTO8000
IF[ABS[#415]GE10]GOTO8000
IF[ABS[#437]GE10]GOTO8000
IF[#4120EQ#0]GOTO8000
IF[#4120LT16]GOTO8000
IF[#4120GT20]GOTO8000
IF[[FIX[#4120]]NE#4120]GOTO8000
IF[[#26-#06]LE[#901011/2]]GOTO8000
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO8000
IF[ABS[#414]GE5]GOTO8000
IF[ABS[#436]GE5]GOTO8000
(if X >= U, go to N8000)
(if Y >= V, go to N8000)
(if |#415| >= 10, go to N8000)
(if |#437| >= 10, go to N8000)
(if T# < 16 or > 20 or not integer or #0, go to N8000)
(if Z-K <= #901011/2, go to N8000)
(if R >= min[X/4, Y/4], go to N8000)
(if |#414| >= 5, go to N8000)
(if |#436| >= 5, go to N8000)

N0013
#33=[#605+#[2400+#4120]+#[2600+#4120]+ABS[#605-[#[2400+#4120]+#[2600+#4120]]]]/2
IF[#33LE0]GOTO8000
(#33: max[#605, tool diameter compensation])

N0014
#32=#24+#415
#31=#25+#415
IF[#4012LE55]THEN #32=#24+#437
IF[#4012LE55]THEN #31=#25+#437
(compensation: outcut OD +compensation)


(kokokara G01)


N0015
G17
M11 (B-axis unclamp)
IF[#4012GE56]GOTO0016
IF[#4012LE55]GOTO0017
N0016 (for Top)
G91 G#4012 G00 B#900038
GOTO0018
N0017 (for Bot)
G91 G#4012 G00 B#900039
N0018
M10 (B-axis clamp)
G90 G43 G00 H#4120 Z[#26+#600]

N0019
#100=[#21-#32]*COS[#900038]
IF[#4012LE55]THEN #100=[#21-#32]*COS[#900039]
#101=#22-#31
#102=[#100+#101+ABS[#100-#101]]/2
#103=FUP[[#102-#628]/#627]
IF[#102LE#628]GOTO0026
IF[#103LT0]GOTO8000
(#102=max[#100, #101])
(#103: number of operation)
(if #102 <= #628, go to N0026)
(if #103 < 0, go to N0026)

N1000 (pre-finishing operation loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#32+#628+#627*#103
#105=#31+#628+#627*#103

N1001 (for Top)
IF[#4012LE55]GOTO1002
G90 G00 X[#900040-[#5261-#901001]+[#104/2]+#33*3+#414] Y[#105/2]
G90 G01 Z[#900041-#06+[#24/2]*SIN[#900038]] F#650
GOTO1003
N1002 (for Bot)
G90 G00 X[#900042-[#5221-#901005]+[#104/2]+#33*3-#436] Y[#105/2]
G90 G01 Z[#900043-#06+[#24/2]*SIN[#900039]] F#650

N1003
G42 D#4120
G91 G00 X-[#33/2] S#701

N1004
M03 (spindle on)
M08 (coolant on)

N1005 (for Top)
IF[#4012LE55]GOTO1006
G90 G01 X[#900040-[#5261-#901001]+[#104/2]+#414] Y[#105/2] Z[#900041-#06+[#24/2]*SIN[#900038]] F#651
G65 P491005 K1.0 B#900038 C#03 R#18 X#104 Y#105 D#33 F#677 E#678 S#701
G90 G40 G00 X[#900040-[#5261-#901001]+[#104/2]+#33*3+#414] Z[#900041-#06+[#24/2]*SIN[#900038]]
GOTO1007
N1006 (for Bot)
G90 G01 X[#900042-[#5221-#901005]+[#104/2]-#436] Y[#105/2] Z[#900043-#06+[#24/2]*SIN[#900039]] F#651
G65 P491005 K1.0 B#900039 C#03 R#18 X#104 Y#105 D#33 F#677 E#678 S#701
G90 G40 G00 X[#900042-[#5221-#901005]+[#104/2]+#33*3-#436] Z[#900043-#06+[#24/2]*SIN[#900039]]
N1007
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


N0026 (finishing operation)
IF[#4012GE56]THEN #32=#24+#415
IF[#4012LE55]THEN #32=#24+#437
IF[#4012GE56]THEN #31=#25+#415
IF[#4012LE55]THEN #31=#25+#437
(re-compensation: outcut OD +compensation)

IF[#4012GE56]THEN #106=FUP[#182]
IF[#4012LE55]THEN #106=FUP[#189]
(Top: #106=FUP[#182]. Bot: #106=FUP[#189])

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#628LE0]THEN #106=#106-1
(#106: number of finishing operation)


G90 G43 G01 H#4120 Z[#26+#600] F#650

N2000 (finishing operation loop)
WHILE[#106GE0]DO2
#106=#106-1

N2001 (for top)
IF[#4012LE55]GOTO2002
G90 G00 X[#900040-[#5261-#901001]+[#32/2]+#33*3+#414] Y[#31/2]
G90 G01 Z[#900041-#06+[#24/2]*SIN[#900038]] F#651
GOTO2003
N2002 (for Bot)
G90 G00 X[#900042-[#5221-#901005]+[#32/2]+#33*3-#436] Y[#31/2]
G90 G01 Z[#900043-#06+[#24/2]*SIN[#900039]] F#650

N2003
G42 D#4120
G91 G00 X-[#33/2] S#701

N2004
M03 (spindle on)
M08 (coolant on)

N2005 (for Top)
IF[#4012LE55]GOTO2006
G90 G01 X[#900040-[#5261-#901001]+[#32/2]+#414] Y[#31/2] Z[#900041-#06+[#24/2]*SIN[#900038]] F#651
G65 P491005 K1.0 B#900038 C#03 R#18 X#32 Y#31 D#33 F#677 E#678 S#701
G90 G40 G00 X[#900040-[#5261-#901001]+[#32/2]+#33*3+#414] Z[#900041-#06+[#24/2]*SIN[#900038]]
GOTO0027
N2006 (for Bot)
G90 G01 X[#900042-[#5221-#901005]+[#32/2]-#436] Y[#31/2] Z[#900043-#06+[#24/2]*SIN[#900039]] F#651
G65 P491005 K1.0 B#900039 C#03 R#18 X#32 Y#31 D#33 F#677 E#678 S#701
G90 G40 G00 X[#900042-[#5221-#901005]+[#32/2]+#33*3-#436] Z[#900043-#06+[#24/2]*SIN[#900039]]
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
(#03:C: outcut corner C)
(#06:K: outcut Length)
(#17:Q: center curvature)
(#18:R: outcut corner R)
(#21:U: AC OD)
(#22:V: BD OD)
(#24:X: AC outcut OD)
(#25:Y: BD outcut OD)
(#26:Z: re-alocation length)

(as LHS)
(#31, #32, #33)

(Common variable)
(as LHS)
(#102, #103, #104, #105, #106)
(as RHS)
(#182, #189)
(#414, #415, #416, #436, #437, #438)
(#600, #605, #627, #628, #650, #651, #677, #678, #701)
(#900038-#900043)
(#901001, #901005, #901011)

(System variables)
(#24xx: #xx tool diameter)
(#26xx: #xx tool diameter wear)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4120: current T#)

(Subprograms)
(O491005, O900003)

(Passed arguments)
(#18, #31, #32, #33, #104, #105, #677, #678, #701)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%