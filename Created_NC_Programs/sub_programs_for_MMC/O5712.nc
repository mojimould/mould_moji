%
O5712
N0001
IF[#24EQ#0]GOTO8000
IF[#24LT10]GOTO8000
IF[#25EQ#0]GOTO8000
IF[#25LT10]GOTO8000
IF[#18EQ#0]GOTO8000
IF[#18LT0.1]GOTO8000
IF[#09EQ#0]GOTO8000
IF[#09LT10]GOTO8000
IF[#08EQ#0]GOTO8000
IF[#08LT10]GOTO8000
IF[#19EQ#0]GOTO8000
IF[#19LE200]GOTO8000
#33=#5001
#32=#5002
#31=#[2400+#07]+#[2600+#07]
#30=[#01+#31+ABS[#01-#31]]/2
IF[#30GT25]GOTO8000
S#19
N0002
G91 G01 G41 D#07 X[[#24/2]-#30] Y[[#25/2]-#18-#30] F[#09*3]
G03 X#30 Y#30 I0 J#30 F#08
G03 X-#18 Y#18 I-#18 J0 F#08
G01 X-[#24-[#18*2]] F#09
G03 X-#18 Y-#18 I0 J-#18 F#08
G01 Y-[#25-[#18*2]] F#09
G03 X#18 Y-#18 I#18 J0 F#08
G01 X[#24-[#18*2]] F#09
G03 X#18 Y#18 I0 J#18 F#08
G01 Y[#25-[#18*2]] F#09
G03 X-#18 Y#18 I-#18 J0 F#08
G03 X-#30 Y-#30 I0 J-#30 F[#09*3]
G90 G01 X#33 Y#32 F7500.
GOTO9999
N8000
M05
M09
#3000=100(are*the*arguments*OK?)
N9999
M99
(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%