%
O150003 (X centerline measurement)

IF[#23EQ#0]GOTO800
IF[#26EQ#0]GOTO800
IF[#20EQ#0]GOTO800
IF[#20LE0]GOTO800
IF[#02EQ#0]GOTO800
IF[#02LE0]GOTO800
IF[#13EQ#0]GOTO800
IF[#13LE0]GOTO800
IF[#06EQ#0]GOTO800
IF[#06LE0]GOTO800
IF[#21EQ#0]GOTO800
IF[#21LT0]GOTO800
(if W = #0, go to N800)
(if Z = #0, go to N800)
(if T <= 0 or #0, go to N800)
(if B <= 0 or #0, go to N800)
(if M <= 0 or #0, go to N800)
(if K <= 0 or #0, go to N800)
(if U < 0 or #0, go to N800)

IF[#23LE[#901011/2]]GOTO800
IF[#26LE[#901011/2]]GOTO800
(if W <= #901011/2, go to N800)
(if Z <= #901011/2, go to N800)

IF[#901011EQ#0]GOTO800
IF[#901011LE100]GOTO800
IF[#600EQ#0]GOTO800
IF[#600LT50]GOTO800
IF[#602EQ#0]GOTO800
IF[#602LE0]GOTO800
IF[#603EQ#0]GOTO800
IF[#603LT0]GOTO800
IF[#603GT20]GOTO800
IF[#679EQ#0]GOTO800
IF[#679LE0]GOTO800
IF[#679GT50]GOTO800
(if #901011 <= 100 or #0, go to N800)
(if #600 < 50 or #0, go to N800)
(if #602 <= 0 or #0, go to N800)
(if #603 < 0 or #603 > 20.0 or #0, go to N800)
(if #679 <= 0 or #0, go to N800)
(if #679 > 50. or #0, go to N800)

IF[#1000NE0]GOTO001
(if NOT p#1, to N001)
#33=#901001 (p#1 X table center)
#32=#901003 (p#1 Z table center)
GOTO002

N001
#33=#901005 (p#2 X table center)
#32=#901007 (p#2 Z table center)


(kokokara G01)


N002
G90 G53 G01 X-5.501 Y-258.624 Z0 F#676
G90 G54 G01 Y0 F#676
(G90 Y: G54 origin Y)
G90 G53 G01 X[#23-[#13/2]+#33] F#676
(X: W-M/2 from table center)

IF[#1005EQ1]GOTO801
IF[#1004EQ1]GOTO003
(if low battery, go to N801)
(if current sensor ON, go to N003)
M117 (sensor on/off)
G04 X1. (wait 1.0s)

N003
G90 G54 G43 G31 Z[#5221-#33-#21+[#20/2]+#600] H50 F#676
(Z skip: topGaisakuCmen +#600)
G90 G54 G31 Z[#5221-#33-#21+[#20/2]+#602] F#678
(Z skip: topGaisakuCmen +#602)
IF[#5003GT[#5221-#33-#21+[#20/2]+#602]]GOTO802
(if skip block end Z > Cmen Z+#602, to N802)

G91 G31 Z-[#602+#603] F#679
(Z- skip: #602+#603)
IF[#5003LE[#5221-#33-#21+[#20/2]-#602]]GOTO802
(if skip block end Z <= Cmen Z-#602, to N802)
#900031=#5003+#501
(#900031= Z top side +probe hosei)

G90 G53 G01 Z0 F#650
G90 G53 G01 X[-#26+[#06/2]+#33] F#676
(X: -Z+K/2 from table center)

G90 G54 G43 G31 Z[#5221-#33+[#20/2]+#600] H50 F#676
(Z skip: botGaisakuCmen +#600)
G90 G54 G31 Z[#5221-#33+[#02/2]+#602] F#678
(G54 Z skip: botGaisakuCmen Z+#602)
IF[#5003GT[#5221-#33+[#02/2]+#602]]GOTO802
(if skip block end Z > Cmen Z+#602, to N802)

G91 G31 Z-[#602+#603] F#679
(Z- skip: #602+#603)
IF[#5003LE[#5221-#33+[#20/2]-#602]]GOTO802
(if skip block end Z <= Cmen Z-#602, to N802)
#900032=#5003+#501
(#900032= Z bot side + probe hosei)

G90 G53 G01 Z0 F#650
#900033=#900032-#900031
(difference)

IF[#1005EQ1]GOTO801
IF[#1004EQ0]GOTO004
(if low battery, go to N801)
(if current sensor off, go to N004)
M117 (sensor off)

N004
G90 G54 G01 X#900033 F#676
(X to table center)
GOTO999


N801
#3000=145 (Low battery)

N802
G90 G53 G01 Z0 F#676

N800
G65 P910002 (sensor OFF)
#3000=121 (are the arguments OK?)

N999 M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#02:B: AC Bot gaisakuKei)
(#06:K: Bot gaisaku height)
(#13:M: mizoIchi)
(#20:T: AC Top gaisakuKei)
(#21:U: tooriShin X)
(#23:W: sai-furiwake Top)
(#26:Z: sai-furiwake Bot)

(as LHS)
(#32, #33)


(Common variables)
(as LHS)
(#900031, #900032, #900033)
(as RHS)
(#501: hosei: touch sensor signal delay)
(#600, #602, #603, #650, #676, #678, #679)
(#901001, #901003, #901005, #901007, #901011)


(System variables)
(#0   : empty)
(#1004: 0: sensor off, 1: on)
(#1005: 0: sensor battery ok, 1: low battery)
(#3000: alarm)
(#5003: current work block end Z)
(#5221: G54 origin X)


(Subprograms)
(O910002)
%