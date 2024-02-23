%
O420000
(Gaisaku, ar HidariMawari 1shuu)

N001
IF[#07EQ#0]GOTO800
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
(if D = #0, go to N800)
(if X < 10 or #0, go to N800)
(if Y < 10 or #0, go to N800)
(if U = #0, go to N800)
(if V = #0, go to N800)
(if Z = #0, go to N800)
(if K < 1 or #0, go to N800)
(if R < 0.1 or #0, go to N800)

N002
IF[#4012EQ56]THEN #33=-#415
IF[#4012EQ54]THEN #33=#437
(Top: #33=-#415. Bot: #33=#437)
(#33: hosei: A-men nikuatsu)

N003
IF[#13EQ#0]THEN #13=0
IF[#23EQ#0]THEN #23=0
IF[#19EQ#0]THEN #19=930
(default: M=0)
(default: W=0)
(default: S=930)

N004
IF[#13LT0]GOTO800
IF[#23LT0]GOTO800
(if M < 0, go to N800)
(if W < 0, go to N800)

IF[#684EQ#0]GOTO800
IF[#684LE10]GOTO800
IF[#685EQ#0]GOTO800
IF[#685LE10]GOTO800
IF[#19LT200]GOTO800
(if #684 <= 10 or #0, go to N800)
(if #685 <= 10 or #0, go to N800)
(if S < 200, go to N800)

N005
IF[#07LT16]GOTO800
IF[#07GT20]GOTO800
IF[[FIX[#07]]NE#07]GOTO800
IF[[#26-#06]LE[#901011/2]]GOTO800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO800
IF[ABS[#33]GE#18]GOTO800
(if D < 16 or D > 20 or D is not integer, go to N800)
(if Z-K <= #901011/2, go to N800)
(if R >= min[X/4, Y/4], go to N800)
(if |#33| >= R, go to N800)

N006
IF[#06GT[#13+#23]]THEN #32=#06
IF[#06LE[#13+#23]]THEN #32=#13+1
(if K > M+W, #32=K)
(if K <= M+W, #32=M+1)

N007
#31=#[2400+#07]+#[2600+#07]
#30=[#605+#31+ABS[#605-#31]]/2
IF[#30LE0]GOTO800
(#30: max[#605, hosei kouguKei])

N008
#100=#21-#24
#101=#22-#25
#102=[#100+#101+ABS[#100-#101]]/2
(#102=max[#100, #101])
IF[#102LE#628]GOTO016
(if #102 <= #628, go to N016)
#103=FUP[[#102-#628]/#627]
IF[#103LT0]GOTO800
(#103: kakou kaisuu)


(kokokara G00)


N009
G90 G43 G01 H#07 Z[#26+#600] F#650

N100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#24+#628+#627*#103
#105=#25+#628+#627*#103

N101
G90 G01 Z[#26-#32] S#19 F#650
G90 G00 X[[#104/2]+#30*3+#33] Y[#105/2]
G42 D#07
G91 G00 X-[#30/2]

N102
M03 (shujiku kaiten on)
M08 (coolant on)

N103
G90 G01 X[[#104/2]+#30*2+#33] Y[#105/2] F#677
G65 P490005 K1. R#18 X#104 Y#105 D#30 F#684 E#685 S#19
G90 G40 G00 X[[#104/2]+#30*3+#33]
END1


N010 (pause)
IF[#4012EQ56]GOTO011
IF[#438EQ1]GOTO012
IF[#438EQ2]GOTO013
GOTO016
N012 (if #438=1)
M05 (shujiku kaiten off)
M09 (coolant off)
M00 (for Bot)
N013 (if #438=2)
M05 (shujiku kaiten off)
M09 (coolant off)
G65 P900003 (for Bot)
GOTO016
N011 (for Top)
IF[#416EQ1]GOTO014
IF[#416EQ2]GOTO015
GOTO016
N014 (if #416=1)
M05 (shujiku kaiten off)
M09 (coolant off)
M00 (for Top)
N015 (if #416=2)
M05 (shujiku kaiten off)
M09 (coolant off)
G90 G01 Z[#26+#600] F#650
G65 P900003 (for Top)


N016 (Shiage)
IF[#4012EQ56]THEN #33=-#415
IF[#4012EQ54]THEN #33=#437
(Top: #33=-#415. Bot: #33=#437)
(#33: hosei: A-men nikuatsu)

IF[#4012EQ56]THEN #106=FUP[#417]
IF[#4012EQ54]THEN #106=FUP[#439]
(Top: #106=FUP[#417]. Bot: #106=FUP[#439])

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#628LE0]THEN #106=#106-1
(#106: Shiage kakou kaisuu)


G90 G43 G01 H#07 Z[#26+#600] F#650

N200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

N201
G90 G00 X[[#24/2]+#30*3+#33] Y[#25/2] F#650
G42 D#07
G91 G00 X-[#30/2] F#650
G90 G01 Z[#26-#32] S#19 F#677

N202
M03 (shujiku kaiten on)
M08 (coolant on)

N203
G90 G01 X[[#24/2]+#30*2+#33] Y[#25/2] F#677
G65 P490005 K1. R#18 X#24 Y#25 D#30 F#684 E#685 S#19
G90 G40 G00 X[[#24/2]+#30*3+#33]
END2


N990
M05 (shujiku kaiten off)
M09 (coolant off)

N991
S200
G90 G43 G01 H#07 Z[#26+#600] F#650
G90 G53 G01 Z0 F#650
GOTO999


N800
M05 (shujiku kaiten off)
M09 (coolant off)
#3000=100 (are the arguments OK?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#06:K: gaisaku Length)
(#07:D: kouguKei&Chou hosei)
(#18:R: corner R)
(#21:U: AC gaiKei)
(#22:V: BD gaiKei)
(#24:X: AC gaikei)
(#25:Y: BD gaikei)
(#26:Z: sai-furiwake)
(as received hidden arguments)
(#13:M: mizoIchi)
(#23:W: mizoHaba)
(#19:S: kaitenSuu)

(as LHS)
(#30, #31, #32, #33)


(Common variable)
(as LHS)
(#102, #103, #104, #105, #106)
(as RHS)
(#415, #416, #417, #437, #438, #439, #600, #605, #627, #628, #650, #677, #684)
(#901011)


(System variables)
(#24xx: #xx kouguKei)
(#26xx: #xx kouguKeiMamou)
(#3000: alarm)
(#4012: current work coordinate G#)


(Subprograms)
(O490005, O900003)


(Passed arguments)
(#18, #19, #24, #25, #30, #104, #105, #684, #685)
%