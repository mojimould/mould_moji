%
O491005 (last update on 20241112)
(outer, ar, counterclockwise with Z-move)

N0001
IF[#24EQ#0]GOTO8000
IF[#24LT10]GOTO8000
IF[#25EQ#0]GOTO8000
IF[#25LT10]GOTO8000
IF[#09EQ#0]GOTO8000
IF[#09LT10]GOTO8000
IF[#08EQ#0]GOTO8000
IF[#08LT10]GOTO8000
IF[#19EQ#0]GOTO8000
IF[#19LE200]GOTO8000
(if X < 10 or #0, go to N8000)
(if Y < 10 or #0, go to N8000)
(if F < 10 or #0, go to N8000)
(if E < 10 or #0, go to N8000)
(if S <= 200 or #0, go to N8000)


(kokokara G01)


N0002
G17
S#19
IF[#06EQ1]GOTO0003
IF[#06EQ2]GOTO0004
IF[#06EQ3]GOTO0005
IF[#06EQ4]GOTO0006
GOTO8000
(if K is not 1-4, go to N8000)

N0003 (for R)
#33=90
G91 G01 X-[#24-#18] Z-[[#24-#18]*SIN[#02]] F#09
(a: X-Z-)
#32=0
WHILE[#32LE[#33-1]]DO1
#31=COS[90*#32/#33]-COS[90*[#32+1]/#33]
#30=SIN[90*[#32+1]/#33]-SIN[90*#32/#33]
G91 G03 X-[#18*#30] Y-[#18*#31] Z-[#18*SIN[#02]*#30] I[#18*SIN[90*#32/#33]] J-[#18*COS[90*#32/#33]] F#08
#32=#32+1
END1
(al corner: R#18 [0, -R] X-Y-Z-)
G91 G01 Y-[#25-#18*2] F#09
(l:Y-)
#32=0
WHILE[#32LE[#33-1]]DO1
#31=COS[90*#32/#33]-COS[90*[#32+1]/#33]
#30=SIN[90*[#32+1]/#33]-SIN[90*#32/#33]
G91 G03 X[#18*#31] Y-[#18*#30] Z[#18*SIN[#02]*#31] I[#18*COS[90*#32/#33]] J[#18*SIN[90*#32/#33]] F#08
#32=#32+1
END1
(bl corner: R#18 [R, 0] X+Y-Z+)
G91 G01 X[#24-#18*2] Z[[#24-#18*2]*SIN[#02]] F#09
(b: X+Z+)
#32=0
WHILE[#32LE[#33-1]]DO1
#31=COS[90*#32/#33]-COS[90*[#32+1]/#33]
#30=SIN[90*[#32+1]/#33]-SIN[90*#32/#33]
G91 G03 X[#18*#30] Y[#18*#31] Z[#18*SIN[#02]*#30] I-[#18*SIN[90*#32/#33]] J[#18*COS[90*#32/#33]] F#08
#32=#32+1
END1
(br corner: R#18 [0, R] X+Y+Z+)
G91 G01 Y[#25-#18*2] F#09
(r: Y+)
#32=0
WHILE[#32LE[#33-1]]DO1
#31=COS[90*#32/#33]-COS[90*[#32+1]/#33]
#30=SIN[90*[#32+1]/#33]-SIN[90*#32/#33]
G91 G03 X-[#18*#31] Y[#18*#30] Z-[#18*SIN[#02]*#31] I-[#18*COS[90*#32/#33]] J-[#18*SIN[90*#32/#33]] F#08
#32=#32+1
END1
(ar corner: R#18 [-R, #0] X-Y+Z-)
G91 G02 X-[#07*2] Y[#07*2] Z-[[#07*2]*SIN[#02]] I0 J[#07*2] F[#09*4]
(G02 R[#07*2] [0, #07*2] X-Y+)
GOTO9999

N0004 (for C)
G91 G01 X-[#24-#03] Z-[[#24-#03]*SIN[#02]] F#09
(a: X-)
G91 G01 X-#03 Y-#03 Z-[#03*SIN[#02]] F#08
(al corner: C#03 X-Y-)
G91 G01 Y-[#25-#03*2] F#09
(l: Y-)
G91 G01 X#03 Y-#03 Z[#03*SIN[#02]] F#08
(bl corner: C#03 X+Y-)
G91 G01 X[#24-#03*2] Z[[#24-#03*2]*SIN[#02]] F#09
(b: X+)
G91 G01 X#03 Y#03 Z[#03*SIN[#02]] F#08
(br corner: C#03 X+Y+)
G91 G01 Y[#25-#03*2] F#09
(r: Y+)
G91 G01 X-#03 Y#03 Z-[#03*SIN[#02]] F#08
(ar corner: C#03 X-Y+)
G91 G01 X-[#07*2] Y[#07*2] Z-[[#07*2]*SIN[#02]] F[#09*4]
(X-Y+)
GOTO9999

N0005 (for rec)
G91 G01 X-#24 Z-[#24*SIN[#02]] F#09
(a: X-)
G91 G01 Y-#25 F#09
(l: Y-)
G91 G01 X#24 Z[#24*SIN[#02]] F#09
(b: X+)
G91 G01 Y#25 F#09
(r: Y+)
G91 G01 Y[#07*2] F[#09*4]
(Y+)
GOTO9999

N0006 (for BD only)
G91 G01 X-[#24+[#07*1.5]] Z-[[#24+[#07*1.5]]*SIN[#02]] F#09
(a: X-)
G91 G00 Y-#25
(l: Y-)
G91 G01 X[#24+[#07*3]] Z[[#24+[#07*3]]*SIN[#02]] F#09
(b: X+)
G91 G00 Y[#25+[#07*2]]
(r: Y+)
GOTO9999


N8000
M05 (spindle off)
M09 (coolant off)
#3000=100 (are*the*arguments*OK?)

N9999
M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#02:B: curved outcut angle)
(#03:C: corner C)
(#06:K: milling type)
(#07:D: distance to clearance plane)
(#08:E: speed at corner)
(#09:F: speed at chokusenBu)
(#18:R: corner R)
(#19:S: spindle speed)
(#24:X: outcut AC OD)
(#25:Y: outcut BD OD)

(System variables)
(#3000: alarm)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%