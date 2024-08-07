%
O491005 (last update on 20240621)
(Sotogawa ar HidariMawari 1shuu with Z-move)

N0001
IF[#24EQ#0]GOTO0800
IF[#24LT10]GOTO0800
IF[#25EQ#0]GOTO0800
IF[#25LT10]GOTO0800
IF[#09EQ#0]GOTO0800
IF[#09LT10]GOTO0800
IF[#08EQ#0]GOTO0800
IF[#08LT10]GOTO0800
IF[#19EQ#0]GOTO0800
IF[#19LE200]GOTO0800
(if X < 10 or #0, go to N0800)
(if Y < 10 or #0, go to N0800)
(if F < 10 or #0, go to N0800)
(if E < 10 or #0, go to N0800)
(if S <= 200 or #0, go to N0800)


(kokokara G01)


N0002
G17
S#19
IF[#06EQ1]GOTO0003
IF[#06EQ2]GOTO0004
IF[#06EQ3]GOTO0005
IF[#06EQ4]GOTO0006
GOTO0800
(if K is not 1-4, go to N0800)

N0003 (for R)
G91 G01 X-[#24-#18] Z-[[#24-#18]*SIN[#02]] F#09
(a: X-Z-)
G91 G03 X-#18 Y-#18 Z-[#18*SIN[#02]] I0 J-#18 F#08
(al corner: R#18 [0, -R] X-Y-Z-)
G91 G01 Y-[#25-#18*2] F#09
(l:Y-)
G91 G03 X#18 Y-#18 Z[#18*SIN[#02]] I#18 J0 F#08
(bl corner: R#18 [R, 0] X+Y-Z+)
G91 G01 X[#24-#18*2] Z[[#24-#18*2]*SIN[#02]] F#09
(b: X+Z+)
G91 G03 X#18 Y#18 Z[#18*SIN[#02]] I0 J#18 F#08
(br corner: R#18 [0, R] X+Y+Z+)
G91 G01 Y[#25-#18*2] F#09
(r: Y+)
G91 G03 X-#18 Y#18 Z-[#18*SIN[#02]] I-#18 J0 F#08
(ar corner: R#18 [-R, #0] X-Y+)
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


N0800
M05 (spindle kaiten off)
M09 (coolant off)
#3000=100 (are*the*arguments*OK?)

N9999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#02:B: curved outcut angle)
(#03:C: corner C)
(#06:K: Corner Type)
(#07:D: kouguNigashiRyou)
(#08:E: speed at corner)
(#09:F: speed at chokusenBu)
(#18:R: corner R)
(#19:S: kaitenSuu)
(#24:X: gaisaku AC kei)
(#25:Y: gaisaku BD kei)

(System variables)
(#3000: alarm)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%