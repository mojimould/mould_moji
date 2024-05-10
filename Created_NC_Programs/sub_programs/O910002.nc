%
O910002 (last update on 20240510)
(touch sensor OFF)

#33=0

N001 (loop)
M117 (sensor on/off)
G04 X1.0 (wait 1.0s)
IF[#1004EQ0]GOTO999
(if current sensor OFF, go to N999)
G04 X4.0 (wait 4.0s)
#33=#33+1
IF[#33LT4]GOTO001
(if #33 < 4, go to N001)

#3000=146 (sensor-ALARM)
(ALM: is sensor ok?)

N999 M99

(Used Variables and Programs)

(Local variables)
(#33)

(System variables)
(#1004: 1: sensor on, 0: off)
(#3000: alarm)


(COPYRIGHT*2023-2024*THE*INDIVIDUAL*CREATOR*NOT*ANY*CORPORATION*ALL*RIGHTS*RESERVED)
%