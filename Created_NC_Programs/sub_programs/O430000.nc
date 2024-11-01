%
O430000 (last update on 20241101)
(Keyway, ar, counterclockwise)

N0001
IF[#21EQ#0]GOTO8000
IF[#21LE10]GOTO8000
IF[#22EQ#0]GOTO8000
IF[#22LE10]GOTO8000
IF[#26EQ#0]GOTO8000
IF[#13EQ#0]GOTO8000
IF[#13LE1]GOTO8000
IF[#11LT#0]GOTO8000
IF[#11LE1]GOTO8000
(if U <= 10 or #0, go to N8000)
(if V <= 10 or #0, go to N8000)
(if Z = #0, go to N8000)
(if M <= 1, or #0, go to N8000)
(if H <= 1, or #0, go to N8000)

N0002
IF[#01EQ0]GOTO0003
IF[#01EQ1]GOTO0003
GOTO8000
(if A is not 0, 1, go to N8000)

N0003
IF[#02EQ#0]THEN #02=0
IF[#02EQ0]GOTO0004
IF[#02EQ1]GOTO0004
GOTO8000
(if B is not 0, 1, go to N8000)

N0004
IF[#476EQ0]GOTO0007
IF[#02EQ1]THEN #423=2
(if B=1, #423=2)

N0007
IF[#5203EQ0]GOTO0008
IF[#5203GE[#13+#11+2]]GOTO0008
(if #5203=0 or >=M+H+2, go to N0008)
GOTO8000

N0008
IF[#06EQ1]GOTO0009
IF[#06EQ2]GOTO0010
IF[#06EQ3]GOTO0011
IF[#06EQ4]GOTO0012
IF[#06EQ5]GOTO0013
IF[#06EQ6]GOTO0014
GOTO8000
(if K is not 1-6, go to N8000)

N0009 (for R)
IF[#18EQ#0]GOTO8000
IF[#03NE#0]GOTO8000
IF[#18LT0.1]GOTO8000
IF[#18GE[[#24+#25-ABS[#24-#25]]/8]]GOTO8000
(if R < 0.1 or R >= min[X/4, Y/4], go to N8000)
GOTO0016

N0010 (for C)
IF[#03EQ#0]GOTO8000
IF[#18NE#0]GOTO8000
IF[#03LT0.1]GOTO8000
IF[#03GE[[#24+#25-ABS[#24-#25]]/8]]GOTO8000
(if C < 0.1 or C >= min[X/4, Y/4], go to N8000)
GOTO0016

N0011 (for rec)
IF[#03NE#0]GOTO8000
IF[#18NE#0]GOTO8000
GOTO0016

N0012 (for BD only)
IF[#03NE#0]GOTO8000
IF[#18NE#0]GOTO8000
IF[#24NE#0]GOTO8000
GOTO0016

N0013 (for oct R)
IF[#03EQ#0]GOTO8000
IF[#18EQ#0]GOTO8000
IF[#03LT1]GOTO8000
IF[#18LT0.1]GOTO8000
IF[#03GE[[#24+#25-ABS[#24-#25]]/8]]GOTO8000
IF[#18GE#03]GOTO8000
(if C < 1 or C >= min[X/4, Y/4], go to N8000)
(if R < 0.1 or R >= C, go to N8000)
GOTO0016

N0014 (for AC only)
IF[#03NE#0]GOTO8000
IF[#18NE#0]GOTO8000
IF[#25NE#0]GOTO8000

N0016
IF[#679EQ#0]GOTO8000
IF[#679LE10]GOTO8000
IF[#680EQ#0]GOTO8000
IF[#680LE10]GOTO8000
IF[#702EQ#0]GOTO8000
IF[#702LT200]GOTO8000
(if #679 <= 10 or #0, go to N8000)
(if #680 <= 10 or #0, go to N8000)
(if #702 < 200 or #0, go to N8000)

N0017
IF[#4120EQ#0]GOTO8000
IF[#4120LT6]GOTO8000
IF[#4120GT10]GOTO8000
IF[[FIX[#4120]]NE#4120]GOTO8000
IF[#25GE#22]GOTO8000
IF[[#26-#13-#11-#419-#420]LE[#901011/2]]GOTO8000
IF[[ABS[#419]]GE[#13/2]]GOTO8000
IF[[ABS[#420]]GE[#11/2]]GOTO8000
IF[[ABS[#421]]GE[[#22-#25]/2]]GOTO8000
(if T# < 6 or > 10 or not integer or #0, go to N8000)
(if Y >= V, go to N8000)
(if Z-M-H-#419-#420 <= #901011/2, go to N8000)
(if |#419| >= M/2, go to N8000)
(if |#420| >= H/2, go to N8000)
(if |#421| >= [V-Y]/2, go to N8000)

N0018
IF[#422GT3]THEN #422=3
IF[#422LT-3]THEN #422=-3
#33=#24+#422
IF[#06EQ4]THEN #33=#21
#32=#25+#422
IF[#06EQ6]THEN #32=#22
(compensation: keyway diameter +compensation)

#31=[#605+#[2400+#4120]+#[2600+#4120]+ABS[#605-[#[2400+#4120]+#[2600+#4120]]]]/2
IF[#31LE1]GOTO8000
(#31: max[#605, tool diameter compensation])

N0019
IF[#4120EQ6]THEN #30=#901105
IF[#4120EQ7]THEN #30=#901107
IF[#4120EQ8]THEN #30=#901109
IF[#4120EQ9]THEN #30=#901111
IF[#30LE1]GOTO8000
(#30: tool Thickness)

#29=0
IF[#01EQ0]THEN #29=SQRT[#17*#17-[#23-[#13+#419]-[[#11+#420]/2]]*[#23-[#13+#419]-[[#11+#420]/2]]]-SQRT[#17*#17-#23*#23]+[#11*#11]/[8*#17]
IF[#4012EQ58]THEN #29=[#11*#11]/[8*#17]
(#29: X compensation from keyway center)

N0020
#100=#21-#33
#101=#22-#32
#102=[#100+#101+ABS[#100-#101]]/2
(#102=max[#100, #101])
IF[#102LE#630]GOTO0024
(if #102 <= #630, go to N0024)
#103=FUP[[#102-#630]/[#629*2]]
IF[#103LT0]GOTO8000
(#103: number of operations)


(kokokara G01)


G90 G43 G01 H#4120 Z[#26+#600] F#650

N1000 (pre-finishing operation loop)
WHILE[#103GE1]DO1
#103=#103-1
#104=#33+#630+[#629*2]*#103
IF[#06EQ4]THEN #104=#21+#630+[#629*2]*#103
#105=#32+#630+[#629*2]*#103
IF[#06EQ6]THEN #105=#22+#630+[#629*2]*#103

N1001 (top side)
G90 G00 X[[#104/2]+#31*3+#29-#421] Y[#105/2]
G42 D#4120
G91 G00 X-[#31/2]
G90 G01 Z[#26-#13-#419-#30] S#702 F#650

N1002
M03 (spindle on)
M08 (coolant on)

N1003
G90 G01 X[[#104/2]+#31*2+#29-#421-#02*[#422/2]] Y[#105/2] F#651
G65 P490005 K#06 C#03 R#18 X#104 Y#105 D#31 F#679 E#680 S#702
G90 G40 G00 X[[#104/2]+#31*3+#29-#421]

N1004 (center)
IF[#475EQ3]GOTO1005
IF[[#11+#420]LE[#30*2-1]]GOTO1007

N1005
G90 G01 Z[#26-[#13+#419+[#11+#420+#30]/2]] S#702 F#650
G90 G00 Y[#105/2]
G42 D#4120
G91 G00 X-[#31/2]

N1006
G90 G01 X[[#104/2]+#31*2+#29-#421-#02*[#422/2]] Y[#105/2] F#651
G65 P490005 K#06 C#03 R#18 X#104 Y#105 D#31 F#679 E#680 S#702
G90 G40 G00 X[[#104/2]+#31*3+#29-#421]

N1007 (bot side)
G90 G01 Z[#26-#13-#11-#419-#420] S#702 F#650
G90 G00 Y[#105/2]
G42 D#4120
G91 G00 X-[#31/2]

N1008
G90 G01 X[[#104/2]+#31*2+#29-#421-#02*[#422/2]] Y[#105/2] F#651
G65 P490005 K#06 C#03 R#18 X#104 Y#105 D#31 F#679 E#680 S#702
G90 G40 G00 X[[#104/2]+#31*3+#29-#421]
END1


N0021 (pause)
IF[#423EQ0]GOTO0022
IF[#423EQ2]GOTO0023
GOTO0024
N0022 (if #423=0)
M09 (coolant off)
S2599
G90 G01 Z[#26+#600] F#650
G04 X1.0 (wait 1.0s)
M05 (spindle off)
S35
M00
GOTO0024
N0023 (if #423=2)
G65 P900003


N0024 (finishing operation)
#33=#24+#422
IF[#06EQ4]THEN #33=#21
#32=#25+#422
IF[#06EQ6]THEN #32=#22
(re-compensation: keyway diameter +compensation)

#106=FUP[#183]

IF[#106EQ#0]THEN #106=0
IF[#106LT0]THEN #106=0
IF[#106GT3]THEN #106=3
IF[#630LE0]THEN #106=#106-1
(#106: number of finishing operation)

N0025
G90 G43 G01 H#4120 Z[#26+#600] F#650

N2000 (finishing operation loop)
WHILE[#106GE0]DO2
#106=#106-1

N2001 (top side)
G90 G00 X[[#33/2]+#31*3+#29-#421] Y[#32/2]
G42 D#4120
G91 G00 X-[#31/2]
G90 G01 Z[#26-#13-#419-#30] S#702 F#650

N2002
M03 (spindle on)
M08 (coolant on)

N2003
G90 G01 X[[#33/2]+#31*2+#29-#421-#02*[#422/2]] Y[#32/2] F#651
G65 P490005 K#06 C#03 R#18 X#33 Y#32 D#31 F#679 E#680 S#702
G90 G40 G00 X[[#33/2]+#31*3+#29-#421]

N2004
IF[#475EQ3]GOTO2005
IF[[#11+#420]LE[#30*2-1]]GOTO2007

N2005 (center)
G90 G01 Z[#26-[#13+#419+[#11+#420+#30]/2]] S#702 F#650
G90 G00 Y[#32/2]
G42 D#4120
G91 G00 X-[#31/2]

N2006
G90 G01 X[[#33/2]+#31*2+#29-#421-#02*[#422/2]] Y[#32/2] F#651
G65 P490005 K#06 C#03 R#18 X#33 Y#32 D#31 F#679 E#680 S#702
G90 G40 G00 X[[#33/2]+#31*3+#29-#421]

N2007 (bot side)
G90 G01 Z[#26-#13-#11-#419-#420] S#702 F#650
G90 G00 Y[#32/2]
G42 D#4120
G91 G00 X-[#31/2]

N2008
G90 G01 X[[#33/2]+#31*2+#29-#421-#02*[#422/2]] Y[#32/2] F#651
G65 P490005 K#06 C#03 R#18 X#33 Y#32 D#31 F#679 E#680 S#702
G90 G40 G00 X[[#33/2]+#31*3+#29-#421]
END2


N9990
M09 (coolant off)
G90 G43 G01 H#4120 Z[#26+#600] F#650
IF[#4119GE2600]GOTO991
S2599
GOTO9992
N991
S6000

N9992
G90 G53 G01 Z0 F#650
G04 X1.5 (wait 1.5s)
M05 (spindle off)
S35
GOTO9999

N8000
M09 (coolant off)
S2599
G04 X1.5 (wait 1.5s)
M05 (spindle off)
S35
#3000=100 (are*the*arguments*OK?)

N9999
M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#01:A: Top gaisaku check: 0:none, 1:exist)
(#02:B: depth tolerance: 0:none, 1:exist)
(#03:C: corner C)
(#06:K: key type: 1:R, 2:C, 3:rec, 4:BDonly, 5:oct R)
(#11:H: keyway width)
(#13:M: keyway position)
(#17:Q: central curvature)
(#18:R: corner R)
(#21:U: AC OD or Top oucut AC OD)
(#22:V: BD OD or Top oucut BD OD)
(#23:W: Top ori-alocation length)
(#24:X: AC keyway diameter)
(#25:Y: BD keyway diameter)
(#26:Z: re-alocation length)

(as LHS)
(#29, #30, #31, #32, #33)

(Common variable)
(as LHS)
(#102, #103, #104, #105, #106)
(as RHS)
(#183, #419, #420, #421, #422, #423, #475, #476)
(#600, #605, #629, #630, #650, #651, #679, #680, #702)
(#901011, #901105, #901107, #901109, #901111)

(System variables)
(#24xx: #xx tool diameter)
(#26xx: #xx tool diameter wear)
(#3000: alarm)
(#4012: current work coordinate G#)
(#4120: current T#)

(Subprograms)
(O490005, O900003)

(Passed arguments)
(#03, #06, #18, #31, #32, #33, #104, #105, #679, #680, #702)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%