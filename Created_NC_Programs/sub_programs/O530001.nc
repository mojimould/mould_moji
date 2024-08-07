%
O530001 (last update on 20240701)
(for AC dimples kakou)
(level 3: kakou dimple)
(I > 0: A, I < 0: C)

N0001
IF[#04EQ#0]GOTO0800
IF[#04EQ0]GOTO0800
(if I = 0 or empty, go to N0800)

N0002
IF[#4111EQ31]GOTO0003
IF[#4111EQ32]GOTO0003
IF[#4111EQ33]GOTO0003
GOTO0800

N0003
IF[#621LT0]GOTO0800
IF[#672EQ#0]GOTO0800
IF[#672LE10]GOTO0800
IF[#673EQ#0]GOTO0800
IF[#673LE10]GOTO0800
(if #672 <= 10 or #0, go to N0800)
(if #673 <= 10 or #0, go to N0800)
(if #621 < 0, go to N0800)

N0004
#33=#5041
#32=#[2400+#4111]+#[2600+#4111]
(#33= current work X: start point X)
(#32= KouguKei + Mamou)

N0006
IF[#04LT0]GOTO0007
(if I < 0, go to N0007)
#31=1
(for A, #31=1)
IF[#4111EQ31]THEN #29=#461
IF[#4111EQ32]THEN #29=#466
IF[#4111EQ33]THEN #29=#471
(if H#=31, #29=#461)
(if H#=32, #29=#466)
(if H#=33, #29=#471)
GOTO0008

N0007
#31=-1
(for C, #31=-1)
IF[#4111EQ31]THEN #29=#462
IF[#4111EQ32]THEN #29=#467
IF[#4111EQ33]THEN #29=#472
(if H#=31, #29=#462)
(if H#=32, #29=#467)
(if H#=33, #29=#472)


(kokokara G01)


N0008
G90 G01 X[#23-#31*[#32+#621]] F#651
G91 G01 X[#31*[#621+#29]] F#672
G91 G01 X[#31*#21] F#673
G04 X#622 (wait #622s)
(X+: #23-#32-#621 or X-: #23+#32+#621)
(X+ or X-: #621+hosei, speed #672)
(X+ or X-: U, speed #673)

N0009
G90 G01 X#33 F#651
(G90 G01 X: to start point)
GOTO9999


N0800
M09 (coolant off)
M05 (spindle off)
#3000=121 (Argument*Is*Not*Assigned)

N9999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#04:I: +:X+direction, -:X-direction)
(#21:U: the depth of dimples)
(#23:W: the position of the dimple)
(as LHS)
(#29, #31, #32, #33)

(Common variables)
(as RHS)
(#461, #462, #466, #467, #471, #472, #621, #651, #672, #673)

(System variables)
(#3000: alarm)
(#4111: current H#)
(#5041: current work X)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%