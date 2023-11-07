%
O21000 (for dimple measurement)
(level 1: mainly moving along central curvature)

IF[#4012LT54]GOTO98 
IF[#4012GT59]GOTO98
IF[#26EQ#0]GOTO98
IF[#26LE0]GOTO98
IF[#18EQ#0]GOTO98
IF[#18LE#26]GOTO98
IF[#17EQ#0]GOTO98
IF[#17LE0]GOTO98
IF[#13EQ#0]GOTO98
IF[#13LE0]GOTO98
IF[[#13-FIX[#13]]NE0]GOTO98
IF[[#17+[#13-1]*#6]GE#26]GOTO98
IF[#6EQ#0]GOTO98
IF[#6LT0]GOTO98
IF[#2EQ#0]GOTO98
IF[[ABS[#2]]GT20.]GOTO98
IF[#24EQ#0]GOTO98
IF[#24LE0]GOTO98
IF[#25EQ#0]GOTO98
IF[#25LE0]GOTO98
IF[#9EQ#0]GOTO98
IF[#9LE0]GOTO98
IF[#19EQ#0]GOTO98
IF[#19LE0]GOTO98
IF[[#9+#19+ABS[#9-#19]]/2]GE[[#24+#25-ABS[#24-#25]]/2]GOTO98
IF[#4EQ#0]GOTO98
IF[#4LE0]GOTO98
IF[#4LE0]GOTO98
(if work G# < 54 or G# > 59, go to N98)
(if Z <= 0 or empty, go to N98)
(if R <= Z or empty, go to N98)
(if Q <= 0 or empty, go to N98)
(if M <= 0 or empty or not intger, go to N98)
(if Q+[M-1]*K >= Z, go to N98)
(if K < 0 or empty, go to N98)
(if B is empty or |B| > 20., go to N98)
(if X <= 0 or empty, go to N98)
(if Y <= 0 or empty, go to N98)
(if F <= 0 or empty, go to N98)
(if S <= 0 or empty, go to N98)
(if max[F, S] >= min[X, Y], go to N98)
(if I <= 0 or empty, go to N98)

N01
#401=#4012 (#401= current work coordinate G#)
#402=#5201+[#401-53]*20 (#402= current work origin X)
#403=#5202+[#401-53]*20 (#403= current work origin Y)

M11 (4jiku unclamp)
G90 G00 G#401 B#2 (current work B: G90 A deg)
M10 (4jiku clamp)
G90 G01 X[#402*COS[#2]-#26*SIN[#2]] F6400
G90 G01 Z[#402*SIN[#2]+#26*COS[#2]-#512]
(XZ to tanmen center)

#404=#5041 (#404= current work X: start point X)
#405=#5043 (#405= current work Z: start point Z)
#406=#26-#17 (Z: the 1st row before rotation)
#407=SQRT[#18*#18-#406*#406]-SQRT[#18*#18-#26*#26]
(X: the center of the 1st row before rotation)
#408=[#407*COS[#2]-#406*SIN[#2]]
#409=[#407*SIN[#2]+#406*COS[#2]]
(XZ: the center of the 1st row after rotation)

G65 P19393 (sensor ON, G53)
IF[#1005EQ1]GOTO96 (if low battery, go to N96)
IF[#1004EQ0]GOTO97 (if current sensor OFF, go to N97)
G#401 (work G#401)

G91 G31 X#408 F1800
G90 G31 Z[#409-#512]
(XZ skip: to the center of the 1st row)
#410=#5041 (#410= current work X: the center of the 1st row)

#411=4 (#411: faces 1: A, 2: B, 3: C, 4: D)
IF[#411NE4]GOTO98 (if #411 is not 4, go to N98)
N10
G90 G01 X#410 Y#403 Z[#409-#512] F6400
(XYZ: to the center of the 1st row)

#33=1 (#33: current row)
WHILE[#33LE#13]DO1 (if #33 <= #13, do 1)
IF[#411EQ3]GOTO31 (#411=3, for B)
IF[#411EQ2]GOTO32 (#411=2, for C)
IF[#411EQ1]GOTO33 (#411=1, for A)
M98 P22002 A-1. Y#25 F#9 S#19 I#4 K#6 B#2 M#33
(for D: moving along row)
GOTO51
N31 (face B)
M98 P22002 A1. Y#25 F#9 S#19 I#4 K#6 B#2 M#33
(for B: moving along row)
GOTO51
N32 (face C)
M98 P22001 A-1. X#24 F#9 S#19 I#4 K#6 B#2 M#33
(for C: moving along row)
GOTO51
N50 (face A)
M98 P22001 A1. X#24 F#9 S#19 I#4 K#6 B#2 M#33
(for A: moving along row)
N51
IF[#33GE#13]GOTO15 (end of loop)
#32=#406-[#33-1]*#6 (#32= the #33th row's Z from table center)
#31=SQRT[#18*#18-[#32+#6]*[#32+#6]]-SQRT[#18*#18-#32*#32]
G91 G31 X[#31*COS[#2]-#6*SIN[#2]] Z-[#31*SIN[#2]+#6*COS[#2]] F1800
#33=#33+1 (#33 to current row +1)
END1

N15
#411=#411-1 (changing face)
IF[#411LE0]GOTO20 (if #411 <= 0, go to N20 )
GOTO10

N20
G90 G01 X#410 Z[#409-#512] F6400
(XZ: to the center of the 1st row)
G90 G01 X#404 Z#405 F6400 (XZ: to start point)
G65 P19392 (sensor OFF)
G90 G01 Z[#405+100.0] F9600
GOTO99

N96
#3000=145 (MP10/MP12/MP60-Low battery)
M00 (ALARM: low battery)
GOTO99

N97
#3000=146 (MP10/MP12/MP60-ALARM)
M00 (ALM: is the sensor ok?)
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
(#26:Z: top friwake)

(#4 :I: X pitch)
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

(using #401-#411)
%