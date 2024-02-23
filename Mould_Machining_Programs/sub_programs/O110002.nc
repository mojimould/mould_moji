%
O110002 (Y center of outer measurement)

N001
#33=#4012
#32=#5002
(#33= current work coordinate G#)
(#32= block end X: start position Y)

N002
IF[#33LT54]GOTO800
IF[#33GT59]GOTO800
IF[#33NE[FUP[#33]]]GOTO800
(if work G# < 54 go to N800)
(if work G# > 59 go to N800)
(if work G# is not integer, go to N800)

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
IF[#512EQ#0]GOTO800
IF[#512LE1]GOTO800
IF[#600EQ#0]GOTO800
IF[#600LT50]GOTO800
IF[#602EQ#0]GOTO800
IF[#602LE0]GOTO800
IF[#603EQ#0]GOTO800
IF[#603LT0]GOTO800
IF[#603GT20]GOTO800
IF[#680EQ#0]GOTO800
IF[#680LE10]GOTO800
IF[#901011EQ#0]GOTO800
IF[#901011LE100]GOTO800
(if #512 <= 1 or #0, go to N800)
(if #600 < 50 or #0, go to N800)
(if #602 <= 0 or #0, go to N800)
(if #603 < 0 or #603 > 20.0 or #0, go to N800)
(if #680 <= 10 or #0, go to N800)
(if #901011 <= 100 or #0, go to N800)

N006
IF[#33GE56]THEN #31=#411
IF[#33LE55]THEN #31=#406
(Top: #31=#411, Bot: #31=#406)
IF[[ABS[#31]]GE[#26/4]]GOTO800
(if |#31| >= Z/4, go to N800)

N007
IF[#1005EQ0]GOTO008
M00 (sensor low battery)
N008
IF[#1004EQ1]GOTO009
(if current sensor ON, go to N009)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)


(kokokara G01)


N009
G91 G01 Y-[[#25/2]+#512+#602] F#676
(Y-: [BD gaikei/2 +#512+#602])

G90 G31 Z[#26-#512-#31] F#678
(Z skip: Z-#512-#31)
IF[#5003GT[#26-#512-#31]]GOTO802
(if skip Z > Z-#512-#31, to N802)

N010
G91 G31 Y[#602+#603] F#680
(Y+ skip: #602+#603)
#900006=#5002+#512-#501+#503
(#900006= Y bellow side +#512 +probe hosei)

N011
G91 G01 Y-[#602+#603] F#676
(Y-: #602+#603)
G91 G01 Z[#31+#512+#600] F#675
(Z+: #31+#512+#600)
IF[[ABS[#900006+#501-#503]]LE[ABS[[#25/2]-#602]]]GOTO800
(if |#900006 -probe hosei|<=|Y/2-#602|, go to N800)

G90 G01 Y#32 F#676
(Y to start point)

N012
G91 G01 Y[[#25/2]+#512+#602] F#676
(Y+: [BD gaikei/2 +#512+#602])

G90 G31 Z[#26-#512-#31] F#678
(Z skip: Z-#512-#31)
IF[#5003GT[#26-#512-#31]]GOTO802
(if skip Z > Z-#512-#31, to N802)

N013
G91 G31 Y-[#602+#603] F#680
(Y- skip: #602+#603)
#900007=#5002-#512+#501+#503
(#900007= Y above side -#512 +probe hosei)

N014
G91 G01 Y[#602+#603] F#676
(Y+: #602+#603)
G91 G01 Z[#31+#512+#600] F#675
(Z+: #31+#512+#600)
IF[[ABS[#900007-#501-#503]]LE[ABS[[#25/2]-#602]]]GOTO800
(if |#900007 -probe hosei|<=|Y/2-#602|, go to N800)

N015
#900008=[#900007+#900006]/2
#900009=#900007-#900006
(average: center)
(difference: thickness)

N018
G90 G01 Y#900008 F#676
(Y to measured center)

#[5202+[#33-53]*20]=#5022
(current work origin Y = current machine Y)

N990
G90 G01 Z[#26+#600] F#676
GOTO999


N802
G90 G53 G01 Z0 F#676
G90 G01 Y#32 F#676
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
(#25:Y: Y outside width)
(#26:Z: sai_furiwake)

(as LHS)
(#31, #32, #33)


(Common variables)
(as LHS)
(#900006, #900007, #900008, #900009)
(as RHS)
(#406, #411, #600, #602, #603, #675, #676, #678, #680)
(#501: hosei: touch sensor signal delay)
(#503: hosei: probe center Y)
(#512: probe radius)
(#901011)


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