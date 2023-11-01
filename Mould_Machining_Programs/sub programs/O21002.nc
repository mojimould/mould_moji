%
O21002 (dimple measurement Z: for BD)


G90 G01 X[#5281*COS[#1]-#26*SIN[#1]] F6400
G90 G31 Z[#5281*SIN[#1]+#26*COS[#1]-#512] F6400
(XZ to tanmen center)
IF[[#5063-#2050]GT[#5281*SIN[#1]+#26*COS[#1]-#512]]GOTO10
(if skip Z - hosei #50 KouguChou > tanmen center Z - D/2, to N10)

#27=#5041 (#27= current work X: start point X)
#28=#5043 (#28= current work Z: start point Z)



















N10
G91 G28 Z0
G65 P19392 (sensor OFF)

N98 #3000=121 (are the arguments or the mould OK?)
M00 (are arguments ok?)

N99 M99

(#26:Z: furiwake Top)


(#501: hosei: touch sensor signal delay)
(#503: hosei: probe center Y)
(#512: probe radius)
(#514: default skip speed)
(#1004: 1: sensor on, 0: off)
(#1005: 1: sensor low battery, 0: OK)
(#3000: alarm)
(#5041: current work X)
(#5042: current work Y)
(#5063: skip position Z)
%