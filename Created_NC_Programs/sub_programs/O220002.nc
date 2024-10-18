%
O220002 (last update on 20241018)
(for BD dimples measurement & milling)
(level 2: mainly moving along row)

N0001
IF[#01EQ#0]GOTO8000
IF[#01EQ0]GOTO8000
(if A = 0 or #0, to N8000)

IF[#01GT0]THEN #33=1
IF[#01LT0]THEN #33=-1
(for B, #33=1)
(for D, #33=-1)

N0002
#725=#5001
#726=#5003
(#725= current work block end X)
(#726= current work block end Z)

#727=FIX[#13/2]
#728=#19/#04+1
#729=#09/#04+1
(#727= # of even row)
(#728= # of dimple of even rows)
(#729= # of dimple of odd rows)

IF[[#13/2]NE#727]THEN #32=#09/2
IF[[#13/2]EQ#727]THEN #32=#19/2
(if #13 is odd, #32=#09/2)
(if #13 is even, #32=#19/2)

N0004
#730=[#32*2]/#04+1
(#730= the # of dimple for current row)


(kokokara G31 or G01)


IF[#4111EQ50]GOTO0005
(if H#=50, go to N0005)
GOTO0006
N0005 (for measurement)
G91 G31 X[#32*COS[ABS[#02]]] Z-[#32*SIN[ABS[#02]]] F#653
(XZ skip to the 1st dimple: Y: faceB-#620 or faceD+#620)
GOTO0007
N0006 (for milling)
G91 G01 X[#32*COS[ABS[#02]]] Z-[#32*SIN[ABS[#02]]] F#651
(XZ to the 1st dimple: Y: faceB-#620 or faceD+#620)

N0007
#31=1 (loop #)
#30=900001+#724*100+#727*#729+FIX[[#13-1]/2]*#728
(#30: numbering for dimples)
(B:#900301-, D:#900401-)
WHILE[#31LE#730]DO1
IF[#4111NE50]GOTO1000
(if H# is not 50, go to N1000)
(for sensor)
G65 P230002 J#33
(measurement for BD dimples)
#[#30]=#749
GOTO1001
N1000 (for milling)
G65 P530002 J#33 U#21 W#[#30]
(milling for BD dimples)
N1001
#30=#30+1
IF[#31GE#730]GOTO0008 (end loop)
IF[#4111NE50]GOTO1002
(if H# is not 50, go to N1002)
G91 G31 X[-#04*COS[ABS[#02]]] Z[#04*SIN[ABS[#02]]] F#653
GOTO1003
N1002 (for milling)
G91 G01 X[-#04*COS[ABS[#02]]] Z[#04*SIN[ABS[#02]]] F#651
N1003
#31=#31+1
END1

N0008
G90 G01 X#725 Z#726 F#651
(XZ: to start point)
GOTO9999

N8000
#3000=121 (are*the*arguments*OK?)

N9999
M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(used only as variables)
(#01:A: face A>0: B, A<0: D)
(#02:B: angle)
(#04:I: X pitch)
(#09:F: length of odd rows)
(#13:M: number of rows)
(#19:S: length of even rows)
(used only as passed argument)
(#21:U: depth of dimple)

(as LHS)
(#30, #31, #32, #33)

(Common variables)
(as RHS)
(#620, #651, #653, #724, #749)
(as LHS)
(#725-#730)
(#900301-#900500)

(System variables)
(#3000: alarm)
(#4111: current H#)
(#5001: current work block end point X)
(#5003: current work block end point Z)

(Subprograms)
(O230002, O530002)

(Passed arguments)
(#21, #33, #900301-#900500)

(Used variables in other programs)
(#724: O210003)
(#749: O230002)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%