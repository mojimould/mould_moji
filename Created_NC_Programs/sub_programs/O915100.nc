%
O915100 (warming up: 20240716)

N0001 (initialize)
G49 G40 (cancel hosei)
G80 (cancel cycle)
G17 (select XY)
S35
M05 (spindle off)
M09 (coolant off)
M29 (chip conveyor off)
G90 G53 G01 Z0 F#650
G90 G53 G01 X-5.501 Y-258.624 F#652

N0002
M72 (palette #2)

N0003
M11 (B-axis unclamp)
G90 G53 G00 B0
G90 G53 G00 B-90.0
M10 (B-axis clamp)

N0004
T16 (tool selection)
M06 (tool exchange)

N0005
G91 G28 X0 Y0 Z0
S35
M03 (spindle on)
M08 (coolant #1 on)
M28 (chip conveyor on)

N0006
M98 P915101 L1

N0007
S2599
M98 P915101 L1

N0008
S2600
M98 P915101 L1

N0009
S6000
M98 P915101 L7

N9990
M09 (coolant off)
G91 G30 X0 Y0 Z0
T01 (tool #01)
G04 X5.0 (wait 5.0s)
M05 (spindle off)
S35

N9991
M06 (tool exchange)
T38 (tool #38)

N9992
M11 (B-axis unclamp)
G90 G53 G00 B0
M10 (B-axis clamp)
M29 (chip conveyor off)

N9993
M06 (tool exchange)
T01 (tool #01)
M06 (tool exchange)

N9999
#3901=-1
M30

(Used Variables and Programs)

(Common variables)
(as RHS)
(#650, #652)

(System variables)
(#3901)

(Subprograms)
(O905101)


(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)
%