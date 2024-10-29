%
O160003 (last update on 20241030)
(endface leveling)

N0001
IF[#26EQ#0]GOTO8000
IF[#21EQ#0]GOTO8000
IF[#21LE10]GOTO8000
IF[#13EQ#0]GOTO8000
IF[#13GT1]GOTO8000
(if Z = #0, go to N8000)
(if U <= 10 or #0, go to N8000)
(if M > 1 or #0, go to N8000)

N0002
IF[#901011EQ#0]GOTO8000
IF[#901011LT540]GOTO8000
IF[#901050EQ#0]GOTO8000
IF[#901050LE1]GOTO8000
IF[#600EQ#0]GOTO8000
IF[#600LT50]GOTO8000
IF[#610EQ#0]GOTO8000
IF[#610LT1]GOTO8000
IF[#611EQ#0]GOTO8000
IF[#611LE0]GOTO8000
IF[#611GT15]GOTO8000
IF[#656EQ#0]GOTO8000
IF[#656LE0]GOTO8000
IF[#656GT50]GOTO8000
(if #901011 < 540 or #0, go to N8000)
(if #901050 <= 1 or #0, go to N8000)
(if #600 < 50 or #0, go to N8000)
(if #610 < 1 or #0, go to N8000)
(if #611 <= 0 or > 15 or #0, go to N8000)
(if #656 <= 0 or > 50 or #0, go to N8000)

N0003
IF[#26LE[#901011/2]]GOTO8000
(if Z <= #901011/2, go to N8000)

N0004
IF[#1005EQ1]GOTO8001
IF[#1004EQ1]GOTO0005
(if low battery, go to N8001)
(if current sensor ON, go to N005)
M117 (sensor on/off)
G04 X1.0 (wait 1.0s)


(kokokara G01)


N0005
G90 G57 G31 Z[#26+#610] F#653
IF[#5003GT[#26+#610]]GOTO8002
G91 G57 G31 X-[[#24+#21+#13*2]/4] F#653
IF[#5001GT[-[#24+#21+#13*2]/4]]GOTO8002

N0006 (for X-)
G91 G57 G31 Z-[#610+#611] F#656
IF[#5003LE[#26-#611]]GOTO8002
#900045=#5003+#901053
(Z- skip: #610+#611)
(if skip block end Z <= endface-#611, to N8002)
(#900045= block end Z +probe compensation)

N0007
G91 G57 G01 Z[[#610+#611]/2] F#652
G91 G57 G01 X[[#24+#21+#13*2]/4] F#652

N0008
G91 G57 G31 X[[#24+#21+#13*2]/4] F#653
IF[#5001LT[[#24+#21+#13*2]/4]]GOTO8002

N0009 (for X+)
G91 G57 G31 Z-[#610+#611] F#656
IF[#5003LE[#26-#611]]GOTO8002
#900046=#5003+#901053
(Z- skip: #610+#611)
(if skip block end Z <= endface-#611, to N8002)
(#900046= block end Z +probe compensation)

N0010
G91 G57 G01 Z[[#610+#611]/2] F#652
G90 G53 G01 Z0 F#650

N0011
#900047=ATAN[2*[#900045-#900046]/[#24+#21+#13*2]]
G57
M11 (B-axis unclamp)
G91 G57 G00 B#900047
M10 (B-axis clamp)
(G91 G57 B parallel angle #900047)

#33=[-[#24+#21+#13*2]/4]*SIN[#900047]+#900045*COS[#900047]
#32=[[#24+#21+#13*2]/4]*SIN[#900047]+#900046*COS[#900047]
IF[ABS[ATAN[2*[#33-#32]/[#24+#21+#13*2]]]GT0.001]GOTO8002
#900048=#33

N0012
G90 G57 G01 X0 Y0 F#652
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
(#13:M: mekki thickness mm)
(#21:U: Top AC ID or incut ID)
(#24:X: Top AC OD or outcut OD)
(#26:Z: Top re-alocation length)

(as LHS)
(#32, #33)

(Common variables)
(as LHS)
(#900045, #900046, #900047, #900048)
(as RHS)
(#600, #610, #611, #650, #652, #653, #656)
(#901011)
(#901050: probe radius)
(#901053: compensation: touch sensor signal delay)

(System variables)
(#1000: 0: palette #1, 1: palette #2)
(#1004: 0: sensor off, 1: on)
(#1005: 0: sensor battery ok, 1: low battery)
(#3000: alarm)
(#5003: current work block end Z)

(Subprograms)
(O910002)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%