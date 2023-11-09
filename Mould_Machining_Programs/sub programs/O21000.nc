%
O21000 (for dimple measurement & kakou)
(level 1: mainly moving along central curvature)

IF[#4012LT54]GOTO98 
IF[#4012GT59]GOTO98
(if work G# < 54 or G# > 59, go to N98)

IF[#18EQ#0]GOTO98
IF[#23EQ#0]GOTO98
IF[#23LE0]GOTO98
IF[#24EQ#0]GOTO98
IF[#24LE0]GOTO98
IF[#25EQ#0]GOTO98
IF[#25LE0]GOTO98
IF[#26EQ#0]GOTO98
IF[#26LE0]GOTO98
IF[#9EQ#0]GOTO98
IF[#9LE0]GOTO98
IF[#19LE0]GOTO98
IF[#17EQ#0]GOTO98
IF[#17LE0]GOTO98
IF[#4EQ#0]GOTO98
IF[#4LE0]GOTO98
IF[#6EQ#0]GOTO98
IF[#6LT0]GOTO98
IF[#13EQ#0]GOTO98
IF[#13LE0]GOTO98
IF[#21EQ#0]GOTO98
IF[#21LE0]GOTO98
(if R is empty, go to N98)
(if W <= 0 or empty, go to N98)
(if Z <= 0 or empty, go to N98)
(if Q <= 0 or empty, go to N98)
(if M <= 0 or empty, go to N98)
(if K < 0 or empty, go to N98)
(if X <= 0 or empty, go to N98)
(if Y <= 0 or empty, go to N98)
(if F <= 0 or empty, go to N98)
(if S <= 0, go to N98)
(if I <= 0 or empty, go to N98)
(if U <= 0 or empty, go to N98)

IF[#18LE#26]GOTO98
IF[[#13-FIX[#13]]NE0]GOTO98
IF[[#17+[#13-1]*#6]GE#26]GOTO98
IF[#2EQ#0]GOTO98
IF[[[#9+#19+ABS[#9-#19]]/2]GE[[#24+#25-ABS[#24-#25]]/2]]GOTO98
IF[[ABS[#2]]GT20.]GOTO98
IF[#9GE#25]GOTO98
IF[#19GE#25]GOTO98
IF[#21GT#4]GOTO98
(if R <= Z, go to N98)
(if M is not intger, go to N98)
(if Q+[M-1]*K >= Z, go to N98)
(if max[F, S] >= min[X, Y], go to N98)
(if B is empty or |B| > 20., go to N98)
(if F >= Y, go to N98)
(if S >= Y, go to N98)
(if U > I, go to N98)

#701=#4012 (#701= current work coordinate G#)
#702=#[5201+[#701-53]*20] (#702= current work origin X)
IF[#4111EQ50]GOTO1 (if H# = 50, go to N01)
IF[#4111EQ31]GOTO2 (if H# = 31, go to N02)
IF[#4111EQ32]GOTO2 (if H# = 32, go to N02)
IF[#4111EQ33]GOTO2 (if H# = 33, go to N02)
GOTO98
N01 #30=#512
GOTO03 (if sensor, #30=#512)
N02 #30=0 (if Tslot, #30=0)

N03
IF[#1000NE0]GOTO04
(if the palette is NOT #1, to N4)
#29=#401 (p#1 table center X)
#28=#403 (p#1 table center Z)
GOTO05
N04
#29=#405 (p#2 table center X)
#28=#407 (p#2 table center Z)

N05
M11 (4jiku unclamp)
G90 G00 G#701 B#2 (current work B: G90 A deg)
M10 (4jiku clamp)
G90 G01 X[[#702-#29]*COS[#2]-#26*SIN[#2]] F6400
G90 G01 Z[[#702-#29]*SIN[#2]+#26*COS[#2]-#30]
(XZ to tanmen center)

#703=#5041
#704=#5043
(current work XZ: start point XZ)
#705=#23-#17
(Z: the 1st row before rotation)
#706=SQRT[#18*#18-#705*#705]-SQRT[#18*#18-#23*#23]
(the center of the 1st row before rotation)
#707=#706*COS[#2]-#17*SIN[#2]
#708=-#706*SIN[#2]-#17*COS[#2]
(XZ: the center of the 1st row after rotation)

IF[#4111NE50]GOTO05
(if tool is not sensor, go to N05)
IF[#1005EQ1]GOTO96 (if low battery, go to N96)
IF[#1004EQ1]GOTO05 (if current sensor ON, go to N05)
M117 (sensor on/off)

N05
G91 G31 X#707 Z#708 F600
(XZ skip: to the center of the 1st row)
#709=#5041
#710=#5043
(current work XZ: the center of the 1st row)

#711=4 (#711: faces 1: A, 2: B, 3: C, 4: D)
IF[#711NE4]GOTO98 (if #711 is not 4, go to N98)
N10
G90 G01 X#709 Z[#710-#30] F6400
(XYZ: to the center of the 1st row)

#33=1 (#33: current row)
WHILE[#33LE#13]DO1 (if #33 <= #13, do 1)
IF[#711EQ3]GOTO31 (#711=3, for B)
IF[#711EQ2]GOTO32 (#711=2, for C)
IF[#711EQ1]GOTO33 (#711=1, for A)
M98 P22002 A-1. Y#25 F#9 S#19 I#4 K#6 U#21 B#2 M#33
(for D: moving along row)
GOTO51
N31 (face B)
M98 P22002 A1. Y#25 F#9 S#19 I#4 K#6 U#21 B#2 M#33
(for B: moving along row)
GOTO51
N32 (face C)
M98 P22001 A-1. X#24 F#9 S#19 I#4 K#6 U#21 B#2 M#33
(for C: moving along row)
GOTO51
N50 (face A)
M98 P22001 A1. X#24 F#9 S#19 I#4 K#6 U#21 B#2 M#33
(for A: moving along row)
N51
IF[#33GE#13]GOTO15 (end of loop)
#32=#705-[#33-1]*#6
(#32= the #33th row's Z from table center)
#31=SQRT[#18*#18-[#32+#6]*[#32+#6]]-SQRT[#18*#18-#32*#32]
G91 G31 X[#31*COS[#2]-#6*SIN[#2]] Z-[#31*SIN[#2]+#6*COS[#2]] F1800
#33=#33+1 (#33 to current row +1)
END1

N15
#711=#711-1 (changing face)
IF[#711LE0]GOTO20 (if #711 <= 0, go to N20)
GOTO10

N20
G90 G01 X#709 Z[#710-#30] F6400
(XZ: to the center of the 1st row)
G90 G01 X#703 Z#704 F6400 (XZ: to start point)
G90 G01 Z[#704+100.0] F9600
GOTO99

N96
#3000=145 (MP10/MP12/MP60-Low battery)
M00 (ALARM: low battery)
GOTO99

N10
G91 G28 Z0
G65 P19392 (sensor OFF)

N98 #3000=121 (are the arguments or the mould OK?)
M00 (are arguments ok?)

N99 M99

(#2 :B: angle)
(#6 :K: Z pitch)
(#13:M: number of rows)
(#17:Q: Z length between top and the 1st row)
(#18:R: radius of the central curvature)
(#23:W: furiwake Top)
(#26:Z: sai-furiwake Top)

(#4 :I: X pitch)
(#21:U: depth of dimple)
(#9 :F: length of odd rows)
(#19:S: length of even rows)
(#24:X: AC naikei of last row)
(#25:Y: BD naikei of last row)

(#512: probe radius)
(#1004: 1: sensor on, 0: off)
(#1005: 1: sensor low battery, 0: OK)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5041: current work X)
(#5043: current work Z)
(#5063: skip position Z without KouguChou hosei)

(using #701-#711)
%