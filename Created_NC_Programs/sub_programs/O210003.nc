%
O210003 (last update on 20241030)
(for dimple measurement & milling)
(level 1: mainly moving along central curvature)

N0001
#901200=#4012
IF[#901200NE57]GOTO8000 
(#901200: current work coordinate G#)
(if work G# is not 57, go to N8000)

N0002
IF[#5203EQ0]GOTO0003
IF[#5203GE[#17+5]]GOTO0003
(if #5203=0 or >=Q+5, go to N0003)
GOTO8000

N0003
IF[#23EQ#0]GOTO8000
IF[#23LT10]GOTO8000
IF[#20LT0]GOTO8000
IF[#26EQ#0]GOTO8000
IF[#09EQ#0]GOTO8000
IF[#09LT0]GOTO8000
IF[#19LT0]GOTO8000
IF[#17EQ#0]GOTO8000
IF[#17LE0]GOTO8000
IF[#04EQ#0]GOTO8000
IF[#04LE0]GOTO8000
IF[#06EQ#0]GOTO8000
IF[#06LT0]GOTO8000
IF[#13EQ#0]GOTO8000
IF[#13LE0]GOTO8000
IF[#21EQ#0]GOTO8000
IF[#21LE0]GOTO8000
IF[#18EQ#0]GOTO8000
IF[#02EQ#0]GOTO8000
IF[#02GT0]GOTO8000
(if W < 10 or #0, go to N8000)
(if X < 10 or #0, go to N8000)
(if Y < 10 or #0, go to N8000)
(if T < 0, go to N8000)
(if Z = #0, go to N8000)
(if F < 0 or #0, go to N8000)
(if S < 0, go to N8000)
(if Q <= 0 or #0, go to N8000)
(if I <= 0 or #0, go to N8000)
(if K < 0 or #0, go to N8000)
(if M <= 0 or #0, go to N8000)
(if U <= 0 or #0, go to N8000)
(if R = #0, go to N8000)
(if B > 0 or #0, go to N8000)

#24=#900018
#25=#900024
IF[#24EQ#0]GOTO8000
IF[#24LT10]GOTO8000
IF[#25EQ#0]GOTO8000
IF[#25LT10]GOTO8000
(XY into measurement values)
(if X < 10 or #0, go to N8000)
(if Y < 10 or #0, go to N8000)

IF[#09EQ#19]GOTO8000
IF[#620EQ#0]GOTO8000
IF[#620LT2]GOTO8000
IF[#18LE#26]GOTO8000
IF[[#13-FIX[#13]]NE0]GOTO8000
IF[[#17+[#13-1]*#06]GE#26]GOTO8000
IF[[[#09+#19+ABS[#09-#19]]/2]GE[[#24+#25-ABS[#24-#25]]/2]]GOTO8000
IF[#02LT[-15]]GOTO8000
IF[#21GT#04]GOTO8000
IF[#26LE[#901011/2]]GOTO8000
IF[[#17+[#06*[#13-1]]]GT240]GOTO8000
(if F = S, go to N8000)
(if #620 < 2 or #0, go to N8000)
(if R <= Z, go to N8000)
(if M is not intger, go to N8000)
(if Q+[M-1]*K >= Z, go to N8000)
(if max[F, S] >= min[X, Y], go to N8000)
(if B < -15, go to N8000)
(if U > I, go to N8000)
(if Z <= #901011/2, go to N8000)
(if Q+K*[M-1] >= 240, go to N8000)

IF[#20EQ#0]THEN #20=0
(if T=#0, then T=0)

IF[#4111EQ50]GOTO0012
IF[#4111EQ31]GOTO0013
IF[#4111EQ32]GOTO0013
IF[#4111EQ34]GOTO0013
(if H#=50, go to N0012)
(if H#=31, go to N0013)
(if H#=32, go to N0013)
(if H#=34, go to N0013)
GOTO8000

N0012 (if sensor)
#901201=#901050 (Z compensation)
#901202=#901050 (XY compensation)
#901203=31 (G31)
GOTO0014

N0013 (if Tslot)
#901201=0 (Z compensation)
#901202=#[2400+#4111]+#[2600+#4111]
(XY compensation: tool radius)
#901203=1 (G01)

N0014
IF[#1000EQ0]THEN #30=#901001
IF[#1000EQ1]THEN #30=#901005
(#30: table center X)

#901204=#[5201+[#901200-53]*20]-#30
#901205=#901204*COS[ABS[#02]]+#26*SIN[ABS[#02]]
#901206=-#901204*SIN[ABS[#02]]+#26*COS[ABS[#02]]
(#901204= current work origin X from table center)

#901207=#23-#17
(Z: the 1st row before rotation)
#901208=SQRT[#18*#18-#901207*#901207]-SQRT[#18*#18-#23*#23]
(the center of the 1st row before rotation)
#901209=#901208*COS[ABS[#02]]-#17*SIN[ABS[#02]]
#901210=-#901208*SIN[ABS[#02]]-#17*COS[ABS[#02]]
(XZ: the center of the 1st row after rotation)


(kokokara G01)


N0015
G17
M11 (B-axis unclamp)
G90 G#901200 G00 B[#01+#02]
M10 (B-axis clamp)
(current work B: G90 #01+#02 deg)

G90 G01 Z[#26+#600] F#652
(Z: Z+#600)

G91 G01 X[#901205-#901204] Z[#901206-#26-#901201-#600] F#652
(XZ: endface center)

#901211=#5001
#901212=#5003
(XZ block end: start point XZ)

IF[#4111NE50]GOTO0017
(if tool is not sensor, go to N0017)
IF[#1005EQ0]GOTO0016
M00 (sensor low battery)

N0016
IF[#1004EQ1]GOTO0017
(if current sensor ON, go to N0017)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)

N0017
G91 G#901203 X#901209 Z#901210 F#653
(XZ to the center of the 1st row after rotation)
(if sensor G31, else G01)

#901213=#5001
#901214=#5002
#901215=#5003
(XYZ block end: the center of the 1st row)

IF[#4111EQ50]GOTO0020
(if sensor, go to N0020)
IF[#4111EQ34]GOTO0018
S#707
M09 (coolant off)
GOTO0019

N0018
S#708
M08 (coolant on)

N0019
M03 (spindle on)
M28 (chip conveyor on)

N0020
#901216=#25/2+#20-#901202-#620
#901217=[#24/2+#20-#901202-#620]*COS[ABS[#02]]
(#901216, #901217: face from -#620)

#901218=FIX[#21*10]/10-0.1
(#901218=FIX[U*10]/10-0.1)


(start loop for the 1st #901224)


IF[#4111EQ50]GOTO2000
IF[#401EQ0]GOTO2000

#901224=4
(#901224: faces 1: A, 2: C, 3: B, 4: D)

N1000 (loop on #901224)
G90 G01 X#901213 Y#901214 Z#901215 F#652
(XYZ: to the center of the 1st row)

IF[#901224EQ3]GOTO1001
IF[#901224EQ2]GOTO1002
IF[#901224EQ1]GOTO1003
(if B, to N1001)
(if C, to N1002)
(if A, to N1003)

(for face D)
G91 G#901203 Y-#901216 F#653
IF[#5002GT[-#901216+0.001]]GOTO8002
GOTO1004

N1001 (for face B)
G91 G#901203 Y#901216 F#653
IF[#5002LT[#901216-0.001]]GOTO8002
GOTO1004

N1002 (for face C)
G91 G#901203 X-#901217 F#653
IF[#5001GT[#901213-#901217+0.001]]GOTO8002
GOTO1004

N1003 (for face A)
G91 G#901203 X#901217 F#653
IF[#5001LT[#901213+#901217-0.001]]GOTO8002

N1004
IF[#901224EQ3]GOTO1005
IF[#901224EQ2]GOTO1006
IF[#901224EQ1]GOTO1007
(#901224=3, for B)
(#901224=2, for C)
(#901224=1, for A)
(face D)
G65 P220002 A-1.0 F#09 S#19 I#04 K#06 U#901218 V#22 B#02 M1.0
(for D: moving along row)
GOTO1008

N1005 (face B)
G65 P220002 A1.0 F#09 S#19 I#04 K#06 U#901218 V#22 B#02 M1.0
(for B: moving along row)
GOTO1008

N1006 (face C)
G65 P220001 A-1.0 X#24 F#09 S#19 I#04 K#06 U#901218 V#22 B#02 M1.0
(for C: moving along row)
GOTO1008

N1007 (face A)
G65 P220001 A1.0 X#24 F#09 S#19 I#04 K#06 U#901218 V#22 B#02 M1.0
(for A: moving along row)

N1008
#901224=#901224-1 (changing face)
IF[#901224LE0]GOTO0021
GOTO1000


(end loop for the 1st #901224)


N0021
IF[#4111EQ50]GOTO0022
S35

N0022
G17
G90 G01 X#901213 Z[#901215-#901201] F#652
(XZ: to the center of the 1st row)
G90 G01 X#901211 Z#901212 F#652
(XZ: to start point)
G90 G01 Z[#901212+#600] F#652
S2599

N0023
G90 G53 G01 Z0 F#650
M05 (spindle off)
S35
G65 P900003
(pause in front of the door)

G43 H#4120
(tool length compensation: T#)

G90 G00 X0 Y0
G90 G01 Z[#26+#600] F#652
(XY Top Inside Center)
(Z= top realocation +#600)

G91 G01 X[#901205-#901204] Z[#901206-#26-#901201-#600] F#652
(XZ: endface center)

IF[#4111NE50]GOTO0025
(if tool is not sensor, go to N0025)
IF[#1005EQ0]GOTO0024
M00 (sensor low battery)

N0024
IF[#1004EQ1]GOTO0025
(if current sensor ON, go to N0025)
M117 (sensor on/off)
G04 X1.5 (wait 1.5s)

N0025
G91 G#901203 X#901209 Z#901210 F#653
(XZ to the center of the 1st row after rotation)
(if sensor G31, else G01)

IF[#4111EQ50]GOTO2000
(if sensor, go to N2000)
IF[#4111EQ34]GOTO0026
S#707
GOTO0027

N0026
S#708

N0027
M03 (spindle on)
M08 (coolant on)
M28 (chip conveyor on)


N2000
(start loop for the 2nd #901224)


#901224=4
(#901224: faces 1: A, 2: C, 3: B, 4: D)

N2001 (loop on #901224)
G90 G01 X#901213 Y#901214 Z#901215 F#652
(XYZ: to the center of the 1st row)

IF[#901224EQ3]GOTO2002
IF[#901224EQ2]GOTO2003
IF[#901224EQ1]GOTO2004
(if B, to N2002)
(if C, to N2003)
(if A, to N2004)

(for face D)
G91 G#901203 Y-#901216 F#653
IF[#5002GT[-#901216+0.001]]GOTO8002
GOTO2005

N2002 (for face B)
G91 G#901203 Y#901216 F#653
IF[#5002LT[#901216-0.001]]GOTO8002
GOTO2005

N2003 (for face C)
G91 G#901203 X-#901217 F#653
IF[#5001GT[#901213-#901217+0.001]]GOTO8002
GOTO2005

N2004 (for face A)
G91 G#901203 X#901217 F#653
IF[#5001LT[#901213+#901217-0.001]]GOTO8002


(start loop for #33)


N2005
#33=1 (#33: current row)
WHILE[#33LE#13]DO1
IF[#901224EQ3]GOTO3000
IF[#901224EQ2]GOTO3001
IF[#901224EQ1]GOTO3002
(#901224=3, for B)
(#901224=2, for C)
(#901224=1, for A)

(face D)
G65 P220002 A-1.0 F#09 S#19 I#04 K#06 U#21 V#22 B#02 M#33
(for D: moving along row)
GOTO3003

N3000 (face B)
G65 P220002 A1.0 F#09 S#19 I#04 K#06 U#21 V#22 B#02 M#33
(for B: moving along row)
GOTO3003

N3001 (face C)
G65 P220001 A-1.0 X#24 F#09 S#19 I#04 K#06 U#21 V#22 B#02 M#33
(for C: moving along row)
GOTO3003

N3002 (face A)
G65 P220001 A1.0 X#24 F#09 S#19 I#04 K#06 U#21 V#22 B#02 M#33
(for A: moving along row)

N3003
IF[#33GE#13]GOTO2025
(if #33 >= #13, go to N2025)
#32=#901207-[#33-1]*#06
(#32= Z of the #33th row from table center)
#31=SQRT[#18*#18-[#32-#06]*[#32-#06]]-SQRT[#18*#18-#32*#32]
G91 G#901203 X[#31*COS[ABS[#02]]-#06*SIN[ABS[#02]]] Z-[#31*SIN[ABS[#02]]+#06*COS[ABS[#02]]] F#653
(current work XY: the center of the #33+1th row)
#33=#33+1 (#33 to current row +1)
END1


(end loop for #33)


(start loop for #29)


N2025
IF[#4111NE50]GOTO2026
IF[#901224NE3]GOTO2026
#901219=0
#29=1
WHILE[#29LE100]DO1
#[900500+#29]=#0
#29=#29+1
END1

#29=1
WHILE[#29LE100]DO1
#28=#[900300+#29]+#[900400+#29]
IF[ABS[#28]GE0.5]GOTO4000
GOTO4001

N4000
#[900500+#29]=#28

N4001
#29=#29+1
END1

#29=1
WHILE[#29LE100]DO1
#901219=#901219+ABS[#[900500+#29]]
#29=#29+1
END1


(end loop for #29)


IF[#901219EQ0]GOTO2026
GOTO8002

N2026
#901224=#901224-1 (changing face)
IF[#901224LE0]GOTO0028
GOTO2001


(end loop for the 2nd #901224)


N0028
IF[#4111EQ50]GOTO0029
M09 (coolant off)

N0029
G17
G90 G01 X#901213 Z[#901215-#901201] F#652
(XZ: to the center of the 1st row)
G90 G01 X#901211 Z#901212 F#652
(XZ: to start point)
G90 G01 Z[#901212+#600] F#652

N9990
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


N8002
G17
G90 G01 X#901213 Y#901214 F#653
IF[#1004EQ0]GOTO8003
(if current sensor OFF, go to N8003)
M117 (sensor on/off)

N8003
G17
G90 G01 Z#901215 F#653
(Z: to the center of the 1st row)
G90 G01 X#901211 Z#901212 F#653
(XZ: to start point)

N8000
G17
M09 (coolant off)
M05 (spindle off)
#3000=121 (are*the*arguments*or*dimple*values*OK?)

N9999
M99

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
(#09:F: length of odd rows)
(#19:S: length of even rows)
(#21:U: depth of dimple)
(#22:V: dimple milling radius)

(as LHS)
(#24, #25, #29, #30, #31, #32, #33)

(Common variables)
(as RHS)
(#401)
(#600, #620, #652, #653, #707)
(#900018, #900024, #901001, #901005, #901011, #901050)
(#900301-#900600)
(as LHS)
(#901200-#901219, #901224)

(System variables)
(#0   : empty)
(#1004: 1: sensor on, 0: off)
(#1005: 1: sensor low battery, 0: OK)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4111: current H#)
(#5001: block end X)
(#5002: block end X)
(#5003: block end Z)
(#5203: outer work coordinate Z)
(#5281: G57 X)

(Subprograms)
(O220001, O220002, O900003)

(Passed arguments)
(#04, #09, #13, #19, #21, #24, #33)

(Used variable in other programs)
(#901224)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%