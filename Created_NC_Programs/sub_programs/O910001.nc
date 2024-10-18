%
O910001 (last update on 20241018)
(touch sensor ON)

#33=0

N0001 (loop)
M19 (spindle orientation)
IF[#1005EQ1]GOTO8000
IF[#1004EQ1]GOTO9999
(if low battery, go to N8000)
(if current sensor ON, go to N9999)
M117 (sensor on/off)
G04 X1.0 (wait 1.0s)
IF[#1004EQ1]GOTO9999
(if current sensor ON, go to N9999)
G04 X4.0 (wait 4.0s)
#33=#33+1
IF[#33LT4]GOTO0001
(if #33 < 4, go to N0001)

#3000=146 (sensor-ALARM)
GOTO9999

N8000
#3000=145 (sensor*Low*battery)

N9999
M99

(Used Variables and Programs)

(Local variables)
(#33)

(System variables)
(#1004: 1: sensor on, 0: off)
(#1005: 1: sensor low battery, 0: OK)
(#3000: alarm)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%