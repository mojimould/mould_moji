%
O230002 (for BD dimples measurement)
(level 3: measurement dimple)
(J > 0: Y+, J < 0: Y-)

#767=#5042
(#767= current work Y: start point Y)

IF[#05EQ0]GOTO98
IF[#05EQ#0]GOTO98
(if J = 0 then to N98)
(if J = #0 then to N98)

IF[#1004EQ1]GOTO01
M117 (if the sensor is off, turn on)
G04X1. (wait 1.0s)

N01
IF[#05LT0]GOTO02 (if J < 0 then to N02)
#33=1
GOTO05 (if J > 0, #33=1 and to N05)
N02
#33=-1 (if J < 0, #33=-1)

N05
G91 G31 Y[#33*15.0] F#514
(skip Y+ or Y-: 15.0, speed #514)
#768=#5062+#503+#33*[-#501+#512]
(#768= current machine Y + hosei probe etc)
G90 G01 Y#767 F6400
(G90 G01 Y: to start point)
GOTO999 (to N999)

N98
G65 P900002 (sensor OFF)
#3000=121 (Argument Is Not Assigned)
M00 (are arguments ok?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(used only as variables)
(#05:J: +:Y+direction, -:Y-direction)

(as LHS)
(#33)


(Common variables)
(as RHS)
(#501: hosei: touch sensor signal delay)
(#503: hosei: probe center Y)
(#512: probe radius)
(#514: default skip speed)
(as LHS)
(#767, #768)


(System variables)
(#1004: 1: sensor on, 0: off)
(#3000: alarm)
(#5042: current work Y)
(#5062: skip position Y)


(Subprograms)
(O90002)


(Used in other programs)
(#768)
%