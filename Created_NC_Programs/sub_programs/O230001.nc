%
O230001 (last update on 20240510)
(for AC dimples measurement)
(level 3: measurement dimple)
(I > 0: A, I < 0: C)

N001
#748=#5001
(#748= current work block end X)

IF[#04EQ#0]GOTO800
IF[#04EQ0]GOTO800
(if I = 0 or empty, to N800)

IF[#656NE50]GOTO800
(if #656 is not 50.0, go to N800)

IF[#1004EQ1]GOTO002
M117 (if the sensor is off, turn on)
G04 X1.0 (wait 1.0s)

N002
IF[#04GT0]THEN #33=1
IF[#04LT0]THEN #33=-1
(for A, #33=1)
(for C, #33=-1)


(kokokara G31)


N003
G91 G31 X[#33*[#620+#603]] F#656
IF[ABS[#5001-#748]GE[#620+#603]]GOTO800
#749=#5001+#901054+#33*[-#901053+#901050]
G90 G01 X#748 F#652
(skip X+ or X-: #620+#603)
(#749= block end X + hosei probe etc)
(G90 G01 X: to start point)
GOTO999


N800
G90 G01 X#748 F#656
G65 P910002 (sensor OFF)
#3000=121 (something wrong)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#04:I: +:X+direction, -:X-direction)

(as LHS)
(#33)

(Common variables)
(as RHS)
(#603, #620, #652, #656)
(#901050: probe radius)
(#901053: hosei: touch sensor signal delay)
(#901054: hosei: probe center X)
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


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%