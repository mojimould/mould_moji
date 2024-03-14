%
O110001 (X center of outer measurement)

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
(if X < 10 or #0, go to N800)
(if Z = #0, go to N800)
(if W < 10 or #0, go to N800)
(if R = #0, go to N800)

N004
IF[#18LE#26]GOTO800
IF[#26LE[#901011/2]]GOTO800
(if R <= Z, go to N800)
(if Z <= #901011/2, go to N800)

N005
IF[#901050EQ#0]GOTO800
IF[#901050LE1]GOTO800
IF[#600EQ#0]GOTO800
IF[#600LT50]GOTO800
IF[#602EQ#0]GOTO800
IF[#602LE0]GOTO800
IF[#603EQ#0]GOTO800
IF[#603LT0]GOTO800
IF[#603GT20]GOTO800
IF[#655EQ#0]GOTO800
IF[#655LE10]GOTO800
IF[#901011EQ#0]GOTO800
IF[#901011LE100]GOTO800
(if #901050 <= 1 or #0, go to N800)
(if #600 < 50 or #0, go to N800)
(if #602 <= 0 or #0, go to N800)
(if #603 < 0 or #603 > 20.0 or #0, go to N800)
(if #655 <= 10 or #0, go to N800)
(if #901011 <= 100 or #0, go to N800)

N006
IF[#33GE56]THEN #31=1
IF[#33LE55]THEN #31=-1
(Top: #31=1, Bot: #31=-1)
IF[#33GE56]THEN #30=#409
IF[#33LE55]THEN #30=#404
(Top: #30=#409, Bot: #30=#404)
IF[[ABS[#30]]GE[#26/4]]GOTO800
IF[[ABS[#30]]GE[#23/4]]GOTO800
(if |#30| >= Z/4, go to N800)
(if |#30| >= W/4, go to N800)

N007
#29=SQRT[#18*#18-[#23-#30]*[#23-#30]]-SQRT[#18*#18-#23*#23]
(#29: X hosei from #30)
IF[[ABS[#29]]GE[#24/4]]GOTO800
(if |#29| >= X/4, go to N800)

N008
IF[#1005EQ0]GOTO009
M00 (sensor low battery)
N009
IF[#1004EQ1]GOTO010
(if current sensor ON, go to N010)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)


(kokokara G01)


N010
G91 G01 X[#31*#29] F#652
G91 G01 X-[[#24/2]+#901050+#602] F#652
(X-: [AC gaikei/2 +#901050+#602])

G90 G31 Z[#26-#901050-#30] F#653
(Z skip: Z-#901050-#30)
IF[#5003GT[#26-#901050-#30]]GOTO802
(if skip Z > Z-#901050-#30, to N802)

N011
G91 G31 X[#602+#603] F#655
(X+ skip: #602+#603)
#900001=#5001+#901050-#901053+#502
(#900001= X left side +#901050 +probe hosei)

N012
G91 G01 X-[#602+#603] F#652
(X-: #602+#603)
G91 G01 Z[#30+#901050+#600] F#650
(Z+: #30+#901050+#600)
IF[[ABS[#900001+#901053-#502]]LE[ABS[[#24/2]-#602]]]GOTO800
(if |#900001 -probe hosei|<=|X/2-#602|, go to N800)

G90 G01 X[#32+#31*#29] F#652
(X to start point +hosei)

N013
G91 G01 X[[#24/2]+#901050+#602] F#652
(X+: [AC gaikei/2 +#901050+#602])

G90 G31 Z[#26-#901050-#30] F#653
(Z skip: Z-#901050-#30)
IF[#5003GT[#26-#901050-#30]]GOTO802
(if skip Z > Z-#901050-#30, to N802)

N014
G91 G31 X-[#602+#603] F#655
(X- skip: #602+#603)
#900002=#5001-#901050+#901053+#502
(#900002= X right side -#901050 +probe hosei)

N015
G91 G01 X[#602+#603] F#652
(X+: #602+#603)
G91 G01 Z[#30+#901050+#600] F#650
(Z+: #30+#901050+#600)
IF[[ABS[#900002-#901053-#502]]LE[ABS[[#24/2]-#602]]]GOTO800
(if |#900002 -probe hosei|<=|X/2-#602|, go to N800)

N016
#900003=[#900002+#900001]/2
#900004=#900002-#900001
(average: center)
(difference: thickness)

N017
G90 G01 X#900003 F#652
(X to measured center)
G91 G01 X-[#31*#29] F#652
(X to measured tanmen center)

#[5201+[#33-53]*20]=#5021
(current work origin X = current machine X)

N990
G90 G01 Z[#26+#600] F#652
GOTO999


N802
G90 G53 G01 Z0 F#652
G90 G01 X#32 F#652
(X to start point)
G65 P910002 (sensor OFF)
#3000=121 (are the arguments or the mould OK?)

N800
G65 P910002 (sensor OFF)
#3000=121 (are the arguments or the mould OK?)

N999 M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#18:R: central curvature)
(#23:W: ori_furiwake)
(#24:X: X outside width)
(#26:Z: sai_furiwake)

(as LHS)
(#29, #30, #31, #32, #33)


(Common variables)
(as LHS)
(#900001, #900002, #900003, #900004)
(as RHS)
(#404, #409, #600, #602, #603, #650, #652, #653, #655)
(#901011)
(#901050: probe radius)
(#901053: hosei: touch sensor signal delay)
(#502: hosei: probe center X)


(System variables)
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