# last update: 20241010
# Copyright 2023-2024 The individual creator, not held by any corporation.
# All rights reserved.

from openpyxl import Workbook, load_workbook
from openpyxl.utils import column_index_from_string
from datetime import datetime
from itertools import count
import subprocess
import math


# File Loading
with open('./subscripts/preample_for_d_main_prg.py', 'r', encoding='utf-8') as file:
    variables = file.read()
exec(variables)


# Specific Code Description
SN_overall            = next(SN_base)
SN_origin_measurement = next(SN_origin_setting)
SN_dimple_Me          = next(SN_dimple_measurement)
SN_dimple_Mi          = next(SN_dimple_milling)
SN_top_EF             = next(SN_top_endface)
if TopOutcutExistsFlag == 1 and EndfaceBoringExistsFlag == 0:
    SN_top_OC             = next(SN_top_outcut)
elif TopOutcutExistsFlag == 0 and EndfaceBoringExistsFlag == 1:
    SN_EBoring            = next(SN_Endface_Boring)
SN_KW                 = next(SN_keyway)
SN_top_OCh            = next(SN_top_out_chamfer)
SN_top_ICh            = next(SN_top_in_chamfer)
SN_bot_EF             = next(SN_bot_endface)
SN_bot_OC             = next(SN_bot_outcut)
SN_bot_OCh            = next(SN_bot_out_chamfer)
SN_bot_ICh            = next(SN_bot_in_chamfer)
SN_M_centerline       = next(SN_centerline)
SN_alarm_pallete      = next(SN_alarmPallete)
SN_base_finish        = next(SN_base_end)
SN_finish_end         = next(SN_prg_end)

