%
O490004
(Sotogawa Corner R ac HidariMawari 1shuu)

N001
IF[#24EQ#0]GOTO800
IF[#24LT10]GOTO800
IF[#18EQ#0]GOTO800
IF[#18LT1]GOTO800
IF[#09EQ#0]GOTO800
IF[#09LT10]GOTO800
IF[#08EQ#0]GOTO800
IF[#08LT10]GOTO800
IF[#19EQ#0]GOTO800
IF[#19LE200]GOTO800
(if X < 10 or #0, go to N800)
(if R < 1 or #0, go to N800)
(if F < 10 or #0, go to N800)
(if E < 10 or #0, go to N800)
(if S <= 200 or #0, go to N800)

#33=#5001
#32=#5002
(#33: start position X)
(#32: start position Y)


(kokokara G01)


N002
S#19
G91 G41 G01 D#07 X[#24/2] Y[[#24/2]-#18] F[#09*3]
(hosei kouguKei, kougu #07)
(X+: X/2)
(Y+: Y/2-R)
G91 G03 X-#18 Y#18 I-#18 J0 F#08
(ar corner: R #18 [-#18, 0] X-Y+)
G91 G01 X-[#24-[#18*2]] F#09
(a:X-: chokusenBu)
G91 G03 X-#18 Y-#18 I0 J-#18 F#08
(al corner: R #18 [0, -#18] X-Y-)
G90 G01 X#33 Y#32 F#651
(XY to the start position)

GOTO999


N800
M05 (shujiku kaiten off)
M09 (coolant off)
#3000=100 (are the arguments OK?)

N999 M99

(Used Variables and Programs)

(Local variables)

(as received arguments)
(#07:D: kouguNigashiRyou)
(#08:E: speed at corner)
(#09:F: speed at chokusen)
(#18:R: corner R)
(#19:S: kaitenSuu)
(#24:X: AC kei)
(#25:Y: BD kei)

(as LHS)
(#32, #33)


(Common variables)
(as RHS)
(#651)


(System variables)
(#3000: alarm)
%