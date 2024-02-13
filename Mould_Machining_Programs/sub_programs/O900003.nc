%
O900003 (pause and check)

N001
G90 G53 G01 Z0 F#675

#33=#4012
#32=#5001
#31=#5002
(#33: current work coordinate G#)
(#32: X block end: start point X)
(#31: Y block end: start point Y)

N002
IF[#33LT54]GOTO800 
IF[#33GT59]GOTO800
(if work G# < 54 or G# > 59, go to N800)

N003
G91 G28 G00 X0 Y0

N004
M11 (4jiku unclamp)
G91 G00 B90.0
M10 (4jiku clamp)

N005
G90 G53 G01 Z-1000.0 F#675

N006
M00 (OK?)

N007
G90 G53 G01 Z0 F#675

N008
M11 (4jiku unclamp)
G91 G00 B-90.0
M10 (4jiku clamp)

GOTO999


N800
#3000=121 (are the arguments OK?)

N999 M99

(Used Variables)

(Local variables)
(#31, #32, #33)


(Common variables)
(as RHS)
(#675)


(System variables)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5001: block end X)
(#5002: block end X)
(#5003: block end Z)
%