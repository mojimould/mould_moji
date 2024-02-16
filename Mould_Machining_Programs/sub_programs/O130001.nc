%
O130001 (X center of inner measurement)

N001
#33=#4012
#32=#5001
(#33= current work coordinate G#)
(#32= block end X: start position X)

N002
IF[#33LT54]GOTO800
IF[#33GT59]GOTO800
IF[#33NE[FUP[#33]]]GOTO800
(if work G# < 54 go to N800)
(if work G# > 59 go to N800)
(if work G# is not integer, go to N800)

N003
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#26EQ#0]GOTO800
IF[#23EQ#0]GOTO800
IF[#23LT10]GOTO800
IF[#18EQ#0]GOTO800
IF[#13EQ#0]GOTO800
IF[#13LT0]GOTO800
IF[#13GT10]GOTO800
(if X < 10 or #0, go to N800)
(if Z = #0, go to N800)
(if W < 10 or #0, go to N800)
(if R = #0, go to N800)
(if M < 0 or M > 10 or #0, go to N800)

N004
IF[#18LE#26]GOTO800
IF[#26LE[#901011/2]]GOTO800
(if R <= Z, go to N800)
(if Z <= #901011/2, go to N800)

N005
IF[#512EQ#0]GOTO800
IF[#512LE1]GOTO800
IF[#601EQ#0]GOTO800
IF[#601LT50]GOTO800
IF[#603EQ#0]GOTO800
IF[#603LE0]GOTO800
IF[#604EQ#0]GOTO800
IF[#604LT0]GOTO800
IF[#604GT20]GOTO800
IF[#680EQ#0]GOTO800
IF[#680LE10]GOTO800
IF[#901011EQ#0]GOTO800
IF[#901011LE100]GOTO800
(if #512 <= 1 or #0, go to N800)
(if #601 < 50 or #0, go to N800)
(if #603 <= 0 or #0, go to N800)
(if #604 < 0 or #604 > 20.0 or #0, go to N800)
(if #680 <= 10 or #0, go to N800)
(if #901011 <= 100 or #0, go to N800)

N006
IF[#33GE56]THEN #31=1
IF[#33LE55]THEN #31=-1
(Top: #31=1, Bot: #31=-1)
IF[#33GE56]THEN #30=#412
IF[#33LE55]THEN #30=#407
(Top: #30=#412, Bot: #30=#407)
IF[[ABS[#30]]GE[#26/4]]GOTO800
IF[[ABS[#30]]GE[#23/4]]GOTO800
(if |#30| >= Z/4, go to N800)
(if |#30| >= W/4, go to N800)

N007
#29=#24/2+#13
#28=SQRT[#18*#18-[#23-#30]*[#23-#30]]-SQRT[#18*#18-#23*#23]
(#29= X/2+M)
(#28: X hosei from #30)
IF[[#29-#512-#603]LE0]GOTO800
IF[[ABS[#28]]GE[#24/4]]GOTO800
(if X/2+M-#512-#603 <= 0, go to N800)
(if |#28| >= X/4, go to N800)

N008
IF[#1005EQ0]GOTO009
M00 (sensor low battery)
N009
IF[#1004EQ1]GOTO010
(if current sensor ON, go to N010)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)


(kokokara G31)


N010
G90 G31 Z[#26-#512] F#678
(Z skip: Z-#512)
IF[#5003GT[#26-#512]]GOTO802
(if skip Z > Z-#512, to N802)

G91 G31 X[#31*#28] Z-#30 F#678
(X skip to #31*#28)
(Z skip to Z-#512-#30)
IF[#5001GT[#32+#31*#28+0.001]]GOTO803
IF[#5003GT[#26-#512-#30]]GOTO802
(if skip X > #32+#31*#28, to N802)
(if skip Z > Z-#512-#30, to N802)

N011
G91 G31 X-[#29-#512-#603] F#678
(X- skip: [#29-#512-#603])
IF[[ABS[#5001-#32-#31*#28]+0.001]LT[ABS[#29-#512-#603]]]GOTO803
(if |skip X -#32| < |#29-#512-#603|, go to N803)

G91 G31 X-[#603+#604] F#680
(X- skip: #603+#604)
#900014=#5001-#512+#501+#502
(#900014= X left side -#512 +probe hosei)

N012
G90 G01 X[#32+#31*#28] F#676
(X to start point +hosei)
IF[[ABS[#900014-#501-#502]]GE[ABS[#29+#603]]]GOTO800
(if |#900014 -probe hosei| >= |#29+#603|, go to N800)

N013
G91 G31 X[#29-#512-#603] F#678
(X+ skip: [#29-#512-#603])
IF[[ABS[#5001-#32-#31*#28]+0.001]LT[ABS[#29-#512-#603]]]GOTO803
(if |skip X -#32| < |#29-#512-#603|, to N803)

G91 G31 X[#603+#604] F#680
(X+ skip: #603+#604)
#900015=#5001+#512-#501+#502
(#900015= X right side +#512 +probe hosei)

N014
#900016=[#900015+#900014]/2
#900017=#900015-#900014
(average: center)
(difference: width)

N015
G90 G01 X#900016 F#676
(X to measured center)
G91 G01 X-[#31*#28] Z#30 F#676
(X to measured tanmen center)
IF[[ABS[#900015+#501-#502]]GE[ABS[#29+#603]]]GOTO800
(if |#900015 -probe hosei|>=|#29+#603|, go to N800)

#[5201+[#33-53]*20]=#5021
(current work origin X = current machine X)

N990
G90 G01 Z[#26+#601] F#676
GOTO999


N803
G90 G01 X#32 F#676 (X to start point)
G90 G53 G01 Z0 F#676
G65 P910002 (sensor OFF)
#3000=121 (are the arguments or the mould OK?)

N802
G90 G53 G01 Z0 F#676
G65 P910002 (sensor OFF)
#3000=121 (are the arguments or the mould OK?)

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