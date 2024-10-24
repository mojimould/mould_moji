%
O110001 (last update on 20241010)
(X center of outer measurement)

N0001
#33=#4012
#32=#5001
(#33= current work coordinate G#)
(#32= block end X: start position X)

N0002
IF[#33EQ54]GOTO0003
IF[#33EQ56]GOTO0003
GOTO8000
(if work G# is neither 54 nor 56, go to N8000)

N0003
IF[#24EQ#0]GOTO8000
IF[#24LT10]GOTO8000
IF[#26EQ#0]GOTO8000
IF[#23EQ#0]GOTO8000
IF[#23LT10]GOTO8000
IF[#18EQ#0]GOTO8000
(if X < 10 or #0, go to N8000)
(if Z = #0, go to N8000)
(if W < 10 or #0, go to N8000)
(if R = #0, go to N8000)

N0004
IF[#33EQ54]GOTO0005
IF[#13LE1]GOTO8000
IF[#11LE1]GOTO8000
IF[ABS[#419]GE1]GOTO8000
IF[ABS[#420]GE1]GOTO8000
(if M <= 1, go to N8000)
(if H <= 1, go to N8000)
(if |#419| >= 1, go to N8000)
(if |#420| >= 1, go to N8000)

N0005
IF[#18LE#26]GOTO8000
IF[#26LE[#901011/2]]GOTO8000
(if R <= Z, go to N8000)
(if Z <= #901011/2, go to N8000)

N0008
IF[#901050EQ#0]GOTO8000
IF[#901050LE1]GOTO8000
IF[#600EQ#0]GOTO8000
IF[#600LT50]GOTO8000
IF[#602EQ#0]GOTO8000
IF[#602LE0]GOTO8000
IF[#603EQ#0]GOTO8000
IF[#603LT0]GOTO8000
IF[#603GT20]GOTO8000
IF[#656NE50]GOTO8000
IF[#901011EQ#0]GOTO8000
IF[#901011LE100]GOTO8000
(if #901050 <= 1 or #0, go to N8000)
(if #600 < 50 or #0, go to N8000)
(if #602 <= 0 or #0, go to N8000)
(if #603 < 0 or #603 > 20.0 or #0, go to N8000)
(if #656 is not 50 or #0, go to N8000)
(if #901011 <= 100 or #0, go to N8000)

N0009
IF[#33EQ56]THEN #31=1
IF[#33EQ54]THEN #31=-1
(Top: #31=1, Bot: #31=-1)
IF[#33EQ56]THEN #30=#409
IF[#33EQ54]THEN #30=#404
(Top: #30=#409, Bot: #30=#404)
IF[[ABS[#30]]GE[#26/4]]GOTO8000
IF[[ABS[#30]]GE[#23/4]]GOTO8000
(if |#30| >= Z/4, go to N8000)
(if |#30| >= W/4, go to N8000)

N0010
#29=SQRT[#18*#18-[#23-#30]*[#23-#30]]-SQRT[#18*#18-#23*#23]
(#29: X compensation from #30)
IF[[ABS[#29]]GE[#24/4]]GOTO8000
(if |#29| >= X/4, go to N8000)

N0011
IF[#1005EQ0]GOTO0012
M00 (sensor low battery)
N0012
IF[#1004EQ1]GOTO0013
(if current sensor ON, go to N0013)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)


(kokokara G01)


N0013
G91 G01 X[#31*#29] F#652
G91 G01 X-[[#24/2]+#901050+#602] F#652
(X-: X/2 +#901050+#602)

G90 G31 Z[#26-#901050-#30] F#653
IF[#5003GT[#26-#901050-#30+0.001]]GOTO8002
(Z skip: Z-#901050-#30)
(if skip Z > Z-#901050-#30, to N8002)

N0014
G91 G31 X[#602+#603] F#656
#900000=#5001+#901050-#901053+#901054
(X+ skip: #602+#603)
(#900000= skip X +#901050 +probe compensation)

N0015
G91 G01 X-[#602+#603] F#652
G91 G01 Z[#30+#901050+#600] F#650
IF[[ABS[#900000+#901053-#901054]]LE[ABS[[#24/2]-#603]]]GOTO8000
(X-: #602+#603)
(Z+: #30+#901050+#600)
(if |#900000 -probe compensation|<=|X/2-#603|, go to N8000)

G90 G01 X[#32+#31*#29] F#652
(X to start point +compensation)

N0016
G91 G01 X[[#24/2]+#901050+#602] F#652
(X+: X/2 +#901050+#602)

G90 G31 Z[#26-#901050-#30] F#653
IF[#5003GT[#26-#901050-#30+0.001]]GOTO8002
(Z skip: Z-#901050-#30)
(if skip Z > Z-#901050-#30, to N8002)

N0017
G91 G31 X-[#602+#603] F#656
#900001=#5001-#901050+#901053+#901054
(X- skip: #602+#603)
(#900001= skip X -#901050 +probe compensation)

N0018
G91 G01 X[#602+#603] F#652
G91 G01 Z[#30+#901050+#600] F#650
IF[[ABS[#900001-#901053-#901054]]LE[ABS[[#24/2]-#603]]]GOTO8000
(X+: #602+#603)
(Z+: #30+#901050+#600)
(if |#900001 -probe compensation|<=|X/2-#603|, go to N8000)

N0019
#900002=[#900001+#900000]/2
IF[#33EQ56]THEN #900003=#900001-#900000
IF[#33EQ54]THEN #900004=#900001-#900000
(#900002: center)
(#900003: length for top)
(#900004: length for bot)

N0020
G90 G01 X#900002 F#652
(X to measured center)
G91 G01 X-[#31*#29] F#652
(X to measured endface center)

#[5201+[#33-53]*20]=#5021
IF[#33EQ56]THEN #5301=#5261+SQRT[#18*#18-[#23-[#13+#419]-[[#11+#420]/2]]*[#23-[#13+#419]-[[#11+#420]/2]]]-SQRT[#18*#18-#23*#23]+[#11*#11]/[8*#18]
(current work origin X = current machine X)
(if top, G58X = G56X +compensation)

N9990
G90 G01 Z[#26+#600] F#652
GOTO9999


N8002
G90 G53 G01 Z0 F#652
G90 G01 X#32 F#652
(X to start point)
G65 P910002 (sensor OFF)
#3000=121 (are*the*arguments*or*the*mould*OK?)

N8000
G65 P910002 (sensor OFF)
#3000=121 (are*the*arguments*or*the*mould*OK?)

N9999
M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#11:H: keyway width)
(#13:M: keyway pos)
(#18:R: central curvature)
(#23:W: alocation length)
(#24:X: X outside width)
(#26:Z: re-alocation length)

(as LHS)
(#29, #30, #31, #32, #33)

(Common variables)
(as LHS)
(#900000, #900001, #900002, #900003, #900004)
(as RHS)
(#404, #409, #419, #420)
(#600, #602, #603, #650, #652, #653, #656)
(#901011)
(#901050: probe radius)
(#901053: compensation: touch sensor signal delay)
(#901054: compensation: probe center X)

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
(#5301: G58 X)

(Subprograms)
(O910002)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%