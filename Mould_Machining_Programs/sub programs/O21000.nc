%
O21000 (for dimple measurement)
(mainly moving along central curvature)

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
(if work G# < 54 or G# > 59, go to N98)
(if Z <= 0 or empty, go to N98)
(if R <= Z or empty, go to N98)
(if Q <= 0 or empty, go to N98)
(if M <= 0 or empty or not intger, go to N98)
(if Q+[M-1]*K >= Z, go to N98)
(if K < 0 or empty, go to N98)
(if B is empty or |B| > 20., go to N98)

#401=#4012 (#401= current work coordinate G#)
#402=#5201+[#401-53]*20 (#402= current work origin X)

M11 (4jiku unclamp)
G90 G00 G#401 B#2 (current work B: G90 A deg)
M10 (4jiku clamp)
G90 G01 X[#402*COS[#2]-#26*SIN[#2]] F6400
G90 G01 Z[#402*SIN[#2]+#26*COS[#2]-#512]
(XZ to tanmen center)

#403=#5041 (#403= current work X: start point X)
#404=#5043 (#404= current work Z: start point Z)
#405=#26-#17 (Z: the 1st row before rotation)
#406=#405-[#13-1]*#6 (Z: the last row before rotation)
#407=SQRT[#18*#18-#405*#405]-SQRT[#18*#18-#26*#26]
(X: the center of the 1st row before rotation)
#408=[#407*COS[#2]-#405*SIN[#2]]
#409=[#407*SIN[#2]+#405*COS[#2]]
(XZ: the center of the 1st row after rotation)

G65 P19393 (sensor ON, G53)
IF[#1005EQ1]GOTO96 (if low battery, go to N96)
IF[#1004EQ0]GOTO97 (if current sensor OFF, go to N97)
G#401 (work G#401)

G91 G31 X#408 F1800
G90 G31 Z[#409-#512]
(XZ skip: to the center of the 1st row)
#410=#5041 (#410= current work X: the center of the 1st row)

WHILE [#13 GT 0] DO1 (1st to last dimple)
M98 P22002 Y#25 I#4 K#6 B#2
(moving along row)
IF[#13GT1]GOTO20 (end of loop)
#33=SQRT[#18*#18-[#406+[#13-2]*#6]*[#406+[#13-2]*#6]]-SQRT[#18*#18-[#406+[#13-1]*#6]*[#406+[#13-1]*#6]]
G91 G31 X[#33*COS[#2]-#6*SIN[#2]] Z-[#33*SIN[#2]+#6*COS[#2]] F1800
#13=#13-1
END1

N20
G90 G01 X#410 Z[#409-#512] F6400
(XZ: to the center of the 1st row)
G90 G01 X#403 Z#404 F6400 (XZ: to start point)
G65 P19392 (sensor OFF)
G90 G01 Z[#404+100.0] F9600
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
(#25:Y: BD naikei of last row)

(#512: probe radius)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5041: current work X)
(#5043: current work Z)
(#5063: skip position Z without KouguChou hosei)
%