%
O915100
(warming up)

N001
G91 G28 Z0
G91 G28 X0 Y0

N002
M72 (palette #2)

M11 (4jiku unclamp)
G91 G28 B0
G91 G00 B-90.

T16
M06 (tool exchange)

G91 G28 X0 Y0 Z0

M28 (chip conveyor on)

S35
M03 (spindle on)
M08 (coolant #1 on)

M98 P915101 L1

S2599
M98 P915101 L1

S2600
M98 P915101 L1

M29 (chip conveyor off)

S6000
M98 P915101 L7

M09 (coolant off)
G04 X5.
M05 (spindle off)

M30


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

