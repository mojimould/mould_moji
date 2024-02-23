%
O230001 (for AC dimples measurement)
(level 3: measurement dimple)
(I > 0: X+, I < 0: X-)

N001
#748=#5001
(#748= current work block end X)

IF[#04EQ#0]GOTO800
IF[#04EQ0]GOTO800
(if I = 0 or empty, to N800)

IF[#679EQ#0]GOTO800
IF[#679NE50]GOTO800
(if #679 is not 50.0 or #0, go to N800)

IF[#1004EQ1]GOTO002
M117 (if the sensor is off, turn on)
G04 X1. (wait 1.0s)

N002
IF[#04GT0]THEN #33=1
IF[#04LT0]THEN #33=-1
(for A, #33=1)
(for C, #33=1)

N003
G91 G31 X[#33*[#602+#603]] F#679
(skip X+ or X-: #602+#603, speed #679)
#749=#5001+#502+#33*[-#501+#512]
(#749= block end X + hosei probe etc)
G90 G01 X#748 F#676
(G90 G01 X: to start point)
GOTO999 (to N999)

N800
G65 P910002 (sensor OFF)
#3000=121 (Argument Is Not Assigned)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#04:I: +:X+direction, -:X-direction)

(as LHS)
(#33)


(Common variables)
(as RHS)
(#501: hosei: touch sensor signal delay)
(#502: hosei: probe center X)
(#512: probe radius)
(#602, #603, #676, #679)
(as LHS)
(#748, #749)


(System variables)
(#1004: 1: sensor on, 0: off)
(#3000: alarm)
(#5001: current work block end point X)


(Subprograms)
(O910002)


(Used in other programs)
(#749: O220001)
%