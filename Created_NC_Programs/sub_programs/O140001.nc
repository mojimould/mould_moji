%
O140001 (last update on 20240701)
(X center: left side measurement)

N001
#33=#4012
#32=#5001
(#33= current work coordinate G#)
(#32= block end X: start position X)

N002
IF[#33LT54]GOTO0800
IF[#33GT59]GOTO0800
IF[#33NE[FUP[#33]]]GOTO0800
(if work G# < 54, go to N0800)
(if work G# > 59, go to N0800)
(if work G# is not integer, go to N0800)

N003
IF[#24EQ#0]GOTO0800
IF[#24LT10]GOTO0800
IF[#04EQ#0]GOTO0800
IF[#04LT10]GOTO0800
IF[#26EQ#0]GOTO0800
IF[#23EQ#0]GOTO0800
IF[#23LT10]GOTO0800
IF[#20EQ#0]GOTO0800
IF[#20LT1]GOTO0800
IF[#03LT0]GOTO0800
IF[#18EQ#0]GOTO0800
IF[#13EQ#0]GOTO0800
IF[#13LT0]GOTO0800
IF[#13GT10]GOTO0800
(if X < 10 or #0, go to N0800)
(if I < 10 or #0, go to N0800)
(if Z = #0, go to, N0800)
(if W < 10 or #0, go to N0800)
(if T < 1 or #0, go to N0800)
(if C < 0, go to N0800)
(if R = #0, go to, N0800)
(if M < 0 or M > 10 or #0, go to N0800)

N004
IF[#18LE#26]GOTO0800
IF[#24LE[#04+#20]]GOTO0800
IF[#20LE#13]GOTO0800
IF[#20GE[#24/2]]GOTO0800
IF[#03GE[#26/4]]GOTO0800
IF[#26LE[#901011/2]]GOTO0800
(if R <= Z, go to N0800)
(if X <= I+T, go to N0800)
(if T <= M, go to N0800)
(if T >= X/2, go to N0800)
(if C >= Z/4, go to N0800)
(if Z <= #901011/2, go to N0800)

N005
IF[#901050EQ#0]GOTO0800
IF[#901050LE0]GOTO0800
IF[#600EQ#0]GOTO0800
IF[#600LT50]GOTO0800
IF[#602EQ#0]GOTO0800
IF[#602LE0]GOTO0800
IF[#603EQ#0]GOTO0800
IF[#603LT0]GOTO0800
IF[#603GT20]GOTO0800
IF[#656NE50]GOTO0800
IF[#901011EQ#0]GOTO0800
IF[#901011LE100]GOTO0800
(if #901050 <= 0 or #0 go to N0800)
(if #600 < 50 or #0, go to N0800)
(if #602 <= 0 or #0, go to N0800)
(if #603 < 0 or #603 > 20.0 or #0, go to N0800)
(if #656 is not 50.0, go to N0800)
(if #901011 <= 100 or #0 go to N0800)

N006
IF[#33GE56]THEN #31=1
IF[#33LE55]THEN #31=-1
(Top: #31=1, Bot: #31=-1)
IF[#33GE56]THEN #30=#409
IF[#33LE55]THEN #30=#404
(Top: #30=#409-C, Bot: #30=#404-C)
IF[[ABS[#30]]GE[#26/4]]GOTO0800
IF[[ABS[#30]]GE[#23/4]]GOTO0800
(if |#30| >= Z/4, go to N0800)
(if |#30| >= W/4, go to N0800)

N007
#29=[#24/2]-#20+#13
#28=SQRT[[#18+#04/2]*[#18+#04/2]-[#23-#03]*[#23-#03]]-SQRT[[#18+#04/2]*[#18+#04/2]-#23*#23]
#27=SQRT[[#18+#04/2]*[#18+#04/2]-[#23-#03-#30]*[#23-#03-#30]]-SQRT[[#18+#04/2]*[#18+#04/2]-[#23-#03]*[#23-#03]]
IF[[ABS[#28]]GE[#24/4]]GOTO0800
IF[[ABS[#27+#28]]GE[#24/4]]GOTO0800
(#29=X/2-T+M)
(#28: X hosei from tanmen to C)
(#27: X hosei from C to #30)
(if |#28| >= X/4, go to N0800)
(if |#27+#28| >= X/4, go to N0800)

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
G90 G31 Z[#26-#901050] F#653
IF[#5003GT[#26-#901050]]GOTO0802
(Z skip: Z-#901050)
(if skip Z > Z-#901050, to N0802)

G91 G31 X[#31*#28] Z-#03 F#653
IF[#5001GT[#32+#31*#28+0.001]]GOTO0803
IF[#5003GT[#26-#901050-#03]]GOTO0802
(X skip to #31*#28)
(Z skip to Z-#901050-C)
(if skip X > #32+#31*#28, to N0803)
(if skip Z > Z-#901050-C, to N0802)

G91 G31 X[#31*#27] Z-#30 F#653
IF[#5001GT[#32+#31*#28+#31*#27+0.001]]GOTO0803
IF[#5003GT[#26-#901050-#03-#30]]GOTO0802
(X skip to #31*[#28+#27])
(Z skip to Z-#901050-C-#30)
(if skip X > #32+#31*[#28+#27], to N0803)
(if skip Z > Z-#901050-#03-#30, to N0802)

N011
G91 G31 X[#31*[#29-#901050-#602]] F#653
IF[[ABS[#5001-#32]+0.001]LT[ABS[#29-#901050-#602]]]GOTO0803
(X skip: #31*[#29-#901050-#602])
(if |skipX-#32| < |#29-#901050-#602|, go to N0803)

G91 G31 X[#31*[#602+#603]] F#656
#900027=#5001+#901054+#31*[#901050-#901053]
(X skip: #31*[#602+#603])
(#900027= skip X +#901054+#31*[#901050-#901053])

N012
G90 G01 X[#900027-#31*#29] F#652
(X to measured center)
G91 G01 X-[#31*#27] Z#30 F#652
(X to measured center at Z-C)
IF[[ABS[#900027-#901054+[#31*#901053]]]GE[ABS[#29+#603]]]GOTO0800
(if |#900027-#901054+#31*#901053|>=|#29-#603|, go to N0800)

#[5201+[#33-53]*20]=#5021
(current work origin X = current machine coordinate X)

N990
G90 G01 Z[#26+#600] F#650
GOTO999


N0803
G90 G01 X#32 F#652
(X to start point)
G90 G53 G01 Z0 F#652
G65 P910002 (sensor OFF)
#3000=121 (are*the*arguments*or*the*mould*OK?)

N0802
G90 G53 G01 Z0 F#652
G65 P910002 (sensor OFF)
#3000=121 (are*the*arguments*or*the*mould*OK?)

N0800
#3000=121 (are*the*arguments*or*the*mould*OK?)

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
(#900027)
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
(#5001: current work block end point X)
(#5003: current work block end point Z)
(#5021: current machine coordinate X)
(#5221: G54 X)
(#5261: G56 X)

(Subprogram)
(O910002)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%