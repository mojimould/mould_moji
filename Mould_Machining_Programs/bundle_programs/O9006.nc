%
O9006(ATC)
#138=#4107(DCODE)
#139=#4111(HCODE)
#137=#4003(G90-G91)
G91G28Z0(Z-ZERO-RETURN)
G91G30P2X0Y0M6(TOOLCHANGE)
(#510=#4120,T-CODE)
(IF[#1009EQ1]GOTO50,SP-TOOL-LIFE-CHECK)
G49
G53
G#137M99
N50
#3000=7(TOOL-LIFE-CHECK)
%
