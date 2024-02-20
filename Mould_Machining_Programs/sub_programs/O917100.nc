%
O917100 (all tool length measurement)

N002 (for T02)
(If the cutter is changed, I & J must be checked)
T02 M06
G65 P919100 H02 I-45. J15.
M02

N006 (for T06)
(If the cutter is changed, I & J must be checked)
T06 M06
G65 P919100 H06 I-45. J10.
M02

N011 (for T11)
T11 M06
G65 P919100 H11
M02

N012 (for T12)
T12 M06
G65 P919100 H12
M02

N013 (for T13)
T13 M06
G65 P919100 H13
M02

N016 (for T16)
(If the cutter is changed, I & J must be checked)
T16 M06
G65 P919100 H16 I-5. J-5.
M02

N031 (for T31 and T32)
T31 M06
(If the cutter is changed, I & J must be checked)
G65 P919100 H31 I-17.5 J6.
M01 (optional pause)

N032
T32 M06
(If the cutter is changed, I & J must be checked)
G65 P919100 H32 I-17.5 J6.
M02

N050 (for T50)
T50 M06
G65 P919100 H50
T01 M06
T50
M30

(Used Variables and Programs)

(Subprograms)
(O919100)
%