%
O910001 (last update on 20240510)
(touch sensor ON)

#33=0

N001 (loop)
M19 (shujiku orientation)
IF[#1005EQ1]GOTO800
IF[#1004EQ1]GOTO999
(if low battery, go to N800)
(if current sensor ON, go to N999)
M117 (sensor on/off)
G04 X1.0 (wait 1.0s)
IF[#1004EQ1]GOTO999
(if current sensor ON, go to N2)
G04 X4.0 (wait 4.0s)
#33=#33+1
IF[#33LT4]GOTO001
(if #33 < 4, go to N001)

#3000=146 (sensor-ALARM)
(ALM: is the sensor ok?)
GOTO999 (go to N999)

N800
#3000=145 (sensor-Low battery)

N999 M99

(Used Variables and Programs)

(Local variables)
(#33)

(System variables)
(#1004: 1: sensor on, 0: off)
(#1005: 1: sensor low battery, 0: OK)
(#3000: alarm)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%