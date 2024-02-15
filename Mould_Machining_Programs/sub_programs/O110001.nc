%
O110001 (X center of outer measurement)

N001
#33=#4012
#32=#5001
(#33= current work coordinate G#)
(#32= current work block end X)

IF[#33LT54]GOTO800
IF[#33GT59]GOTO800
(if work G# < 54 go to N800)
(if work G# > 59 go to N800)

IF[#24EQ#0]GOTO800
IF[#24LE0]GOTO800
IF[#26EQ#0]GOTO800
(if X <= 0 or #0, go to N800)
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
IF[#33EQ56]THEN #30=#410
IF[#33EQ57]THEN #30=#410
IF[#33EQ54]THEN #30=#405
IF[#33EQ55]THEN #30=#405
(Top: #30=#410, Bot: #30=#405)
IF[[ABS[#30]]GT[#26/2]]GOTO800
(if |#30| > Z/2, go to N800)

N003
#29=0 (#29: X +hosei)
IF[#23LT10]GOTO800
IF[#100LT10]GOTO800
IF[[ABS[#30]]GE[#23/2]]GOTO800
(if W,R < 10, go to N800)
(if |#30| >= W/2, go to N800)
#29=SQRT[#100*#100-[#23+#30]*[#23+#30]]-SQRT[#100*#100-#23*#23]
IF[[ABS[#29]]GE[#24/2]]GOTO800
(if |#29| >= X/2, go to N800)
IF[#31EQ1]GOTO004
G91 G01 X-#29 F#676
GOTO005
N004
G91 G01 X#29 F#676

N005
IF[#1005EQ1]GOTO801
IF[#1004EQ1]GOTO007
(if low battery, go to N801)
(if current sensor ON, go to N007)
M117 (sensor on/off)
G04 X1. (wait 1.0s)

N007
G91 G01 X-[[#24/2]+#512+#603] F#676
(X-: [AC gaikei/2 + D/2 + #603])

G90 G31 Z[#26-#512+#30] F#678
(Z skip: tanmen Z-D/2+#30)
IF[#5003GT[#26-#512+#30]]GOTO802
(if skip block end Z > tanmen Z-D/2+#30, to N802)

G91 G31 X[#603+#604] F#680
(X+ skip: #603+#604)
#900001=#5001+#512-#501+#502
(#900001= X left side + D/2 + probe hosei)

G91 G01 X-[#603*2] F#676 (X-: #603*2)
G91 G01 Z[#512-#30+#601] F#676
(Z+: D/2-#30+#601)

IF[[ABS[#900001+#501-#502]]LE[ABS[[#24/2]-#603]]]GOTO800
(if |#900001|<=|X/2-#603|, go to N800)

G90 G01 X#32 F#676 (X to start point)
G91 G01 X[[#24/2]+#512+#603] F#676
(X+: [AC gaikei/2 + D/2 + #603])

G90 G31 Z[#26-#512+#30] F#678
(Z skip: tanmen Z-D/2+#30)
IF[#5003GT[#26-#512+#30]]GOTO802
(if skip block end Z > tanmen Z-D/2+#30, to N802)

G91 G31 X-[#603+#604] F#680
(X- skip: #603+#604)
#900002=#5001-#512+#501+#502
(#900002= X right side - D/2 + probe hosei)

G91 G01 X[#603*2] F#676 (X+: #603*2)
G91 G01 Z[#512-#30+#601] F#676
(Z+: D/2-#30+#601)
IF[[ABS[#900002-#501-#502]]LE[ABS[[#24/2]-#603]]]GOTO800
(if |#900002|<=|X/2-#603|, go to N800)

#900003=[#900002+#900001]/2
#900004=#900002-#900001
(average: center)
(difference: thickness)

IF[#31EQ1]GOTO008
G90 G01 X[#900003+#29] F#676
(X to center for Bot)
GOTO009
N008
G90 G01 X[#900003-#29] F#676
(X to center for Top)

N009
#[5201+[#33-53]*20]=#5021
(current work origin X = current machine X)

G90 G01 Z[#26+#601] F#676
GOTO999

N801
#3000=145 (Low battery)
GOTO999

N802
G90 G53 G01 Z0 F#676
G90 G01 X#32 F#676 (X to start point)

N800
G65 P910002 (sensor OFF)
#3000=121 (are the arguments or the mould OK?)

N999 M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#23:W: ori_furiwake)
(#24:X: X outside width)
(#26:Z: sai_furiwake)

(as LHS)
(#30, #31, #32, #33)


(Common variables)
(as LHS)
(#900001, #900002, #900003, #900004)
(as RHS)
(#405, #410, #601, #603, #604, #676, #678, #680)
(#501: hosei: touch sensor signal delay)
(#502: hosei: probe center X)
(#512: probe radius)
(#901011)


(System variables)
(#0   : empty)
(#1004: 0: sensor off, 1: on)
(#1005: 0: sensor battery ok, 1: low battery)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5001: current work block end X)
(#5003: current work block end Z)
(#5021: current machine coordinate X)
(#5221: G54 X)
(#5261: G56 X)


(Subprograms)
(O910002)
%