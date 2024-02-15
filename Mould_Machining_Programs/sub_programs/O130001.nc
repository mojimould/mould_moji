%
O130001 (X center of inner measurement)

N001
#33=#4012
(#33= current work coordinate G#)

IF[#33LT54]GOTO800
IF[#33GT59]GOTO800
IF[#33NE[FUP[#33]]]GOTO800
(if work G# < 54 go to N800)
(if work G# > 59 go to N800)
(if work G# is not integer, go to N800)

IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#26EQ#0]GOTO800
IF[#23EQ#0]GOTO800
IF[#23LT10]GOTO802
IF[#18EQ#0]GOTO800
IF[#13EQ#0]GOTO800
IF[#13LT0]GOTO800
IF[#13GT10]GOTO800
(if X < 10 or #0, go to N800)
(if Z = #0, go to N800)
(if W < 10 or #0, go to N802)
(if R = #0, go to N800)
(if M < 0 or M > 10 or #0, go to N800)

IF[#18LE#26]GOTO800
IF[#26LE[#901011/2]]GOTO810
(if R <= Z, go to N800)
(if Z <= #901011/2, go to N810)

IF[#512EQ#0]GOTO800
IF[#512LE0]GOTO800
IF[#603EQ#0]GOTO800
IF[#603LE0]GOTO800
IF[#604EQ#0]GOTO800
IF[#604LT0]GOTO800
IF[#604GT20]GOTO800
IF[#680EQ#0]GOTO800
IF[#680LE10]GOTO800
IF[#901011EQ#0]GOTO800
IF[#901011LE100]GOTO800
(if #901011 <= 100 or #0 go to N800)
(if #512 <= 0 or #0, go to N800)
(if #603 <= 0 or #0, go to N800)
(if #604 < 0 or #604 > 20.0 or #0, go to N800)
(if #680 <= 10 or #0, go to N800)

IF[#33EQ56]THEN #32=1
IF[#33EQ57]THEN #32=1
IF[#33EQ54]THEN #32=-1
IF[#33EQ55]THEN #32=-1
(Top: #32=1, Bot: #32=-1)
IF[#33EQ56]THEN #31=#412
IF[#33EQ57]THEN #31=#412
IF[#33EQ54]THEN #31=#407
IF[#33EQ55]THEN #31=#407
(Top: #31=#412, Bot: #31=#407)

N002
#30=#24/2+#13
IF[[#30-#512-#603]LE0]GOTO811
(if X/2+M-D/2-#603 <= 0 go to N811)
IF[#31EQ#0]GOTO005
IF[#31EQ0]GOTO005
(if #31 = 0 or #0, go to N005)

N003
#29=0 (#29: X +hosei)
IF[[ABS[#31]]GE[#23/2]]GOTO812
(if |#31| >= W/2, go to N812)
#29=SQRT[#18*#18-[#23+#31]*[#23+#31]]-SQRT[#18*#18-#23*#23]
IF[[ABS[#29]]GE[#24/2]]GOTO812
(if |#29| >= X/2, go to N812)

N004
G91 G01 X[#32*#29] F#676

N005
#28=#5001 (#28= block end X)

IF[#1005EQ0]GOTO007
M00 (sensor low battery)
N007
IF[#1004EQ1]GOTO008
(if current sensor ON, go to N008)
M117 (sensor on/off)
G04 X1. (wait 1.0s)

N008
G90 G31 Z[#26-#512+#31] F#678
(Z tanmen: Z-D/2+#31)
IF[#5003GT[#26-#512+#31]]GOTO802
(if skip block end Z > tanmen Z-D/2+#31, to N802)

G91 G31 X-[#30-#512-#603] F#678
(X-: [AC naikei/2 -D/2 -#603])
IF[[ABS[#5001-#28]+0.001]LT[ABS[#30-#512-#603]]]GOTO803
(if |skipX-#28| < |AC naikei/2 -D/2 -#603|, to N803)

G91 G31 X-[#603+#604] F#680
(X- skip: #603+#604)
#900014=#5001-#512+#501+#502
(#900014= X left side -D/2 +probe hosei)

G90 G01 X#28 F#676 (X to start point)
IF[[ABS[#900014-#501-#502]]GE[ABS[#30+#603]]]GOTO800
(if |#900014|>=|X/2+#603|, go to N800)

G91 G31 X[#30-#512-#603] F#678
(X+: [AC gaikei/2 -D/2 -#603])
IF[[ABS[#5001-#28]+0.001]LT[ABS[#30-#512-#603]]]GOTO803
(if |skipX -#28| < |AC naikei/2 -D/2 -#603|, to N803)

G91 G31 X[#603+#604] F#680
(X+ skip: #603+#604)
#900015=#5001+#512-#501+#502
(#900015= X right side +D/2 +probe hosei)
#900016=[#900015+#900014]/2
#900017=#900015-#900014
(average: center)
(difference: width)

G90 G01 X#900016 F#676
(X to measured center)
IF[[ABS[#900015+#501-#502]]GE[ABS[#30+#603]]]GOTO800
(if |#900015| >= |X/2+#603| go to N800)

G90 G01 X-[#32*#29] F#676
(X to measured tanmen center)

#[5201+[#33-53]*20]=#5021
(current work origin X = current machine X)

G90 G01 Z[#26+#601] F#676
GOTO999


N801
#3000=145 (Low battery)

N803
G90 G01 X#28 F#676 (X to start point)

N802
G90 G53 G01 Z0 F#676
G65 P910002 (sensor OFF)

N800
#3000=121 (are the arguments or the mould OK?)

N999 M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#13:M: mekki thickness mm)
(#18:R: central curvature)
(#23:W: ori_furiwake)
(#24:X: X inside width)
(#26:Z: sai-furiwake)

(as LHS)
(#28, #29, #30, #31, #32, #33)


(Common variables)
(as LHS)
(#900014, #900015, #900016, #900017)
(as RHS)
(#407, #412, #601, #603, #604, #676, #678, #680)
(#501: hosei: touch sensor signal delay)
(#502: hosei: probe center X)
(#512: probe radius)
(#901011)


(System variables)
(#0   : empty)
(#1004: 0: sensor off, 1: on)
(#1005: 0: sensor battery ok, 1: low battery)
(#2050: hosei #50 KouguChou)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5001: current work block end point X)
(#5003: current work block end point Z)
(#5021: current machine coordinate X)
(#5241: G55 X)
(#5281: G57 X)


(Subprograms)
(O910002)
%