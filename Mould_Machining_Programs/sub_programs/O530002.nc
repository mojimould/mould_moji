%
O530002 (for BD dimples kakou)
(level 3: kakou dimple)
(J > 0: B, J < 0: D)

N001
IF[#05EQ#0]GOTO800
IF[#05EQ0]GOTO800
(if J = 0 or empty, go to N800)

IF[#621LT0]GOTO800
IF[#670EQ#0]GOTO800
IF[#670LE10]GOTO800
IF[#671EQ#0]GOTO800
IF[#671LE10]GOTO800
(if #670 <= 10 or #0, go to N800)
(if #671 <= 10 or #0, go to N800)
(if #621 < 0, go to N800)

#33=#5042
(#33= current work X: start point Y)
#32=#[2400+#4111]+#[2600+#4111]
(#32= hosei KouguKei + Mamou)

IF[#05LT0]GOTO002
(if J < 0, go to N002)
#31=1 (for B)
(if J > 0, #31=1)
IF[#4111EQ31]THEN #30=#463
IF[#4111EQ32]THEN #30=#468
IF[#4111EQ33]THEN #30=#473
(if H#=31, #30=#463)
(if H#=32, #30=#468)
(if H#=33, #30=#473)
GOTO008

N002
#31=-1 (for D)
(if J < 0, #31=-1)
IF[#4111EQ31]THEN #30=#464
IF[#4111EQ32]THEN #30=#469
IF[#4111EQ33]THEN #30=#474
(if H#=31, #30=#464)
(if H#=32, #30=#469)
(if H#=33, #30=#474)

N008
G90 G01 Y[#23-#31*[#32+#621]] F#651
(Y+: #23-#32-#621 or Y-: #23+#32+#621)
G91 G01 Y[#31*[#621+#30]] F#670
G91 G01 Y[#31*#21] F#671
(Y+ or Y-: #621+hosei, speed #670)
(Y+ or Y-: U, speed #671)
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
(#463, #464, #468, #469, #473, #474, #621, #651, #670, #671)


(System variables)
(#3000: alarm)
(#5042: current work Y)
%