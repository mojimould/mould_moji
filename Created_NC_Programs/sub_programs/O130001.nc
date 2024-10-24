%
O130001 (last update on 20241024)
(X center of inner measurement)

N0001
#33=#4012
#32=#5001
(#33= current work coordinate G#)
(#32= block end X: start position X)

N0002
IF[#33EQ55]GOTO0003
IF[#33EQ57]GOTO0003
GOTO8000
(if work G# is neither 55 nor 57, go to N8000)

N0003
IF[#24EQ#0]GOTO8000
IF[#24LT10]GOTO8000
IF[#26EQ#0]GOTO8000
IF[#23EQ#0]GOTO8000
IF[#23LT10]GOTO8000
IF[#18EQ#0]GOTO8000
IF[#13EQ#0]GOTO8000
IF[#13LT0]GOTO8000
IF[#13GT10]GOTO8000
(if X < 10 or #0, go to N8000)
(if Z = #0, go to N8000)
(if W < 10 or #0, go to N8000)
(if R = #0, go to N8000)
(if M < 0 or M > 10 or #0, go to N8000)

N0004
IF[#18LE#26]GOTO8000
IF[#26LE[#901011/2]]GOTO8000
(if R <= Z, go to N8000)
(if Z <= #901011/2, go to N8000)

N0005
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

N0006
IF[#33EQ57]THEN #31=1
IF[#33EQ55]THEN #31=-1
(Top: #31=1, Bot: #31=-1)
IF[#33EQ57]THEN #30=#411
IF[#33EQ55]THEN #30=#406
(Top: #30=#411, Bot: #30=#406)
IF[[ABS[#30]]GE[#26/4]]GOTO8000
IF[[ABS[#30]]GE[#23/4]]GOTO8000
(if |#30| >= Z/4, go to N8000)
(if |#30| >= W/4, go to N8000)

N0007
#29=#24/2+#13
#28=SQRT[#18*#18-[#23-#30]*[#23-#30]]-SQRT[#18*#18-#23*#23]
(#29= X/2+M)
(#28: X compensation from #30)
IF[[#29-#901050-#602]LE0]GOTO8000
IF[[ABS[#28]]GE[#24/4]]GOTO8000
(if X/2+M-#901050-#602 <= 0, go to N8000)
(if |#28| >= X/4, go to N8000)

N0008
IF[#1005EQ0]GOTO0009
M00 (sensor low battery)
N0009
IF[#1004EQ1]GOTO0010
(if current sensor ON, go to N0010)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)


(kokokara G31)


N0010
G90 G31 Z[#26-#901050] F#653
(Z skip: Z-#901050)
IF[#5003GT[#26-#901050+0.001]]GOTO8002
(if skip Z > Z-#901050, to N8002)

G91 G31 X[#31*#28] Z-#30 F#653
(X skip to #31*#28)
(Z skip to Z-#901050-#30)
IF[#5001GT[#32+#31*#28+0.001]]GOTO8003
IF[#5003GT[#26-#901050-#30+0.001]]GOTO8002
(if skip X > #32+#31*#28, to N8002)
(if skip Z > Z-#901050-#30, to N8002)

N0011
G91 G31 X-[#29-#901050-#602] F#653
IF[[ABS[#5001-#32-#31*#28]+0.001]LT[ABS[#29-#901050-#602]]]GOTO8003
(X- skip: [#29-#901050-#602])
(if |skip X -#32| < |#29-#901050-#602|, go to N8003)

G91 G31 X-[#602+#603] F#656
#900015=#5001-#901050+#901053+#901054
(X- skip: #602+#603)
(#900015= X left side -#901050 +probe compensation)

N0012
G90 G01 X[#32+#31*#28] F#652
IF[[ABS[#900015-#901053-#901054]]GE[ABS[#29+#603]]]GOTO8000
(X to start point +compensation)
(if |#900015 -probe compensation| >= |#29+#603|, go to N8000)

N0013
G91 G31 X[#29-#901050-#602] F#653
IF[[ABS[#5001-#32-#31*#28]+0.001]LT[ABS[#29-#901050-#602]]]GOTO8003
(X+ skip: [#29-#901050-#602])
(if |skip X -#32| < |#29-#901050-#602|, to N8003)

G91 G31 X[#602+#603] F#656
#900016=#5001+#901050-#901053+#901054
(X+ skip: #602+#603)
(#900016= X right side +#901050 +probe compensation)

N0014
#900017=[#900016+#900015]/2
IF[#33EQ57]THEN #900018=#900016-#900015
IF[#33EQ55]THEN #900019=#900016-#900015
(#900017: center)
(#900018: length for top)
(#900019: length for bot)

N0015
G90 G01 X#900017 F#652
(X to measured center)
G91 G01 X-[#31*#28] Z#30 F#652
(X to measured endface center)
IF[[ABS[#900016+#901053-#901054]]GE[ABS[#29+#603]]]GOTO8000
(if |#900016 -probe compensation|>=|#29+#603|, go to N8000)

#[5201+[#33-53]*20]=#5021
(current work origin X = current machine X)

N9990
G90 G01 Z[#26+#600] F#650
GOTO9999


N8003
G90 G01 X#32 F#652 (X to start point)
G90 G53 G01 Z0 F#652
G65 P910002 (sensor OFF)
#3000=121 (are*the*arguments*or*the*mould*OK?)

N8002
G90 G53 G01 Z0 F#652
G65 P910002 (sensor OFF)
#3000=121 (are*the*arguments*or*the*mould*OK?)

N8000
#3000=121 (are*the*arguments*or*the*mould*OK?)

N9999
M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#13:M: mekki thickness mm)
(#18:R: central curvature)
(#23:W: alocation length)
(#24:X: X inside width)
(#26:Z: re-alocation length)

(as LHS)
(#28, #29, #30, #31, #32, #33)

(Common variables)
(as LHS)
(#900015, #900016, #900017, #900018, #900019)
(as RHS)
(#406, #411, #600, #602, #603, #650, #652, #653, #656)
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
(#5241: G55 X)
(#5281: G57 X)

(Subprograms)
(O910002)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%