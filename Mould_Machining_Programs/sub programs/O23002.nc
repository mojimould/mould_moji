%
O23002 (dimple measurement Y: for BD)
(J > 0: Y+, J < 0: Y-)
#467=#5041 (#467= current work X: start point X)
#468=#5042 (#468= current work Y: start point Y)
IF[#5EQ0]GOTO97 (if J = 0 then to N97)
IF[#5EQ#0]GOTO97 (if J = #0 then to N97)

IF[#5LT0]GOTO2 (if J < 0 then to N1)
N01 #469=1 GOTO10 (if J > 0, #469=1 and to N10)
N02 #469=-1 (if J < 0, #469=-1)

N10
G91 G31 Y[15.0*#469] F#514 (skip Y+ or Y-: 15.0, speed 50)
#566=#5062+#503+#469*[-#501+#512]
(#566= current machine Y + hosei probe etc)
G90 G01 Y#468 F6400 (G90 G01 Y: to start point)
G90 G01 X#467 (G90 G01 X: to start point)
GOTO98 (to N98)

N97
G65 P19392 (sensor OFF)
#3000=121 (Argument Is Not Assigned)
M00 (are arguments ok?)

N98
IF[#1004EQ1]GOTO99
M117 (if the sensor is off, turn on)
G04X1. (wait 1.0s)
IF[#1005EQ0]GOTO99
#3000=145 (sensor: Low battery)

N99 M99

(#5 :J: +:Y+direction, -:Y-direction)

(#501: hosei: touch sensor signal delay)
(#503: hosei: probe center Y)
(#512: probe radius)
(#514: default skip speed)
(#1004: 1: sensor on, 0: off)
(#1005: 1: sensor low battery, 0: OK)
(#3000: alarm)
(#5041: current work X)
(#5042: current work Y)
(#5062: skip position Y)
%