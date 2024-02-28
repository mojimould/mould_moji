%
O140001 (X center: left side measurement)

N001
#33=#4012
#32=#5001
(#33= current work coordinate G#)
(#32= block end X: start position X)

N002
IF[#33LT54]GOTO800
IF[#33GT59]GOTO800
IF[#33NE[FUP[#33]]]GOTO800
(if work G# < 54, go to N800)
(if work G# > 59, go to N800)
(if work G# is not integer, go to N800)

N003
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#04EQ#0]GOTO800
IF[#04LT10]GOTO800
IF[#26EQ#0]GOTO800
IF[#23EQ#0]GOTO800
IF[#23LT10]GOTO800
IF[#20EQ#0]GOTO800
IF[#20LT1]GOTO800
IF[#03LT0]GOTO800
IF[#18EQ#0]GOTO800
IF[#13EQ#0]GOTO800
IF[#13LT0]GOTO800
IF[#13GT10]GOTO800
(if X < 10 or #0, go to N800)
(if I < 10 or #0, go to N800)
(if Z = #0, go to, N800)
(if W < 10 or #0, go to N800)
(if T < 1 or #0, go to N800)
(if C < 0, go to N800)
(if R = #0, go to, N800)
(if M < 0 or M > 10 or #0, go to N800)

N004
IF[#18LE#26]GOTO800
IF[#24LE[#04+#20]]GOTO800
IF[#20LE#13]GOTO800
IF[#20GE[#24/2]]GOTO800
IF[#03GE[#26/4]]GOTO800
IF[#26LE[#901011/2]]GOTO800
(if R <= Z, go to N800)
(if X <= I+T, go to N800)
(if T <= M, go to N800)
(if T >= X/2, go to N800)
(if C >= Z/4, go to N800)
(if Z <= #901011/2, go to N800)

N005
IF[#512EQ#0]GOTO800
IF[#512LE0]GOTO800
IF[#600EQ#0]GOTO800
IF[#600LT50]GOTO800
IF[#602EQ#0]GOTO800
IF[#602LE0]GOTO800
IF[#603EQ#0]GOTO800
IF[#603LT0]GOTO800
IF[#603GT20]GOTO800
IF[#656NE50]GOTO800
IF[#901011EQ#0]GOTO800
IF[#901011LE100]GOTO800
(if #512 <= 0 or #0 go to N800)
(if #600 < 50 or #0, go to N800)
(if #602 <= 0 or #0, go to N800)
(if #603 < 0 or #603 > 20.0 or #0, go to N800)
(if #656 is not 50.0, go to N800)
(if #901011 <= 100 or #0 go to N800)

N006
IF[#33GE56]THEN #31=1
IF[#33LE55]THEN #31=-1
(Top: #31=1, Bot: #31=-1)
IF[#33GE56]THEN #30=#410
IF[#33LE55]THEN #30=#405
(Top: #30=#410-C, Bot: #30=#405-C)
IF[[ABS[#30]]GE[#26/4]]GOTO800
IF[[ABS[#30]]GE[#23/4]]GOTO800
(if |#30| >= Z/4, go to N800)
(if |#30| >= W/4, go to N800)

N007
#29=[#24/2]-#20+#13
#28=SQRT[[#18+#04/2]*[#18+#04/2]-[#23-#03]*[#23-#03]]-SQRT[[#18+#04/2]*[#18+#04/2]-#23*#23]
#27=SQRT[[#18+#04/2]*[#18+#04/2]-[#23-#03-#30]*[#23-#03-#30]]-SQRT[[#18+#04/2]*[#18+#04/2]-[#23-#03]*[#23-#03]]
(#29=X/2-T+M)
(#28: X hosei from tanmen to C)
(#27: X hosei from C to #30)
IF[[ABS[#28]]GE[#24/4]]GOTO800
IF[[ABS[#27+#28]]GE[#24/4]]GOTO800
(if |#28| >= X/4, go to N800)
(if |#27+#28| >= X/4, go to N800)

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
G90 G31 Z[#26-#512] F#653
(Z skip: Z-#512)
IF[#5003GT[#26-#512]]GOTO802
(if skip Z > Z-#512, to N802)

G91 G31 X[#31*#28] Z-#03 F#653
(X skip to #31*#28)
(Z skip to Z-#512-C)
IF[#5001GT[#32+#31*#28+0.001]]GOTO803
IF[#5003GT[#26-#512-#03]]GOTO802
(if skip X > #32+#31*#28, to N802)
(if skip Z > Z-#512-C, to N802)

G91 G31 X[#31*#27] Z-#30 F#653
(X skip to #31*[#28+#27])
(Z skip to Z-#512-C-#30)
IF[#5001GT[#32+#31*#28+#31*#27+0.001]]GOTO803
IF[#5003GT[#26-#512-#03-#30]]GOTO802
(if skip X > #32+#31*[#28+#27], to N802)
(if skip Z > Z-#512-#03-#30, to N802)

N011
G91 G31 X[#31*[#29-#512-#602]] F#653
(X skip: #31*[#29-#512-#602])
IF[[ABS[#5001-#32]+0.001]LT[ABS[#29-#512-#602]]]GOTO803
(if |skipX-#32| < |#29-#512-#602|, go to N803)

G91 G31 X[#31*[#602+#603]] F#656
(X skip: #31*[#602+#603])
#900024=#5001+#502+#31*[#512-#501]
(#900024= skip X +#502+#31*[#512-#501])

N012
G90 G01 X[#900024-#31*#29] F#652
(X to measured center)
G91 G01 X-[#31*#27] Z#30 F#652
(X to measured center at Z-C)
IF[[ABS[#900024-#502]]GE[ABS[#29+#602-#501]]]GOTO800
(if |#900024-#502|>=|#29-#602-#501|, go to N800)

#[5201+[#33-53]*20]=#5021
(current work origin X = current machine coordinate X)

N990
G90 G01 Z[#26+#600] F#650
GOTO999


N803
G90 G01 X#32 F#652
(X to start point)
G90 G53 G01 Z0 F#652
G65 P910002 (sensor OFF)
#3000=121 (are the arguments or the mould OK?)

N802
G90 G53 G01 Z0 F#652
G65 P910002 (sensor OFF)
#3000=121 (are the arguments or the mould OK?)

N800
#3000=121 (are the arguments or the mould OK?)

N999 M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#03:C: measurement depth from tanmen)
(#04:I: AC naiKei)
(#13:M: mekki mm)
(#18:R: central curvature)
(#20:T: A-nikuatsu)
(#23:W: ori_furiwake)
(#24:X: AC gaisakuKei)
(#26:Z: sai_furiwake)

(as LHS)
(#27, #28, #29, #30, #31, #32, #33)


(Common variables)
(as LHS)
(#900024)
(as RHS)
(#405, #410, #600, #602, #603, #650, #652, #653, #656)
(#501: hosei: touch sensor signal delay)
(#502: hosei: probe center X)
(#512: probe radius)
(#901011)


(System variables)
(#1004: 0: sensor off, 1: on)
(#1005: 0: sensor battery ok, 1: low battery)
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