%
O9301(XYZ)
#18=#512
G65P9393
IF[#1005EQ1]GOTO50
IF[#1004EQ0]GOTO51
#1=#4001
#2=#4003
#3=1
IF[#4012EQ54.1]GOTO20
#4=5221+[#4012-54]*20
GOTO21
N20#4=7001+[#4130-1]*20
N21IF[#26EQ#0]GOTO6
IF[#25EQ#0]GOTO1
IF[#24EQ#0]GOTO2
GOTO6
N1IF[#24NE#0]GOTO3
G65P9390Z#26R#18D#7
GOTO8
N2G65P9391Y#25Z#26R#18D#7
GOTO8
N3IF[#4003EQ90]GOTO4
#24=#5001+#24
#26=#5003+#26
N4IF[#24LT#5001]GOTO5
#3=-1
N5G90G0Z#26
#24=#24+#3*#18
X[#24+#3*#7]
G31X[#24-#3*[#500+1.0]]F#514
#5=#5061+#3*#501+#502
G0X[#24+#3*#7]
IF[ABS[#5-#24]GE#500]GOTO7
#[#4]=#[#4]+#5-#24
GOTO8
N6#3000=140(Z-AXIS-IS-NOT-COMMAND)
N7G65P9392
#3000=141(MEASURED-VALUE-IS-OVER)
N50#3000=145(MP10/MP12/MP60-LOW-BATTERY)
N51#3000=146(MP10/MP12/MP60-ALARM)
N8G65P9392
G#1G#2
M99
%
