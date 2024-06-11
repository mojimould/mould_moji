%
O490007 (last update on 20240611)
(Uchigawa Corner R ac HidariMawari 1shuu)

N0001
IF[#24EQ#0]GOTO0800
IF[#24LT10]GOTO0800
IF[#25EQ#0]GOTO0800
IF[#25LT10]GOTO0800
IF[#18EQ#0]GOTO0800
IF[#18LT0.1]GOTO0800
IF[#09EQ#0]GOTO0800
IF[#09LT10]GOTO0800
IF[#08EQ#0]GOTO0800
IF[#08LT10]GOTO0800
IF[#19EQ#0]GOTO0800
IF[#19LE200]GOTO0800
(if X < 10 or #0, go to N0800)
(if Y < 10 or #0, go to N0800)
(if R < 0.1 or #0, go to N0800)
(if F < 10 or #0, go to N0800)
(if E < 10 or #0, go to N0800)
(if S <= 200 or #0, go to N0800)

#33=#5001
#32=#5002
(#33: start position X)
(#32: start position Y)

#31=#[2400+#07]+#[2600+#07]
#30=[#01+#31+ABS[#01-#31]]/2
IF[#30GT25]GOTO0800


(kokokara G01)


N0002
S#19
G91 G41 G01 D#07 X[[#24/2]-#30] Y[[#25/2]-#18-#30] F[#09*3]
(hosei kouguKei, kougu #07)
(X+: X/2-#30)
(Y+: Y/2-R-#30)
G91 G03 X#30 Y#30 I0 J#18 F#08
G91 G03 X-#18 Y#18 I-#18 J0 F#08
(ar corner: R #30 [0, #18] X+Y+)
(ar corner: R #18 [-#18, 0] X-Y+)
G91 G01 X-[#24-[#18*2]] F#09
(a: X- AC chokusenBu)
G91 G03 X-#18 Y-#18 I0 J-#18 F#08
(al corner: R #18 [0, -#18] X-Y-)
G91 G01 Y-[#25-[#18*2]] F#09
(l:Y-: BD chokusenBu)
G91 G03 X#18 Y-#18 I#18 J0 F#08
(bl corner: R #18 [#18, 0] X+Y-)
G91 G01 X[#24-[#18*2]] F#09
(b:X+: AC chokusenBu)
G91 G03 X#18 Y#18 I0 J#18 F#08
(br corner: R #18 [0, #18] X+Y+)
G91 G01 Y[#25-[#18*2]] F#09
(r:Y+: BD chokusenBu)
G91 G03 X-#18 Y#18 I-#18 J0 F#08
G91 G03 X-#30 Y-#30 I0 J-#18 F[#09*3]
(ar corner: R #18 [-#18, 0] X-Y+)
(ar corner: R #30 [0, -#18] X-Y-)
G90 G01 X#33 Y#32 F#651
(XY to the start position)
GOTO9999


N0800
M05 (shujiku kaiten off)
M09 (coolant off)
#3000=100 (are*the*arguments*OK?)

N9999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#01:A: aproach radious)
(#03:C: corner C)
(#07:D: kouguNigashiRyou)
(#08:E: speed at corner)
(#09:F: speed at chokusen)
(#18:R: corner R)
(#19:S: kaitenSuu)
(#24:X: AC kei)
(#25:Y: BD kei)

(as LHS)
(#30, #31, #32, #33)

(Common variables)
(as RHS)
(#651)

(System variables)
(#3000: alarm)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%