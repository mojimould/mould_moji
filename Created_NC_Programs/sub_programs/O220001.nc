%
O220001 (last update on 20241029)
(for AC dimples measurement & milling)
(level 2: mainly moving along row)

N0001
IF[#01EQ#0]GOTO8000
IF[#01EQ0]GOTO8000
(if A = 0 or #0, to N8000)

IF[#01GT0]THEN #33=1
IF[#01LT0]THEN #33=-1
(for A, #33=1)
(for C, #33=-1)

N0002
#901225=#5002
#901226=#5003
(#901225= current work block end Y)
(#901226= current work block end Z)

#901227=FIX[#13/2]
#901228=#19/#04+1
#901229=#09/#04+1
(#901227= # of even row)
(#901228= # of dimple of even rows)
(#901229= # of dimple of odd rows)

IF[[#13/2]NE#901227]THEN #32=#09/2
IF[[#13/2]EQ#901227]THEN #32=#19/2
(if #13 is odd, #32=#09/2)
(if #13 is even, #32=#19/2)

N0004
#901230=[#32*2]/#04+1
(#901230= the # of dimple for current row)


(kokokara G31 or G01)


IF[#4111EQ50]GOTO0005
(if H#=50, go to N0005)
GOTO0006
N0005 (for measurement)
G91 G31 Y-#32 Z-[#33*[#24/2]*SIN[ABS[#02]]] F#653
(YZ skip to the 1st dimple: X: faceA-#620 or faceC+#620)
GOTO0007
N0006 (for milling)
G91 G01 Y-#32 Z-[#33*[#24/2]*SIN[ABS[#02]]] F#651
(YZ to the 1st dimple: X: faceA-#620 or faceC+#620)

N0007
#31=1 (loop #)
#30=900001+#901224*100+#901227*#901229+FIX[[#13-1]/2]*#901228
(#30: numbering for dimples)
(A:#900101-, C:#900201-)
WHILE[#31LE#901230]DO1
IF[#4111NE50]GOTO1000
(if H# is not 50, go to N1000)
(for sensor)
G65 P230001 I#33
(measurement for AC dimples)
#[#30]=#901249
GOTO1001
N1000 (for milling)
G65 P530001 I#33 U#21 V#22 W#[#30]
(milling for AC dimples)
N1001
#30=#30+1
IF[#31GE#901230]GOTO0008 (end loop)
IF[#4111NE50]GOTO1002
(if H# is not 50, go to N1002)
G91 G31 Y#04 F#653
GOTO1003
N1002 (for milling)
G91 G01 Y#04 F#651
N1003
#31=#31+1
END1

N0008
G90 G01 Y#901225 Z#901226 F#651
(YZ: to start point)
GOTO9999

N8000
#3000=121 (are*the*arguments*OK?)

N9999
M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(used only as variables)
(#01:A: face A>0: A, A<0: C)
(#02:B: angle)
(#04:I: X pitch)
(#09:F: length of odd rows)
(#13:M: number of rows)
(#19:S: length of even rows)
(#24:X: top endface ACID measured value)
(used only as passed argument)
(#21:U: dimple depth)
(#22:V: dimple milling radius)

(as LHS)
(#30, #31, #32, #33)

(Common variables)
(as RHS)
(#620, #651, #653, #901224, #901249)
(as LHS)
(#901225-#901230)
(#900101-#900300)

(System variables)
(#3000: alarm)
(#4111: current H#)
(#5002: current work block end point Y)
(#5003: current work block end point Z)

(Subprograms)
(O230001, O530001)

(Passed arguments)
(#21, #33, #900101-#900300)

(Used variables in other programs)
(#901224: O210003)
(#901249: O230001)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%