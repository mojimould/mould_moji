%
O33001 (for AC dimples kakou)
(level 3: kakou dimple)
(I > 0: Y+, I < 0: Y-)

#767=#5041 (#767= current work X: start point X)
#768=#5042 (#768= current work Y: start point Y)
IF[#4EQ0]GOTO98 (if I = 0 then to N98)
IF[#4EQ#0]GOTO98 (if I = #0 then to N98)

IF[#4LT0]GOTO01 (if I < 0 then to N01)
#33=1 GOTO05 (if J > 0, #33=1 and to N05)
N01 #33=-1 (if J < 0, #33=-1)

N05
G90 G01 X[#23-#33*[#7+5.0]] F500
(X+: #23-#7-5.0 or X-: #23+#7+5.0, speed 500)
G91 G01 X[#33*5.0] F200 (Y+ or Y-: 5.0, speed 200)
G91 G01 X[#33*#21] F100 (Y+ or Y-: #21, speed 100)
G90 G01 X#768 F6400 (G90 G01 Y: to start point)
G90 G01 Y#767 (G90 G01 X: to start point)
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

(using #767, #768)
%