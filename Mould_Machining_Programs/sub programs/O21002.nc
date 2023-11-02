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
IF[#1EQ#0]GOTO98
IF[[ABS[#1]]GT20.]GOTO98
(if work G# < 54 or G# > 59, go to N98)
(if Z <= 0 or empty, go to N98)
(if R <= Z or empty, go to N98)
(if Q <= 0 or empty, go to N98)
(if M <= 0 or empty or not intger, go to N98)
(if Q+[M-1]*K >= Z, go to N98)
(if K < 0 or empty, go to N98)
(if A is empty or |A| > 20., go to N98)

#27=#4012 (#101= current work coordinate G#)

M11 (4jiku unclamp)
G90 G00 G#27 B#1 (current work B: G90 A deg)
M10 (4jiku clamp)
G90 G01 X[[#5201+[#27-53]*20]*COS[#1]-#26*SIN[#1]] F6400
G90 G31 Z[[#5201+[#27-53]*20]*SIN[#1]+#26*COS[#1]-#512] F6400
(XZ to tanmen center)
IF[[#5063-#2050]GT[[#5201+[#27-53]*20]*SIN[#1]+#26*COS[#1]-#512]]GOTO10
(if skip Z - hosei #50 KouguChou > tanmen center Z - D/2, to N10)

#28=#5041 (#28= current work X: start point X)
#29=#5043 (#29= current work Z: start point Z)
#100=#26-#17 (Z: the 1st row before rotation)
#101=#100-[#13-1]*#6 (Z: the last row before rotation)
#102=SQRT[#18*#18-#100*#100]-SQRT[#18*#18-#26*#26]
(X: the center of the 1st row before rotation)

#103=[#102*COS[#1]-#100*SIN[#1]]
#104=[#102*SIN[#1]+#100*COS[#1]]
(XZ: the center of the 1st row after rotation)

G65 P19393 (sensor ON, G53)
IF[#1005EQ1]GOTO96
(if low battery, go to N96)
IF[#1004EQ0]GOTO97
(if current sensor ON, go to N97)
G#101 (work G#101)

G91 G31 X#103 F1800
G90 G31 Z[#104-#512]
(XZ skip: to the center of the 1st row)
#105=#5041 (#105= current work X: the cetner of the 1st row)

WHILE [#13 GT 0] DO1 (1st to last dimple)
M98 P22002 (moving along row)
IF[#13GT1]GOTO10
#33=SQRT[#18*#18-[#101+[#13-2]*#6]*[#101+[#13-2]*#6]]-SQRT[#18*#18-[#101+[#13-1]*#6]*[#101+[#13-1]*#6]]
G91 G31 X[#33*COS[#1]-#6*SIN[#1]] Z-[#33*SIN[#1]+#6*COS[#1]] F1800
#13=#13-1
END1

N10
G90 G01 X#105 Z[#104-#512] F6400
(XZ: to the center of the 1st row)
G90 G01 X#28 Z#29 F6400 (XZ: to start point)
G65 P19392 (sensor OFF)
G90 G01 Z[#29+100.0] F9600
GOTO99


N10
G91 G28 Z0
G65 P19392 (sensor OFF)

N98 #3000=121 (are the arguments or the mould OK?)
M00 (are arguments ok?)

N99 M99

(#1 :A: angle)
(#6 :K: Z pitch)
(#13:M: number of rows)
(#17:Q: Z length between top and the 1st row)
(#18:R: radius of the central curvature)
(#26:Z: top friwake)

(#512: probe radius)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5041: current work X)
(#5043: current work Z)
(#5063: skip position Z without KouguChou hosei)
%