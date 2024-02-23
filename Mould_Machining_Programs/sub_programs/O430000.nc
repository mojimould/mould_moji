%
O430000
(Mizo Corner R or C, ar HidariMawari 1shuu)

N001
IF[#07EQ#0]GOTO800
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#25EQ#0]GOTO800
IF[#25LT10]GOTO800
IF[#26EQ#0]GOTO800
IF[#13EQ#0]GOTO800
IF[#13LE1]GOTO800
IF[#23LT#0]GOTO800
IF[#23LE1]GOTO800
(if D = #0, go to N800)
(if X < 10 or #0, go to N800)
(if Y < 10 or #0, go to N800)
(if Z = #0, go to N800)
(if M < 1, or #0, go to N800)
(if W < 1, or #0, go to N800)

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

N006
IF[#19EQ#0]THEN #19=930.0
(default: S=930.)

N007
IF[#686EQ#0]GOTO800
IF[#686LE10]GOTO800
IF[#687EQ#0]GOTO800
IF[#687LE10]GOTO800
IF[#19LT200]GOTO800
(if #686 <= 10 or #0, go to N800)
(if #687 <= 10 or #0, go to N800)
(if S < 200, go to N800)

N008
IF[#07LT6]GOTO800
IF[#07GT10]GOTO800
IF[[FIX[#07]]NE#07]GOTO800
IF[[#26-#13-#23-#419-#420]LE[#901011/2]]GOTO800
IF[[ABS[#419]]GE[#13/2]]GOTO800
IF[[ABS[#420]]GE[#23/2]]GOTO800
IF[[ABS[#421]]GE[[#21-#24]/2]]GOTO800
(if D < 6 or D > 10 or D is not integer, go to N800)
(if Z-M-W-#419-#420 <= #901011/2, go to N800)
(if |#419| >= M/2, go to N800)
(if |#420| >= W/2, go to N800)
(if |#421| >= [U-X]/2, go to N800)

N009
#33=#[2400+#07]+#[2600+#07]
#32=[#605+#33+ABS[#605-#33]]/2
IF[#32LE1]GOTO800
(#32: max[#605, hosei kouguKei])

N010
IF[#07EQ6]THEN #31=#901105
IF[#07EQ7]THEN #31=#901107
IF[#07EQ8]THEN #31=#901109
IF[#07EQ9]THEN #31=#901111
IF[#31LE1]GOTO800
(#31: kougu Thickness)

N011
#100=#21-#24
#101=#22-#25
#102=[#100+#101+ABS[#100-#101]]/2
(#102=max[#100, #101])
IF[#102LE#630]GOTO015
(if #102 <= #630, go to N015)
#103=FUP[[#102-#630]/[#629*2]]
IF[#103LT0]GOTO800
(#103: kakou kaisuu)


(kokokara G00)


G90 G43 G01 H#07 Z[#26+#600] F#650

N100 (ShiageMae loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#24+#630+[#629*2]*#103
#105=#25+#630+[#629*2]*#103

N101 (top side)
G90 G01 Z[#26-#13-#419-#31] S#19 F#650
G90 G00 X[[#104/2]+#32*3-#421] Y[#105/2]
G42 D#07
G91 G00 X-[#32/2]

N102
M03 (shujiku kaiten on)
M08 (coolant on)

N103
G90 G01 X[[#104/2]+#32*2-#421] Y[#105/2] F#651
G65 P490005 K#06 C#03 R#18 X#104 Y#105 D#32 F#686 E#687 S#19
G90 G40 G00 X[[#104/2]+#32*3-#421]

N104 (center)
IF[#422NE3]GOTO106
G90 G01 Z[#26-[#13+#419+[#23+#420+#31]/2]] S#19 F#650
G90 G00 Y[#105/2]
G42 D#07
G91 G00 X-[#32/2]

N105
G90 G01 X[[#104/2]+#32*2-#421] Y[#105/2] F#651
G65 P490005 K#06 C#03 R#18 X#104 Y#105 D#32 F#686 E#687 S#19
G90 G40 G00 X[[#104/2]+#32*3-#421]

N106 (bot side)
G90 G01 Z[#26-#13-#23-#419-#420] S#19 F#650
G90 G00 Y[#105/2]
G42 D#07
G91 G00 X-[#32/2]

N107
G90 G01 X[[#104/2]+#32*2-#421] Y[#105/2] F#651
G65 P490005 K#06 C#03 R#18 X#104 Y#105 D#32 F#686 E#687 S#19
G90 G40 G00 X[[#104/2]+#32*3-#421]
END1


N012 (pause)
IF[#423EQ1]GOTO013
IF[#423EQ2]GOTO014
GOTO016
N013 (if #423=1)
M05 (shujiku kaiten off)
M09 (coolant off)
M00
N014 (if #423=2)
M05 (shujiku kaiten off)
M09 (coolant off)
G90 G01 Z[#26+#600] F#650
G65 P900003


N015 (Shiage)
#106=FUP[#424]

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#630LE0]THEN #106=#106-1
(#106: Siage +kaisuu)

N016
G90 G43 G01 H#07 Z[#26+#600] F#650

N200 (Shiage loop)
WHILE[#106GE0]DO2
#106=#106-1

N201
G90 G01 Z[#26-#13-#419-#31] S#19 F#650
G90 G00 X[[#24/2]+#32*3-#421] Y[#25/2]
G42 D#07
G91 G00 X-[#32/2]

N202
M03 (shujiku kaiten on)
M08 (coolant on)

N203
G90 G01 X[[#24/2]+#32*2-#421] Y[#25/2] F#651
G65 P490005 K#06 C#03 R#18 X#24 Y#25 D#32 F#686 E#687 S#19
G90 G40 G00 X[[#24/2]+#32*3-#421]

N204
IF[#422NE3]GOTO206
G90 G01 Z[#26-[#13+#419+[#23+#420+#31]/2]] S#19 F#650
G90 G00 Y[#25/2]
G42 D#07
G91 G00 X-[#32/2]

N205
G90 G01 X[[#24/2]+#32*2-#421] Y[#25/2] F#651
G65 P490005 K#06 C#03 R#18 X#24 Y#25 D#32 F#686 E#687 S#19
G90 G40 G00 X[[#24/2]+#32*3-#421]

N206
G90 G01 Z[#26-#13-#23-#419-#420] S#19 F#650
G90 G00 Y[#25/2]
G42 D#07
G91 G00 X-[#32/2]

N207
G90 G01 X[[#24/2]+#32*2-#421] Y[#25/2] F#651
G65 P490005 K#06 C#03 R#18 X#24 Y#25 D#32 F#686 E#687 S#19
G90 G40 G00 X[[#24/2]+#32*3-#421]
END2


N017
M05 (shujiku kaiten off)
M09 (coolant off)

N018
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
(#06:K: key type)
(#03:C: corner C)
(#07:D: kouguKei&Chou hosei)
(#13:M: mizoIchi)
(#18:R: corner R)
(#21:U: AC gaisakuKei)
(#22:V: BD gaisakuKei)
(#23:W: mizoHaba)
(#24:X: AC mizoKei)
(#25:Y: BD mizoKei)
(#26:Z: sai-furiwake)
(as received hidden arguments)
(#19:S: kaitenSuu)

(as LHS)
(#31, #32, #33)


(Common variable)
(as LHS)
(#102, #103, #104, #105, #106)
(as RHS)
(#419, #420, #421, #422, #423, #424, #600, #605, #629, #630, #650, #651)
(#901011, #901105, #901107, #901109, #901111)


(System variables)
(#24xx: #xx kouguKei)
(#26xx: #xx kouguKeiMamou)
(#3000: alarm)


(Subprograms)
(O490005, O900003)


(Passed arguments)
(#03, #06, #18, #19, #24, #25, #32, #104, #105, #686, #687)
%