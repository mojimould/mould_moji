%
O110002 (Y center of outer measurement)

N001
#33=#4012
#32=#5002
(#33= current work coordinate G#)
(#32= block end X: start position Y)

N002
IF[#33EQ54]GOTO003
IF[#33EQ56]GOTO003
IF[#33EQ58]GOTO003
GOTO800
(if work G# isn't 54, 56, 58, go to N800)

N003
IF[#25EQ#0]GOTO800
IF[#25LT10]GOTO800
IF[#26EQ#0]GOTO800
(if Y < 10 or #0, go to N800)
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
IF[#901011LE100]GOTO800
(if #901050 <= 1 or #0, go to N800)
(if #600 < 50 or #0, go to N800)
(if #602 <= 0 or #0, go to N800)
(if #603 < 0 or #603 > 20.0 or #0, go to N800)
(if #655 <= 10 or #0, go to N800)
(if #901011 <= 100 or #0, go to N800)

N006
#29=#656
IF[#33NE58]GOTO007
(if #33 isn't 58, go to N007)
IF[#655EQ#0]THEN #655=50
IF[#655LE50]THEN #655=50
IF[#655GE300]THEN #655=300
#29=#655
IF[#13EQ#0]GOTO800
IF[#13LE1]GOTO800
IF[#11EQ#0]GOTO800
IF[#11LE1]GOTO800
(if M <= 1 or #0, go to N800)
(if H <= 1 or #0, go to N800)

N007
IF[#33EQ56]THEN #30=#410
IF[#33EQ54]THEN #30=#405
IF[#33EQ58]THEN #30=#13+[#11/2]
IF[[ABS[#30]]GE[#26/4]]GOTO800
(Top: #30=#410)
(Bot: #30=#405)
(mizo: #30=M+H/2)
(if |#30| >= Z/4, go to N800)

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
G91 G01 Y-[[#25/2]+#901050+#602] F#652
(Y-: Y/2 +#901050+#602)

G90 G31 Z[#26-#901050-#30] F#653
IF[#5003GT[#26-#901050-#30]]GOTO802
(Z skip: Z-#901050-#30)
(if skip Z > Z-#901050-#30, to N802)

N011
G91 G31 Y[#602+#603] F#29
#900006=#5002+#901050-#901053+#901055
(Y+ skip: #602+#603)
(#900006= skip Y +#901050 +probe hosei)

N012
G91 G01 Y-[#602+#603] F#652
G91 G01 Z[#30+#901050+#600] F#650
IF[[#900006+#901053-#901055]GE[-[#25/2]+#603]]GOTO802
(Y-: #602+#603)
(Z+: #30+#901050+#600)

G90 G01 Y#32 F#652
(Y to start point)

N013
G91 G01 Y[[#25/2]+#901050+#602] F#652
(Y+: Y/2 +#901050+#602)

G90 G31 Z[#26-#901050-#30] F#653
IF[#5003GT[#26-#901050-#30]]GOTO802
(Z skip: Z-#901050-#30)
(if skip Z > Z-#901050-#30, to N802)

N014
G91 G31 Y-[#602+#603] F#29
#900007=#5002-#901050+#901053+#901055
(Y- skip: #602+#603)
(#900007= skip Y -#901050 +probe hosei)

N015
G91 G01 Y[#602+#603] F#652
G91 G01 Z[#30+#901050+#600] F#650
IF[[#900007-#901053-#901055]LE[[#25/2]-#603]]GOTO802
(Y+: #602+#603)
(Z+: #30+#901050+#600)

N016
#900008=[#900007+#900006]/2
IF[#33EQ56]THEN #900009=#900007-#900006
IF[#33EQ54]THEN #900010=#900007-#900006
(#900008: center)
(#900009: length for top)
(#900010: length for bot)

N018
G90 G01 Y#900008 F#652
(Y to measured center)

#[5202+[#33-53]*20]=#5022
(current work origin Y = current machine Y)

N990
G90 G01 Z[#26+#600] F#652
GOTO999


N802
G90 G53 G01 Z0 F#652
G90 G01 Y#32 F#652
(Y to start point)
G65 P910002 (sensor OFF)
#3000=121 (are the arguments or the mould OK?)

N800
G65 P910002 (sensor OFF)
#3000=121 (are the arguments or the mould OK?)

N999 M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#11:H: mizoHaba)
(#13:M: mizoIchi)
(#25:Y: Y outside width)
(#26:Z: sai_furiwake)

(as LHS)
(#29, #30, #32, #33)


(Common variables)
(as LHS)
(#900006, #900007, #900008, #900009, #900010)
(as RHS)
(#405, #410, #600, #602, #603, #650, #652, #653, #655, #656)
(#901011)
(#901050: probe radius)
(#901053: hosei: touch sensor signal delay)
(#901055: hosei: probe center Y)


(System variables)
(#1004: 0: sensor off, 1: on)
(#1005: 0: sensor battery ok, 1: low battery)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5002: current work block end Y)
(#5003: current work block end Z)
(#5022: current machine coordinate Y)
(#5222: G54 Y)
(#5262: G56 Y)


(Subprograms)
(O910002)
%