%
O630002 (for BD dimples kakou)
(level 3: kakou dimple)
(J > 0: Y+, J < 0: Y-)

#767=#5042
(#767= current work X: start point Y)

IF[#05EQ0]GOTO98
IF[#05EQ#0]GOTO98
(if J = 0 then to N98)
(if J = #0 then to N98)

IF[#05LT0]GOTO01 (if J < 0 then to N01)
#33=1 (for B)
(if J > 0, #33=1)
IF[#4111EQ31]GOTO02 (if H#= 31, go to N02)
IF[#4111EQ32]GOTO03 (if H#= 32, go to N03)
IF[#4111EQ33]GOTO04 (if H#= 33, go to N04)
GOTO98
N02 #768=#603 (for T31) GOTO08
N03 #768=#607 (for T32) GOTO08
N04 #768=#611 (for T33) GOTO08
N01
#33=-1 (for D)
(if J < 0, #33=-1)
IF[#4111EQ31]GOTO05 (if H#= 31, go to N05)
IF[#4111EQ32]GOTO06 (if H#= 32, go to N06)
IF[#4111EQ33]GOTO07 (if H#= 33, go to N07)
GOTO98
N05 #768=#604 (for T31) GOTO08
N06 #768=#608 (for T32) GOTO08
N07 #768=#612 (for T33)

N08
G90 G01 Y[#23-#33*[#7+5.0]] F500
(Y+: #23-#07-5.0 or Y-: #23+#07+5.0, speed 500)
G91 G01 Y[#33*5.0] F200
G91 G01 Y[#33*#21] F100
(Y+ or Y-: 5.0, speed 200)
(Y+ or Y-: #21, speed 100)
G90 G01 Y#767 F6400
(G90 G01 Y: to start point)
GOTO999 (to N999)

N98
#3000=121 (Argument Is Not Assigned)
M00 (are arguments ok?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#05:J: +:Y+direction, -:Y-direction)
(#07:D: the radius of the current tool)
(#21:U: the depth of dimples)
(#23:W: the position of the dimple)

(as LHS)
(#33)


(Common variables)
(as RHS)
(#603, #604, #607, #608, #611, #612)
(as LHS)
(#767, #768)


(System variables)
(#3000: alarm)
(#5042: current work Y)
%