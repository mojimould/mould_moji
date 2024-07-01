%
O220001 (last update on 20240701)
(for AC dimples measurement & kakou)
(level 2: mainly moving along row)

N001
IF[#01EQ#0]GOTO0800
IF[#01EQ0]GOTO0800
(if A = 0 or #0, to N0800)

IF[#01GT0]THEN #33=1
IF[#01LT0]THEN #33=-1
(for A, #33=1)
(for C, #33=-1)

N002
#725=#5002
#726=#5003
(#725= current work block end Y)
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

N004
#730=[#32*2]/#04+1
(#730= the # of dimple for current row)


(kokokara G31 or G01)


IF[#4111EQ50]GOTO005
(if H#=50, go to N005)
GOTO006
N005 (for sensor)
G91 G31 Y-#32 Z-[#33*[#24/2]*SIN[ABS[#02]]] F#653
(YZ skip to the 1st dimple: X: faceA-#620 or faceC+#620)
GOTO007
N006 (for kakou)
G91 G01 Y-#32 Z-[#33*[#24/2]*SIN[ABS[#02]]] F#651
(YZ to the 1st dimple: X: faceA-#620 or faceC+#620)

N007
#31=1 (loop #)
#30=900001+#724*100+#727*#729+FIX[[#13-1]/2]*#728
(#30: numbering for dimples)
(A:#900101-, C:#900201-)
WHILE[#31LE#730]DO1
IF[#4111NE50]GOTO100
(if H# is not 50, go to N100)
(for sensor)
G65 P230001 I#33
(measurement for AC dimples)
#[#30]=#749
GOTO101
N100 (for kakou)
G65 P530001 I#33 U#21 W#[#30]
(kakou for AC dimples)
N101
#30=#30+1
IF[#31GE#730]GOTO008 (end loop)
IF[#4111NE50]GOTO102
(if H# is not 50, go to N102)
G91 G31 Y#04 F#653
GOTO103
N102 (for kakou)
G91 G01 Y#04 F#651
N103
#31=#31+1
END1

N008
G90 G01 Y#725 Z#726 F#651
(YZ: to start point)
GOTO9999

N0800
#3000=121 (are*the*arguments*OK?)

N9999 M99

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
(#24:X: AC naikei of last row)
(used only as passed argument)
(#21:U: depth of dimple)

(as LHS)
(#30, #31, #32, #33)

(Common variables)
(as RHS)
(#620, #651, #653, #724, #749)
(as LHS)
(#725-#730)
(#900101-#900200 ,#900201-#900300)

(System variables)
(#3000: alarm)
(#4111: current H#)
(#5002: current work block end point Y)
(#5003: current work block end point Z)

(Subprograms)
(O230001, O530001)

(Passed arguments)
(#21, #33, #900101-#900200 ,#900201-#900300)

(Used variables in other programs)
(#724: O210003)
(#749: O230001)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%