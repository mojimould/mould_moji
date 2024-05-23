%
O420000 (last update on 20240522)
(Gaisaku, ar HidariMawari 1shuu)

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
IF[#4012EQ56]THEN #33=#414
IF[#4012EQ54]THEN #33=-#436
(Top: #33=#414. Bot: #33=-#436)
(#33: hosei: A-men nikuatsu)

N003
IF[#13EQ#0]THEN #13=0
IF[#23EQ#0]THEN #23=0
IF[#13LT0]GOTO800
IF[#23LT0]GOTO800
(default: M=0)
(default: W=0)
(if M < 0, go to N800)
(if W < 0, go to N800)

IF[#660EQ#0]GOTO800
IF[#660LE10]GOTO800
IF[#661EQ#0]GOTO800
IF[#661LE10]GOTO800
IF[#676EQ#0]GOTO800
IF[#676LE200]GOTO800
(if #660 <= 10 or #0, go to N800)
(if #661 <= 10 or #0, go to N800)
(if #676 <= 200 or #0, go to N800)

N004
IF[ABS[#415]GE10]GOTO800
IF[ABS[#437]GE10]GOTO800
IF[#4120EQ#0]GOTO800
IF[#4120LT16]GOTO800
IF[#4120GT20]GOTO800
IF[[FIX[#4120]]NE#4120]GOTO800
IF[[#26-#06]LE[#901011/2]]GOTO800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO800
IF[ABS[#33]GE#18]GOTO800
(if |#415| >= 10, go to N800)
(if |#437| >= 10, go to N800)
(if T# < 16 or > 20 or not integer or #0, go to N800)
(if Z-K <= #901011/2, go to N800)
(if R >= min[X/4, Y/4], go to N800)
(if |#33| >= R, go to N800)

N005
IF[#06GT[#13+#23]]THEN #32=#06
IF[#06LE[#13+#23]]THEN #32=#13+1
(if K > M+W, #32=K)
(if K <= M+W, #32=M+1)

N006
#31=[#605+#[2400+#4120]+#[2600+#4120]+ABS[#605-[#[2400+#4120]+#[2600+#4120]]]]/2
IF[#31LE0]GOTO800
(#31: max[#605, hosei kouguKei])

N007
IF[#4012EQ56]THEN #30=#24+#415
IF[#4012EQ54]THEN #30=#24+#437
IF[#4012EQ56]THEN #29=#25+#415
IF[#4012EQ54]THEN #29=#25+#437
(hosei: gaisakuKei +hosei)

N008
#100=#21-#30
#101=#22-#29
#102=[#100+#101+ABS[#100-#101]]/2
(#102=max[#100, #101])
IF[#102LE#628]GOTO016
(if #102 <= #628, go to N016)
#103=FUP[[#102-#628]/#627]
IF[#103LT0]GOTO800
(#103: kakou kaisuu)


(kokokara G01)


N009
G90 G43 G01 H#4120 Z[#26+#600] F#650

N100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#30+#628+#627*#103
#105=#29+#628+#627*#103

N101
G90 G00 X[[#104/2]+#31*3+#33] Y[#105/2]
G42 D#4120
G91 G00 X-[#31/2]
G90 G01 Z[#26-#32] S#676 F#650

N102
M03 (spindle on)
M08 (coolant on)

N103
G90 G01 X[[#104/2]+#31*2+#33] Y[#105/2] F#651
G65 P490005 K1.0 R#18 X#104 Y#105 D#31 F#660 E#661 S#676
G90 G40 G00 X[[#104/2]+#31*3+#33]
END1


N010 (pause)
IF[#4012EQ56]GOTO011
IF[#438EQ0]GOTO012
IF[#438EQ2]GOTO013
GOTO016

N012 (if #438=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00 (for Bot)
GOTO016
N013 (if #438=2)
M09 (coolant off)
G65 P900003 (for Bot)
GOTO016

N011 (for Top)
IF[#416EQ0]GOTO014
IF[#416EQ2]GOTO015
GOTO016

N014 (if #416=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00 (for Top)
GOTO016
N015 (if #416=2)
G65 P900003 (for Top)


N016 (Shiage)
IF[#4012EQ56]THEN #33=#414
IF[#4012EQ54]THEN #33=-#436
(Top: #33=#414. Bot: #33=-#436)
(#33: hosei: A-men nikuatsu)

IF[#4012EQ56]THEN #30=#24+#415
IF[#4012EQ54]THEN #30=#24+#437
IF[#4012EQ56]THEN #29=#25+#415
IF[#4012EQ54]THEN #29=#25+#437
(sai-hosei: gaisakuKei +hosei)

IF[#4012EQ56]THEN #106=FUP[#182]
IF[#4012EQ54]THEN #106=FUP[#189]
(Top: #106=FUP[#182], Bot: #106=FUP[#189])

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#628LE0]THEN #106=#106-1
(#106: Shiage kakou kaisuu)


G90 G43 G01 H#4120 Z[#26+#600] F#650

N200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

N201
G90 G00 X[[#30/2]+#31*3+#33] Y[#29/2] F#650
G42 D#4120
G91 G00 X-[#31/2] F#650
G90 G01 Z[#26-#32] S#676 F#651

N202
M03 (spindle on)
M08 (coolant on)

N203
G90 G01 X[[#30/2]+#31*2+#33] Y[#29/2] F#651
G65 P490005 K1.0 R#18 X#30 Y#29 D#31 F#660 E#661 S#676
G90 G40 G00 X[[#30/2]+#31*3+#33]
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
(as received hidden arguments)
(#13:M: mizoIchi)
(#23:W: mizoHaba)

(as LHS)
(#29, #30, #31, #32, #33)

(Common variable)
(as LHS)
(#102, #103, #104, #105, #106)
(as RHS)
(#182, #189)
(#414, #415, #416, #436, #437, #438)
(#600, #605, #627, #628, #650, #651, #660, #661, #676)
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
(#18, #29, #30, #31, #104, #105, #660, #661, #676)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%