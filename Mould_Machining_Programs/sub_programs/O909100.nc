%
O909100 (tool length measurement)

#01=#4001
#02=#4003

#24=#516 (X)
#25=#517 (Y)
#26=-820. (Z)
#21=#24-#5021+#4
#22=#25-#5022+#5

/G91 G28 Z0 M19
/G00 X#21 Y#22

IF[#4012EQ54.1]GOTO20

#03=5223+[#4012-54]*20
GOTO21

N020
#03=7003+[#4130-1]*20
N021
#04=ABS[#26+#504]

M32
G4X2.
G53
/GOTO22
M00

N022
#05=#5043

/G91 G31 P2 Z-#4 F#513

IF[#5063LE[#05-#04]]GOTO001

/G00 Z#504.

#05=#5043-#504-#507

G91 G31 P2 Z[-#504-#507-#507] F#514

IF[#5063LE#05]GOTO001
#[11000+#11]=0
#[10000+#11]=#5063+#[#03]+#5203+#505
G91 G28 Z0
M33
GOTO002

N001
G91 G28 Z0
M33
#3000=141 (tool measurement alarm)

N002
G#01G#02
M99
%
