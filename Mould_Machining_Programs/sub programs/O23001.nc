%
O23001 (for AC dimples measurement)
(level 3: measurement dimple)
(I > 0: X+, I < 0: X-)

#467=#5041 (#467= current work X: start point X)
#468=#5042 (#468= current work Y: start point Y)
IF[#4EQ0]GOTO97 (if I = 0 then to N97)
IF[#4EQ#0]GOTO97 (if I = #0 then to N97)

IF[#1004EQ1]GOTO1
M117 (if the sensor is off, turn on)
G04X1. (wait 1.0s)
IF[#1005EQ0]GOTO1 (if the sensor battery is OK, to N1)
#3000=145 (sensor: Low battery)

N01
IF[#4LT0]GOTO2 (if I < 0 then to N2)
#33=1 GOTO10 (if I > 0, #33=1 and to N10)
N02 #33=-1 (if I < 0, #33=-1)

N10
G91 G31 X[#33*15.0] F#514 (skip X+ or X-: 15.0, speed #514)
#469=#5061+#502+#33*[-#501+#512]
(#469= current machine X + hosei probe etc)
G90 G01 X#467 F6400 (G90 G01 X: to start point)
G90 G01 Y#468 (G90 G01 Y: to start point)
GOTO99 (to N99)

N97
G65 P19392 (sensor OFF)
#3000=121 (Argument Is Not Assigned)
M00 (are arguments ok?)

N99 M99

(#4 :I: +:X+direction, -:X-direction)

(#501: hosei: touch sensor signal delay)
(#502: hosei: probe center X)
(#512: probe radius)
(#514: default skip speed)
(#1004: 1: sensor on, 0: off)
(#1005: 1: sensor low battery, 0: OK)
(#3000: alarm)
(#5041: current work X)
(#5042: current work Y)
(#5061: skip position X)

(using #467-#469)
%