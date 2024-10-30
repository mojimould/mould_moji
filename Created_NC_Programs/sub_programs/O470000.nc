%
O470000 (last update on 20241030)
(Incut boring, ar, Counterclockwise)

N0001
IF[#24EQ#0]GOTO0800
IF[#24LT10]GOTO0800
IF[#25EQ#0]GOTO0800
IF[#25LT10]GOTO0800
IF[#26EQ#0]GOTO0800
IF[#06EQ#0]GOTO0800
IF[#06LT1]GOTO0800
IF[#18EQ#0]GOTO0800
IF[#18LT0.1]GOTO0800
(if X < 10 or #0, go to N0800)
(if Y < 10 or #0, go to N0800)
(if U = #0, go to N0800)
(if V = #0, go to N0800)
(if Z = #0, go to N0800)
(if K < 1 or #0, go to N0800)
(if R < 0.1 or #0, go to N0800)

N0002
IF[#670EQ#0]GOTO0800
IF[#670LE10]GOTO0800
IF[#671EQ#0]GOTO0800
IF[#671LE10]GOTO0800
IF[#706EQ#0]GOTO0800
IF[#706LE200]GOTO0800
(if #670 <= 10 or #0, go to N0800)
(if #671 <= 10 or #0, go to N0800)
(if #706 <= 200 or #0, go to N0800)

N0003
IF[ABS[#485]GE10]GOTO0800
IF[#4120EQ#0]GOTO0800
IF[#4120LT16]GOTO0800
IF[#4120GT20]GOTO0800
IF[[FIX[#4120]]NE#4120]GOTO0800
IF[[#26-#06]LE[#901011/2]]GOTO0800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO0800
IF[ABS[#484]GE#18]GOTO0800
(if |#485| >= 10, go to N0800)
(if T# < 16 or > 20 or not integer or #0, go to N0800)
(if Z-K <= #901011/2, go to N0800)
(if R >= min[X/4, Y/4], go to N0800)
(if |#484| >= R, go to N0800)

N0004
#30=#24+#485
#29=#25+#485
(compensation: incut ID +compensation)

N0005
#100=#30-#900018
#101=#29-#900024
#102=[#100+#101+ABS[#100-#101]]/2
(#102=max[#100, #101])
IF[#102LE#638]GOTO0016
(if #102 <= #638, go to N0016)
#103=FUP[[#102-#638]/#637]
IF[#103LT0]GOTO0800
(#103: number of operationss)


(kokokara G01)


N0006
G90 G00 X#484 Y0
G90 G43 G01 H#4120 Z[#26+#600] F#650
G90 G01 Z[#26-#06] S#706 F#651
(X to compensation #484)
(tool lengthcompensation: #4120)
(Z: Z-K)

N0007
M03 (spindle on)
M08 (coolant on)

N0100 (pre-finishing operation loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#30-#638-#637*#103
#105=#29-#638-#637*#103

N0103
G65 P490007 D#4120 X#104 Y#105 R#18 A#606 F#670 E#671 S#706
END1


N0010 (pause)
IF[#486EQ0]GOTO0012
IF[#486EQ2]GOTO0013
GOTO0016

N0012 (if #486=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00 (OK?)
GOTO0016

N0013 (if #486=2)
G65 P900003


N0016 (finishing operation)
#30=#24+#485
#29=#25+#485
(re-compensation: incut ID +compensation)

#106=FUP[#187]

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#638LE0]THEN #106=#106-1
(#106: number of finishing operation)

N0015
G90 G00 X#484 Y0
G90 G43 G01 H#4120 Z[#26+#600] F#650
G90 G01 Z[#26-#06] S#706 F#651
(X to compensation #484)
(tool length compensation: #4120)
(Z: Z-K)

M03 (spindle on)
M08 (coolant on)


N0200 (finishing operation loop)
WHILE[#106GE0]DO2
#106=#106-1

N0201
G65 P490007 D#4120 X#30 Y#29 R#18 A#606 F#670 E#671 S#706
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
(#06:K: incut Length)
(#18:R: incut corner R)
(#24:X: AC ID)
(#25:Y: BD ID)
(#26:Z: Top re-alocation length)

(as LHS)
(#29, #30, #31)

(Common variable)
(as LHS)
(#102, #103, #104, #105, #106)
(as RHS)
(#187)
(#484, #485, #486)
(#600, #606, #637, #638, #650, #651, #670, #671, #706)
(#900018, #900024, #901011)

(System variables)
(#24xx: #xx kouguKei)
(#26xx: #xx kouguKeiMamou)
(#3000: alarm)
(#4120: current T#)

(Subprograms)
(O490007, O900003)

(Passed arguments)
(#18, #29, #30, #31, #104, #105, #606, #670, #671, #706)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%