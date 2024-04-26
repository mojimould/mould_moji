%
O210003 (for dimple measurement & kakou)
(level 1: mainly moving along central curvature)

#700=#4012
(#700: current work coordinate G#)

IF[#700NE57]GOTO800 
(if work G# is not 57, go to N800)

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

IF[#09EQ#19]GOTO800
IF[#620EQ#0]GOTO800
IF[#620LT2]GOTO800
IF[#18LE#26]GOTO800
IF[[#13-FIX[#13]]NE0]GOTO800
IF[[#17+[#13-1]*#06]GE#26]GOTO800
IF[[[#09+#19+ABS[#09-#19]]/2]GE[[#24+#25-ABS[#24-#25]]/2]]GOTO800
IF[#02LT[-15]]GOTO800
IF[#21GT#04]GOTO800
IF[#26LE[#901011/2]]GOTO800
(if F = S, go to N800)
(if #620 < 2 or #0, go to N800)
(if R <= Z, go to N800)
(if M is not intger, go to N800)
(if Q+[M-1]*K >= Z, go to N800)
(if max[F, S] >= min[X, Y], go to N800)
(if B < -15, go to N800)
(if U > I, go to N800)
(if Z <= #901011/2, go to N800)

IF[#20EQ#0]THEN #20=0
(if T=#0, then T=0)

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
#701=#901050 (Z hosei)
#702=#901050 (XY hosei)
#703=31 (G31)
GOTO003
N002 (if Tslot)
#701=0 (Z hosei)
#702=#[2400+#4111]+#[2600+#4111]
(XY hosei: the KouguHankei)
#703=1 (G01)

N003
IF[#1000EQ0]THEN #30=#901001
IF[#1000EQ1]THEN #30=#901005
(#30: table center X)

#704=#[5201+[#700-53]*20]-#30
#705=#704*COS[ABS[#02]]+#26*SIN[ABS[#02]]
#706=-#704*SIN[ABS[#02]]+#26*COS[ABS[#02]]
(#704= current work origin X from table center)

#707=#23-#17
(Z: the 1st row before rotation)
#708=SQRT[#18*#18-#707*#707]-SQRT[#18*#18-#23*#23]
(the center of the 1st row before rotation)
#709=#708*COS[ABS[#02]]-#17*SIN[ABS[#02]]
#710=-#708*SIN[ABS[#02]]-#17*COS[ABS[#02]]
(XZ: the center of the 1st row after rotation)


(kokokara G01)


N004
M11 (B-axis unclamp)
G90 G#700 G00 B[#01+#02]
M10 (B-axis clamp)
(current work B: G90 #01+#02 deg)

G90 G01 Z[#26+#600] F#652
(Z: Z+#600)

G91 G01 X[#705-#704] Z[#706-#26-#701-#600] F#652
(XZ: tanmen center)

#711=#5001
#712=#5003
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
G91 G#703 X#709 Z#710 F#653
(XZ to the center of the 1st row after rotation)
(if sensor G31, else G01)

#713=#5001
#714=#5002
#715=#5003
(XYZ block end: the center of the 1st row)

IF[#4111EQ50]GOTO009
(if sensor, go to N009)
S#681
M03 (spindle on)
M08 (coolant on)
M28 (chip conveyor on)

N009
#716=#25/2+#20-#702-#620
#717=[#24/2+#20-#702-#620]*COS[ABS[#02]]
(#716, #717: face from -#620)

#718=FIX[#21*10]/10-0.1
(#718=FIX[U*10]/10-0.1)

IF[#4111EQ50]GOTO200
IF[#401EQ0]GOTO200


(start loop for the 1st #724)


#724=4
(#724: faces 1: A, 2: C, 3: B, 4: D)
N100 (loop on #724)
G90 G01 X#713 Y#714 Z#715 F#652
(XYZ: to the center of the 1st row)

IF[#724EQ3]GOTO101
IF[#724EQ2]GOTO102
IF[#724EQ1]GOTO103
(if B, to N101)
(if C, to N102)
(if A, to N103)
(for face D)
G91 G#703 Y-#716 F#653
IF[#5002GT[-#716]]GOTO802
GOTO104
N101 (for face B)
G91 G#703 Y#716 F#653
IF[#5002LT#716]GOTO802
GOTO104
N102 (for face C)
G91 G#703 X-#717 F#653
IF[#5001GT[#713-#717+0.001]]GOTO802
GOTO104
N103 (for face A)
G91 G#703 X#717 F#653
IF[#5001LT[#713+#717-0.001]]GOTO802

N104
IF[#724EQ3]GOTO105
IF[#724EQ2]GOTO106
IF[#724EQ1]GOTO107
(#724=3, for B)
(#724=2, for C)
(#724=1, for A)
(face D)
G65 P220002 A-1. F#09 S#19 I#04 K#06 U#718 B#02 M1.0
(for D: moving along row)
GOTO108
N105 (face B)
G65 P220002 A1. F#09 S#19 I#04 K#06 U#718 B#02 M1.0
(for B: moving along row)
GOTO108
N106 (face C)
G65 P220001 A-1. X#24 F#09 S#19 I#04 K#06 U#718 B#02 M1.0
(for C: moving along row)
GOTO108
N107 (face A)
G65 P220001 A1. X#24 F#09 S#19 I#04 K#06 U#718 B#02 M1.0
(for A: moving along row)

N108
#724=#724-1 (changing face)
IF[#724LE0]GOTO010
GOTO100


(end loop for the 1st #724)


N010
IF[#4111EQ50]GOTO011
M09 (coolant off)
S35

N011
G90 G01 X#713 Z[#715-#701] F#652
(XZ: to the center of the 1st row)
G90 G01 X#711 Z#712 F#652
(XZ: to start point)
G90 G01 Z[#712+#600] F#652
S2599
G90 G53 G01 Z0 F#650
G04 X1.5 (wait 1.5s)
M05 (spindle off)
S35
G65 P900003
(pause in front of the door)

G43 H#4120 (hosei KouguChou: T#)

G90 G00 X0 Y0
G90 G01 Z[#26+#600] F#652
(XY Top Inside Center)
(Z= TopTanmen +#600)

G91 G01 X[#705-#704] Z[#706-#26-#701-#600] F#652
(XZ: tanmen center)

IF[#4111NE50]GOTO013
(if tool is not sensor, go to N013)
IF[#1005EQ0]GOTO012
M00 (sensor low battery)
N012
IF[#1004EQ1]GOTO013
(if current sensor ON, go to N013)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)

N013
G91 G#703 X#709 Z#710 F#653
(XZ to the center of the 1st row after rotation)
(if sensor G31, else G01)

IF[#4111EQ50]GOTO200
(if sensor, go to N200)
S#681
M03 (spindle on)
M08 (coolant on)
M28 (chip conveyor on)


N200
(start loop for the 2nd #724)


#724=4
(#724: faces 1: A, 2: C, 3: B, 4: D)
N201 (loop on #724)
G90 G01 X#713 Y#714 Z#715 F#652
(XYZ: to the center of the 1st row)

IF[#724EQ3]GOTO202
IF[#724EQ2]GOTO203
IF[#724EQ1]GOTO204
(if B, to N202)
(if C, to N203)
(if A, to N204)
(for face D)
G91 G#703 Y-#716 F#653
IF[#5002GT[-#716]]GOTO802
GOTO205
N202 (for face B)
G91 G#703 Y#716 F#653
IF[#5002LT#716]GOTO802
GOTO205
N203 (for face C)
G91 G#703 X-#717 F#653
IF[#5001GT[#713-#717+0.001]]GOTO802
GOTO205
N204 (for face A)
G91 G#703 X#717 F#653
IF[#5001LT[#713+#717-0.001]]GOTO802


(start loop for #33)


N205
#33=1 (#33: current row)
WHILE[#33LE#13]DO1
IF[#724EQ3]GOTO300
IF[#724EQ2]GOTO301
IF[#724EQ1]GOTO302
(#724=3, for B)
(#724=2, for C)
(#724=1, for A)
(face D)
G65 P220002 A-1. F#09 S#19 I#04 K#06 U#21 B#02 M#33
(for D: moving along row)
GOTO303
N300 (face B)
G65 P220002 A1. F#09 S#19 I#04 K#06 U#21 B#02 M#33
(for B: moving along row)
GOTO303
N301 (face C)
G65 P220001 A-1. X#24 F#09 S#19 I#04 K#06 U#21 B#02 M#33
(for C: moving along row)
GOTO303
N302 (face A)
G65 P220001 A1. X#24 F#09 S#19 I#04 K#06 U#21 B#02 M#33
(for A: moving along row)
N303
IF[#33GE#13]GOTO206
(if #33 >= #13, go to N206)
#32=#707-[#33-1]*#06
(#32= the #33th row's Z from table center)
#31=SQRT[#18*#18-[#32-#06]*[#32-#06]]-SQRT[#18*#18-#32*#32]
G91 G#703 X[#31*COS[ABS[#02]]-#06*SIN[ABS[#02]]] Z-[#31*SIN[ABS[#02]]+#06*COS[ABS[#02]]] F#653
(current work XY: the center of the #33+1th row)
#33=#33+1 (#33 to current row +1)
END1


(end loop for #33)


N206
#724=#724-1 (changing face)
IF[#724LE0]GOTO014
GOTO201


(end loop for the 2nd #724)


N014
IF[#4111EQ50]GOTO016
M09 (coolant off)
S35

N016
G90 G01 X#713 Z[#715-#701] F#652
(XZ: to the center of the 1st row)
G90 G01 X#711 Z#712 F#652
(XZ: to start point)
G90 G01 Z[#712+#600] F#652
S2599
G90 G53 G01 Z0 F#650
G04 X1.5 (wait 1.5s)
M05 (spindle off)
S35
GOTO999


N801
M09 (coolant off)
M05 (spindle off)
#3000=145 (Sensor Low battery)

N802
G90 G01 X#713 Y#714 F#653
IF[#1004EQ0]GOTO803
(if current sensor OFF, go to N803)
M117 (sensor on/off)

N803
G90 G01 Z#715 F#653
(XYZ: to the center of the 1st row)
G90 G01 X#711 Z#712 F#653
(XZ: to start point)

N800
M09 (coolant off)
M05 (spindle off)
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
(#401, #600, #620, #652, #653, #681, #901001, #901005, #901011, #901050)
(as LHS)
(#700-#718, #724)


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
(#724)
%