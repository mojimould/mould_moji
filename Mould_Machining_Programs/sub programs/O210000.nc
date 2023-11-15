%
O210000 (for dimple measurement & kakou)
(level 1: mainly moving along central curvature)

IF[#4012LT54]GOTO800 
IF[#4012GT59]GOTO800
(if work G# < 54 or G# > 59, go to N800)

IF[#18EQ#0]GOTO800
IF[#23EQ#0]GOTO800
IF[#23LE0]GOTO800
IF[#24EQ#0]GOTO800
IF[#24LE0]GOTO800
IF[#25EQ#0]GOTO800
IF[#25LE0]GOTO800
IF[#26EQ#0]GOTO800
IF[#26LE0]GOTO800
IF[#09EQ#0]GOTO800
IF[#09LE0]GOTO800
IF[#19LE0]GOTO800
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
(if R is empty, go to N800)
(if W <= 0 or empty, go to N800)
(if Z <= 0 or empty, go to N800)
(if Q <= 0 or empty, go to N800)
(if M <= 0 or empty, go to N800)
(if K < 0 or empty, go to N800)
(if X <= 0 or empty, go to N800)
(if Y <= 0 or empty, go to N800)
(if F <= 0 or empty, go to N800)
(if S <= 0, go to N800)
(if I <= 0 or empty, go to N800)
(if U <= 0 or empty, go to N800)

IF[#18LE#26]GOTO800
IF[[#13-FIX[#13]]NE0]GOTO800
IF[[#17+[#13-1]*#06]GE#26]GOTO800
IF[#02EQ#0]GOTO800
IF[[[#09+#19+ABS[#09-#19]]/2]GE[[#24+#25-ABS[#24-#25]]/2]]GOTO800
IF[[ABS[#02]]GT15.]GOTO800
IF[#09GE#25]GOTO800
IF[#19GE#25]GOTO800
IF[#21GT#04]GOTO800
(if R <= Z, go to N800)
(if M is not intger, go to N800)
(if Q+[M-1]*K >= Z, go to N800)
(if max[F, S] >= min[X, Y], go to N800)
(if B is empty or |B| > 20., go to N800)
(if F >= Y, go to N800)
(if S >= Y, go to N800)
(if U > I, go to N800)

#701=#4012 (#701= current work coordinate G#)
IF[#4111EQ50]GOTO001 (if H# = 50, go to N001)
IF[#4111EQ31]GOTO002 (if H# = 31, go to N002)
IF[#4111EQ32]GOTO002 (if H# = 32, go to N002)
IF[#4111EQ33]GOTO002 (if H# = 33, go to N002)
GOTO800
N001 #30=#512
GOTO003 (if sensor, #30=#512)
N002 #30=0 (if Tslot, #30=0)

N003
IF[#1000NE0]GOTO004
(if the palette is NOT #1, to N004)
#29=#401 (p#1 table center X)
#28=#403 (p#1 table center Z)
GOTO005
N004
#29=#405 (p#2 table center X)
#28=#407 (p#2 table center Z)

N005
M11 (4jiku unclamp)
G90 G00 G#701 B[#02+#585]
(current work B: G90 B+#585 deg)
M10 (4jiku clamp)

#702=#[5201+[#701-53]*20]-#29
#703=#702*COS[ABS[#02]]+#26*SIN[ABS[#02]]
#704=-#702*SIN[ABS[#02]]+#26*COS[ABS[#02]]
(#702= current work origin X from table center)
(#702~-11.095, #703~7.497, #704~500.083)
G91 G01 X[#703-#702] F6400
G91 G01 Z[#704-#26-#30-100]
(X~18.592, Z~0.067-#30)
(XZ to tanmen center)

#705=#5041
#706=#5043-#[2000+#4111]
(current work XZ: start point XZ)
#707=#23-#17
(Z: the 1st row before rotation)
#708=SQRT[#18*#18-#707*#707]-SQRT[#18*#18-#23*#23]
(the center of the 1st row before rotation)
#709=#708*COS[ABS[#02]]-#17*SIN[ABS[#02]]
#710=-#708*SIN[ABS[#02]]-#17*COS[ABS[#02]]
(XZ: the center of the 1st row after rotation)

IF[#4111NE50]GOTO006
(if tool is not sensor, go to N006)
IF[#1005EQ1]GOTO801
IF[#1004EQ1]GOTO006
(if low battery, go to N801)
(if current sensor ON, go to N006)
M117 (sensor on/off)

N006
G91 G31 X#709 Z#710 F1500
(XZ skip: to the center of the 1st row)
#711=#5041
#712=#5042
#713=#5043-[#[2000+#4111]+#[2200+#4111]]
(current work XYZ: the center of the 1st row)

IF[#4111EQ50]GOTO007
M03 (shujiku kaiten on)
(M08 coolant on)

N007
#714=4 (#714: faces 1: A, 2: C, 3: B, 4: D)

N100 (loop on #714)
G90 G01 X#711 Y#712 Z#713 F6400
(XYZ: to the center of the 1st row)

IF[#714EQ3]GOTO101
IF[#714EQ2]GOTO102
IF[#714EQ1]GOTO103
(if B, to N101)
(if C, to N102)
(if A, to N103)
(for face D)
G91 G31 Y-[#25/2-#512-10] F1500
GOTO200
N101 (for face B)
G91 G31 Y[#25/2-#512-10] F1500
GOTO200
N102 (for face C)
G91 G31 X-[[#24/2-#512-10]*COS[ABS[#02]]] F1500
GOTO200
N103 (for face A)
G91 G31 X[[#24/2-#512-10]*COS[ABS[#02]]] F1500

N200
#33=1 (#33: current row)
WHILE[#33LE#13]DO1 (loop on #33)
IF[#714EQ3]GOTO201
IF[#714EQ2]GOTO202
IF[#714EQ1]GOTO203
(#714=3, for B)
(#714=2, for C)
(#714=1, for A)
G65P220002 A-1. Y#25 F#09 S#19 I#04 K#06 U#21 B#02 M#33
(for D: moving along row)
GOTO204
N201 (face B)
G65P220002 A1. Y#25 F#09 S#19 I#04 K#06 U#21 B#02 M#33
(for B: moving along row)
GOTO204
N202 (face C)
G65P220001 A-1. X#24 F#09 S#19 I#04 K#06 U#21 B#02 M#33
(for C: moving along row)
GOTO204
N203 (face A)
G65P220001 A1. X#24 F#09 S#19 I#04 K#06 U#21 B#02 M#33
(for A: moving along row)
N204
IF[#33GE#13]GOTO205
(end loop for #33)
#32=#707-[#33-1]*#06
(#32= the #33th row's Z from table center)
#31=SQRT[#18*#18-[#32-#06]*[#32-#06]]-SQRT[#18*#18-#32*#32]
G91 G31 X[#31*COS[ABS[#02]]-#06*SIN[ABS[#02]]] Z-[#31*SIN[ABS[#02]]+#06*COS[ABS[#02]]] F1500
(current work XY: the center of the #33+1th row)
#33=#33+1 (#33 to current row +1)
END1

N205
#714=#714-1 (changing face)
IF[#714LE0]GOTO104
(end loop for #714)
GOTO100


N104
IF[#4111EQ50]GOTO008
M05 (shujiku kaiten off)
M09 (coolant off)

N008
G90 G01 X#711 Z[#713-#30] F6400
(XZ: to the center of the 1st row)
G90 G01 X#705 Z#706 F6400
(XZ: to start point)
G90 G01 Z[#706+100.0] F9600
GOTO999

N801
#3000=145 (Sensor Low battery)
M00 (ALARM: low battery)
GOTO999

N800
#3000=121 (are the arguments or the mould OK?)
M00 (are arguments ok?)

N999 M99

(Used Variables and Programs)
(local variables)
(as received argument)
(#02:B: angle)
(#06:K: Z pitch)
(#13:M: number of rows)
(#17:Q: Z length between top and the 1st row)
(#18:R: radius of the central curvature)
(#23:W: furiwake Top)
(#26:Z: sai-furiwake Top)
(as received and passed argument)
(#04 :I: X pitch)
(#21:U: depth of dimple)
(#09 :F: length of odd rows)
(#19:S: length of even rows)
(#24:X: AC naikei of last row)
(#25:Y: BD naikei of last row)
(as destination)
(#28, #29, #30, #31, #32, #33)

(common variables)
(as destination)
(#401, #403, #405, #407, #512, #585)
(as source)
(#701, #702, #703, #704, #705, #707, #708, #709, #710, #711, #712, #713, #714)

(system variables)
(#0   : empty)
(#1004: 1: sensor on, 0: off)
(#1005: 1: sensor low battery, 0: OK)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5041: current work X)
(#5042: current work X)
(#5043: current work Z)
(#5044: current work B)
(#5063: skip position Z without KouguChou hosei)

(subprograms)
(O220001, O220002)
%