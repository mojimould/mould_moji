%
O491005 (last update on 20240510)
(Sotogawa ar HidariMawari 1shuu)

N001
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#25EQ#0]GOTO800
IF[#25LT10]GOTO800
IF[#09EQ#0]GOTO800
IF[#09LT10]GOTO800
IF[#08EQ#0]GOTO800
IF[#08LT10]GOTO800
IF[#19EQ#0]GOTO800
IF[#19LE200]GOTO800
(if X < 10 or #0, go to N800)
(if Y < 10 or #0, go to N800)
(if F < 10 or #0, go to N800)
(if E < 10 or #0, go to N800)
(if S <= 200 or #0, go to N800)


(kokokara G01)


N002
S#19
IF[#20EQ1]GOTO003
IF[#20EQ2]GOTO004
IF[#20EQ3]GOTO005
IF[#20EQ4]GOTO006
GOTO800
(if K is not 1, 2, 3, 4, go to N800)

N003 (for R)
G90 G01 X[[#24/2]+#12] Y[#25/2] Z[#900049-#06] F#09
(a: X-)
G91 G03 X-#18 Y-#18 I0 J-#18 F#08
(al corner: R#18 [0, -R] X-Y-)
G91 G01 Y-[#25-#18*2] F#09
(l:Y-)
G91 G03 X#18 Y-#18 I#18 J0 F#08
(bl corner: R#18 [R, 0] X+Y-)
G91 G01 X[#24-#18*2] F#09
(b: X+)
G91 G03 X#18 Y#18 I0 J#18 F#08
(br corner: R#18 [0, R] X+Y+)
G91 G01 Y[#25-#18*2] F#09
(r: Y+)
G91 G03 X-#18 Y#18 I-#18 J0 F#08
(ar corner: R#18 [-R, #0] X-Y+)
G91 G02 X-[#07*2] Y[#07*2] I0. J[#07*2] F[#09*4]
(G02 R[#07*2] [0, #07*2] X-Y+)
GOTO999

N004 (for C)
G91 G01 X-[#24+#07*2-#03] F#09
(a: X-)
G91 G01 X-#03 Y-#03 F#08
(al corner: C#03 X-Y-)
G91 G01 Y-[#25-#03*2] F#09
(l: Y-)
G91 G01 X#03 Y-#03 F#08
(bl corner: C#03 X+Y-)
G91 G01 X[#24-#03*2] F#09
(b: X+)
G91 G01 X#03 Y#03 F#08
(br corner: C#03 X+Y+)
G91 G01 Y[#25-#03*2] F#09
(r: Y+)
G91 G01 X-#03 Y#03 F#08
(ar corner: C#03 X-Y+)
G91 G01 X-[#07*2] Y[#07*2] F[#09*4]
(X-Y+)
GOTO999

N005 (for rec)
G91 G01 X-[#24+#07*2] F#09
(a: X-)
G91 G01 Y-#25 F#09
(l: Y-)
G91 G01 X#24 F#09
(b: X+)
G91 G01 Y#25 F#09
(r: Y+)
G91 G01 Y[#07*2] F[#09*4]
(Y+)
GOTO999

N006 (for BD only)
G91 G01 X-[#24+#07*2+[#07*1.5]] F#09
(a: X-)
G91 G00 Y-#25
(l: Y-)
G91 G01 X[#24+#07*3] F#09
(b: X+)
G91 G00 Y[#25+#07*2]
(r: Y+)
GOTO999


N800
M05 (spindle kaiten off)
M09 (coolant off)
#3000=100 (are the arguments OK?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#03:C: corner C)
(#07:D: kouguNigashiRyou)
(#08:E: speed at corner)
(#09:F: speed at chokusenBu)
(#12:H: hosei: gaisaku center)
(#18:R: corner R)
(#19:S: kaitenSuu)
(#20:T: type)
(#24:X: AC kei)
(#25:Y: BD kei)

(System variables)
(#3000: alarm)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%