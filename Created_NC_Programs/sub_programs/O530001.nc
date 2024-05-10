%
O530001 (last update on 20240510)
(for AC dimples kakou)
(level 3: kakou dimple)
(I > 0: A, I < 0: C)

N001
IF[#04EQ#0]GOTO800
IF[#04EQ0]GOTO800
(if I = 0 or empty, go to N800)

N002
IF[#4111EQ31]GOTO003
IF[#4111EQ32]GOTO003
IF[#4111EQ33]GOTO003
GOTO800

N003
IF[#621LT0]GOTO800
IF[#670EQ#0]GOTO800
IF[#670LE10]GOTO800
IF[#671EQ#0]GOTO800
IF[#671LE10]GOTO800
(if #670 <= 10 or #0, go to N800)
(if #671 <= 10 or #0, go to N800)
(if #621 < 0, go to N800)

N004
#33=#5041
#32=#[2400+#4111]+#[2600+#4111]
(#33= current work X: start point X)
(#32= KouguKei + Mamou)

N006
IF[#04LT0]GOTO007
(if I < 0, go to N007)
#31=1
(for A, #31=1)
IF[#4111EQ31]THEN #29=#461
IF[#4111EQ32]THEN #29=#466
IF[#4111EQ33]THEN #29=#471
(if H#=31, #29=#461)
(if H#=32, #29=#466)
(if H#=33, #29=#471)
GOTO008

N007
#31=-1
(for C, #31=-1)
IF[#4111EQ31]THEN #29=#462
IF[#4111EQ32]THEN #29=#467
IF[#4111EQ33]THEN #29=#472
(if H#=31, #29=#462)
(if H#=32, #29=#467)
(if H#=33, #29=#472)


(kokokara G01)


N008
G90 G01 X[#23-#31*[#32+#621]] F#651
G91 G01 X[#31*[#621+#29]] F#670
G91 G01 X[#31*#21] F#671
G04 X0.1 (wait 0.1s)
(X+: #23-#32-#621 or X-: #23+#32+#621)
(X+ or X-: #621+hosei, speed #670)
(X+ or X-: U, speed #671)

G90 G01 X#33 F#651
(G90 G01 X: to start point)
GOTO999


N800
M09 (coolant off)
M05 (spindle off)
#3000=121 (Argument Is Not Assigned)

N999 M99

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
(#461, #462, #466, #467, #471, #472, #621, #651, #670, #671)

(System variables)
(#3000: alarm)
(#5041: current work X)


(COPYRIGHT*2023-2024*THE*INDIVIDUAL*CREATOR*NOT*ANY*CORPORATION*ALL*RIGHTS*RESERVED)
%