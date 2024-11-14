%
O150003 (last update on 20241114)
(tilt measurement)

N0001
IF[#23EQ#0]GOTO8000
IF[#26EQ#0]GOTO8000
IF[#20EQ#0]GOTO8000
IF[#20LE5]GOTO8000
IF[#02EQ#0]GOTO8000
IF[#02LE5]GOTO8000
IF[#18EQ#0]GOTO8000
IF[#18LE100]GOTO8000
(if W = #0, go to N8000)
(if Z = #0, go to N8000)
(if T <= 5 or #0, go to N8000)
(if B <= 5 or #0, go to N8000)
(if R <= 100 or #0, go to N8000)

N0002
IF[#901011EQ#0]GOTO8000
IF[#901011LE200]GOTO8000
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

N0005
#31=SQRT[#18*#18-[#23-#20]*[#23-#20]]-SQRT[#18*#18-#23*#23]
#30=SQRT[#18*#18-[#26-#02]*[#26-#02]]-SQRT[#18*#18-#26*#26]

(kokokara G01)


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
G90 G53 G01 X[#23-#20+#33] F#652
(X: W-T from table center)

N0008
IF[#1005EQ1]GOTO8001
IF[#1004EQ1]GOTO0008
(if low battery, go to N8001)
(if current sensor ON, go to N0008)
M117 (sensor on/off)
G04 X1. (wait 1.0s)

N0009
G90 G54 G43 G31 Z[-#5261+#33+[#24/2]-#31+#600] H50 F#652
G90 G54 G31 Z[-#5261+#33+[#24/2]-#31+#602] F[#653/2]
IF[#5003GT[-#5261+#33+[#24/2]-#31+#602]]GOTO8002
(Z skip: Cface +#600)
(Z skip: Cface +#602)
(if skip block end Z > Cface Z+#602, to N8002)

N0010
G91 G31 Z-[#602+#603] F#656
IF[#5003LE[-#5261+#33+[#24/2]-#31-#603]]GOTO8002
#900034=#5003+#901053
(Z- skip: #602+#603)
(if skip block end Z <= Cmen Z-#603, to N8002)
(#900034= Z top side +probe compensation)

N0011
G90 G53 G01 Z0 F#650
G90 G53 G01 X[-#26+#02+#33] F#652
(X: -[Z-B] from table center)

N0012
G90 G54 G43 G31 Z[#5221-#33+[#24/2]-#30+#600] H50 F#652
G90 G54 G31 Z[#5221-#33+[#24/2]-#30+#602] F[#653/2]
IF[#5003GT[#5221-#33+[#24/2]-#30+#602]]GOTO8002
(Z skip: bot outcut Cface +#600)
(Z skip: bot outcut Cface Z+#602)
(if skip block end Z > Cface Z+#602, to N8002)

N0013
G91 G31 Z-[#602+#603] F#656
IF[#5003LE[#5221-#33+[#24/2]-#30-#603]]GOTO8002
#900035=#5003+#901053
(Z- skip: #602+#603)
(if skip block end Z <= Cface Z-#602, to N8002)
(#900035= Z bot side + probe compensation)

N0014
G90 G53 G01 Z0 F#650
#900036=#900035-#900034
(difference)

N0015
IF[#1005EQ1]GOTO8001
IF[#1004EQ0]GOTO0017
(if low battery, go to N8001)
(if current sensor off, go to N0017)
M117 (sensor off)

N0017
G90 G54 G01 X#900036 F#652
(X to #90036)

N0018
G49 G40 (cancel compensation)
G90 G53 G01 Z0 F#650
M11 (B-axis unclamp)
G90 G54 G00 B[180+#01]
M10 (B-axis clamp)
(G54 Bot:+Z, Top:-Z)
(B parallel angle 180+A)
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
(#02:B: distance from bottom end)
(#18:R: central curvature)
(#20:T: distance from top end)
(#23:W: Top re-alocation length)
(#24:X: AC OD)
(#26:Z: Bot re-alocation length)

(as LHS)
(#30, #31, #32, #33)

(Common variables)
(as LHS)
(#900034, #900035, #900036)
(as RHS)
(#600, #602, #603, #650, #652, #653, #656)
(#901001, #901003, #901005, #901007, #901011)
(#901053: compensation: touch sensor signal delay)

(System variables)
(#1000: 0: palette #1, 1: palette #2)
(#1004: 0: sensor off, 1: on)
(#1005: 0: sensor battery ok, 1: low battery)
(#3000: alarm)
(#5003: current work block end Z)
(#5221: G54 origin X)
(#5261: G56 origin X)

(Subprograms)
(O910002)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%