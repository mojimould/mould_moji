%
O410000 (last update on 20240510)
(Tanmen naikei-#608 Coner R, ar MigiMawari 1shuu)

N001
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#25EQ#0]GOTO800
IF[#25LT10]GOTO800
IF[#18EQ#0]GOTO800
IF[#18LT1]GOTO800
IF[#26EQ#0]GOTO800
(if X < 10 or #0, go to N800)
(if Y < 10 or #0, go to N800)
(if R < 1 or #0, go to N800)
(if Z = #0, go to N800)

N003
IF[#400EQ#0]GOTO800
IF[#400LE0]GOTO800
IF[#658EQ#0]GOTO800
IF[#658LE10]GOTO800
IF[#659EQ#0]GOTO800
IF[#659LE10]GOTO800
IF[#675EQ#0]GOTO800
IF[#675LE200]GOTO800
(if #400 <= 0 or #0, go to N800)
(if #658 <= 10 or #0, go to N800)
(if #659 <= 10 or #0, go to N800)
(if #675 <= 200 or #0, go to N800)

N004
#100=#400
#106=FUP[#100/#625]
(#106: kakou kaisuu)

N005
IF[#4120EQ#0]GOTO800
IF[#4120LT2]GOTO800
IF[#4120GT5]GOTO800
IF[[FIX[#4120]]NE#4120]GOTO800
IF[#26LE[#901011/2]]GOTO800
IF[#901101EQ#0]GOTO800
IF[#901101LE1]GOTO800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO800
IF[#100EQ#0]GOTO800
IF[#100LT1]GOTO800
IF[#106LE0]GOTO800
IF[#608LT1]GOTO800
IF[#625EQ#0]GOTO800
IF[#625LE0]GOTO800
IF[#625GT5]GOTO800
IF[[#625*#106]LT0]GOTO800
(if T# < 2 or > 5 or not integer or #0, go to N800)
(if Z <= #901011/2, go to N800)
(if BCX <= 1 or BCX = #0, go to N800)
(if R >= min[X/4, Y/4], go to N800)
(if #100 < 1 or #0, go to N800)
(if #106 <= 0, go to N800)
(if #608 < 1, go to N800)
(if #625 <= 0 or #625 > 5 or #625 = #0, go to N800)
(if #625*#106 < 0, go to N800)

N006
#33=#[2400+#4120]+#[2600+#4120]
#32=[#605+#33+ABS[#605-#33]]/2
#31=#24-[#608*2]
#30=#25-[#608*2]
IF[#32LE0]GOTO800
(#32: max[#605, hosei kouguKei])
(#31: X-#608*2)
(#30: Y-#608*2)

N007
IF[#608GE#33]GOTO800
(if #608 >= kouguKei, go to N800)


(kokokara G00)


N008
G90 G43 G01 H#4120 Z[#26+#625*#106+#600] F#650

N100 (loop)
WHILE[#106GE1]DO1
#106=#106-1

N101
G90 G00 X[[#31/2]+#32*3] Y[#30/2]
G42 D#4120
G91 G00 X-[#32/2]
G90 G01 Z[#26+#625*#106] S#675 F#650

N102
M03 (spindle on)
M08 (coolant #1 on)

N103
G90 G01 X[[#31/2]+#32*2] Y[#30/2] F#651
G65 P490005 K1.0 R#18 X#31 Y#30 D#32 F#658 E#659 S#675
G90 G40 G00 X[[#31/2]+#32*3]
END1

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
(#18:R: sotogawa coner R)
(#24:X: AC naikei)
(#25:Y: BD naikei)
(#26:Z: sai-furiwake)
(as received hidden arguments)

(as LHS)
(#30, #31, #32, #33)

(Common variable)
(as LHS)
(#100, #106)
(as RHS)
(#400, #600, #605, #608, #625, #650, #651, #658, #659, #675)
(#901011, #901101)

(System variables)
(#24xx: #xx kouguKei)
(#26xx: #xx kouguKeiMamou)
(#3000: alarm)
(#4120: current T#)

(Subprograms)
(O490005)

(Passed arguments)
(#18, #30, #31, #32, #658, #659, #675)


(COPYRIGHT*2023-2024*THE*INDIVIDUAL*CREATOR*NOT*ANY*CORPORATION*ALL*RIGHTS*RESERVED)
%