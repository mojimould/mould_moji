%
O9103(MANUAL-MEASUREMENT)
M32
G4X2.
M4S400(CCW-SPINDLE)
#8=50(Z-AXIS-R-POINT)
#1=#4001
#2=#4003
#4=#5043(Z-POINT)
#5=#5041(X-START-POINT)
#6=#5042(Y-START-POINT)
IF[#24EQ#0]GOTO10


(IF[#24GE0]  GOTO16)


#21=ABS[#24](X-DIR)
G53G90G0Y#517(SENSER-POSITION)
G91G31P2X#24F#523
G91G0X[-0.5*#24/#21]
G91G31P2X[1.*#24/#21]F#524
#20=ABS[#5061-#5]
#22=#5061
G90G0X#5
IF[#20GE#21]GOTO15

#[17000+#7]=0
#[16000+#7]=ABS[#516-#5021+#5041-#22]-#519/2
GOTO20

N10
(IF[#25LE0]  GOTO16)


#21=ABS[#25](Y-DIR)
G53G90G0X#516(SENSER-POSITION)
G91G31P2Y#25F#523
G91G0Y[-0.5*#25/#21]
G91G31P2Y[1.*#25/#21]F#524
#20=ABS[#5062-#6]
#22=#5062
G90G0Y#6
IF[#20GE#21]GOTO16

#[17000+#7]=0
#[16000+#7]=ABS[#517-#5022+#5042-#22]-#519/2

GOTO20
N15M5
#3000=141(TOOL-CHECK)
N16M5
#3000=143(CHECK-X,Y-AXIS-COMMAND-VALUE)
N20G91G0Z50.
M33
M5G#1G#2
M99
%
