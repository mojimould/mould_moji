%
O919100 (last update on 20241023)
(tool length measurement)

N001
#26=#901064 (Z)
#21=#901062-#5021+#04
#22=#901063-#5022+#05

N002
G90 G53 G01 Z0 F#650
M19 (spindle orientation)
IF[#4120EQ50]GOTO003
G91 G53 G00 X#21 Y#22
GOTO004
N003
G91 G53 G01 X#21 Y#22 F#652

N004
IF[#4012EQ54.1]THEN #03=7003+[#4130-1]*20
IF[#4012NE54.1]THEN #03=5223+[#4012-54]*20

N005
#06=ABS[#26+#901057]
#07=#5043

N006
M32 (open sensor and ON)
G04 X1.5 (wait 1.5s)

N007
G91 G53 G31 P2 Z-#06 F#654
(skip Z to sensor)
IF[#5063LE[#07-#06]]GOTO0800

N008
G91 G53 G01 Z#901057
(Z retract)

N009
#08=#5043-#901057-#901060
IF[#5063LE#08]GOTO0800

N010
G91 G31 P2 Z[-#901057-#901060-#901060] F#656
(skip Z to sensor)

#[10000+#11]=#5063+#[#03]+#5203+#901058
IF[#11EQ11]THEN #[10000+#11]=#5063+#[#03]+#5203+#901058-#901113
IF[#11EQ12]THEN #[10000+#11]=#5063+#[#03]+#5203+#901058-#901115
IF[#11EQ13]THEN #[10000+#11]=#5063+#[#03]+#5203+#901058-#901117
IF[#11EQ31]THEN #[10000+#11]=#5063+#[#03]+#5203+#901058-#901127/2
IF[#11EQ32]THEN #[10000+#11]=#5063+#[#03]+#5203+#901058-#901131/2
IF[#11EQ34]THEN #[10000+#11]=#5063+#[#03]+#5203+#901058-#901139
#[11000+#11]=0
(set tool length and wear)

N990
G90 G53 G01 Z0 F#650
M33 (close sensor)
IF[#11EQ50]GOTO992
G91 G30 X0 Y0
GOTO999
N992
G90 G53 G01 X-5.501 Y-258.624 F#652
GOTO999


N0800
G90 G53 G01 Z0 F#650
M33 (close sensor and off)
#3000=141 (tool*measurement*alarm)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(used only as variables)
(#04:I: shift of the cutting edge X)
(#05:J: shift of the cutting edge Y)
(#11:H: the tool #)

(as LHS)
(#03, #04, #05, #06, #07, #08, #21, #22, #26)

(Common variables)
(as RHS)
(#650, #652)
(#654: aproach speed)
(#656: measurement skip speed)
(#901057: measurement length)
(#901058: distance from the probe surface to Z0)
(#901060: tolerance for tool breakage detection)
(#901062: sensor position X)
(#901063: sensor position Y)
(#901064: sensor position Z)
(#901113, #901115, #901117, #901127, #901131)

(System variables)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4130: G54.1 P code)
(#5021: current machine coordinate X)
(#5022: current machine coordinate Y)
(#5043: current work Z)
(#5063: skip Z)
(#5203: outer work origin offset)
(#5223: G54 origin Z)
(#5243: G55 origin Z)
(#5263: G56 origin Z)
(#5283: G57 origin Z)
(#5303: G58 origin Z)
(#5323: G59 origin Z)
(#7003: G54.1 origin Z)
(#10000-#10200: hosei kouguChou #100-200)
(#11000-#11200: mamou kouguChou #100-200)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%