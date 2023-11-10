%
O33002 (for BD dimples kakou)
(level 3: kakou dimple)
(J > 0: Y+, J < 0: Y-)

#767=#5042
(#767= current work X: start point Y)

IF[#5EQ0]GOTO98
IF[#5EQ#0]GOTO98
(if J = 0 then to N98)
(if J = #0 then to N98)

IF[#5LT0]GOTO01 (if J < 0 then to N01)
#33=1
GOTO05 (if J > 0, #33=1 and to N05)
N01
#33=-1 (if J < 0, #33=-1)

N05
G90 G01 Y[#23-#33*[#7+5.0]] F500
(Y+: #23-#7-5.0 or Y-: #23+#7+5.0, speed 500)
G91 G01 Y[#33*5.0] F200
G91 G01 Y[#33*#21] F100
(Y+ or Y-: 5.0, speed 200)
(Y+ or Y-: #21, speed 100)
G90 G01 Y#767 F6400
(G90 G01 Y: to start point)
GOTO99 (to N99)

N98
#3000=121 (Argument Is Not Assigned)
M00 (are arguments ok?)

N99 M99

(#5 :J: +:Y+direction, -:Y-direction)
(#7 :D: the radius of the current tool)
(#23:W: the position of the dimple)
(#21:U: the depth of dimples)

(#3000: alarm)
(#5041: current work X)
(#5042: current work Y)

(using #767)
%