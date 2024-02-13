%
O909100 (tool length measurement)

#01=#4001
#02=#4003

#24=#516 (X)
#25=#517 (Y)
#26=-820. (Z)
#21=#24-#5021+#04
#22=#25-#5022+#05

G91 G28 Z0 M19
G00 X#21 Y#22

IF[#4012EQ54.1]GOTO20

#03=5223+[#4012-54]*20
GOTO21

N020
#03=7003+[#4130-1]*20
N021
#04=ABS[#26+#504]

M32
G04 X2.
G53
/GOTO022
M00

N022
#05=#5043

/G91 G31 P2 Z-#04 F#513

IF[#5063LE[#05-#04]]GOTO800

/G00 Z#504

#05=#5043-#504-#507

G91 G31 P2 Z[-#504-#507-#507] F#514

IF[#5063LE#05]GOTO800
#[11000+#11]=0
#[10000+#11]=#5063+#[#03]+#5203+#505
G91 G28 Z0
M33
GOTO002

N800
G91 G28 Z0
M33
#3000=141 (tool measurement alarm)

N002
G#01 G#02
M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(used only as variables)
(#04:I: )
(#05:J: )
(#11:H: tool #)

(as LHS)
(#01, #02, #03, #04, #05)


(Common variables)
(as RHS)
(#504: measurement length)
(#505: )
(#507: )
(#513: speed)
(#514: measurement skip speed)
(#516: sensor position X)
(#517: sensor position Y)


(System variables)
(#3000: alarm)
(#4001: )
(#4003: )
(#4012: current work coordinate G#)
(#4130: )
(#5021: current machine coordinate X)
(#5022: current machine coordinate Y)
(#5043: current work Z)
(#5063: skip Z)
(#5203: )
(#5223: G54 origin Z)
(#5243: G55 origin Z)
(#5263: G56 origin Z)
(#5283: G57 origin Z)
(#5303: G58 origin Z)
(#5323: G59 origin Z)
(#7003: )
(#10000-#10200: hosei kouguChou # 100-200)
(#11000-#11200: mamou kouguChou # 100-200)
%