%
O22001 (for AC dimples measurement & kakou)
(level 2: mainly moving along row)

IF[#1EQ#0]GOTO98
IF[#1EQ0]GOTO98
IF[#1LT0]GOTO01
#33=1
GOTO2
N01
#33=-1

N02
#434=#5042 (#434= current work Y: start point Y)
#435=#5043 (#435= current work Z: start point Z)
#436=FIX[#13/2] (#436= number of even row)
#437=#19/#4+1   (#437= number of dimple of even rows)
#438=#9/#4+1    (#438= number of dimple of odd rows)

IF[[#13/2]EQ#436]GOTO03
#32=#9/2 (if #13 is odd, #32= #9/2)
GOTO04
N03
#32=#19/2 (if #13 is even, #32= #19/2)

N04
#439=[#32*2]/#4+1 (#439= the number of dimple)
IF[#4111EQ31]GOTO05 (if H# is 31, go to N05)
IF[#4111EQ32]GOTO06 (if H# is 32, go to N06)
IF[#4111EQ33]GOTO07 (if H# is 33, go to N07)
IF[#4111EQ50]GOTO08 (if H# is 50, go to N08)
GOTO98
N05 #29=#731 GOTO09 (if Tslot 1, #29=#731)
N06 #29=#732 GOTO09 (if Tslot 2, #29=#732)
N07 #29=#733 GOTO09 (if Tslot 3, #29=#733)

N08 (for sensor)
G91 G31 X[#33*[#24/2-#512-10]*COS[#2]] Y-#32 Z-[#33*[#24/2]*SIN[#2]] F1800
(XYZ skip to the 1st dimple: X: faceA-10 or faceC+10)
GOTO10

N09 (for kakou)
G91 G00 X[#33*[#24/2-#29-5]*COS[#2]] Y-#32 Z-[#33*[#24/2]*SIN[#2]]
(XYZ to the 1st dimple: X: faceA-5 or faceC+5)

N10
#31=1
#30=900001+#411*100+#436*#438+FIX[[#13-1]/2]*#437
(#30: numbering for dimples)
(A:#900101-, C:#900201-)
WHILE[#31LE#439]DO1
IF[#4111NE50]GOTO15 (if H# is not sensor, go to N15)
(for sensor)
M98 P23001 I#33 (measurement of AC dimples)
#[#30]=#469
GOTO20
N15 (for kakou)
M98 P33001 I#33 U#21 D#29 W#[#30] (kakou of AC dimples)
N20
#30=#30+1
IF[#31GE#439]GOTO50 (end loop)
IF[#4111NE50]GOTO25 (if H# is not 50, go to N25)
G91 G31 Y#6 F1800
GOTO30
N25
G91 G01 Y#6
N30
#31=#31+1
END1

N50
G90 G01 Y#434 Z#435 F6400
(YZ: to start point)
GOTO99

N98 #3000=121 (are the arguments or the mould OK?)
M00 (are arguments ok?)

N99 M99

(#1 :A: face A>0: B, A<0: D)
(#2 :B: angle)
(#4 :I: X pitch)
(#6 :K: Z pitch)
(#9 :F: length of odd rows)
(#21:U: depth of dimple)
(#13:M: number of rows)
(#19:S: length of even rows)
(#25:Y: BD naikei of last row)

(#512: probe radius)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4111: current H#)
(#5042: current work Y)
(#5043: current work Z)
(#5063: skip position Z without KouguChou hosei)

(using: #434-#439, #90010x-#90020x)
%