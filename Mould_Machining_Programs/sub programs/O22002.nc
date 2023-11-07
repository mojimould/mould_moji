%
O22002 (for D dimple measurement)
(level 2: mainly moving along row)

#434=#5041 (#434= current work X: start point X)
#435=#5042 (#435= current work Y: start point Y)
#436=#5043 (#436= current work Z: start point Z)
#437=#9  (#437= length of odd rows)
#438=#19 (#438= length of even rows)

IF[[#13/2]EQ[FIX[#13/2]]]GOTO1
#32=#437/2 (if #13 is odd, #32= #9/2)
GOTO2
N01
#32=#438/2 (if #13 is even, #32= #19/2)

N02
#439=[#32*2]/#4+1 (#439= the number of dimple)
G90 G31 X[#32*COS[#2]] Z-[#32*SIN[#2]] F1800
(XZ to the 1st dimple)

G91 G31 Y[-#25/2+#512+10] F1800
(Y- skip: face + 10)

#31=1
WHILE[#31LE#439]DO1
M98 P23002 J-1. (measurement of dimple)
IF[#31GE#439]GOTO10
G90 G31 X[-#4*COS[#2]] Z[#4*SIN[#2]] F1800
#31=#31+1
END1

N10
G90 G01 X#434 Z#436 F6400
(XZ: to start point)
GOTO99

N99 M99

(#1 :A: face 1: B, -1: D)
(#2 :B: angle)
(#4 :I: X pitch)
(#6 :K: Z pitch)
(#9 :F: length of odd rows)
(#13:M: number of rows)
(#19:S: length of even rows)
(#25:Y: BD naikei of last row)

(#512: probe radius)
(#3000: alarm)
(#4012: current work coordinate G#)
(#5041: current work X)
(#5043: current work Z)
(#5063: skip position Z without KouguChou hosei)
%