%
O905100
(warming up)

N001
G91 G28 Z0
G91 G28 X0 Y0

N002
M72

M11
G91 G28 B0
G91 G00 B-90.

T16
M06

G91 G28 G00 X0 Y0 Z0

M28

M03 S35
M08

M98 P905101 L1

S2599
M98 P905101 L1

S2600
M98 P905101 L1

M29
S6000
M98 P905101 L7

M09
G04 X5.
M05
M30

T01
M06
M07
G04 X30.

M09
G04 X4.
M151
G04 X10.

M09
G91 G28 Z0
G91 G28 X0 Y0
G91 G28 B0
M30
%
