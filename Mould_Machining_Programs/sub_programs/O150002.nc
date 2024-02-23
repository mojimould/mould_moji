%
O150002 (Y centerline measurement)

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
IF[#901011LE0]GOTO800
IF[#512EQ#0]GOTO800
IF[#512LE0]GOTO800
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
(if #901011 <= 0 or #0, go to N800)
(if #512 <= 0 or #0, go to N800)
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
G49
G90 G53 G01 Z0 F#650
G90 G54 G01 X0 Y[[#02/2]+#512+#602] F#652
G90 G54 G43 G01 Z[#26+#600] H50 F#652
(G43 Z: Z+#600)

IF[#1005EQ1]GOTO801
IF[#1004EQ1]GOTO003
(if low battery, go to N801)
(if current sensor ON, go to N003)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)

N003
G90 G54 G31 Z[#26-[#06/2]-#512] F#678
(G54 Z skip: BotTanmen Z-K/2-#512)
IF[#5003GT[#26-[#06/2]-#512]]GOTO802
(if skip block end Z > BotTanmen Z-K/2-#512, to N802)

G91 G31 Y-[#602+#603] F#679
(Y- skip: #602+#603)
#900027=#5002-#512+#501+#503
(#900027= Y bot above side -#512 +probe hosei)

G91 G01 Y[#602+#603] F#652
(Y+: #602+#603)

G90 G53 G01 Z0 F#650
IF[[ABS[#900027-#501-#503]]LE[ABS[[#02/2]-#602]]]GOTO800
(if |#900027|<=|B/2-#602|, go to N800)

M11 (4jiku unclamp)
G91 G00 B180.
(rotate 180 deg)
M10 (4jiku clamp)

G91 G01 X[-2*[#5221-#33]+#21] F#652
G90 G54 G01 Y[[#20/2]+#512+#602] F#652
(X: top gaisaku center)
(Y: top gaisaku Bmen +#602)

G90 G54 G43 G01 Z[#23+#600] H50 F#652
G90 G54 G31 Z[#23-[#13/2]-#512] F#678
(G54 Z skip: W-M/2-#512)
IF[#5003GT[#23-[#13/2]-#512]]GOTO802
(if skip block end Z > W-#512-M/2+#32, to N802)

G91 G31 Y-[#602+#603] F#679
(Y-: #602+#603)
#900028=#5002-#512+#501+#503
(#900028= Y top above side -#512 +probe hosei)

G91 G01 Y[#602+#603] F#652
(Y+: #602+#603)

G90 G53 G01 Z0 F#650
IF[[ABS[#900028-#501-#503]]LE[ABS[[#20/2]-#602]]]GOTO800
(if |#900028|<=|T/2-#602|, go to N800)

#900029=#900027-#900028-[#02-#20]/2
(difference)

IF[#1005EQ1]GOTO801
IF[#1004EQ0]GOTO004
(if low battery, go to N801)
(if current sensor off, go to N004)
M117 (sensor off)

N004
G90 G54 G01 Y#900029 F#652
(Y to table center)
GOTO999


N801
#3000=145 (Low battery)

N802
G90 G53 G01 Z0 F#652
G90 G54 G01 X0 F#652

N800
G65 P910002 (sensor OFF)
#3000=121 (are the arguments OK?)

N999 M99

(Used Variables and Programs)

(Local variables)
(as received arguments)
(#02:B: BD bot gaisakuKei)
(#06:K: Bot gaisaku height)
(#13:M: mizoIchi)
(#20:T: BD top gaisakuKei)
(#21:U: tooriShin X)
(#23:W: sai-furiwake Top)
(#24:X: bot gaisaku center X)
(#26:Z: sai-furiwake Bot)

(as LHS)
(#32, #33)


(Common variables)
(as LHS)
(#900027, #900028, #900029)
(as RHS)
(#600, #602, #603, #650, #652, #678, #679)
(#501: hosei: touch sensor signal delay)
(#503: hosei: probe center Y)
(#512: probe radius)
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