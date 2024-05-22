%
O460000
(Tanmen Zaguri Corner R, rc HidariMawari)

N001
IF[#04EQ#0]GOTO800
IF[#04LE1]GOTO800
IF[#21EQ#0]GOTO800
IF[#21LE1]GOTO800
IF[#22EQ#0]GOTO800
IF[#22LE1]GOTO800
IF[#23EQ#0]GOTO800
IF[#23LE1]GOTO800
IF[#24EQ#0]GOTO800
IF[#24LE1]GOTO800
IF[#25EQ#0]GOTO800
IF[#25LE1]GOTO800
IF[#26EQ#0]GOTO800
IF[#26LE1]GOTO800
IF[#18EQ#0]GOTO800
IF[#18LT1]GOTO800
(if I <= 1 or #0, go to N800)
(if U <= 1 or #0, go to N800)
(if V <= 1 or #0, go to N800)
(if W <= 1 or #0, go to N800)
(if X <= 1 or #0, go to N800)
(if Y <= 1 or #0, go to N800)
(if Z <= 1 or #0, go to N800)
(if R <= 1 or #0, go to N800)

N002
IF[#668EQ#0]GOTO800
IF[#668LE10]GOTO800
IF[#669EQ#0]GOTO800
IF[#669LE10]GOTO800
IF[#680EQ#0]GOTO800
IF[#680LE200]GOTO800
(if #668 <= 10 or #0, go to N800)
(if #669 <= 10 or #0, go to N800)
(if #680 <= 200 or #0, go to N800)

N005
#33=#21+#479+2*[#18-SQRT[#22*[2*#18-#22]]]
#32=#33-#18*2
(#33: U+#479+2[R-SQRT[2R-V]])
(#32: #33-2R)

N008
IF[#4012NE56]GOTO800
IF[ABS[#477]GE5]GOTO800
IF[ABS[#478]GE5]GOTO800
IF[[#23-#26]LE[#901011/2]]GOTO800
IF[#18LE[#[2400+#4120]+#[2600+#4120]]-0.1]GOTO800
IF[#636GT#635]GOTO800
(if T# is not 56, go to N800)
(if |#477| >= 5, go to N800)
(if |#478| >= 5, go to N800)
(if W-Z <= #901011/2, go to N800)
(if R <= hosei kouguKei-0.1, go to N800)
(if #636 > #635, go to N800)

IF[#22LE#636]GOTO017
(if V <= #636, go to Shiage)
#103=FUP[[#22-#636]/#635]
IF[#103LT0]GOTO800
(#103: kakou kaisuu)


(kokokara G00)


N009
G90 G00 X[#900003/2-#04-[#21/2]+#477] Y[-#900009/2+#22-[#33/2]+#478]

G90 G43 G01 H#4120 Z[#26+#600] F#650
G90 G01 Z[#26-#23] F#651
(hosei kouguChou: #4120)
(Z: Z-W)

N010
M03 (spindle on)
M08 (coolant #1 on)

N100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#33-#636-#635*#103

G65 P490004 D#4120 X#104 Y#104 R#18 F#668 E#669 S#680
END1

N011 (pause)
IF[#480EQ0]GOTO015
IF[#480EQ2]GOTO016
GOTO017
N015 (if #480=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
M00 (OK?)
GOTO017
N016 (if #480=2)
M09 (coolant off)
G90 G01 Z[#26+#600] F#650
G65 P900003 (for Top)

N017 (Shiage)
#33=#21+#479+2*[#18-SQRT[#22*[2*#18-#22]]]
#32=#33-#18*2
(#33: U+#479+2[R-SQRT[2R-V]])
(#32: #33-2R)

#106=FUP[#186]

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#636LE0]THEN #106=#106-1
(#106: Shiage kakou kaisuu)

G90 G00 X[#900003/2-#04-[#21/2]+#477] Y[-#900009/2+#22-[#33/2]+#478]

G90 G43 G01 H#4120 Z[#26+#600] F#650
G90 G01 Z[#26-#23] F#651
(hosei kouguChou: #4120)
(Z: Z-W)

M03 (spindle on)
M08 (coolant #1 on)

N200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

G65 P490007 D#4120 X#33 Y#33 R#18 F#668 E#669 S#680
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
(#06:K: mentori C or R length)
(#17:Q: central curvature)
(#18:R: corner R)
(#23:W: Bot ori_furiwake)
(#24:X: AC naikei)
(#25:Y: BD naikei)
(#26:Z: sai-furiwake)

(as LHS)
(#27, #28, #29, #30, #31, #32, #33)

(Common variable)
(as LHS)
(#103, #104, #105, #106)
(as RHS)
(#186)
(#430, #431, #432, #446, #447, #448)
(#600, #606, #633, #634, #650, #651, #666, #667, #679)
(#901011)

(System variables)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4120: current T#)

(Subprograms)
(O490007, O900003)

(Passed arguments)
(#07, #18, #28, #29, #104, #105, #606, #666, #667, #679)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%