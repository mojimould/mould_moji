%
O130002 (Y center of inner measurement)

N001
#33=#4012
(#33= current work coordinate G#)

IF[#33LT54]GOTO800
IF[#33GT59]GOTO800
(if work G# < 54 go to N800)
(if work G# > 59 go to N800)

IF[#25EQ#0]GOTO800
IF[#25LE0]GOTO800
IF[#26EQ#0]GOTO800
IF[#13EQ#0]GOTO800
IF[#13LT0]GOTO800
IF[#13GT10]GOTO800
(if Y <= 0 or #0, go to N800)
(if Z = #0, go to N800)
(if M < 0 or M > 10 or #0, go to N800)

IF[#26LE[#901011/2]]GOTO800
(if Z <= #901011/2, go to N800)

IF[#901011EQ#0]GOTO800
IF[#901011LE100]GOTO800
IF[#512EQ#0]GOTO800
IF[#512LE0]GOTO800
IF[#603EQ#0]GOTO800
IF[#603LE0]GOTO800
IF[#604EQ#0]GOTO800
IF[#604LT0]GOTO800
IF[#604GT20]GOTO800
IF[#680EQ#0]GOTO800
IF[#680LE10]GOTO800
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
IF[#33EQ56]THEN #31=#413
IF[#33EQ57]THEN #31=#413
IF[#33EQ54]THEN #31=#408
IF[#33EQ55]THEN #31=#408
(Top: #31=#413, Bot: #31=#408)

N002
#30=#25/2+#13
IF[[#30-#512-#603]LE0]GOTO800
(if Y/2+mekki-D/2-#603 <= 0 go to N800)
IF[[ABS[#31]]GT#26/2]GOTO800
(if |#31| > Z/2, go to N800)

N004
#29=#5002
(#29= current work block end Y)

IF[#1005EQ1]GOTO801
IF[#1004EQ1]GOTO005
(if low battery, go to N801)
(if current sensor ON, go to N005)
M117 (sensor on/off)
G04 X1. (wait 1.0s)

N005
G90 G31 Z[#26-#512+#31] F#678
(Z tanmen: Z-D/2+#31)
IF[#5003GT[#26-#512+#31]]GOTO802
(if skip block end Z > tanmen Z-D/2+#31, to N802)

G91 G31 Y-[#30-#512-#603] F#678
(Y-: [BD naikei/2 -D/2 -#603])
IF[[ABS[#5002-#29]+0.001]LT[ABS[#30-#512-#603]]]GOTO803
(if |skipY-#29| < |BD naikei/2 -D/2 -#603|, to N803)

G91 G31 Y-[#603+#604] F#680
(Y- skip: #603+#604)
#900019=#5002-#512+#501+#503
(#900019= Y bellow side -D/2 +probe hosei)

G91 G01 Y#603 F#676 (Y+: #603)
IF[[ABS[#900019-#501-#503]]GE[ABS[#30+#603]]]GOTO800
(if |#900019|>=|Y/2+#603| go to N800)

G90 G01 Y#29 F#676 (Y to start point)

G91 G31 Y[#30-#512-#603] F#678
(Y+: [BD gaikei/2 -D/2 -#603])
IF[[ABS[#5002-#29]+0.001]LT[ABS[#30-#512-#603]]]GOTO803
(if |skipY - #29| < |BD naikei/2 -D/2 -#603|, to N803)

G91 G31 Y[#603+#604] F#680
(Y+ skip: #603+#604)
#900020=#5002+#512-#501+#503
(#900020= Y above side +D/2 +probe hosei)

G91 G01 Y-#603 F#676 (Y-: #603)
IF[[ABS[#900020+#501-#503]]GE[ABS[#30+#603]]]GOTO800
(if |#900020| >= |Y/2+#603| go to N800)

#900021=[#900020+#900019]/2
#900022=#900020-#900019
(average: center)
(difference: width)

G90 G01 Y#900021 F#676
(Y to measured center)

#[5202+[#33-53]*20]=#5022
(current work origin Y = current machine Y)

G90 G01 Z[#26+#601] F#676
GOTO999


N801
#3000=145 (Low battery)

N803
G90 G01 Y#29 F#676 (Y to start point)

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
(#25:Y: Y inside width)
(#26:Z: sai-furiwake)

(as LHS)
(#29, #30, #31, #32, #33)


(Common variables)
(as LHS)
(#900019, #900020, #900021, #900022)
(as RHS)
(#408, #413, #601, #603, #604, #676, #678, #680)
(#501: hosei: touch sensor signal delay)
(#503: hosei: probe center Y)
(#512: probe radius)
(#901011)


(System variables)
(#0   : empty)
(#1004: 0: sensor off, 1: on)
(#1005: 0: sensor battery ok, 1: low battery)
(#2050: hosei #50 KouguChou)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5002: current work block end point Y)
(#5003: current work block end point Z)
(#5022: current machine coordinate Y)
(#5242: G55 Y)
(#5282: G57 Y)


(Subprograms)
(O910002)
%