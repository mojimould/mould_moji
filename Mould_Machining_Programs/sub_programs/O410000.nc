%
O410000
(Tanmen naikei-#608 Coner R, ar MigiMawari 1shuu)

N001
IF[#07EQ#0]GOTO800
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#25EQ#0]GOTO800
IF[#25LT10]GOTO800
IF[#18EQ#0]GOTO800
IF[#18LT1]GOTO800
IF[#26EQ#0]GOTO800
(if D = #0, go to N800)
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
IF[#401LE#625]THEN #401=#0
(if #401 <= #625, #401=#0)
#100=#400
IF[#4012EQ55]THEN #100=#401
IF[#100EQ#0]THEN #100=#400
(#100=#400)
(if #401 > #625, Bot: #100=#401)
N501
#106=FUP[#100/#625]
(#106: kakou kaisuu)

N005
IF[#07LT2]GOTO800
IF[#07GT5]GOTO800
IF[[FIX[#07]]NE#07]GOTO800
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
(if D < 2 or D > 5 or #0 or D is not integer, go to N800)
(if Z <= #901011/2, go to N800)
(if BCX <= 1 or BCX = #0, go to N800)
(if R >= min[X/4, Y/4], go to N800)
(if #100 < 1 or #0, go to N800)
(if #106 <= 0, go to N800)
(if #608 < 1, go to N800)
(if #625 <= 0 or #625 > 5 or #625 = #0, go to N800)
(if #625*#106 < 0, go to N800)

N006
#33=#[2400+#07]+#[2600+#07]
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
G90 G43 G01 H#07 Z[#26+#625*#106+#600] F#650

N100 (loop)
WHILE[#106GE1]DO1
#106=#106-1

N101
G90 G00 X[[#31/2]+#32*3] Y[#30/2]
G42 D#07
G91 G00 X-[#32/2]
G90 G01 Z[#26+#625*#106] S#675 F#650

N102
M03 (spindle on)
M08 (coolant #1 on)

N103
G90 G01 X[[#31/2]+#32*2] Y[#30/2] F#651
G65 P490005 K1. R#18 X#31 Y#30 D#32 F#658 E#659 S#675
G90 G40 G00 X[[#31/2]+#32*3]
END1

N990
M05 (spindle off)
M09 (coolant off)

N991
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
(#07:D: hosei kouguChou #)
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
(#400, #401, #600, #605, #608, #625, #650, #651, #658, #659, #675)
(#901011, #901101)


(System variables)
(#24xx: #xx kouguKei)
(#26xx: #xx kouguKeiMamou)
(#3000: alarm)
(#4012: current work coordinate G#)


(Subprograms)
(O490005)


(Passed arguments)
(#18, #30, #31, #32, #658, #659, #675)
%