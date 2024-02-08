%
O530001 (for AC dimples kakou)
(level 3: kakou dimple)
(I > 0: Y+, I < 0: Y-)

N001
IF[#04EQ#0]GOTO800
IF[#04EQ0]GOTO800
(if I = 0 or empty, go to N800)

IF[#620LT0]GOTO800
IF[#694EQ#0]GOTO800
IF[#694LE10]GOTO800
IF[#695EQ#0]GOTO800
IF[#695LE10]GOTO800
(if #694 <= 10 or #0, go to N800)
(if #695 <= 10 or #0, go to N800)
(if #620 < 0, go to N800)

#33=#5041
(#33= current work X: start point X)
#32=#[2400+#4111]+#[2600+#4111]
(#32= hosei KouguKei + Mamou)

IF[#04LT0]GOTO002 (if I < 0, go to N002)
#31=1 (for A)
(if I > 0, #31=1)
IF[#4111EQ31]THEN #30=#450
IF[#4111EQ32]THEN #30=#455
IF[#4111EQ33]THEN #30=#460
(if H#=31, #30=#450)
(if H#=32, #30=#455)
(if H#=33, #30=#460)
GOTO008

N002
#31=-1 (for C)
(if I < 0, #31=-1)
IF[#4111EQ31]THEN #30=#451
IF[#4111EQ32]THEN #30=#456
IF[#4111EQ33]THEN #30=#461
(if H#=31, #30=#451)
(if H#=32, #30=#456)
(if H#=33, #30=#461)

N008
G90 G01 X[#23-#31*[#32+#620]] F#677
(X+: #23-#32-#620 or X-: #23+#32+#620)
G91 G01 X[#31*[#620+#30]] F#694
G91 G01 X[#31*#21] F#695
(Y+ or Y-: #620+hosei, speed #694)
(Y+ or Y-: U, speed #695)
G90 G01 X#33 F#677
(G90 G01 Y: to start point)
GOTO999 (to N999)

N800
#3000=121 (Argument Is Not Assigned)
M00 (are arguments ok?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#04:I: +:X+direction, -:X-direction)
(#21:U: the depth of dimples)
(#23:W: the position of the dimple)

(as LHS)
(#30, #31, #32, #33)


(Common variables)
(as RHS)
(#450, #451, #455, #456, #460, #461, #620, #677, #694, #695)


(System variables)
(#3000: alarm)
(#5041: current work X)
%