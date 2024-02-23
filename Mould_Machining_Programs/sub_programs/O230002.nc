%
O230002 (for BD dimples measurement)
(level 3: measurement dimple)
(J > 0: Y+, J < 0: Y-)

N001
#748=#5002
(#748= current work block end Y)

IF[#05EQ#0]GOTO800
IF[#05EQ0]GOTO800
(if J = 0 or empty, to N800)

IF[#679EQ#0]GOTO800
IF[#679NE50]GOTO800
(if #679 is not 50.0 or #0, go to N800)

IF[#1004EQ1]GOTO002
M117 (if the sensor is off, turn on)
G04 X1. (wait 1.0s)

N002
IF[#05GT0]THEN #33=1
IF[#05LT0]THEN #33=-1
(for B, #33=1)
(for D, #33=1)

N003
G91 G31 Y[#33*[#602+#603]] F#679
(skip Y+ or Y-: #602+#603, speed #679)
#749=#5002+#503+#33*[-#501+#512]
(#749= block end Y + hosei probe etc)
G90 G01 Y#748 F#652
(G90 G01 Y: to start point)
GOTO999 (to N999)

N800
G65 P910002 (sensor OFF)
#3000=121 (Argument Is Not Assigned)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#05:J: +:Y+direction, -:Y-direction)

(as LHS)
(#33)


(Common variables)
(as RHS)
(#501: hosei: touch sensor signal delay)
(#503: hosei: probe center Y)
(#512: probe radius)
(#602, #603, #652, #679)
(as LHS)
(#748, #749)


(System variables)
(#1004: 1: sensor on, 0: off)
(#3000: alarm)
(#5002: current work block end point Y)


(Subprograms)
(O910002)


(Used in other programs)
(#749: O220002)
%