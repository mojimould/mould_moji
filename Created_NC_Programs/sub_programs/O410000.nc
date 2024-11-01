%
O410000 (last update on 20241101)
(endface, ID-#608, coner R, ar, clockwise)

N0001
IF[#18EQ#0]GOTO8000
IF[#18LT1]GOTO8000
IF[#26EQ#0]GOTO8000
(if R < 1 or #0, go to N8000)
(if Z = #0, go to N8000)

N0003
IF[#400EQ#0]GOTO8000
IF[#400LE0]GOTO8000
IF[#675EQ#0]GOTO8000
IF[#675LE10]GOTO8000
IF[#676EQ#0]GOTO8000
IF[#676LE10]GOTO8000
IF[#700EQ#0]GOTO8000
IF[#700LE200]GOTO8000
(if #400 <= 0 or #0, go to N8000)
(if #675 <= 10 or #0, go to N8000)
(if #676 <= 10 or #0, go to N8000)
(if #700 <= 200 or #0, go to N8000)

IF[#4012EQ57]THEN #24=#900018
IF[#4012EQ55]THEN #24=#900019
IF[#4012EQ57]THEN #25=#900024
IF[#4012EQ55]THEN #25=#900025
IF[#24EQ#0]GOTO8000
IF[#24LT50]GOTO8000
IF[#25EQ#0]GOTO8000
IF[#25LT50]GOTO8000
(XY into measurement values)
(if X < 50 or #0, go to N8000)
(if Y < 50 or #0, go to N8000)

N0004
#100=#400
#106=FUP[#100/#625]
(#106: number of operations)

N0004
IF[#4120EQ#0]GOTO8000
IF[#4120LT2]GOTO8000
IF[#4120GT5]GOTO8000
IF[[FIX[#4120]]NE#4120]GOTO8000
IF[#26LE[#901011/2]]GOTO8000
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO8000
IF[#100EQ#0]GOTO8000
IF[#100LT1]GOTO8000
IF[#106LE0]GOTO8000
IF[#608LT1]GOTO8000
IF[#625EQ#0]GOTO8000
IF[#625LE0]GOTO8000
IF[#625GT5]GOTO8000
IF[[#625*#106]LT0]GOTO8000
(if T# < 2 or > 5 or not integer or #0, go to N8000)
(if Z <= #901011/2, go to N8000)
(if BCX <= 1 or BCX = #0, go to N8000)
(if R >= min[X/4, Y/4], go to N8000)
(if #100 < 1 or #0, go to N8000)
(if #106 <= 0, go to N8000)
(if #608 < 1, go to N8000)
(if #625 <= 0 or #625 > 5 or #625 = #0, go to N8000)
(if #625*#106 < 0, go to N8000)

N0006
#33=#[2400+#4120]+#[2600+#4120]
#32=[#605+#33+ABS[#605-#33]]/2
#31=#24-[#608*2]
#30=#25-[#608*2]
IF[#32LE0]GOTO8000
(#32: max[#605, tool diameter compensation])
(#31: X-#608*2)
(#30: Y-#608*2)

N0007
IF[#608GE#33]GOTO8000
(if #608 >= tool diameter, go to N8000)


(kokokara G00)


N0008
G90 G43 G01 H#4120 Z[#26+#625*#106+#600] F#650

N1000 (loop)
WHILE[#106GE1]DO1
#106=#106-1

N1001
G90 G00 X[[#31/2]+#32*3] Y[#30/2]
G42 D#4120
G91 G00 X-[#32/2]
G90 G01 Z[#26+#625*#106] S#700 F#650

N1002
M03 (spindle on)
M08 (coolant #1 on)

N1003
G90 G01 X[[#31/2]+#32*2] Y[#30/2] F#651
G65 P490005 K1.0 R#18 X#31 Y#30 D#32 F#675 E#676 S#700
G90 G40 G00 X[[#31/2]+#32*3]
END1

N9990
M09 (coolant off)
G90 G43 G01 H#4120 Z[#26+#600] F#650
IF[#4119GE2600]GOTO9991
S2599
GOTO9992
N9991
S6000

N9992
G90 G53 G01 Z0 F#650
G04 X1.5 (wait 1.5s)
M05 (spindle off)
S35
GOTO9999


N8000
M09 (coolant off)
S2599
G04 X2.0 (wait 2.0s)
M05 (spindle off)
S35
#3000=100 (are*the*arguments*OK?)

N9999
M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#18:R: outside corner R)
(#26:Z: re_alocation)

(as LHS)
(#24, #25, #30, #31, #32, #33)

(Common variable)
(as LHS)
(#100, #106)
(as RHS)
(#400, #600, #605, #608, #625, #650, #651, #675, #676, #700)
(#900018, #900019, #900024, #900025, #901011)

(System variables)
(#24xx: #xx tool diameter)
(#26xx: #xx tool diameter wear)
(#3000: alarm)
(#4120: current T#)

(Subprograms)
(O490005)

(Passed arguments)
(#18, #30, #31, #32, #675, #676, #700)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%