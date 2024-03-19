%
O430000
(Mizo Corner R or C, ar HidariMawari 1shuu)

N001
IF[#21EQ#0]GOTO800
IF[#21LE10]GOTO800
IF[#22EQ#0]GOTO800
IF[#22LE10]GOTO800
IF[#26EQ#0]GOTO800
IF[#13EQ#0]GOTO800
IF[#13LE1]GOTO800
IF[#11LT#0]GOTO800
IF[#11LE1]GOTO800
(if U <= 10 or #0, go to N800)
(if V <= 10 or #0, go to N800)
(if Z = #0, go to N800)
(if M <= 1, or #0, go to N800)
(if H <= 1, or #0, go to N800)

IF[#01EQ0]GOTO002
IF[#01EQ1]GOTO002
GOTO800

N002
IF[#06EQ1]GOTO003
IF[#06EQ2]GOTO004
IF[#06EQ3]GOTO005
IF[#06EQ4]GOTO005
GOTO800
(if K is not 1, 2, 3, 4, go to N800)

N003 (for R)
IF[#18EQ#0]GOTO800
IF[#03NE#0]GOTO800
IF[#18LT0.1]GOTO800
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO800
(if R < 0.1 or R >= min[X/4, Y/4], go to N800)
GOTO006

N004 (for C)
IF[#03EQ#0]GOTO800
IF[#18NE#0]GOTO800
IF[#03LT0.1]GOTO800
IF[#03GE[[#24+#25-ABS[#24-#25]]/8]]GOTO800
(if C < 0.1 or C >= min[X/4, Y/4], go to N800)
GOTO006

N005 (for rec or BD only)
IF[#03NE#0]GOTO800
IF[#18NE#0]GOTO800
IF[#24NE#0]GOTO800

N006
IF[#662EQ#0]GOTO800
IF[#662LE10]GOTO800
IF[#663EQ#0]GOTO800
IF[#663LE10]GOTO800
IF[#677EQ#0]GOTO800
IF[#677LT200]GOTO800
(if #662 <= 10 or #0, go to N800)
(if #663 <= 10 or #0, go to N800)
(if #677 < 200 or #0, go to N800)

N008
IF[ABS[#422]GE10]GOTO800
IF[#4120EQ#0]GOTO800
IF[#4120LT6]GOTO800
IF[#4120GT10]GOTO800
IF[[FIX[#4120]]NE#4120]GOTO800
IF[#25GE#22]GOTO800
IF[[#26-#13-#11-#419-#420]LE[#901011/2]]GOTO800
IF[[ABS[#419]]GE[#13/2]]GOTO800
IF[[ABS[#420]]GE[#11/2]]GOTO800
IF[[ABS[#421]]GE[[#22-#25]/2]]GOTO800
(if |#422| >= 10, go to N800)
(if T# < 6 or > 10 or not integer or #0, go to N800)
(if Y >= V, go to N800)
(if Z-M-H-#419-#420 <= #901011/2, go to N800)
(if |#419| >= M/2, go to N800)
(if |#420| >= H/2, go to N800)
(if |#421| >= [V-Y]/2, go to N800)

N009
#33=#24+#422
IF[#06EQ4]THEN #33=#21
#32=#25+#422
(hosei: mizoKei +hosei)

#31=[#605+#[2400+#4120]+#[2600+#4120]+ABS[#605-[#[2400+#4120]+#[2600+#4120]]]]/2
IF[#31LE1]GOTO800
(#31: max[#605, hosei kouguKei])

N010
IF[#4120EQ6]THEN #30=#901105
IF[#4120EQ7]THEN #30=#901107
IF[#4120EQ8]THEN #30=#901109
IF[#4120EQ9]THEN #30=#901111
IF[#30LE1]GOTO800
(#30: kougu Thickness)

#29=0
IF[#01EQ0]THEN #29=SQRT[#17*#17-[#23-[#13+#419]-[[#11+#420]/2]]*[#23-[#13+#419]-[[#11+#420]/2]]]-SQRT[#17*#17-#23*#23]
(#29: X hosei from keyway center)

N011
#100=#21-#33
#101=#22-#32
#102=[#100+#101+ABS[#100-#101]]/2
(#102=max[#100, #101])
IF[#102LE#630]GOTO015
(if #102 <= #630, go to N015)
#103=FUP[[#102-#630]/[#629*2]]
IF[#103LT0]GOTO800
(#103: kakou kaisuu)


(kokokara G00)


G90 G43 G01 H#4120 Z[#26+#600] F#650

N100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#33+#630+[#629*2]*#103
IF[#06EQ4]THEN #104=#21+#630+[#629*2]*#103
#105=#32+#630+[#629*2]*#103

N101 (top side)
G90 G00 X[[#104/2]+#31*3+#29-#421] Y[#105/2]
G42 D#4120
G91 G00 X-[#31/2]
G90 G01 Z[#26-#13-#419-#30] S#677 F#650

N102
M03 (spindle on)
M08 (coolant on)

N103
G90 G01 X[[#104/2]+#31*2+#29-#421] Y[#105/2] F#651
G65 P490005 K#06 C#03 R#18 X#104 Y#105 D#31 F#662 E#663 S#677
G90 G40 G00 X[[#104/2]+#31*3+#29-#421]

N104 (center)
IF[#475NE3]GOTO106
G90 G01 Z[#26-[#13+#419+[#11+#420+#30]/2]] S#677 F#650
G90 G00 Y[#105/2]
G42 D#4120
G91 G00 X-[#31/2]

N105
G90 G01 X[[#104/2]+#31*2+#29-#421] Y[#105/2] F#651
G65 P490005 K#06 C#03 R#18 X#104 Y#105 D#31 F#662 E#663 S#677
G90 G40 G00 X[[#104/2]+#31*3+#29-#421]

N106 (bot side)
G90 G01 Z[#26-#13-#11-#419-#420] S#677 F#650
G90 G00 Y[#105/2]
G42 D#4120
G91 G00 X-[#31/2]

N107
G90 G01 X[[#104/2]+#31*2+#29-#421] Y[#105/2] F#651
G65 P490005 K#06 C#03 R#18 X#104 Y#105 D#31 F#662 E#663 S#677
G90 G40 G00 X[[#104/2]+#31*3+#29-#421]
END1


N012 (pause)
IF[#423EQ0]GOTO013
IF[#423EQ2]GOTO014
GOTO016
N013 (if #423=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00
N014 (if #423=2)
G65 P900003


N015 (Shiage)
#33=#24+#422
IF[#06EQ4]THEN #33=#21
#32=#25+#422
(sai-hosei: mizoKei +hosei)

#106=FUP[#183]

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#630LE0]THEN #106=#106-1
(#106: Siage +kaisuu)

N016
G90 G43 G01 H#4120 Z[#26+#600] F#650

N200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

N201
G90 G00 X[[#33/2]+#31*3+#29-#421] Y[#32/2]
G42 D#4120
G91 G00 X-[#31/2]
G90 G01 Z[#26-#13-#419-#30] S#677 F#650

N202
M03 (spindle on)
M08 (coolant on)

N203
G90 G01 X[[#33/2]+#31*2+#29-#421] Y[#32/2] F#651
G65 P490005 K#06 C#03 R#18 X#33 Y#32 D#31 F#662 E#663 S#677
G90 G40 G00 X[[#33/2]+#31*3+#29-#421]

N204
IF[#475NE3]GOTO206
G90 G01 Z[#26-[#13+#419+[#11+#420+#30]/2]] S#677 F#650
G90 G00 Y[#32/2]
G42 D#4120
G91 G00 X-[#31/2]

N205
G90 G01 X[[#33/2]+#31*2+#29-#421] Y[#32/2] F#651
G65 P490005 K#06 C#03 R#18 X#33 Y#32 D#31 F#662 E#663 S#677
G90 G40 G00 X[[#33/2]+#31*3+#29-#421]

N206
G90 G01 Z[#26-#13-#11-#419-#420] S#677 F#650
G90 G00 Y[#32/2]
G42 D#4120
G91 G00 X-[#31/2]

N207
G90 G01 X[[#33/2]+#31*2+#29-#421] Y[#32/2] F#651
G65 P490005 K#06 C#03 R#18 X#33 Y#32 D#31 F#662 E#663 S#677
G90 G40 G00 X[[#33/2]+#31*3+#29-#421]
END2


N990
M09 (coolant off)
G90 G43 G01 H#4120 Z[#26+#600] F#650
S2599
G90 G53 G01 Z0 F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
GOTO999

N800
M09 (coolant off)
S2599
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
#3000=100 (are the arguments OK?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#01:A: Top gaisaku check: 0:not exist, 1:exist)
(#06:K: key type: 1:R, 2:C, 3:rec, 4:BDonly)
(#03:C: corner C)
(#11:H: mizoHaba)
(#13:M: mizoIchi)
(#17:Q: central curvature)
(#18:R: corner R)
(#21:U: AC gaiKei or gaisakuKei)
(#22:V: BD gaiKei or gaisakuKei)
(#23:W: Top ori_furiwake)
(#24:X: AC mizoKei)
(#25:Y: BD mizoKei)
(#26:Z: sai-furiwake)

(as LHS)
(#29, #30, #31, #32, #33)


(Common variable)
(as LHS)
(#102, #103, #104, #105, #106)
(as RHS)
(#183, #419, #420, #421, #422, #423, #475, #600, #605, #629, #630, #650, #651, #662, #663, #677)
(#901011, #901105, #901107, #901109, #901111)


(System variables)
(#24xx: #xx kouguKei)
(#26xx: #xx kouguKeiMamou)
(#3000: alarm)
(#4120: current T#)


(Subprograms)
(O490005, O900003)


(Passed arguments)
(#03, #06, #18, #31, #32, #33, #104, #105, #662, #663, #677)
%