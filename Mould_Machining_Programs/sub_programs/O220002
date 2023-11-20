%
O220002 (for BD dimples measurement & kakou)
(level 2: mainly moving along row)

IF[#01EQ#0]GOTO98
IF[#01EQ0]GOTO98
IF[#01LT0]GOTO01
#33=1
GOTO02
N01
#33=-1

N02
#734=#5001
#735=#5003
(#734= current work block end X)
(#735= current work block end Z)

#736=FIX[#13/2]
#737=#19/#04+1
#738=#09/#04+1
(#736= number of even row)
(#737= number of dimple of even rows)
(#738= number of dimple of odd rows)

IF[[#13/2]EQ#736]GOTO03
#32=#09/2
GOTO04
N03
#32=#19/2
(if #13 is odd, #32=#09/2)
(if #13 is even, #32=#19/2)

N04
#739=[#32*2]/#04+1 (#739= the number of dimple)
IF[#4111EQ50]GOTO08
(if H# is 50, go to N08)
#29=#[2400+#4111]
(#29= hosei KouguKei #4111)
GOTO09

N08 (for sensor)
G91 G31 X[#32*COS[ABS[#02]]] Z-[#32*SIN[ABS[#02]]] F1500
(XYZ skip to the 1st dimple: Y: faceB-10 or faceD+10)
GOTO10

N09 (for kakou)
G91 G00 X[#32*COS[ABS[#02]]] Z-[#32*SIN[ABS[#02]]]
(XYZ to the 1st dimple: Y: faceB-5 or faceD+5)

N10
#31=1
#30=900001+#714*100+#736*#738+FIX[[#13-1]/2]*#737
(#30: numbering for dimples)
(B:#900301-, D:#900401-)
WHILE[#31LE#739]DO1
IF[#4111NE50]GOTO15
(if H# is not sensor, go to N15)
(for sensor)
G65P230002 J#33
(measurement for BD dimples)
#[#30]=#768
GOTO20
N15 (for kakou)
G65P630002 J#33 U#21 D#29 W#[#30]
(kakou for BD dimples)
N20
#30=#30+1
IF[#31GE#739]GOTO50 (end loop)
IF[#4111NE50]GOTO25
(if H# is not sensor, go to N25)
G91 G31 X[-#04*COS[ABS[#02]]] Z[#04*SIN[ABS[#02]]] F1500
GOTO30
N25
G91 G01 X[-#04*COS[ABS[#02]]] Z[#04*SIN[ABS[#02]]]
N30
#31=#31+1
END1

N50
G90 G01 X#734 Z#735 F6400
(XZ: to start point)
GOTO999

N98 #3000=121 (are the arguments or the mould OK?)
M00 (are arguments ok?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(used only as variables)
(#01:A: face A>0: B, A<0: D)
(#02:B: angle)
(#04:I: X pitch)
(#09:F: length of odd rows)
(#13:M: number of rows)
(#19:S: length of even rows)
(#25:Y: BD naikei of last row)
(used only as passed argument)
(#21:U: depth of dimple)

(as LHS)
(#29, #30, #31, #32, #33)


(Common variables)
(as RHS)
(#431, #432, #433, #714, #768)
(as LHS)
(#734-#739, #900301-#900400 ,#900401-#900500)


(System variables)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4111: current H#)
(#5001: current work block end point X)
(#5003: current work block end point Z)


(Subprograms)
(O230001, O630001)


(Passed arguments)
(#21, #29, #33, #900301-#900400 ,#900401-#900500)


(Using variables in other programs)
(#714, #768)
%