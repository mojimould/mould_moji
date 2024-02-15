%
O140001 (X center: left side measurement)

N001
#33=#4012
#32=#5001
(#33= current work coordinate G#)
(#32= current work block end X)

IF[#33LT54]GOTO800
IF[#33GT59]GOTO800
IF[#33NE[FUP[#33]]]GOTO800
(if work G# < 54, go to N800)
(if work G# > 59, go to N800)
(if work G# is not integer, go to N800)

IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#26EQ#0]GOTO800
IF[#23EQ#0]GOTO800
IF[#23LT10]GOTO800
IF[#20EQ#0]GOTO800
IF[#20LT1]GOTO800
IF[#18EQ#0]GOTO800
IF[#13EQ#0]GOTO800
IF[#13LT0]GOTO800
IF[#13GT10]GOTO800
(if X < 10 or #0, go to N800)
(if Z = #0, go to, N800)
(if W < 10 or #0, go to N800)
(if T < 1 or #0, go to N800)
(if R = #0, go to, N800)
(if M < 0 or M > 10 or #0, go to N800)

IF[#18LE#26]GOTO800
IF[#20LE#13]GOTO800
IF[#26LE[#901011/2]]GOTO800
(if R <= Z, go to N800)
(if T <= M, go to N800)
(if Z <= #901011/2, go to N800)

IF[#512EQ#0]GOTO800
IF[#512LE0]GOTO800
IF[#603EQ#0]GOTO800
IF[#603LE0]GOTO800
IF[#604EQ#0]GOTO800
IF[#604LT0]GOTO800
IF[#604GT20]GOTO800
IF[#679EQ#0]GOTO800
IF[#679NE50]GOTO800
IF[#901011EQ#0]GOTO800
IF[#901011LE100]GOTO800
(if #512 <= 0 or #0 go to N800)
(if #603 <= 0 or #0, go to N800)
(if #604 < 0 or #604 > 20.0 or #0, go to N800)
(if #679 is not 50.0 or #0, go to N800)
(if #901011 <= 100 or #0 go to N800)

IF[#33EQ56]THEN #31=1
IF[#33EQ57]THEN #31=1
IF[#33EQ54]THEN #31=-1
IF[#33EQ55]THEN #31=-1
(Top: #31=1, Bot: #31=-1)
IF[#33EQ56]THEN #30=#410
IF[#33EQ57]THEN #30=#410
IF[#33EQ54]THEN #30=#405
IF[#33EQ55]THEN #30=#405
(Top: #30=#408, Bot: #30=#403)

IF[[ABS[#30]]GE[#23/2]]GOTO800
(if |#30| >= W/2, go to N800)

N002
#29=[#24/2]-#20+#13
IF[#29LE0]GOTO800
(#29=X/2-T+M)
(if #29 <= 0, go to 800)

N003
#28=0 (#28: X +hosei)
IF[#30EQ#0]GOTO005
IF[#30EQ0]GOTO005
(if #30 = 0 or #0, go to N005)
#28=SQRT[#18*#18-[#23+#30]*[#23+#30]]-SQRT[#18*#18-#23*#23]
IF[[ABS[#28]]GE[#24/2]]GOTO800
(if |#28| >= X/2, go to N800)

N004
G91 G01 X[#31*#28] F#676

N005
IF[#1005EQ0]GOTO006
M00 (sensor low battery)
N006
IF[#1004EQ1]GOTO007
(if low battery, go to N801)
(if current sensor ON, go to N007)
M117 (sensor on/off)
G04 X1. (wait 1.0s)

N007
G90 G31 Z[#26-#512+#30] F#678
(Z skip tanmen: Z -D/2)
IF[#5003GT[#26-#512+#30]]GOTO802
(if skip block end Z > tanmen Z -D/2+#30, to N802)

N008
G91 G31 X[#31*[#29-#512-#603]] F#678
(X skip: #31*[#29-D/2-#603])
IF[[ABS[#5001-#32]+0.001]LT[ABS[#29-#512-#603]]]GOTO803
(if |skipX-#32| < |#29-D/2-#603| to N803)

G91 G31 X[#31*[#603+#604]] F#679
(X skip: #31*[#603+#604])
#900024=#5001+#502+#31*[#512-#501]
(#900024= block end X +#502+#31*[D/2-#501])

N009
G90 G01 X[#900024-#31*#29] F#676
(X to measured center)
G91 G01 X-[#31*#28] F#676
(X to measured tanmen center)
IF[[ABS[#900024-#502]]GE[ABS[#29+#603-#501]]]GOTO800
(if |#900024-#502|>=|#29-#603-#501|, go to N800)

#[5201+[#33-53]*20]=#5021
(current work origin X = current machine coordinate X)

G90 G01 Z[#26+#601] F#676
GOTO999


N801
#3000=145 (sensor low battery)
GOTO999

N803
G90 G01 X#32 F#676 (X to start point)
G90 G53 G01 Z0 F#676
G65 P910002 (sensor OFF)
#3000=121 (Argument Is Not Assigned)

N802
G90 G53 G01 Z0 F#676
G65 P910002 (sensor OFF)
#3000=121 (Argument Is Not Assigned)

N800
#3000=121 (Argument Is Not Assigned)

N999 M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#13:M: mekki mm)
(#18:R: central curvature)
(#20:T: A-nikuatsu)
(#23:W: ori_furiwake)
(#24:X: AC gaisakuKei)
(#26:Z: sai_furiwake)

(as LHS)
(#28, #29, #30, #31, #32, #33)


(Common variables)
(as LHS)
(#900024)
(as RHS)
(#403, #408, #601, #603, #604, #676, #678, #679)
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
(#5221: G54 X)
(#5261: G56 X)


(Subprogram)
(O910002)
%