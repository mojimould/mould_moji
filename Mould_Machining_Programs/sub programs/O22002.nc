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
#734=#5041
#735=#5043-#[2000+#4111]
(#734= current work X: start point X)
(#735= current work Z: start point Z)

#736=FIX[#13/2]
#737=#19/#4+1
#738=#9/#4+1
(#736= number of even row)
(#737= number of dimple of even rows)
(#738= number of dimple of odd rows)

IF[[#13/2]EQ#736]GOTO03
#32=#9/2
GOTO04
N03
#32=#19/2
(if #13 is odd, #32=#9/2)
(if #13 is even, #32=#19/2)

N04
#739=[#32*2]/#4+1 (#739= the number of dimple)
IF[#4111EQ31]GOTO05
IF[#4111EQ32]GOTO06
IF[#4111EQ33]GOTO07
IF[#4111EQ50]GOTO08
(if H# is 31, go to N05)
(if H# is 32, go to N06)
(if H# is 33, go to N07)
(if H# is 50, go to N08)
GOTO98
N05
#29=#431
GOTO11
N06
#29=#432
GOTO11
N07
#29=#433
GOTO11
(if Tslot 1, #29=#431 and to N09)
(if Tslot 2, #29=#432 and to N09)
(if Tslot 3, #29=#433 and to N09)

N08 (for sensor)
G91 G31 X[#32*COS[ABS[#2]]] Z-[#32*SIN[ABS[#2]]] F1500
(XYZ skip to the 1st dimple: Y: faceB-10 or faceD+10)
GOTO19

N11 (for kakou)
G91 G00 X[#32*COS[ABS[#2]]] Z-[#32*SIN[ABS[#2]]]
(XYZ to the 1st dimple: Y: faceB-5 or faceD+5)

N19
#31=1
#30=900001+#714*100+#736*#738+FIX[[#13-1]/2]*#737
(#30: numbering for dimples)
(B:#900301-, D:#900401-)
WHILE[#31LE#739]DO1
IF[#4111NE50]GOTO20
(if H# is not sensor, go to N15)
(for sensor)
G65P23002 J#33
(measurement for BD dimples)
#[#30]=#768
GOTO25
N20 (for kakou)
G65P33002 J#33 U#21 D#29 W#[#30]
(kakou for BD dimples)
N25
#30=#30+1
IF[#31GE#739]GOTO50 (end loop)
IF[#4111NE50]GOTO30
(if H# is not sensor, go to N25)
G91 G31 X[-#4*COS[ABS[#2]]] Z[#4*SIN[ABS[#2]]] F1500
GOTO35
N30
G91 G01 X[-#4*COS[ABS[#2]]] Z[#4*SIN[ABS[#2]]]
N35
#31=#31+1
END1

N50
G90 G01 X#734 Z#735 F6400
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
(#21:U: depth of dimple)
(#13:M: number of rows)
(#19:S: length of even rows)
(#25:Y: BD naikei of last row)

(#512: probe radius)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4111: current H#)
(#5041: current work X)
(#5042: current work X)
(#5043: current work Z)
(#5063: skip position Z without KouguChou hosei)

(using: #734-#739, #90030x-#90040x)
%