%
O120001 (X center of outer measurement)

N001
#33=#4012
#32=#5001
(#33= current work coordinate G#)
(#32= block end X: start position X)

N002
IF[#33NE58]GOTO800
(if work G# is not 58, go to N800)

N003
IF[#21EQ#0]GOTO800
IF[#21LT10]GOTO800
IF[#26EQ#0]GOTO800
(if U < 10 or #0, go to N800)
(if Z = #0, go to N800)

N004
IF[#26LE[#901011/2]]GOTO800
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
IF[#901011LT660]GOTO800
(if #901050 <= 1 or #0, go to N800)
(if #600 < 50 or #0, go to N800)
(if #602 <= 0 or #0, go to N800)
(if #603 < 0 or #603 > 20.0 or #0, go to N800)
(if #656 is not 50.0, go to N800)
(if #901011 < 660 or #0, go to N800)

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
G91 G01 X[[#21/2]+#901050+#602] F#652
(X-: [U/2 +#901050+#602])

G90 G31 Z[#26-#901050-[#13+#419]-[[#11+#420]/2]] F#653
(Z skip: Z-#901050-M-H/2)
IF[#5003GT[#26-#901050-[#13+#419]-[[#11+#420]/2]]]GOTO802
(if skip Z > Z-#901050-M-H/2, to N802)

N011
G91 G31 X-[#602+#603] F#656
(X- skip: #602+#603)
#900011=#5001-#901050+#501+#502
(#900011= A-face: block end -#901050 +probe hosei)

N012
G91 G01 X[#602+#603] F#652
(X+: #602+#603)
G90 G01 Z[#26+#600] F#650
(Z+: Z+#901050+#600)
IF[[ABS[#900011-#501-#502]]LE[ABS[[#21/2]-#602]]]GOTO800
(if |#900011 -probe hosei|<=|U/2-#602|, go to N800)

G90 G01 X[#900011-#04-[#24/2]] F#652
(X to mizo center)
#[5201+[#33-53]*20]=#5021
(current work origin X = current machine X)
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
(#04:I: A-side mizo depth)
(#11:H: mizo width)
(#13:M: mizo position)
(#21:U: X outside width)
(#24:X: AC mizoKei)
(#26:Z: sai_furiwake)

(as LHS)
(#29, #30, #31, #32, #33)


(Common variables)
(as LHS)
(#900001, #900002, #900003, #900004)
(as RHS)
(#600, #602, #603, #650, #652, #653, #656)
(#501: hosei: touch sensor signal delay)
(#502: hosei: probe center X)
(#900011, #901011)
(#901050: probe radius)


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