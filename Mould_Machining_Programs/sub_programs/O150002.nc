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
IF[#901050EQ#0]GOTO800
IF[#901050LE0]GOTO800
IF[#600EQ#0]GOTO800
IF[#600LT50]GOTO800
IF[#602EQ#0]GOTO800
IF[#602LE0]GOTO800
IF[#603EQ#0]GOTO800
IF[#603LT0]GOTO800
IF[#603GT20]GOTO800
IF[#656EQ#0]GOTO800
IF[#656LE0]GOTO800
IF[#656GT50]GOTO800
(if #901011 <= 0 or #0, go to N800)
(if #901050 <= 0 or #0, go to N800)
(if #600 < 50 or #0, go to N800)
(if #602 <= 0 or #0, go to N800)
(if #603 < 0 or #603 > 20.0 or #0, go to N800)
(if #656 <= 0 or #0, go to N800)
(if #656 > 50. or #0, go to N800)

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
G90 G54 G01 X0 Y[[#02/2]+#901050+#602] F#652
G90 G54 G43 G01 Z[#26+#600] H50 F#652
(G43 Z: Z+#600)

IF[#1005EQ1]GOTO801
IF[#1004EQ1]GOTO003
(if low battery, go to N801)
(if current sensor ON, go to N003)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)

N003
G90 G54 G31 Z[#26-[#06/2]-#901050] F#653
(G54 Z skip: BotTanmen Z-K/2-#901050)
IF[#5003GT[#26-[#06/2]-#901050]]GOTO802
(if skip block end Z > BotTanmen Z-K/2-#901050, to N802)

G91 G31 Y-[#602+#603] F#656
(Y- skip: #602+#603)
#900030=#5002-#901050+#901053+#901055
(#900030= Y bot above side -#901050 +probe hosei)

G91 G01 Y[#602+#603] F#652
(Y+: #602+#603)

G90 G53 G01 Z0 F#650
IF[[ABS[#900030-#901053-#901055]]LE[ABS[[#02/2]-#602]]]GOTO800
(if |#900030|<=|B/2-#602|, go to N800)

M11 (B-axis unclamp)
G91 G00 B180.
(rotate 180 deg)
M10 (B-axis clamp)

G91 G01 X[-2*[#5221-#33]+#21] F#652
G90 G54 G01 Y[[#20/2]+#901050+#602] F#652
(X: top gaisaku center)
(Y: top gaisaku Bmen +#602)

G90 G54 G43 G01 Z[#23+#600] H50 F#652
G90 G54 G31 Z[#23-[#13/2]-#901050] F#653
(G54 Z skip: W-M/2-#901050)
IF[#5003GT[#23-[#13/2]-#901050]]GOTO802
(if skip block end Z > W-#901050-M/2+#32, to N802)

G91 G31 Y-[#602+#603] F#656
(Y-: #602+#603)
#900031=#5002-#901050+#901053+#901055
(#900031= Y top above side -#901050 +probe hosei)

G91 G01 Y[#602+#603] F#652
(Y+: #602+#603)

G90 G53 G01 Z0 F#650
IF[[ABS[#900031-#901053-#901055]]LE[ABS[[#20/2]-#602]]]GOTO800
(if |#900031|<=|T/2-#602|, go to N800)

#900032=#900030-#900031-[#02-#20]/2
(difference)

IF[#1005EQ1]GOTO801
IF[#1004EQ0]GOTO004
(if low battery, go to N801)
(if current sensor off, go to N004)
M117 (sensor off)

N004
G90 G54 G01 Y#900032 F#652
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
(#900030, #900031, #900032)
(as RHS)
(#600, #602, #603, #650, #652, #653, #656)
(#901001, #901003, #901005, #901007, #901011)
(#901050: probe radius)
(#901053: hosei: touch sensor signal delay)
(#901055: hosei: probe center Y)


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