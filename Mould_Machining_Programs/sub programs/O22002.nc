%
O22002 (for BD dimples measurement & kakou)
(level 2: mainly moving along row)

IF[#1EQ#0]GOTO98
IF[#1EQ0]GOTO98
IF[#1LT0]GOTO01
#33=1
GOTO02
N01
#33=-1

N02
#434=#5041 (#434= current work X: start point X)
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
G91 G31 X[#32*COS[#2]] Y[#33*[#25/2-#512-10]] Z-[#32*SIN[#2]] F1800
(XYZ skip to the 1st dimple: Y: faceB-10 or faceD+10)

#31=1
#30=900001+#411*100+#436*#438+FIX[[#13-1]/2]*#437
(#30: numbering for dimples)
(B:#900301-, D:#900401-)
WHILE[#31LE#439]DO1
IF[#4111EQ50]GOTO05 (if H# is sensor, go to N05)
IF[#4111EQ31]GOTO06 (if H# is 31, go to N06)
IF[#4111EQ32]GOTO06 (if H# is 32, go to N06)
IF[#4111EQ33]GOTO06 (if H# is 33, go to N06)
GOTO98
N05 (in the case: sensor)
M98 P23002 J#33 (measurement of BD dimples)
#[#30]=#469
GOTO30
N06 (in the case: kakou)
M98 P33002 J#33 D#[#30] (kakou of BD dimples)
N30
#30=#30+1
IF[#31GE#439]GOTO50
G91 G31 X[-#4*COS[#2]] Z[#4*SIN[#2]] F1800
#31=#31+1
END1

N50
G90 G01 X#434 Z#435 F6400
(XZ: to start point)
GOTO99

N98 #3000=121 (are the arguments or the mould OK?)
M00 (are arguments ok?)

N99 M99

(#1 :A: face A>0: B, A<0: D)
(#2 :B: angle)
(#4 :I: X pitch)
(#6 :K: Z pitch)
(#9 :F: length of odd rows)
(#13:M: number of rows)
(#19:S: length of even rows)
(#25:Y: BD naikei of last row)

(#512: probe radius)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5041: current work X)
(#5043: current work Z)
(#5063: skip position Z without KouguChou hosei)

(using: #434-#439, #90030x-#90040x)
%