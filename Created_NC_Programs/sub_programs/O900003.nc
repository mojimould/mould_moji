%
O900003 (pause and check)

N001
M09 (coolant off)
S2599
G90 G53 G01 Z0 F#650

N002
#33=#5004
(#33: block end B: start point B)

N003
IF[#4012LT54]GOTO800 
IF[#4012GT59]GOTO800
(if work G# < 54 or G# > 59, go to N800)

N006
#32=#33MOD360
IF[#32GT180]THEN #32=#32-360
IF[ABS[#32]LE90]THEN #31=90
IF[ABS[#32]GT90]THEN #31=270
(#32= #33 mod 360)
(-180 < #32 <= 180)
(if ABS[#32]<=90, #31=90)
(if ABS[#32]>90, #31=270)

N010
G91 G28 G00 X0 Y0

N011
M11 (B-axis unclamp)
G90 G00 B#31
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
G90 G00 B#33
M10 (B-axis clamp)
(B to start point)

GOTO999


N800
#3000=121 (are the arguments OK?)

N999 M99

(Used Variables)

(Local variables)
(#31, #32, #33)


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