%
O150002 (last update on 20241108)
(X centerline measurement)

N0001
IF[#23EQ#0]GOTO8000
IF[#26EQ#0]GOTO8000
IF[#20EQ#0]GOTO8000
IF[#20LE10]GOTO8000
IF[#21EQ#0]GOTO8000
IF[#21LE10]GOTO8000
IF[#02EQ#0]GOTO8000
IF[#02LE10]GOTO8000
IF[#03EQ#0]GOTO8000
IF[#03LE10]GOTO8000
IF[#13EQ#0]GOTO8000
IF[#13LE1]GOTO8000
IF[#06EQ#0]GOTO8000
IF[#06LE1]GOTO8000
IF[#04EQ#0]GOTO8000
IF[#04LT0]GOTO8000
(if W = #0, go to N8000)
(if Z = #0, go to N8000)
(if T <= 10 or #0, go to N8000)
(if U <= 10 or #0, go to N8000)
(if B <= 10 or #0, go to N8000)
(if C <= 10 or #0, go to N8000)
(if M <= 1 or #0, go to N8000)
(if K <= 1 or #0, go to N8000)
(if I < 0 or #0, go to N8000)

N0002
IF[#901011EQ#0]GOTO8000
IF[#901011LE200]GOTO8000
IF[#901050EQ#0]GOTO8000
IF[#901050LE1]GOTO8000
IF[#600EQ#0]GOTO8000
IF[#600LT50]GOTO8000
IF[#602EQ#0]GOTO8000
IF[#602LT1]GOTO8000
IF[#603EQ#0]GOTO8000
IF[#603LE0]GOTO8000
IF[#603GT15]GOTO8000
IF[#656EQ#0]GOTO8000
IF[#656LE0]GOTO8000
IF[#656GT50]GOTO8000
(if #901011 <= 200 or #0, go to N8000)
(if #901050 <= 1 or #0, go to N8000)
(if #600 < 50 or #0, go to N8000)
(if #602 < 1 or #0, go to N8000)
(if #603 <= 0 or > 15 or #0, go to N8000)
(if #656 <= 0 or > 50 or #0, go to N8000)

N0003
IF[#23LE[#901011/2]]GOTO8000
IF[#26LE[#901011/2]]GOTO8000
(if W <= #901011/2, go to N8000)
(if Z <= #901011/2, go to N8000)

N0004
IF[#1000EQ0]THEN #33=#901001
IF[#1000EQ1]THEN #33=#901005
(#33: X table center)
IF[#1000EQ0]THEN #32=#901003
IF[#1000EQ1]THEN #32=#901007
(#32: Z table center)


(kokokara G01)


(TooriShin X start)

N0005
G91 G28 X0 Y0
M11 (B-axis unclamp)
G90 G53 G00 B-30.0
M10 (B-axis clamp)
G90 G53 G01 Z-650.0 F#650

M00 (clean BC surfaces)

N0006
G90 G53 G01 Z0 F#650
T50 (touch sensor)
M11 (B-axis unclamp)
G90 G54 G00 B[-90+#01]
M10 (B-axis clamp)
(G54 Top:+X, Bot:-X)
(B parallel angle -90.000+A)

M06 (tool exchange)
M19 (Spindle orientation)
G43 H50 (tool length compensation: #50)

N0007
G90 G53 G01 X-5.501 Y-258.624 Z0 F#652
G90 G54 G01 Y0 F#652
(G90 Y: G54 origin Y)
G90 G53 G01 X[#23-[#13/2]+#33] F#652
(X: W-M/2 from table center)

IF[#1005EQ1]GOTO8001
IF[#1004EQ1]GOTO0008
(if low battery, go to N8001)
(if current sensor ON, go to N0008)
M117 (sensor on/off)
G04 X1. (wait 1.0s)

N0008
G90 G54 G43 G31 Z[#5221-#33-#04+[#20/2]+#600] H50 F#652
G90 G54 G31 Z[#5221-#33-#04+[#20/2]+#602] F[#653/2]
IF[#5003GT[#5221-#33-#04+[#20/2]+#602]]GOTO8002
(Z skip: top outcut Cface +#600)
(Z skip: top outcut Cface +#602)
(if skip block end Z > Cface Z+#602, to N8002)

G91 G31 Z-[#602+#603] F#656
IF[#5003LE[#5221-#33-#04+[#20/2]-#603]]GOTO8002
#900034=#5003+#901053
(Z- skip: #602+#603)
(if skip block end Z <= Cmen Z-#603, to N8002)
(#900034= Z top side +probe compensation)

G90 G53 G01 Z0 F#650
G90 G53 G01 X[-#26+[#06/2]+#33] F#652
(X: -Z+K/2 from table center)

G90 G54 G43 G31 Z[#5221-#33+[#20/2]+#600] H50 F#652
G90 G54 G31 Z[#5221-#33+[#02/2]+#602] F[#653/2]
IF[#5003GT[#5221-#33+[#02/2]+#602]]GOTO8002
(Z skip: bot outcut Cface +#600)
(Z skip: bot outcut Cface Z+#602)
(if skip block end Z > Cface Z+#602, to N8002)

G91 G31 Z-[#602+#603] F#656
IF[#5003LE[#5221-#33+[#20/2]-#603]]GOTO8002
#900035=#5003+#901053
(Z- skip: #602+#603)
(if skip block end Z <= Cface Z-#602, to N8002)
(#900035= Z bot side + probe compensation)

G90 G53 G01 Z0 F#650
#900036=#900035-#900034
(difference)

IF[#1005EQ1]GOTO8001
IF[#1004EQ0]GOTO0009
(if low battery, go to N8001)
(if current sensor off, go to N0009)
M117 (sensor off)

N0009
G90 G54 G01 X#900036 F#652
(X to table center)


(TooriShin X end)
(TooriShin Y start)


N1000
G49 G40 (cancel compensation)
G90 G53 G01 Z0 F#650
M11 (B-axis unclamp)
G90 G54 G00 B[180+#01]
M10 (B-axis clamp)
(G54 Bot:+Z, Top:-Z)
(B parallel angle 180+A)

N1002
G90 G54 G01 X0 Y[[#03/2]+#901050+#602] F#652
G90 G54 G43 G01 Z[#26+#600] H50 F#652
(G43 Z: Z+#600)

IF[#1005EQ1]GOTO8001
IF[#1004EQ1]GOTO1003
(if low battery, go to N8001)
(if current sensor ON, go to N1003)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)

N1003
G90 G54 G31 Z[#26-[#06/2]-#901050] F#653
IF[#5003GT[#26-[#06/2]-#901050]]GOTO8002
(G54 Z skip: Bot endface Z-K/2-#901050)
(if skip block end Z > Bot endface Z-K/2-#901050, to N8002)

G91 G31 Y-[#602+#603] F#656
#900030=#5002-#901050+#901053+#901055
(Y- skip: #602+#603)
(#900030= Y bot above side -#901050 +probe compensation)

G91 G01 Y[#602+#603] F#652
(Y+: #602+#603)

G90 G53 G01 Z0 F#650
IF[[ABS[#900030-#901053-#901055]]LE[ABS[[#03/2]-#603]]]GOTO8000
(if |#900030|<=|C/2-#602|, go to N8000)

M11 (B-axis unclamp)
G91 G00 B180.
(rotate 180 deg)
M10 (B-axis clamp)

G91 G01 X[-2*[#5221-#33]+#04] F#652
G90 G54 G01 Y[[#21/2]+#901050+#602] F#652
(X: top outcut center)
(Y: top outcut Bface +#602)

G90 G54 G43 G01 Z[#23+#600] H50 F#652
G90 G54 G31 Z[#23-[#13/2]-#901050] F#653
IF[#5003GT[#23-[#13/2]-#901050]]GOTO8002
(G54 Z skip: W-M/2-#901050)
(if skip block end Z > W-#901050-M/2+#32, to N8002)

G91 G31 Y-[#602+#603] F#656
(Y-: #602+#603)
#900031=#5002-#901050+#901053+#901055
(#900031= Y top above side -#901050 +probe compensation)

G91 G01 Y[#602+#603] F#652
(Y+: #602+#603)

G90 G53 G01 Z0 F#650
IF[[ABS[#900031-#901053-#901055]]LE[ABS[[#21/2]-#603]]]GOTO8000
(if |#900031|<=|U/2-#602|, go to N8000)

#900032=#900030-#900031-[#03-#21]/2
(difference)

IF[#1005EQ1]GOTO8001
IF[#1004EQ0]GOTO1004
(if low battery, go to N8001)
(if current sensor off, go to N1004)
M117 (sensor off)

N1004
G90 G54 G01 Y#900032 F#652
(Y to table center)
GOTO9999


N8001
#3000=145 (Low battery)

N8002
G90 G53 G01 Z0 F#652
G65 P910002 (sensor OFF)
#3000=121 (are*the*arguments*OK?)

N8000
G65 P910002 (sensor OFF)
#3000=121 (are*the*arguments*OK?)

N9999
M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#01:A: angle for alocation)
(#02:B: Bot AC outcut OD)
(#03:C: Bot BD outcut OD)
(#04:I: tooriShin X)
(#06:K: Bot outcut length)
(#13:M: keyway position)
(#20:T: Top AC outcut OD)
(#21:U: Top BD outcut OD)
(#23:W: Top re-alocation length)
(#26:Z: Bot re-alocation length)

(as LHS)
(#32, #33)

(Common variables)
(as LHS)
(#900030, #900031, #900032, #900034, #900035, #900036)
(as RHS)
(#600, #602, #603, #650, #652, #653, #656)
(#901001, #901003, #901005, #901007, #901011)
(#901050: probe radius)
(#901053: compensation: touch sensor signal delay)
(#901055: compensation: probe center Y)

(System variables)
(#1000: 0: palette #1, 1: palette #2)
(#1004: 0: sensor off, 1: on)
(#1005: 0: sensor battery ok, 1: low battery)
(#3000: alarm)
(#5003: current work block end Z)
(#5221: G54 origin X)

(Subprograms)
(O910002)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%