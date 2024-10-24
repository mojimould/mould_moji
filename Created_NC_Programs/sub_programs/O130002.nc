%
O130002 (last update on 20241024)
(Y center of inner measurement)

N0001
#33=#4012
#32=#5002
(#33= current work coordinate G#)
(#32= block end X: start position Y)

N0002
IF[#33EQ55]GOTO0003
IF[#33EQ57]GOTO0003
GOTO8000
(if work G# is neither 55 nor 57, go to N8000)

N0003
IF[#25EQ#0]GOTO8000
IF[#25LT10]GOTO8000
IF[#26EQ#0]GOTO8000
IF[#13EQ#0]GOTO8000
IF[#13LT0]GOTO8000
IF[#13GT10]GOTO8000
(if Y < 10 or #0, go to N8000)
(if Z = #0, go to N8000)
(if M < 0 or M > 10 or #0, go to N8000)

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
IF[#33EQ57]THEN #30=#412
IF[#33EQ55]THEN #30=#407
(Top: #30=#412, Bot: #30=#407)
IF[[ABS[#30]]GE[#26/4]]GOTO8000
(if |#30| >= Z/4, go to N8000)

N0007
#29=#25/2+#13
(#29= Y/2+M)
IF[[#29-#901050-#602]LE0]GOTO8000
(if Y/2+M-#901050-#602 <= 0, go to N8000)

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
G90 G31 Z[#26-#901050-#30] F#653
(Z tanmen: Z-#901050-#30)
IF[#5003GT[#26-#901050-#30+0.001]]GOTO0802
(if skip Z > Z-#901050-#30, to N0802)

N0011
G91 G31 Y-[#29-#901050-#602] F#653
IF[[ABS[#5002-#32]+0.001]LT[ABS[#29-#901050-#602]]]GOTO0803
(Y- skip: [#29-#901050-#602])
(if |skip Y -#32| < |#29-#901050-#602|, to N0803)

G91 G31 Y-[#602+#603] F#656
#900021=#5002-#901050+#901053+#901055
(Y- skip: #602+#603)
(#900021= Y bellow side -#901050 +probe compensation)

N0012
G90 G01 Y#32 F#652
IF[[ABS[#900021-#901053-#901055]]GE[ABS[#29+#603]]]GOTO8000
(Y to start point)
(if |#900021 -probe compensation| >= |#29+#603|, go to N8000)

N0013
G91 G31 Y[#29-#901050-#602] F#653
IF[[ABS[#5002-#32]+0.001]LT[ABS[#29-#901050-#602]]]GOTO0803
(Y+ skip: [#29-#901050-#602])
(if |skip Y -#32| < |#29-#901050-#602|, to N0803)

G91 G31 Y[#602+#603] F#656
#900022=#5002+#901050-#901053+#901055
(Y+ skip: #602+#603)
(#900022= Y above side +#901050 +probe compensation)

N0014
#900023=[#900022+#900021]/2
IF[#33EQ57]THEN #900024=#900022-#900021
IF[#33EQ55]THEN #900025=#900022-#900021
(#900023: center)
(#900024: length for top)
(#900025: length for bot)

N0015
G90 G01 Y#900023 F#652
IF[[ABS[#900022+#901053-#901055]]GE[ABS[#29+#603]]]GOTO8000
(Y to measured center)
(if |#900022| >= |#29+#602|, go to N8000)

#28=#[5202+[#33-53]*20]
#[5202+[#33-53]*20]=#5022
(current work origin Y = current machine Y)

N9990
G90 G01 Z[#26+#600] F#650

N9991 (check)
IF[#05EQ#0]GOTO9992
IF[ABS[#[5202+[#33-53]*20]-#28]LE[[[#05-#25]/2]*0.07]]GOTO9992
M00 (check G55 Y or G57 Y)

N9992
IF[#33EQ55]GOTO9993
IF[ABS[#5242-#5282]LT0.5]GOTO9993
M00 (check G55 Y and G57 Y)

N9993
GOTO9999


N0803
G90 G01 Y#32 F#652 (Y to start point)
G90 G53 G01 Z0 F#652
G65 P910002 (sensor OFF)
#3000=121 (are*the*arguments*or*the*mould*OK?)

N0802
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
(#05:J: Y outside width)
(#13:M: mekki thickness mm)
(#25:Y: Y inside width)
(#26:Z: re-alocation length)

(as LHS)
(#29, #30, #31, #32, #33)

(Common variables)
(as LHS)
(#900021, #900022, #900023, #900024, #900025)
(as RHS)
(#407, #412, #600, #602, #603, #650, #652, #653, #656)
(#901011)
(#901050: probe radius)
(#901053: compensation: touch sensor signal delay)
(#901055: compensation: probe center Y)

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