%
O120001 (last update on 20241011)
(X center of outer measurement)

N0001
#33=#4012
#32=#5001
(#33= current work coordinate G#)
(#32= block end X: start position X)

N0002
IF[#33NE58]GOTO8000
(if work G# is not 58, go to N8000)

N0003
IF[#21EQ#0]GOTO8000
IF[#21LT10]GOTO8000
IF[#26EQ#0]GOTO8000
(if U < 10 or #0, go to N8000)
(if Z = #0, go to N8000)

N0004
IF[#26LE[#901011/2]]GOTO8000
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
IF[#901011LT660]GOTO8000
(if #901050 <= 1 or #0, go to N8000)
(if #600 < 50 or #0, go to N8000)
(if #602 <= 0 or #0, go to N8000)
(if #603 < 0 or #603 > 20.0 or #0, go to N8000)
(if #656 is not 50.0, go to N8000)
(if #901011 < 660 or #0, go to N8000)

N0008
IF[#1005EQ0]GOTO0009
M00 (sensor low battery)
N0009
IF[#1004EQ1]GOTO0010
(if current sensor ON, go to N0010)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)


(kokokara G01)


N0010
G91 G01 X[[#21/2]+#901050+#602] F#652
(X-: [U/2 +#901050+#602])

G90 G31 Z[#26-#901050-[#13+#419]-[[#11+#420]/2]] F#653
IF[#5003GT[#26-#901050-[#13+#419]-[[#11+#420]/2]]]GOTO8002
(Z skip: Z-#901050-M-H/2)
(if skip Z > Z-#901050-M-H/2, to N8002)

N0011
G91 G31 X-[#602+#603] F#656
#900012=#5001-#901050+#901053+#901054
(X- skip: #602+#603)
(#900012= A-face: skip X -#901050 +probe compensation)

N0012
G91 G01 X[#602+#603] F#652
G90 G01 Z[#26+#600] F#650
IF[[ABS[#900012-#901053-#901054]]LE[ABS[[#21/2]-#603]]]GOTO8000
(X+: #602+#603)
(Z: Z+#600)
(if |#900012 -probe compensation|<=|U/2-#603|, go to N8000)

G90 G01 X[#900012-#04-[#24/2]] F#652
(X to mizo center)
#[5201+[#33-53]*20]=#5021
(current work origin X = current machine coordinate X)
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
(#04:I: A-side keyway depth)
(#11:H: keyway width)
(#13:M: keyway position)
(#21:U: X outside width)
(#24:X: AC keyway width)
(#26:Z: re-alocation length)

(as LHS)
(#29, #30, #31, #32, #33)

(Common variables)
(as LHS)
(#900012)
(as RHS)
(#419, #420, #600, #602, #603, #650, #652, #653, #656)
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

(Subprograms)
(O910002)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%