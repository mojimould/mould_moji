%
O915100 (warming up)

N001 (initialize)
G49 G40 (cancel hosei)
G80 (cancel cycle)
G17 (select XY)
S200
M05 (spindle off)
M09 (coolant off)
M29 (chip conveyor off)
G90 G53 G01 Z0 F#675
G90 G53 G01 X-5.501 Y-258.624 F#676


N002
M72 (palette #2)

N003
M11 (B-axis unclamp)
G90 G53 G00 B0
G90 G53 G00 B-90.0
M10 (B-axis clamp)

N004
T16 (tool selection)
M06 (tool exchange)

N005
G91 G28 X0 Y0 Z0
S35
M03 (spindle on)
M08 (coolant #1 on)
M28 (chip conveyor on)

N006
M98 P915101 L1

N007
S2599
M98 P915101 L1

N008
S2600
M98 P915101 L1

N009
M29 (chip conveyor off)
S6000
M98 P915101 L7

N990
M09 (coolant off)
G04 X5.0 (wait 5.0s)
M05 (spindle off)

N991
G91 G30 X0 Y0 Z0
T01 (tool #01)
M06 (tool exchange)
T50 (tool #50)

N992
M11 (B-axis unclamp)
G90 G53 G00 B0
M10 (B-axis clamp)
M29 (chip conveyor off)

N999 M02


T01
M06 (tool exchange)

M07 (coolant #2 on)
G04 X30.

M09 (coolant off)
G04 X4.
M151 (spindle through air blow)
G04 X10.

M09 (coolant off)
G91 G28 Z0
G91 G28 X0 Y0
G91 G28 B0

M30
%

(Used Variables and Programs)


(Subprograms)
(O905101)

