%
O130002 (last update on 20240629)
(Y center of inner measurement)

N001
#33=#4012
#32=#5002
(#33= current work coordinate G#)
(#32= block end X: start position Y)

N002
IF[#33EQ55]GOTO003
IF[#33EQ57]GOTO003
GOTO0800
(if work G# is neither 55 nor 57, go to N0800)

N003
IF[#25EQ#0]GOTO0800
IF[#25LT10]GOTO0800
IF[#26EQ#0]GOTO0800
IF[#13EQ#0]GOTO0800
IF[#13LT0]GOTO0800
IF[#13GT10]GOTO0800
(if Y < 10 or #0, go to N0800)
(if Z = #0, go to N0800)
(if M < 0 or M > 10 or #0, go to N0800)

N004
IF[#26LE[#901011/2]]GOTO0800
(if Z <= #901011/2, go to N0800)

N005
IF[#901050EQ#0]GOTO0800
IF[#901050LE1]GOTO0800
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
(if #901050 <= 1 or #0, go to N0800)
(if #600 < 50 or #0, go to N0800)
(if #602 <= 0 or #0, go to N0800)
(if #603 < 0 or #603 > 20.0 or #0, go to N0800)
(if #656 is not 50 or #0, go to N0800)
(if #901011 <= 100 or #0, go to N0800)

N006
IF[#33EQ57]THEN #31=1
IF[#33EQ55]THEN #31=-1
(Top: #31=1, Bot: #31=-1)
IF[#33EQ57]THEN #30=#412
IF[#33EQ55]THEN #30=#407
(Top: #30=#412, Bot: #30=#407)
IF[[ABS[#30]]GE[#26/4]]GOTO0800
(if |#30| >= Z/4, go to N0800)

N007
#29=#25/2+#13
(#29= Y/2+M)
IF[[#29-#901050-#602]LE0]GOTO0800
(if Y/2+M-#901050-#602 <= 0, go to N0800)

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
G90 G31 Z[#26-#901050-#30] F#653
(Z tanmen: Z-#901050-#30)
IF[#5003GT[#26-#901050-#30]]GOTO0802
(if skip Z > Z-#901050-#30, to N0802)

N011
G91 G31 Y-[#29-#901050-#602] F#653
IF[[ABS[#5002-#32]+0.001]LT[ABS[#29-#901050-#602]]]GOTO0803
(Y- skip: [#29-#901050-#602])
(if |skip Y -#32| < |#29-#901050-#602|, to N0803)

G91 G31 Y-[#602+#603] F#656
#900021=#5002-#901050+#901053+#901055
(Y- skip: #602+#603)
(#900021= Y bellow side -#901050 +probe hosei)

N012
G90 G01 Y#32 F#652
IF[[ABS[#900021-#901053-#901055]]GE[ABS[#29+#603]]]GOTO0800
(Y to start point)
(if |#900021 -probe hosei| >= |#29+#603|, go to N0800)

N013
G91 G31 Y[#29-#901050-#602] F#653
IF[[ABS[#5002-#32]+0.001]LT[ABS[#29-#901050-#602]]]GOTO0803
(Y+ skip: [#29-#901050-#602])
(if |skip Y -#32| < |#29-#901050-#602|, to N0803)

G91 G31 Y[#602+#603] F#656
#900022=#5002+#901050-#901053+#901055
(Y+ skip: #602+#603)
(#900022= Y above side +#901050 +probe hosei)

N014
#900023=[#900022+#900021]/2
IF[#33EQ57]THEN #900024=#900022-#900021
IF[#33EQ55]THEN #900025=#900022-#900021
(#900023: center)
(#900024: length for top)
(#900025: length for bot)

N015
G90 G01 Y#900023 F#652
IF[[ABS[#900022+#901053-#901055]]GE[ABS[#29+#603]]]GOTO0800
(Y to measured center)
(if |#900022| >= |#29+#602|, go to N0800)

#[5202+[#33-53]*20]=#5022
(current work origin Y = current machine Y)

N990
G90 G01 Z[#26+#600] F#650
GOTO999


N0803
G90 G01 Y#32 F#652 (Y to start point)
G90 G53 G01 Z0 F#652
G65 P910002 (sensor OFF)
#3000=121 (are the arguments or the mould OK?)

N0802
G90 G53 G01 Z0 F#652
G65 P910002 (sensor OFF)
#3000=121 (are the arguments or the mould OK?)

N0800
#3000=121 (are the arguments or the mould OK?)

N999 M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#13:M: mekki thickness mm)
(#25:Y: Y inside width)
(#26:Z: sai-furiwake)

(as LHS)
(#29, #30, #31, #32, #33)

(Common variables)
(as LHS)
(#900021, #900022, #900023, #900024, #900025)
(as RHS)
(#407, #412, #600, #602, #603, #650, #652, #653, #656)
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
(#5242: G55 Y)
(#5282: G57 Y)

(Subprograms)
(O910002)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%