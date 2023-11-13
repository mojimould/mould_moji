%
O630001 (for AC dimples kakou)
(level 3: kakou dimple)
(I > 0: Y+, I < 0: Y-)

#767=#5041
(#767= current work X: start point X)

IF[#4EQ0]GOTO98
IF[#4EQ#0]GOTO98
(if I = 0 then to N98)
(if I = #0 then to N98)

IF[#4LT0]GOTO01 (if I < 0 then to N01)
#33=1 (for A)
(if I > 0, #33=1)
IF[#4111EQ31]GOTO02 (if H#= 31, go to N02)
IF[#4111EQ32]GOTO03 (if H#= 32, go to N02)
IF[#4111EQ33]GOTO04 (if H#= 33, go to N02)
GOTO98
N02 #768=#601 (for T31) GOTO08
N03 #768=#605 (for T32) GOTO08
N04 #768=#609 (for T33) GOTO08
N01
#33=-1 (for C)
(if I < 0, #33=-1)
IF[#4111EQ31]GOTO05 (if H#= 31, go to N02)
IF[#4111EQ32]GOTO06 (if H#= 32, go to N02)
IF[#4111EQ33]GOTO07 (if H#= 33, go to N02)
GOTO98
N05 #768=#602 (for T31) GOTO08
N06 #768=#606 (for T32) GOTO08
N07 #768=#610 (for T33)

N08
G90 G01 X[#23-#33*[#7+5.0]] F500
(X+: #23-#7-5.0 or X-: #23+#7+5.0, speed 500)
G91 G01 X[#33*5.0] F200
G91 G01 X[#33*#21] F100
(Y+ or Y-: 5.0, speed 200)
(Y+ or Y-: #21, speed 100)
G90 G01 X#767 F6400
(G90 G01 Y: to start point)
GOTO99 (to N99)

N98
#3000=121 (Argument Is Not Assigned)
M00 (are arguments ok?)

N99 M99

(#4 :I: +:X+direction, -:X-direction)
(#7 :D: the radius of the current tool)
(#23:W: the position of the dimple)
(#21:U: the depth of dimples)

(#3000: alarm)
(#5041: current work X)
(#5042: current work Y)

(using #767)
%