%
O210003 (for dimple measurement & kakou)
(level 1: mainly moving along central curvature)

#701=#4012
(#701: current work coordinate G#)

IF[#701LT54]GOTO800 
IF[#701GT59]GOTO800
(if work G# < 54 or G# > 59, go to N800)

IF[#23EQ#0]GOTO800
IF[#23LT10]GOTO800
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#20LT0]GOTO800
IF[#25EQ#0]GOTO800
IF[#25LT10]GOTO800
IF[#26EQ#0]GOTO800
IF[#09EQ#0]GOTO800
IF[#09LT0]GOTO800
IF[#19LT0]GOTO800
IF[#17EQ#0]GOTO800
IF[#17LE0]GOTO800
IF[#04EQ#0]GOTO800
IF[#04LE0]GOTO800
IF[#06EQ#0]GOTO800
IF[#06LT0]GOTO800
IF[#13EQ#0]GOTO800
IF[#13LE0]GOTO800
IF[#21EQ#0]GOTO800
IF[#21LE0]GOTO800
IF[#18EQ#0]GOTO800
IF[#02EQ#0]GOTO800
IF[#02GT0]GOTO800
(if W < 10 or #0, go to N800)
(if X < 10 or #0, go to N800)
(if Y < 10 or #0, go to N800)
(if T < 0, go to N800)
(if Z = #0, go to N800)
(if F < 0 or #0, go to N800)
(if S < 0, go to N800)
(if Q <= 0 or #0, go to N800)
(if I <= 0 or #0, go to N800)
(if K < 0 or #0, go to N800)
(if M <= 0 or #0, go to N800)
(if U <= 0 or #0, go to N800)
(if R = #0, go to N800)
(if B > 0 or #0, go to N800)

IF[#602EQ#0]GOTO800
IF[#602LT2]GOTO800
IF[#18LE#26]GOTO800
IF[[#13-FIX[#13]]NE0]GOTO800
IF[[#17+[#13-1]*#06]GE#26]GOTO800
IF[[[#09+#19+ABS[#09-#19]]/2]GE[[#24+#25-ABS[#24-#25]]/2]]GOTO800
IF[#02LT[-15]]GOTO800
IF[#21GT#04]GOTO800
IF[#26LE[#901011/2]]GOTO800
(if #602 < 2 or #0, go to N800)
(if R <= Z, go to N800)
(if M is not intger, go to N800)
(if Q+[M-1]*K >= Z, go to N800)
(if max[F, S] >= min[X, Y], go to N800)
(if B < -15, go to N800)
(if U > I, go to N800)
(if Z <= #901011/2, go to N800)

IF[#20EQ#0]THEN #20=0
(if T = #0, then T = 0)

IF[#4111EQ50]GOTO001
IF[#4111EQ31]GOTO002
IF[#4111EQ32]GOTO002
IF[#4111EQ33]GOTO002
(if H#=50, go to N001)
(if H#=31, go to N002)
(if H#=32, go to N002)
(if H#=33, go to N002)
GOTO800

N001 (if sensor)
#702=#901050 (Z hosei)
#703=#901050 (XY hosei)
#704=31 (G#)
GOTO003
N002 (if Tslot)
#702=0 (Z hosei)
#703=#[2400+#4111]+#[2600+#4111]
(XY hosei: the KouguHankei)
#704=1 (G#)

N003
IF[#1000EQ0]THEN #30=#901001
IF[#1000EQ1]THEN #30=#901005
(#30: table center X)

#705=#[5201+[#701-53]*20]-#30
#706=#705*COS[ABS[#02]]+#26*SIN[ABS[#02]]
#707=-#705*SIN[ABS[#02]]+#26*COS[ABS[#02]]
(#705= current work origin X from table center)

#708=#23-#17
(Z: the 1st row before rotation)
#709=SQRT[#18*#18-#708*#708]-SQRT[#18*#18-#23*#23]
(the center of the 1st row before rotation)
#710=#709*COS[ABS[#02]]-#17*SIN[ABS[#02]]
#711=-#709*SIN[ABS[#02]]-#17*COS[ABS[#02]]
(XZ: the center of the 1st row after rotation)


(kokokara G01)


N004
M11 (B-axis unclamp)
G90 G#701 G01 B[#01+#02]
(current work B: G90 #01+#02 deg)
M10 (B-axis clamp)

G90 G01 Z[#26+#600] F#652
(Z: Z+#600)

G91 G01 X[#706-#705] Z[#707-#26-#702-#600] F#652
(XZ: tanmen center)

#712=#5001
#713=#5003
(XZ block end: start point XZ)

IF[#4111NE50]GOTO006
(if tool is not sensor, go to N006)
IF[#1005EQ0]GOTO005
M00 (sensor low battery)
N005
IF[#1004EQ1]GOTO006
(if current sensor ON, go to N006)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)

N006
G91 G#704 X#710 Z#711 F#653
(XZ to the center of the 1st row after rotation)
(if sensor G31, else G01)

#714=#5001
#715=#5002
#716=#5003
(XYZ block end: the center of the 1st row)

IF[#4111EQ50]GOTO009
(if sensor, go to N009)
S#681
M03 (spindle on)
M08 (coolant on)
M28 (chip conveyor on)

N009
#717=4
(#717: faces 1: A, 2: C, 3: B, 4: D)
#718=#25/2+#20-#703-[#602*0.5]
#719=[#24/2+#20-#703-[#602*0.5]]*COS[ABS[#02]]
(#718, #719: face from -[#602*0.5])

N100 (loop on #717)
G90 G01 X#714 Y#715 Z#716 F#652
(XYZ: to the center of the 1st row)

IF[#717EQ3]GOTO101
IF[#717EQ2]GOTO102
IF[#717EQ1]GOTO103
(if B, to N101)
(if C, to N102)
(if A, to N103)
(for face D)
G91 G#704 Y-#718 F#653
IF[#5002GT[-#718]]GOTO802
GOTO200
N101 (for face B)
G91 G#704 Y#718 F#653
IF[#5002LT#718]GOTO802
GOTO200
N102 (for face C)
G91 G#704 X-#719 F#653
IF[#5001GT[#714-#719+0.001]]GOTO802
GOTO200
N103 (for face A)
G91 G#704 X#719 F#653
IF[#5001LT[#714+#719-0.001]]GOTO802

N200
#33=1 (#33: current row)
WHILE[#33LE#13]DO1 (loop on #33)
IF[#717EQ3]GOTO201
IF[#717EQ2]GOTO202
IF[#717EQ1]GOTO203
(#717=3, for B)
(#717=2, for C)
(#717=1, for A)
(face D)
G65 P220002 A-1. F#09 S#19 I#04 K#06 U#21 B#02 M#33
(for D: moving along row)
GOTO204
N201 (face B)
G65 P220002 A1. F#09 S#19 I#04 K#06 U#21 B#02 M#33
(for B: moving along row)
GOTO204
N202 (face C)
G65 P220001 A-1. X#24 F#09 S#19 I#04 K#06 U#21 B#02 M#33
(for C: moving along row)
GOTO204
N203 (face A)
G65 P220001 A1. X#24 F#09 S#19 I#04 K#06 U#21 B#02 M#33
(for A: moving along row)
N204
IF[#33GE#13]GOTO205
(end loop for #33)
#32=#708-[#33-1]*#06
(#32= the #33th row's Z from table center)
#31=SQRT[#18*#18-[#32-#06]*[#32-#06]]-SQRT[#18*#18-#32*#32]
G91 G#704 X[#31*COS[ABS[#02]]-#06*SIN[ABS[#02]]] Z-[#31*SIN[ABS[#02]]+#06*COS[ABS[#02]]] F#653
(current work XY: the center of the #33+1th row)
#33=#33+1 (#33 to current row +1)
END1

N205
#717=#717-1 (changing face)
IF[#717LE0]GOTO104
(end loop for #717)
GOTO100


N104
IF[#4111EQ50]GOTO010
M05 (spindle off)
M09 (coolant off)

N010
G90 G01 X#714 Z[#716-#702] F#652
(XZ: to the center of the 1st row)
G90 G01 X#712 Z#713 F#652
(XZ: to start point)
G90 G01 Z[#713+#600] F#652
GOTO999


N801
M05 (spindle off)
M09 (coolant off)
#3000=145 (Sensor Low battery)

N802
G90 G01 X#714 Y#715 F#653
IF[#1004EQ0]GOTO803
(if current sensor OFF, go to N803)
M117 (sensor on/off)

N803
G90 G01 Z#716 F#653
(XYZ: to the center of the 1st row)
G90 G01 X#712 Z#713 F#653
(XZ: to start point)

N800
M05 (spindle off)
M09 (coolant off)
#3000=121 (are the arguments or the mould OK?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(used only as variables)
(#01:A: angle for furiwake)
(#02:B: angle for dimple)
(#06:K: Z pitch)
(#17:Q: Z length between top and the 1st row)
(#18:R: central curvature)
(#20:T: mekki thickness mm)
(#23:W: Top ori-furiwake)
(#26:Z: Top sai-furiwake)
(used as variables and passed arguments)
(#13:M: number of rows)
(used only as passed arguments)
(#04:I: X pitch)
(#21:U: depth of dimple)
(#09:F: length of odd rows)
(#19:S: length of even rows)
(#24:X: AC naikei of last row)
(#25:Y: BD naikei of last row)

(as LHS)
(#30, #31, #32, #33)


(Common variables)
(as RHS)
(#600, #602, #652, #653, #681, #901001, #901005, #901011, #901050)
(as LHS)
(#701-#719)


(System variables)
(#0   : empty)
(#1004: 1: sensor on, 0: off)
(#1005: 1: sensor low battery, 0: OK)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5001: block end X)
(#5002: block end X)
(#5003: block end Z)
(#5281: G57 X)


(Subprograms)
(O220001, O220002)


(Passed arguments)
(#04, #09, #13, #19, #21, #24, #33)


(Used variable in other programs)
(#717)
%