%
O110002 (Y center of outer measurement)

N001
#33=#4012
#32=#5002
(#33= current work coordinate G#)
(#32= current work block end Y)

IF[#33LT54]GOTO800
IF[#33GT59]GOTO800
(if work G# < 54 go to N800)
(if work G# > 59 go to N800)

IF[#25EQ#0]GOTO800
IF[#25LE0]GOTO800
IF[#26EQ#0]GOTO800
(if Y <= 0 or #0, go to N800)
(if Z = #0, go to N800)

IF[#26LE[#901011/2]]GOTO800
(if Z <= #901011/2, go to N800)

IF[#901011EQ#0]GOTO800
IF[#901011LE100]GOTO800
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
(if #901011 <= 100 or #0, go to N800)
(if #512 <= 1 or #0, go to N800)
(if #601 < 50 or #0, go to N800)
(if #603 <= 0 or #0, go to N800)
(if #604 < 0 or #604 > 20.0 or #0, go to N800)
(if #680 <= 10 or #0, go to N800)

N002
IF[#33EQ56]THEN #31=1
IF[#33EQ57]THEN #31=1
IF[#33EQ54]THEN #31=-1
IF[#33EQ55]THEN #31=-1
(Top: #31=1, Bot: #31=-1)
IF[#33EQ56]THEN #30=#411
IF[#33EQ57]THEN #30=#411
IF[#33EQ54]THEN #30=#406
IF[#33EQ55]THEN #30=#406
(Top: #30=#411, Bot: #30=#406)
IF[[ABS[#30]]GT[#26/2]]GOTO800
(if |#30| > Z/2, go to N800)

N004
IF[#1005EQ1]GOTO801
IF[#1004EQ1]GOTO005
(if low battery, go to N801)
(if current sensor ON, go to N005)
M117 (sensor on/off)
G04 X1. (wait 1.0s)

N005
G91 G01 Y-[[#25/2]+#512+#603] F#676
(Y-: [BD gaikei/2 + D/2 + #603])

G90 G31 Z[#26-#512+#30] F#678
(Z skip: tanmen Z-D/2+#30)
IF[#5003GT[#26-#512+#30]]GOTO802
(if skip block end Z > tanmen Z-D/2+#30, to N802)

G91 G31 Y[#603+#604] F#680
(Y+ skip: #603+#604)
#900006=#5002+#512-#501+#503
(#900006= Y bellow side + D/2 + probe hosei)

G91 G01 Y-[#603*2] F#676 (Y-: #603*2)
G91 G01 Z[#512-#30+#601] F#676
(Z+: D/2-#30+#601)

IF[[ABS[#900006+#501-#503]]LE[ABS[[#25/2]-#603]]]GOTO800
(if |#900006|<=|Y/2-#603|, go to N800)

G90 G01 Y#32 F#676 (Y to start point)
G91 G01 Y[[#25/2]+#512+#603] F#676
(Y+: [BD gaikei/2 + D/2 + #603])

G90 G31 Z[#26-#512+#30] F#678
(Z skip: tanmen Z-D/2+#30)
IF[#5003GT[#26-#512+#30]]GOTO802
(if skip block end Z > tanmen Z-D/2+#30, to N802)

G91 G31 Y-[#603+#604] F#680
(Y- skip: #603+#604)
#900007=#5002-#512+#501+#503
(#900007= Y above side - D/2 + probe hosei)

G91 G01 Y[#603*2] F#676 (Y+: #603*2)
G91 G01 Z[#512-#30+#601] F#676
(Z+: D/2-#30+#601)
IF[[ABS[#900007-#501-#503]]LE[ABS[[#25/2]-#603]]]GOTO800
(if |#900007|<=|Y/2-#603|, go to N800)

#900008=[#900007+#900006]/2
#900009=#900007-#900006
(average: center)
(difference: thickness)
G90 G01 Y#900008 F#676
(Y to measured center)

#[5202+[#33-53]*20]=#5022
(current work origin Y = current machine Y)

G90 G01 Z[#26+#601] F#676
GOTO999

N801
#3000=145 (Low battery)
GOTO999

N802
G90 G53 G01 Z0 F#676
G90 G01 Y#32 F#676 (Y to start point)

N800
G65 P910002 (sensor OFF)
#3000=121 (are the arguments or the mould OK?)

N999 M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#25:Y: Y outside width)
(#26:Z: sai_furiwake)

(as LHS)
(#30, #31, #32, #33)


(Common variables)
(as LHS)
(#900006, #900007, #900008, #900009)
(as RHS)
(#406, #411, #601, #603, #604, #676, #678, #680)
(#501: hosei: touch sensor signal delay)
(#503: hosei: probe center Y)
(#512: probe radius)
(#901011)


(System variables)
(#0   : empty)
(#1004: 0: sensor off, 1: on)
(#1005: 0: sensor battery ok, 1: low battery)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5002: current work block end Y)
(#5003: current work block end Z)
(#5022: current machine coordinate Y)
(#5222: G54 Y)
(#5262: G56 Y)


(Subprograms)
(O910002)
%