%
O110001 (X center of outer measurement)

N001
#33=#4012
#32=#5001
(#33= current work coordinate G#)
(#32= block end X: start position X)

N002
IF[#33EQ54]GOTO003
IF[#33EQ56]GOTO003
GOTO800
(if work G# is neither 54 nor 56, go to N800)

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
IF[#656NE50]GOTO800
IF[#901011EQ#0]GOTO800
IF[#901011LE100]GOTO800
(if #901050 <= 1 or #0, go to N800)
(if #600 < 50 or #0, go to N800)
(if #602 <= 0 or #0, go to N800)
(if #603 < 0 or #603 > 20.0 or #0, go to N800)
(if #656 isn't 50 or #0, go to N800)
(if #901011 <= 100 or #0, go to N800)

N006
IF[#33EQ56]THEN #31=1
IF[#33EQ54]THEN #31=-1
(Top: #31=1, Bot: #31=-1)
IF[#33EQ56]THEN #30=#409
IF[#33EQ54]THEN #30=#404
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
(X-: X/2 +#901050+#602)

G90 G31 Z[#26-#901050-#30] F#653
IF[#5003GT[#26-#901050-#30]]GOTO802
(Z skip: Z-#901050-#30)
(if skip Z > Z-#901050-#30, to N802)

N011
G91 G31 X[#602+#603] F#656
#900000=#5001+#901050-#901053+#901054
(X+ skip: #602+#603)
(#900000= skip X +#901050 +probe hosei)

N012
G91 G01 X-[#602+#603] F#652
G91 G01 Z[#30+#901050+#600] F#650
IF[[ABS[#900000+#901053-#901054]]LE[ABS[[#24/2]-#603]]]GOTO800
(X-: #602+#603)
(Z+: #30+#901050+#600)
(if |#900000 -probe hosei|<=|X/2-#603|, go to N800)

G90 G01 X[#32+#31*#29] F#652
(X to start point +hosei)

N013
G91 G01 X[[#24/2]+#901050+#602] F#652
(X+: X/2 +#901050+#602)

G90 G31 Z[#26-#901050-#30] F#653
IF[#5003GT[#26-#901050-#30]]GOTO802
(Z skip: Z-#901050-#30)
(if skip Z > Z-#901050-#30, to N802)

N014
G91 G31 X-[#602+#603] F#656
#900001=#5001-#901050+#901053+#901054
(X- skip: #602+#603)
(#900001= skip X -#901050 +probe hosei)

N015
G91 G01 X[#602+#603] F#652
G91 G01 Z[#30+#901050+#600] F#650
IF[[ABS[#900001-#901053-#901054]]LE[ABS[[#24/2]-#603]]]GOTO800
(X+: #602+#603)
(Z+: #30+#901050+#600)
(if |#900001 -probe hosei|<=|X/2-#603|, go to N800)

N016
#900002=[#900001+#900000]/2
IF[#33EQ56]THEN #900003=#900001-#900000
IF[#33EQ54]THEN #900004=#900001-#900000
(#900002: center)
(#900003: length for top)
(#900004: length for bot)

N017
G90 G01 X#900002 F#652
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
(#26:Z: sai-furiwake)

(as LHS)
(#29, #30, #31, #32, #33)


(Common variables)
(as LHS)
(#900000, #900001, #900002, #900003, #900004)
(as RHS)
(#404, #409, #600, #602, #603, #650, #652, #653, #656)
(#901011)
(#901050: probe radius)
(#901053: hosei: touch sensor signal delay)
(#901054: hosei: probe center X)


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