with open('./O' + MainPrgID + '0001', 'w') as f:
    f.write(
        '%\n'
        'O'+ MainPrgID + '0001 (Created on ' + date_string+')\n'
        '(Top re_alocation: ' + str(topReAlocationLength) + ')\n'
        '(Bot re_alocation: ' + str(botReAlocationLength) + ')\n'
        '(Top Overhang: ' + str(topOverHangLength) + ')\n'
        '(Bot Overhang: ' + str(botOverHangLength) + ')\n'
        '(Top parallel angle: ' + str(topSideParallelAngle) + ')\n'
        '(Bot parallel angle: ' + str(botSideParallelAngle) + ')\n'
        '\n'
    )

    f.write(
        f"N{SN_overall:04d}\n"
        'G49 G40 (cancel compensation)\n'
        'G80 G17\n'
        'S35\n'
        'M05 (spindle off)\n'
        'M09 (coolant off)\n'
        'M29 (chip conveyor off)\n'
        'G90 G53 G01 Z0 F#650\n'
        '\n'
    )

    SN_overall = next(SN_base)
    N_sensor_battery = SN_overall + 1
    f.write(
        f"N{SN_overall:04d}\n"
        'IF[#1005EQ0]' + f"GOTO{N_sensor_battery:04d}\n"
        'M00 (sensor low battery)\n'
        '\n'
    )

    SN_overall = next(SN_base)
    SN_ini_current_sensor_off = SN_overall + 1
    f.write(
        f"N{SN_overall:04d}\n"
        'IF[#1004EQ0]' + f"GOTO{SN_ini_current_sensor_off:04d}\n"
        '(if current sensor off, go to ' + f"N{SN_ini_current_sensor_off:04d}" + ')\n'
        'M117 (sensor off)\n'
        '\n'
    )

    SN_overall = next(SN_base)
    SN_ini_sensor_or_not = SN_overall + 1
    SN_ini_palette_move_in = SN_overall + 2
    f.write(
        f"N{SN_overall:04d}\n"
        'IF[#4120NE50]' + f"GOTO{SN_ini_sensor_or_not:04d}\n"
        'G90 G53 G01 X-5.501 Y-258.624 F#652\n'
        f"GOTO{SN_ini_palette_move_in:04d}\n"
        '\n'
    )

    SN_overall = next(SN_base)
    f.write(
        f"N{SN_overall:04d}\n"
        'G90 G53 G01 X-5.501 Y-258.624 F#650\n'
        '\n'
    )

    SN_overall = next(SN_base)
    f.write(
        f"N{SN_overall:04d}\n"
        'M262 (palette rotate speed 25)\n'
        'M71 (palette #1)\n'
    )

    f.write(
        '\n'
        '\n'
        '(*** touch sensor measurement ***)\n'
        '\n'
        '\n'
    )

    f.write(
        '(Origin Setting)\n'
    )

    SN_OM_palette_two = SN_origin_measurement + 1
    SN_OM_bot_measurement = SN_OM_palette_two + 1
    f.write(
        f"N{SN_origin_measurement:04d} (for palette #1)\n"
        'IF[#1000NE0]' + f"GOTO{SN_OM_palette_two:04d}\n"
        '(if NOT p#1, to ' + f"N{SN_OM_palette_two:04d})\n"
        'G90 G10 L2 P1 X[' + originBotOut + '+#901001] Y[['+ BDOD + '/2]+#901002] Z#901003 B#901004\n'
        'G90 G10 L2 P2 X[' + originBotIn + '+#901001] Y[['+ BDOD + '/2]+#901002] Z#901003 B#901004\n'
        'G90 G10 L2 P3 X[' + originTopOut + '+#901001] Y[['+ BDOD + '/2]+#901002] Z#901003 B#901004\n'
        'G90 G10 L2 P4 X[' + originTopIn + '+#901001] Y[['+ BDOD + '/2]+#901002] Z#901003 B#901004\n'
        'G90 G10 L2 P5 X[' + originKeyway + '+#901001] Y[['+ BDOD + '/2]+#901002] Z#901003 B#901004\n'
    )
    if BotOutcutExistsFlag == 0:
        f.write('(' + workCoordinateBotOut + ' Bot Outside Center)\n')
    elif BotOutcutExistsFlag == 1:
        f.write('(' + workCoordinateBotOut + ' Bot Outcut Center)\n')
    f.write('(' + workCoordinateBotIn + ' Bot Inside Center)\n')
    if TopOutcutExistsFlag == 0:
        f.write('(' + workCoordinateTopOut + ' Top Outside Center)\n')
    elif TopOutcutExistsFlag == 1:
        f.write('(' + workCoordinateTopOut + ' Top Outcut Center)\n')
    f.write(
        '(' + workCoordinateTopIn + ' Top Inside Center)\n'
        '(' + workCoordinateKeyway + ' Keyway Center)\n'
        f"GOTO{SN_OM_bot_measurement:04d}\n"
        '\n'
    )

    SN_origin_measurement = next(SN_origin_setting)
    f.write(
        f"N{SN_origin_measurement:04d} (for palette #2)\n"
        'IF[#1000NE1]' + f"GOTO{SN_alarm_pallete:04d}\n"
        '(if the palette is NOT #2, go to ' + f"N{SN_alarm_pallete:04d})\n"
        'G90 G10 L2 P1 X[' + originBotOut + '+#901005] Y[['+ BDOD + '/2]+#901006] Z#901007 B#901008\n'
        'G90 G10 L2 P2 X[' + originBotIn + '+#901005] Y[['+ BDOD + '/2]+#901006] Z#901007 B#901008\n'
        'G90 G10 L2 P3 X[' + originTopOut + '+#901005] Y[['+ BDOD + '/2]+#901006] Z#901007 B#901008\n'
        'G90 G10 L2 P4 X[' + originTopIn + '+#901005] Y[['+ BDOD + '/2]+#901006] Z#901007 B#901008\n'
        'G90 G10 L2 P5 X[' + originKeyway + '+#901005] Y[['+ BDOD + '/2]+#901006] Z#901007 B#901008\n'
    )
    if BotOutcutExistsFlag == 0 or (BotOutcutExistsFlag == 1 and BotCurvedOutcutExistsFlag == 1):
        f.write('(' + workCoordinateBotOut + ' Bot Outside Center)\n')
    elif BotOutcutExistsFlag == 1 and BotCurvedOutcutExistsFlag == 0:
        f.write('(' + workCoordinateBotOut + ' Bot Outcut Center)\n')
    f.write('(' + workCoordinateBotIn + ' Bot Inside Center)\n')
    if TopOutcutExistsFlag == 0:
        f.write('(' + workCoordinateTopOut + ' Top Outside Center)\n')
    elif TopOutcutExistsFlag == 1:
        f.write('(' + workCoordinateTopOut + ' Top Outcut Center)\n')
    f.write(
        '(' + workCoordinateTopIn + ' Top Inside Center)\n'
        '(' + workCoordinateKeyway + ' Keyway Center)\n'
        '\n'
        '\n'
    )

    f.write(
        '(Top sokutei start)\n'
        '\n'
        '\n'
    )

    SN_origin_measurement = next(SN_origin_setting)
    f.write(
        f"N{SN_origin_measurement:04d}\n"
        'G90 G53 G01 Z0 F#650\n'
        'T50 (touch sensor)\n'
        '' + workCoordinateTopIn + '\n'
        'M11 (B-axis unclamp)\n'
        'G90 ' + workCoordinateTopIn + ' G00 B' + topSideParallelAngle + '\n'
        'M10 (B-axis clamp)\n'
        'M06 (tool exchange)\n'
        'M19 (Spindle orientation)\n'
        'G43 H50\n'
        '(' + workCoordinateTopIn + ' B parallel angle ' + topSideParallelAngle + ')\n'
        '(tool length compensation #50)\n'
        '\n'
    )

    f.write(
        'G90 ' + workCoordinateTopIn + ' G01 X0 Y0 F#652\n'
        'G90 ' + workCoordinateTopIn + ' G01 Z[' + topReAlocationLength + '+#600] F#652\n'
        '(' + workCoordinateTopIn + ' XY Top inside center)\n'
        '(Z= TopReAlocation +#600)\n'
        '\n'
    )

    SN_OM_sensor_battery = SN_origin_measurement + 1
    f.write(
        'G65 P' + prgSensorOn + ' (sensor ON)\n'
        'IF[#1005EQ0]' + f"GOTO{SN_OM_sensor_battery:04d}\n"
        'M00 (sensor low battery)\n'
        '\n'
    )

    SN_origin_measurement = next(SN_origin_setting)
    SN_OM_sensor_switch = SN_origin_measurement + 1
    f.write(
        f"N{SN_origin_measurement:04d}\n"
        'IF[#1004EQ1]' + f"GOTO{SN_OM_sensor_switch:04d}\n"
        'M117 (sensor switch)\n'
        '\n'
    )

    SN_Zslope_measurement = next(SN_origin_setting)
    f.write(
        f"N{SN_Zslope_measurement:04d}\n"
        '' + workCoordinateTopIn + ' G65 P' + prgEndfaceSlope + ' X' + ACOD + ' U' + topACID + ' Z' + topReAlocationLength + ' M' + mekkiThickness + '\n'
        '(' + workCoordinateTopIn + ': Top X endface parallel angle)\n'
        '(X: AC OD or Top outcut OD)\n'
        '(U: Top AC ID or incut ID)\n'
        '(Z: Top re_alocation)\n'
        '(M: mekki thickness mm)\n'
        '\n'
    )

    SN_origin_measurement = next(SN_origin_setting)
    f.write(
        'IF[#5004EQ[' + topSideParallelAngle + '+#900047]]' + f"GOTO{SN_origin_measurement:04d}\n"
        'M11 (B-axis unclamp)\n'
        'G90 ' + workCoordinateTopIn + ' G00 B[' + topSideParallelAngle + '+#900047]\n'
        'M10 (B-axis clamp)\n'
        '(' + workCoordinateTopIn + ' B parallel angle ' + topSideParallelAngle + '+#900047)\n'
        '\n'
    )

    # Origin Setting Top inner X Measurement
    f.write(
        f"N{SN_origin_measurement:04d}\n"
        'G90 ' + workCoordinateTopIn + ' G01 X0 Y0 F#652\n'
        'G43 ' + f"H{toolIDTouchSensor:02d}" + ' (tool length compensation ' + f"#{toolIDTouchSensor:02d}" + ')\n'
        'G90 ' + workCoordinateTopIn + ' G01 Z[#900048+#600] F#652\n'
        '(' + workCoordinateTopIn + ' XY Top inside center)\n'
        '(Z= TopReReAlocation +#600)\n'
        '\n'

        '#411=5.0\n'
        '' + workCoordinateTopIn + ' G65 P' + prgInsideCenterX + ' X' + topACID + ' Z' + topReAlocationLength + ' W' + topAlocationLength + ' R' + centralCurvature + ' M' + mekkiThickness + '\n'
        '(' + workCoordinateTopIn + ': Top X Inside center)\n'
        '(X: Top AC ID)\n'
        '(Z: Top re_alocation)\n'
        '(W: Top alocation)\n'
        '(R: central curvature)\n'
        '(M: mekki thickness mm)\n'
        '#411=0\n'
        '\n'
    )

    # Origin Setting Top inner Y Measurement
    f.write(
        'G90 ' + workCoordinateTopIn + ' G01 X0 Y0 F#652\n'
        'G43 ' + f"H{toolIDTouchSensor:02d}" + ' (tool length compensation ' + f"#{toolIDTouchSensor:02d}" + ')\n'
        '(' + workCoordinateTopIn + ' XY Top inside center)\n'
        '\n'

        '#412=5.0\n'
        '' + workCoordinateTopIn + ' G65 P' + prgInsideCenterY + ' Y' + topBDID+ ' J' + BDOD + ' Z' + topReAlocationLength + ' M' + mekkiThickness + '\n'
        '(' + workCoordinateTopIn + ': Top Y inside center)\n'
        '(Y: Top BD ID)\n'
        '(J: BD OD)\n'
        '(Z: Top re_alocation)\n'
        '(M: mekki thickness mm)\n'
        '#412=0\n'
        '\n'
    )

    if DimpleExistsFlag == 0:
        SN_origin_measurement = next(SN_origin_setting)
        SN_OM_sensorOff = SN_origin_measurement
        f.write(
            'M117 (sensor on/off)\n'
            'G04 X1.5 (wait 1.5s)\n'
            'IF[#1004EQ0]' + f"GOTO{SN_OM_sensorOff:04d}\n"
            'G65 P' + prgSensorOff + ' (sensor OFF)\n'
            '\n'
            f"N{SN_OM_sensorOff:04d}\n"
        )


    SN_origin_measurement = next(SN_origin_setting)
    SN_OM_end = SN_origin_measurement
    f.write(
        '(mesurement end)\n'
        'IF[#177EQ1]' + f"GOTO{SN_origin_measurement:04d}\n"
        'M00\n'
        f"N{SN_OM_end:04d}\n"
        '\n'
    )

    if DimpleExistsFlag == 1:
        # Dimple measurement
        f.write(
            '\n'
            f"N{SN_dimple_Me:04d}\n"
            '(*** Dimple Measurement Start ***)\n'
            '\n'
            '\n'
        )

        SN_dimple_Me_setup = SN_dimple_Me + 1
        f.write(
            'G90 G53 G01 Z0 F#650\n'
            'IF[#4120EQ' + f"{toolIDTouchSensor:02d}" + ']' + f"GOTO{SN_dimple_Me_setup:04d}" + '\n'
            f"T{toolIDTouchSensor:02d}" + ' (touch sensor)\n'
            'M06 (tool exchange)\n'
            '\n'
        )

        SN_dimple_Me = next(SN_dimple_measurement)
        f.write(
            f"N{SN_dimple_Me:04d}\n"
            'G40 G80 (cancel compensation)\n'
            'S35 (low gear)\n'
            'M19 (Spindle orientation)\n'
            'G43 ' + f"H{toolIDTouchSensor:02d}" + ' (tool length compensation ' + f"#{toolIDTouchSensor:02d}" + ')\n'
            '\n'
        )

        SN_dimple_Me = next(SN_dimple_measurement)
        SN_dimple_Me_before_rotate = SN_dimple_Me + 1
        f.write(
            f"N{SN_dimple_Me:04d}\n"
            '' + workCoordinateTopIn + '\n'
            'IF[#5004EQ[' + topSideParallelAngle + '+#900047]]' + f"GOTO{SN_dimple_Me_before_rotate:04d}" + '\n'
            'M11 (B-axis unclamp)\n'
            'G90 ' + workCoordinateTopIn + ' G00 B[' + topSideParallelAngle + '+#900047]\n'
            'M10 (B-axis clamp)\n'
            '(' + workCoordinateTopIn + ' B parallel angle ' + topSideParallelAngle + '+#900047)\n'
            '\n'
        )

        SN_dimple_Me = next(SN_dimple_measurement)
        f.write(
            f"N{SN_dimple_Me:04d}\n"
            'G90 ' + workCoordinateTopIn + ' G01 X0 Y0 F#652\n'
            'G90 ' + workCoordinateTopIn + ' G01 Z[#900048+#600] F#652\n'
            '(' + workCoordinateTopIn + 'XY Top Inside Center)\n'
            '(Z= TopReAlocation +#600)\n'
            '\n'
        )

        f.write(
            '' + workCoordinateTopIn + ' G65 P' + prgDimpleOne + ' T' + mekkiThickness + ' Z#900048 W' + topAlocationLength + ' F' + dimpleFirstRowLength + ' S' + dimpleSecondRowLength + ' Q' + dimpleFirstRowDistanceFromEndface + ' I' + dimpleHorizontalPitch + ' K' + dimpleVerticalPitch + ' M' + dimpleRowNum + ' U' + dimpleDepth + ' R' + centralCurvature + ' A[' + topSideParallelAngle + '+#900047] B' + dimpleAngle + '\n'
            '(dimple measurement)\n'
            '(T: mekki thickness mm)\n'
            '(Z: Top re_alocation)\n'
            '(W: Top alocation)\n'
            '(F: length of odd rows)\n'
            '(S: length of even rows)\n'
            '(Q: Z length between Top and the 1st row)\n'
            '(I: dimple X pitch)\n'
            '(K: dimple Z pitch)\n'
            '(M: number of rows)\n'
            '(U: dimple depth)\n'
            '(R: central curvature)\n'
            '(A: angle for re_alocation)\n'
            '(B: angle for dimple)\n'
            '\n'
        )

        SN_D_sensor_off = SN_dimple_Me + 1
        f.write(
            'M117 (sensor on/off)\n'
            'G04 X1.5 (wait 1.5s)\n'
            'IF[#1004EQ0]' + f"GOTO{SN_D_sensor_off:04d}" + '\n'
            'G65 P' + prgSensorOff + ' (sensor OFF)\n'
            '\n'
        )

        SN_dimple_Me = next(SN_dimple_measurement)
        f.write(
            f"N{SN_dimple_Me:04d}\n"
            'G90 G53 G01 Z0 F#650\n'
            '\n'
        )


        SN_dimple_Me = next(SN_dimple_measurement)
        SN_dimple_end = SN_dimple_Me
        f.write(
            '(dimple mesurement end)\n'
            'IF[#178EQ1]' + f"GOTO{SN_dimple_end:04d}\n"
            'M00\n'
            f"N{SN_dimple_end:04d}\n"
            '\n'
        )

        # Dimple milling
        f.write(
            '\n'
            f"N{SN_dimple_Mi:04d}\n"
            '(*** Dimple Kakou Start ***)\n'
            '\n'
            '\n'
        )

        f.write(
            'G49 G40 (cancel compensation)\n'
            'G90 G53 G01 Z0 F#650\n'
            '\n'
        )

        SN_D_tool_exchange = SN_dimple_Mi + 1
        SN_D_tool_compensation = SN_dimple_Mi + 2
        f.write(
            'IF[#4120EQ31]' + f"GOTO{SN_D_tool_compensation:04d}\n"
            'IF[#4120NE50]' + f"GOTO{SN_D_tool_exchange:04d}\n"
            'G90 G53 G01 X-5.501 Y-258.624 F#652\n'
            '\n'
        )

        SN_dimple_Mi = next(SN_dimple_milling)
        f.write(
            f"N{SN_dimple_Mi:04d}\n"
            f"T{toolIDTslot[dimpleSmallRadius]:02d}" + ' (Tslot R' + dimpleSmallRadius + ')\n'
            'M06 (tool exchange)\n'
            'G43 H#4120 (tool length compensation: T#)\n'
            '\n'
        )

        SN_dimple_Mi = next(SN_dimple_milling)
        SN_D_approach = SN_dimple_Mi + 1
        f.write(
            f"N{SN_dimple_Mi:04d}\n"
            'IF[#5004EQ[' + topSideParallelAngle + '+#900047' + dimpleAngle + ']]' + f"GOTO{SN_D_approach:04d}\n"
            'M11 (B-axis unclamp)\n'
            'G90 ' + workCoordinateTopIn + ' G00 B[' + topSideParallelAngle + '+#900047]\n'
            'M10 (B-axis clamp)\n'
            '(' + workCoordinateTopIn + ' B parallel angle ' + topSideParallelAngle + '+#900047)\n'
            '\n'
        )

        SN_dimple_Mi = next(SN_dimple_milling)
        f.write(
            f"N{SN_dimple_Mi:04d}\n"
            'G90 ' + workCoordinateTopIn + ' G00 X0 Y0\n'
            'G90 ' + workCoordinateTopIn + ' Z[#900048+#600] F#650\n'
            '(' + workCoordinateTopIn + 'XY Top Inside Center)\n'
            '(Z= TopReAlocation +#600)\n'
            '\n'
        )

        SN_dimple_Mi = next(SN_dimple_milling)
        f.write(
            f"N{SN_dimple_Mi:04d}\n"
            '' + workCoordinateTopIn + ' G65 P' + prgDimpleOne + ' T' + mekkiThickness + ' Z#900048 W' + topAlocationLength + ' F' + dimpleFirstRowLength + ' S' + dimpleSecondRowLength + ' Q' + dimpleFirstRowDistanceFromEndface + ' I' + dimpleHorizontalPitch + ' K' + dimpleVerticalPitch + ' M' + dimpleRowNum + ' U' + dimpleDepth + ' R' + centralCurvature + ' A[' + topSideParallelAngle + '+#900047] B' + dimpleAngle + '\n'
            '(dimple milling)\n'
            '(T: mekki thickness mm)\n'
            '(Z: Top re_alocation)\n'
            '(W: Top alocation)\n'
            '(F: length of odd rows)\n'
            '(S: length of even rows)\n'
            '(Q: Z length between Top and the 1st row)\n'
            '(I: dimple X pitch)\n'
            '(K: dimple Z pitch)\n'
            '(M: number of rows)\n'
            '(U: dimple depth)\n'
            '(R: central curvature)\n'
            '(A: angle for re_alocation)\n'
            '(B: angle for dimple)\n'
            '\n'
        )

        SN_D_M_pause = SN_dimple_Mi + 1
        SN_D_M_pause_check = SN_D_M_pause + 1
        SN_D_M_end = SN_D_M_pause_check + 1
        f.write(
            '(dimple milling end)\n'
            'IF[#459EQ0]' + f"GOTO{SN_D_M_pause:04d}\n"
            'IF[#459EQ2]' + f"GOTO{SN_D_M_pause_check:04d}\n"
            f"GOTO{SN_D_M_end:04d}\n"
            '\n'
        )

        SN_dimple_Mi = next(SN_dimple_milling)
        f.write(
            f"N{SN_dimple_Mi:04d}\n"
            'M00 (if #459=0)\n'
            f"GOTO{SN_D_M_end:04d}\n"
            '\n'
        )

        SN_dimple_Mi = next(SN_dimple_milling)
        f.write(
            f"N{SN_dimple_Mi:04d}\n"
            'G65 P' + prgPauseCheck + ' (if #459=2)\n'
            f"N{SN_D_M_end:04d}\n"
            '\n'
        )

    f.write(
        '\n'
        '(Kakou Owari)\n'
        '\n'
        '\n'
    )

    # end milling
    SN_base_finish_start = SN_base_finish

    # centerline measurement
    if BotOutcutExistsFlag == 1 and TopOutcutExistsFlag == 1:
        SN_overall = next(SN_base)
        f.write(
            f"N{SN_overall:04d}\n"
            'IF[#402EQ0]' + f"GOTO{SN_base_finish_start:04d}\n"
            '(if #402=0, go to ' + f"N{SN_base_finish_start:04d})\n"
            '\n'
        )

        f.write(
            '\n'
            '(*** TooriShin start ***)\n'
            '\n'
            '\n'
        )

        f.write(
            f"N{SN_M_centerline:04d}\n"
            'G90 G53 G01 Z0 F#650\n'
            'G91 G28 X0 Y0\n'
            'G49 G40 (cancel compensations)\n'
            'G80 G17\n'
            'S35 (low gear)\n'
            '\n'
        )

        f.write(
            'M28 (chip conveyor on)\n'
            '' + workCoordinateBotOut + ' G65 P' + prgCenterlineDif + ' W' + topReAlocationLength + ' Z' + botReAlocationLength + ' T' + topOutcutACOD + ' U' + topOutcutBDOD + ' B' + botOutcutACOD + ' C' + botOutcutBDOD + ' I' + centerlineACDif + ' M' + keywayPos + ' K' + botOutcutLength + ' A' + topSideParallelAngle + '\n'
            '(O' + prgCenterlineDif + ': Outside Corner R, ar left)\n'
            '(W: Top re_alocation)\n'
            '(Z: Bot re_alocation)\n'
            '(T: Top outcut AC OD)\n'
            '(U: Top outcut BD OD)\n'
            '(B: Bot outcut AC OD)\n'
            '(C: Bot outcut BD OD)\n'
            '(I: centerline AC dif)\n'
            '(M: keyway position)\n'
            '(K: Bot outcut Length)\n'
            '(A: Top side parallel angle)\n'
            '\n'
        )

        f.write(
            'G90 ' + workCoordinateBotOut + ' G01 X#900036 Y#900032 F#652\n'
            'M00 (tooriShin XY OK?)\n'
            '\n'
            '#402=0 (centerline difference measurement off)\n'
            'G90 G53 G01 X-5.501 Y-258.624 F#652\n'
            '\n'
        )
        f.write(
            '(tooriShin end)\n'
            '\n'
            '\n'
        )

    f.write(
        f"N{SN_base_finish:04d}\n"
        'G49 G40 (cancel compensations)\n'
        'G80 G17\n'
        'G90 G53 G01 Z0 F#650\n'
        'G90 G53 G00 X-5.501 Y-258.624\n'
        '\n'
    )

    SN_base_finish = next(SN_base_end)
    SN_finish_setting = SN_base_finish + 1
    f.write(
        f"N{SN_base_finish:04d}\n"
        'IF[#1004EQ0]' + f"GOTO{SN_finish_setting:04d}\n"
        '(if current sensor off, go to ' + f"N{SN_finish_setting:04d})\n"
        'M117 (sensor on/off)\n'
        '\n'
    )

    SN_base_finish = next(SN_base_end)
    f.write(
        f"N{SN_base_finish:04d}\n"
        'M09 (coolant off)\n'
        'M29 (chip conveyor off)\n'
        'M05 (spindle off)\n'
        'S35 (low gear)\n'
        '\n'
    )

    SN_base_finish = next(SN_base_end)
    f.write(
        f"N{SN_base_finish:04d}\n"
        'M60 (palette change)\n'
        'T38 (tool #38)\n'
        'M06 (tool exchange)\n'
        f"T{toolIDEmpty:02d}" + ' (empty)\n'
        'M06 (tool exchange)\n'
        f"GOTO{SN_finish_end:04d}\n"
        '\n'
    )

    f.write(
        '\n'
        '(Alerm)\n'
        f"N{SN_alarm_pallete:04d}\n"
        'M09 (coolant off)\n'
        'S2599\n'
        'G04 X1.0 (wait 1.0s)\n'
        'M05 (spindle off)\n'
        'S35\n'
        '#3000=146 (is*the*palette#*is*ok?)\n'
        '\n'
    )

    f.write(
        f"N{SN_finish_end:04d}\n"
        'M30\n'
        '\n'
    )

    f.write(
        '\n'
        '(COPYRIGHT*2023-2024 THE*INDIVIDUAL*CREATOR NOT*HELD*BY*ANY*CORPORATION ALL*RIGHTS*RESERVED)\n'
        '%'
    )
