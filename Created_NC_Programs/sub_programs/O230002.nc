%
O230002 (for BD dimples measurement)
(level 3: measurement dimple)
(J > 0: B, J < 0: D)

N001
#748=#5002
(#748= current work block end Y)

IF[#05EQ#0]GOTO800
IF[#05EQ0]GOTO800
(if J = 0 or empty, to N800)

IF[#656NE50]GOTO800
(if #656 is not 50.0, go to N800)

IF[#1004EQ1]GOTO002
M117 (if the sensor is off, turn on)
G04 X1.0 (wait 1.0s)

N002
IF[#05GT0]THEN #33=1
IF[#05LT0]THEN #33=-1
(for B, #33=1)
(for D, #33=-1)


(kokokara G31)


N003
G91 G31 Y[#33*[#620+#603]] F#656
IF[ABS[#5002-#748]GE[#620+#603]]GOTO800
#749=#5002+#901055+#33*[-#901053+#901050]
G90 G01 Y#748 F#652
(skip Y+ or Y-: #620+#603)
(#749= block end Y + hosei probe etc)
(G90 G01 Y: to start point)
GOTO999


N800
G90 G01 Y#748 F#656
G65 P910002 (sensor OFF)
#3000=121 (something wrong)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#05:J: +:Y+direction, -:Y-direction)

(as LHS)
(#33)


(Common variables)
(as RHS)
(#603, #620, #652, #656)
(#901050: probe radius)
(#901053: hosei: touch sensor signal delay)
(#901055: hosei: probe center Y)
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