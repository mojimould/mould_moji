%
O900003 (pause and check)

N001
M09 (coolant off)
S2599
G90 G53 G01 Z0 F#650

N0002
#33=#4012
#32=#5001
#31=#5002
#30=#5004
(#33: current work coordinate G#)
(#32: block end X: start point X)
(#31: block end Y: start point Y)
(#30: block end B: start point B)

N003
IF[#33LT54]GOTO800 
IF[#33GT59]GOTO800
(if work G# < 54 or G# > 59, go to N800)

N006
#29=#30MOD360
IF[#29GT180]THEN #29=#29-360
IF[ABS[#29]LE90]THEN #28=90
IF[ABS[#29]GT90]THEN #28=270
(#29= #30 mod 360)
(-180 < #29 <= 180)
(if ABS[#29]<=90, #28=90)
(if ABS[#29]>90, #28=270)

N010
G91 G28 G00 X0 Y0

N011
M11 (B-axis unclamp)
G90 G00 B#28
M10 (B-axis clamp)
M05 (spindle off)
S35

N012
G90 G53 G01 Z-1030.0 F#650

N013
M00 (OK?)

N014
G90 G53 G01 Z0 F#650

N015
M11 (B-axis unclamp)
G90 G00 B#30
M10 (B-axis clamp)
(B to start point)

GOTO999


N800
#3000=121 (are the arguments OK?)

N999 M99

(Used Variables)

(Local variables)
(#28, #29, #30, #31, #32, #33)


(Common variables)
(as RHS)
(#650)


(System variables)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5001: block end X)
(#5002: block end Y)
(#5004: block end B)
%