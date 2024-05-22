%
O470000 (last update on 20240522)
(Inlay, ar HidariMawari 1shuu)

N001
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#25EQ#0]GOTO800
IF[#25LT10]GOTO800
IF[#21EQ#0]GOTO800
IF[#22EQ#0]GOTO800
IF[#26EQ#0]GOTO800
IF[#06EQ#0]GOTO800
IF[#06LT1]GOTO800
IF[#18EQ#0]GOTO800
IF[#18LT0.1]GOTO800
(if X < 10 or #0, go to N800)
(if Y < 10 or #0, go to N800)
(if U = #0, go to N800)
(if V = #0, go to N800)
(if Z = #0, go to N800)
(if K < 1 or #0, go to N800)
(if R < 0.1 or #0, go to N800)

N002
IF[#670EQ#0]GOTO800
IF[#670LE10]GOTO800
IF[#671EQ#0]GOTO800
IF[#671LE10]GOTO800
IF[#681EQ#0]GOTO800
IF[#681LE200]GOTO800
(if #670 <= 10 or #0, go to N800)
(if #671 <= 10 or #0, go to N800)
(if #681 <= 200 or #0, go to N800)

N003
IF[ABS[#484]GE10]GOTO800
IF[#4120EQ#0]GOTO800
IF[#4120LT16]GOTO800
IF[#4120GT20]GOTO800
IF[[FIX[#4120]]NE#4120]GOTO800
IF[[#26-#06]LE[#901011/2]]GOTO800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO800
IF[ABS[#483]GE#18]GOTO800
(if |#415| >= 10, go to N800)
(if |#437| >= 10, go to N800)
(if T# < 16 or > 20 or not integer or #0, go to N800)
(if Z-K <= #901011/2, go to N800)
(if R >= min[X/4, Y/4], go to N800)
(if |#483| >= R, go to N800)

N004
#30=#24+#484
#29=#25+#484
(hosei: naisakuKei +hosei)

N005
#100=#30-#900018
#101=#29-#900024
#102=[#100+#101+ABS[#100-#101]]/2
(#102=max[#100, #101])
IF[#102LE#638]GOTO016
(if #102 <= #638, go to N016)
#103=FUP[[#102-#638]/#637]
IF[#103LT0]GOTO800
(#103: kakou kaisuu)


(kokokara G01)


N006
G90 G00 X#483 Y0
G90 G43 G01 H#4120 Z[#26+#600] F#650
G90 G01 Z[#26-#06] S#681 F#651
(X to hosei #483)
(hosei kouguChou: #4120)
(Z: Z-K)

N007
M03 (spindle on)
M08 (coolant on)

N100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#30-#638-#637*#103
#105=#29-#638-#637*#103

N103
G65 P490007 D#4120 X#104 Y#105 R#18 A#606 F#670 E#671 S#681
END1


N010 (pause)
IF[#485EQ0]GOTO012
IF[#485EQ2]GOTO013
GOTO016

N012 (if #485=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00 (OK?)
GOTO014

N013 (if #416=2)
G65 P900003


N014 (Shiage)
#30=#24+#484
#29=#25+#484
(sai-hosei: gaisakuKei +hosei)

#106=FUP[#187]

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#638LE0]THEN #106=#106-1
(#106: Shiage kakou kaisuu)

N015
G90 G00 X#483 Y0
G90 G43 G01 H#4120 Z[#26+#600] F#650
G90 G01 Z[#26-#06] S#681 F#651
(X to hosei #483)
(hosei kouguChou: #4120)
(Z: Z-K)

M03 (spindle on)
M08 (coolant on)


N200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

N201
G65 P490007 D#4120 X#30 Y#29 R#18 A#606 F#670 E#671 S#681
END2


N990
M09 (coolant off)
G90 G43 G01 H#4120 Z[#26+#600] F#650
IF[#4119GE2600]GOTO991
S2599
GOTO992
N991
S6000

N992
G90 G53 G01 Z0 F#650
G04 X1.5 (wait 1.5s)
M05 (spindle off)
S35
GOTO999


N800
M09 (coolant off)
S2599
G04 X2.0 (wait 2.0s)
M05 (spindle off)
S35
#3000=100 (are the arguments OK?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#06:K: gaisaku Length)
(#18:R: corner R)
(#21:U: AC gaiKei)
(#22:V: BD gaiKei)
(#24:X: AC gaikei)
(#25:Y: BD gaikei)
(#26:Z: sai-furiwake)

(as LHS)
(#29, #30, #31)

(Common variable)
(as LHS)
(#102, #103, #104, #105, #106)
(as RHS)
(#187)
(#414, #415, #416, #436, #437, #438, #483)
(#600, #605, #637, #638, #650, #651, #670, #671, #681)
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
(#18, #29, #30, #31, #104, #105, #670, #671, #681)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%