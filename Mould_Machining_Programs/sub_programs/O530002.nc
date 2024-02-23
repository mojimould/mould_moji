%
O530002 (for BD dimples kakou)
(level 3: kakou dimple)
(J > 0: Y+, J < 0: Y-)

N001
IF[#05EQ#0]GOTO800
IF[#05EQ0]GOTO800
(if J = 0 or empty, go to N800)

IF[#620LT0]GOTO800
IF[#694EQ#0]GOTO800
IF[#694LE10]GOTO800
IF[#695EQ#0]GOTO800
IF[#695LE10]GOTO800
(if #694 <= 10 or #0, go to N800)
(if #695 <= 10 or #0, go to N800)
(if #620 < 0, go to N800)

#33=#5042
(#33= current work X: start point Y)
#32=#[2400+#4111]+#[2600+#4111]
(#32= hosei KouguKei + Mamou)

IF[#05LT0]GOTO002
(if J < 0, go to N002)
#31=1 (for B)
(if J > 0, #31=1)
IF[#4111EQ31]THEN #30=#452
IF[#4111EQ32]THEN #30=#457
IF[#4111EQ33]THEN #30=#462
(if H#=31, #30=#452)
(if H#=32, #30=#457)
(if H#=33, #30=#462)
GOTO008

N002
#31=-1 (for D)
(if J < 0, #31=-1)
IF[#4111EQ31]THEN #30=#453
IF[#4111EQ32]THEN #30=#458
IF[#4111EQ33]THEN #30=#463
(if H#=31, #30=#453)
(if H#=32, #30=#458)
(if H#=33, #30=#463)

N008
G90 G01 Y[#23-#31*[#32+#620]] F#651
(Y+: #23-#32-#620 or Y-: #23+#32+#620)
G91 G01 Y[#31*[#620+#30]] F#694
G91 G01 Y[#31*#21] F#695
(Y+ or Y-: #620+hosei, speed #694)
(Y+ or Y-: U, speed #695)
G90 G01 Y#33 F#651
(G90 G01 Y: to start point)
GOTO999 (to N999)

N800
#3000=121 (Argument Is Not Assigned)
M00 (are arguments ok?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#05:J: +:Y+direction, -:Y-direction)
(#21:U: the depth of dimples)
(#23:W: the position of the dimple)

(as LHS)
(#30, #31, #32, #33)


(Common variables)
(as RHS)
(#452, #453, #457, #458, #462, #463, #620, #651, #694, #695)


(System variables)
(#3000: alarm)
(#5042: current work Y)
%