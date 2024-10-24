%
O530002 (last update on 20241024)
(for BD dimple milling)
(level 3: milling dimple)
(J > 0: B, J < 0: D)

N0001
IF[#05EQ#0]GOTO8000
IF[#05EQ0]GOTO8000
(if J = 0 or empty, go to N8000)

N0002
IF[#4111EQ31]GOTO0003
IF[#4111EQ32]GOTO0003
IF[#4111EQ34]GOTO0003
GOTO8000

N0003
IF[#621LT0]GOTO8000
IF[#672EQ#0]GOTO8000
IF[#672LE10]GOTO8000
IF[#673EQ#0]GOTO8000
IF[#673LE10]GOTO8000
(if #672 <= 10 or #0, go to N8000)
(if #673 <= 10 or #0, go to N8000)
(if #621 < 0, go to N8000)

N0004
#33=#5042
#32=#[2400+#4111]+#[2600+#4111]
(#33= current work Y: start point Y)
(#32= tool diameter + wear)

N0006
IF[#05LT0]GOTO0007
(if J < 0, go to N0007)
#31=1
(for B, #31=1)
IF[#4111EQ31]THEN #29=#463
IF[#4111EQ32]THEN #29=#468
IF[#4111EQ34]THEN #29=#473
(if H#=31, #29=#463)
(if H#=32, #29=#468)
(if H#=34, #29=#473)
GOTO0008

N0007
#31=-1
(for D, #31=-1)
IF[#4111EQ31]THEN #29=#464
IF[#4111EQ32]THEN #29=#469
IF[#4111EQ34]THEN #29=#474
(if H#=31, #29=#464)
(if H#=32, #29=#469)
(if H#=34, #29=#474)


(kokokara G01)


N0008
G90 G01 Y[#23-#31*[#32+#621]] F#651
G91 G01 Y[#31*[#621+#29]] F#672
(Y+: #23-#32-#621 or Y-: #23+#32+#621)
(Y+ or Y-: #621+compensation, speed #672)

IF[#4111EQ34]GOTO0009
G91 G01 Y[#31*#21] F#673
G04 X#622 (wait #622s)
GOTO0010

N0009
G91 G01 Y[#31*#21] F#674
G04 X#623 (wait #623s)
(Y+ or Y-: U, speed #673 or #674)

N0010
G90 G01 Y#33 F#651
(G90 G01 Y: to start point)
GOTO9999


N8000
M09 (coolant off)
M05 (spindle off)
#3000=121 (argument*is*not*assigned)

N9999
M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#05:J: +:Y+direction, -:Y-direction)
(#21:U: the depth of dimples)
(#23:W: the position of the dimple)
(as LHS)
(#29, #31, #32, #33)

(Common variables)
(as RHS)
(#463, #464, #468, #469, #473, #474)
(#621, #622, #623, #651, #672, #673, #674)

(System variables)
(#3000: alarm)
(#4111: current H#)
(#5042: current work Y)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%