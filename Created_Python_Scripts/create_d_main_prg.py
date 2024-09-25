# last update: 20240925
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

with open('./O' + MainPrgID, 'w') as f:
    f.write(
        '%\n'
        'O'+ MainPrgID + ' (Created on ' + date_string+')\n'
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
        'G49 G40 (cancel correction)\n'
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
        '(' + workCoordinateKeyway + ' Mizo Center)\n'
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
        '(' + workCoordinateKeyway + ' Mizo Center)\n'
        '\n'
    )

    SN_origin_measurement = next(SN_origin_setting)
    f.write(
        f"N{SN_origin_measurement:04d}\n"
        '' + workCoordinateBotOut + '\n'
        'M11 (B-axis unclamp)\n'
        'G90 ' + workCoordinateBotOut + ' G00 B' + botSideParallelAngle + '\n'
        'M10 (B-axis clamp)\n'
        '(' + workCoordinateBotOut + ' B parallel angle ' + botSideParallelAngle + ')\n'
        '\n'
        '\n'
    )

    f.write(
        '(Bottom sokutei start)\n'
        '\n'
        '\n'
    )

    f.write(
        'T50 (touch sensor)\n'
        'M06 (tool exchange)\n'
        '\n'
    )

    f.write(
        'G40 G49 G80 (cancel correction)\n'
        'S35 (low gear)\n'
        'M19 (Spindle orientation)\n'
        'G43 H50 (tool length correction #50)\n'
        '\n'
    )

    f.write('G90 ' + workCoordinateBotOut + ' G01 X0 Y0 F#652\n')
    if BotOutcutExistsFlag == 0:
        f.write('(G01 ' + workCoordinateBotOut + 'XY Bot Outside center)\n')
    elif BotOutcutExistsFlag == 1:
        f.write('(G01 ' + workCoordinateBotOut + 'XY Bot Outcut center)\n')
    f.write('\n')

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

    SN_origin_measurement = next(SN_origin_setting)
    f.write(
        f"N{SN_origin_measurement:04d}\n"
        'G90 ' + workCoordinateBotOut + ' G01 Z[' + botReAlocationLength + '+#600] F#652\n'
        '(Z= BotReAlocation +#600)\n'
        '\n'
    )

    # Origin Setting Bottom Outer X Measurement
    if BotOutcutExistsFlag == 0 or (BotOutcutExistsFlag == 1 and BotCurvedOutcutExistsFlag == 1):
        f.write(
            '' + workCoordinateBotOut + ' G65 P' + prgOutsideCenterX + ' X' + ACOD + ' Z' + botReAlocationLength + ' W' + botAlocationLength + ' R' + centralCurvature + '\n'
            '(' + workCoordinateBotOut + ': Bot X Outside center)\n'
            '(X: AC OD)\n'
            '(Z: Bot re_alocation)\n'
            '(W: Bot alocation)\n'
            '(R: central curvature)\n'
            '\n'
        )
    elif (BotOutcutExistsFlag == 1 and BotCurvedOutcutExistsFlag == 0) and (TopOutcutExistsFlag == 0 or TopOutcutExistsFlag == 1 and OutcutCenterlineBasementFlag == 1):
        f.write(
            '' + workCoordinateBotOut + ' G65 P' + prgOutcutCenterX + ' X' + botOutcutACOD + ' I' + botACID + ' Z' + botReAlocationLength + ' W' + botAlocationLength + ' T' + botOutcutAsideThickness + ' C' + botInChamferLength + ' R' + centralCurvature + ' M' + mekkiThickness + '\n'
            '(' + workCoordinateBotOut + ': Bot X Outcut center)\n'
            '(X: Bot AC Outcut OD)\n'
            '(I: Bot AC ID)\n'
            '(Z: Bot re_alocation)\n'
            '(W: Bot alocation)\n'
            '(T: Bot A-side thickness at measurement depth)\n'
            '(C: measurement depth from endface)\n'
            '(R: central curvature)\n'
            '(M: mekki thickness mm)\n'
            '\n'
        )

    # Origin Setting Bottom Outer Y Measurement
    if BotOutcutExistsFlag == 0:
        f.write(
            'G90 ' + workCoordinateBotOut + ' G01 X0 Y0 F#652\n'
            'G43 ' + f"H{toolIDTouchSensor:02d}" + ' (tool length correction ' + f"#{toolIDTouchSensor:02d}" + ')\n'
            '(' + workCoordinateBotOut + ' XY Bot outside center)\n'
            '\n'

            '' + workCoordinateBotOut + ' G65 P' + prgOutsideCenterY + ' Y' + BDOD + ' Z' + botReAlocationLength + '\n'
            '(' + workCoordinateBotOut + ': Bot Y Outside center)\n'
            '(Y: BD OD)\n'
            '(Z: Bot re_alocation)\n'
            '\n'
        )


    # Origin Setting Bottom inner X Measurement
    f.write(
        'G90 ' + workCoordinateBotIn + ' G01 X0 Y0 F#652\n'
        'G43 ' + f"H{toolIDTouchSensor:02d}" + ' (tool length correction ' + f"#{toolIDTouchSensor:02d}" + ')\n'
        '(' + workCoordinateBotIn + ' XY Bot inside center)\n'
        '\n'

        '' + workCoordinateBotIn + ' G65 P' + prgInsideCenterX + ' X' + botACID + ' Z' + botReAlocationLength + ' W' + botAlocationLength + ' R' + centralCurvature + ' M' + mekkiThickness + '\n'
        '(' + workCoordinateBotIn + ': Bot X Inside center)\n'
        '(X: Bot AC ID)\n'
        '(Z: Bot re_alocation)\n'
        '(W: Bot alocation)\n'
        '(R: central curvature)\n'
        '(M: mekki thickness mm)\n'
        '\n'
    )

    # Origin Setting Bottom inner Y Measurement
    f.write(
        'G90 ' + workCoordinateBotIn + ' G01 X0 Y0 F#652\n'
        'G43 ' + f"H{toolIDTouchSensor:02d}" + ' (tool length correction ' + f"#{toolIDTouchSensor:02d}" + ')\n'
        '(' + workCoordinateBotIn + ' XY Bot inside center)\n'
        '\n'

        '' + workCoordinateBotIn + ' G65 P' + prgInsideCenterY + ' Y' + botBDID + ' J' + BDOD + ' Z' + botReAlocationLength + ' M' + mekkiThickness + '\n'
        '(' + workCoordinateBotIn + ': Bot Y Inside center)\n'
        '(Y: Bot BD ID)\n'
        '(J: BD OD)\n'
        '(Z: Bot re_alocation)\n'
        '(M: mekki thickness mm)\n'
        '\n'
    )

    if BotOutcutExistsFlag == 1:
        f.write(
            '#5222=#5242\n'
            '(' + workCoordinateBotOut + 'Y = ' + workCoordinateBotIn + 'Y)\n'
            '\n'
        )

    f.write(
        '\n'
        '(Bottom sokutei end)\n'
        '\n'
        '(Top sokutei start)\n'
        '\n'
        '\n'
    )

    f.write(
        'G90 G53 G01 Z0 F#650\n'
        '' + workCoordinateTopOut + '\n'
        'M11 (B-axis unclamp)\n'
        'G90 ' + workCoordinateTopOut + ' G00 B' + topSideParallelAngle + '\n'
        'M10 (B-axis clamp)\n'
        'G43 ' + f"H{toolIDTouchSensor:02d}" + '\n'
        '(' + workCoordinateTopOut + ' B parallel angle ' + topSideParallelAngle + ')\n'
        '(tool length correction ' + f"#{toolIDTouchSensor:02d}" + ')\n'
        '\n'
    )

    f.write(
        'G90 ' + workCoordinateTopOut + ' G01 X0 Y0 F#652\n'
        'G90 ' + workCoordinateTopOut + ' G01 Z[' + topReAlocationLength + '+#600] F#652\n'
    )
    if TopOutcutExistsFlag == 0:
        f.write('(' + workCoordinateTopOut + ' XY Top Outside center)\n')
    elif TopOutcutExistsFlag == 1:
        f.write('(' + workCoordinateTopOut + ' XY Top Outcut Center)\n')
    f.write(
        '(Z= TopReAlocation +#600)\n'
        '\n'
    )

    # Origin Setting Top outer X Measurement
    if TopOutcutExistsFlag == 0:
        f.write(
            '' + workCoordinateTopOut + ' G65 P' + prgOutsideCenterX + ' X' + ACOD + ' Z' + topReAlocationLength + ' W' + topAlocationLength + ' R' + centralCurvature + ' M' + keywayPos + ' H' + keywayWidth + '\n'
            '(' + workCoordinateTopOut + ': Top X Outside center)\n'
            '(X: AC OD)\n'
            '(Z: Top re_alocation)\n'
            '(W: Top alocation)\n'
            '(R: central curvature)\n'
            '(M: mizoIchi)\n'
            '(H: mizoHaba)\n'
            '\n'
        )
    elif TopOutcutExistsFlag == 1 and (BotOutcutExistsFlag == 0 or BotOutcutExistsFlag == 1 and OutcutCenterlineBasementFlag == 2):
        f.write(
            '' + workCoordinateTopOut + ' G65 P' + prgOutcutCenterX + ' X' + topOutcutACOD + ' I' + topACID + ' Z' + topReAlocationLength + ' W' + topAlocationLength + ' T' + topOutcutAsideThickness + ' C' + topInChamferLength + ' R' + centralCurvature + ' M' + mekkiThickness + '\n'
            '(' + workCoordinateTopOut + ': Top X Outcut center)\n'
            '(X: Top AC Outcut OD)\n'
            '(I: Top AC ID)\n'
            '(Z: Top re_alocation)\n'
            '(W: Top alocation)\n'
            '(T: Top A-side thickness at measurement depth)\n'
            '(C: measurement depth from endface)\n'
            '(R: central curvature)\n'
            '(M: mekki mm)\n'
            '\n'
        )
    elif TopOutcutExistsFlag == 1 and (BotOutcutExistsFlag == 1 and OutcutCenterlineBasementFlag == 1):
        f.write(
            'IF[#1000EQ0]THEN #5261=-[#5221-#901001]+#901001+' + centerlineACDif + '\n'
            'IF[#1000EQ1]THEN #5261=-[#5221-#901005]+#901005+' + centerlineACDif + '\n'
            '(' + workCoordinateTopOut + ': Top Outcut center)\n'
            '\n'
        )

    # Origin Setting Top outer Y Measurement
    if TopOutcutExistsFlag == 0:
        f.write(
            'G90 ' + workCoordinateTopOut + ' G01 X0 Y0 F#652\n'
            'G43 ' + f"H{toolIDTouchSensor:02d}" + ' (tool length correction ' + f"#{toolIDTouchSensor:02d}" + ')\n'
            '(' + workCoordinateTopOut + ' XY Top outside center)\n'
            '\n'

            '' + workCoordinateTopOut + ' G65 P' + prgOutsideCenterY + ' Y' + BDOD + ' Z' + topReAlocationLength + '\n'
            '(' + workCoordinateTopOut + ': Top Y Outside center)\n'
            '(Y: BD OD)\n'
            '(Z: Top re_alocation)\n'
            '\n'
        )

    # Origin Setting Top inner X Measurement
    f.write(
        'G90 ' + workCoordinateTopIn + ' G01 X0 Y0 F#652\n'
        'G43 ' + f"H{toolIDTouchSensor:02d}" + ' (tool length correction ' + f"#{toolIDTouchSensor:02d}" + ')\n'
        '(' + workCoordinateTopIn + ' XY Top inside center)\n'
        '\n'

        '' + workCoordinateTopIn + ' G65 P' + prgInsideCenterX + ' X' + topACID + ' Z' + topReAlocationLength + ' W' + topAlocationLength + ' R' + centralCurvature + ' M' + mekkiThickness + '\n'
        '(' + workCoordinateTopIn + ': Top X Inside center)\n'
        '(X: Top AC ID)\n'
        '(Z: Top re_alocation)\n'
        '(W: Top alocation)\n'
        '(R: central curvature)\n'
        '(M: mekki thickness mm)\n'
        '\n'
    )

    # Origin Setting Top inner Y Measurement
    f.write(
        'G90 ' + workCoordinateTopIn + ' G01 X0 Y0 F#652\n'
        'G43 ' + f"H{toolIDTouchSensor:02d}" + ' (tool length correction ' + f"#{toolIDTouchSensor:02d}" + ')\n'
        '(' + workCoordinateTopIn + ' XY Top inside center)\n'
        '\n'

        '' + workCoordinateTopIn + ' G65 P' + prgInsideCenterY + ' Y' + topBDID+ ' J' + BDOD + ' Z' + topReAlocationLength + ' M' + mekkiThickness + '\n'
        '(' + workCoordinateTopIn + ': Top Y inside center)\n'
        '(Y: Top BD ID)\n'
        '(J: BD OD)\n'
        '(Z: Top re_alocation)\n'
        '(M: mekki thickness mm)\n'
        '\n'
    )

    if TopOutcutExistsFlag == 1:
        f.write(
            '#5262=#5282\n'
            '(' + workCoordinateTopOut + 'Y = ' + workCoordinateTopIn + 'Y)\n'
            '\n'
        )

    # Origin Setting Keyway X Measurement
    if TopOutcutExistsFlag == 0:
        if KeywayAsideDepthToleranceExitsFlag == 1:
            f.write(
                'G90 ' + workCoordinateKeyway + ' G01 X0 Y0 F#652\n'
                'G43 ' + f"H{toolIDTouchSensor:02d}" + ' (tool length correction ' + f"#{toolIDTouchSensor:02d}" + ')\n'
                '(' + workCoordinateKeyway + ' XY keyway center)\n'
                '\n'

                '' + workCoordinateKeyway + ' G65 P' + prgKeywayCenterX + ' X' + keywayACOD + ' U' + ACOD + ' Z' + topReAlocationLength + ' M' + keywayPos + ' H' + keywayWidth + ' I' + keywayAsideDepth + '\n'
                '(' + workCoordinateKeyway + ': Keyway X center)\n'
                '(X: keyway AC OD)\n'
                '(U: AC OD)\n'
                '(Z: Top re_alocation)\n'
                '(M: keyway position)\n'
                '(H: keyway depth)\n'
                '(I: A-side keyway depth)\n'
                '\n'
            )

    # Origin Setting Keyway Y Measurement
    if TopOutcutExistsFlag == 0:
        f.write(
            'G90 ' + workCoordinateKeyway + ' G01 X0 Y0 F#652\n'
            'G43 ' + f"H{toolIDTouchSensor:02d}" + ' (tool length correction ' + f"#{toolIDTouchSensor:02d}" + ')\n'
            '(' + workCoordinateKeyway + ' XY keyway center)\n'
            '\n'

            '' + workCoordinateKeyway + ' G65 P' + prgOutsideCenterY + ' Y' + BDOD + ' Z' + topReAlocationLength + ' M' + keywayPos + ' H' + keywayWidth + '\n'
            '(' + workCoordinateKeyway + ': Keyway Y center)\n'
            '(Y: BD OD)\n'
            '(Z: Top re_alocation)\n'
            '(M: keyway position)\n'
            '(H: keyway depth)\n'
            '\n'
        )

    if TopOutcutExistsFlag == 1:
        f.write(
            '#5301=#5261\n'
            '(' + workCoordinateKeyway + 'X = ' + workCoordinateTopOut + 'X)\n'
            '\n'
        )

    if TopOutcutExistsFlag == 1:
        f.write(
            '#5302=#5262\n'
            '(' + workCoordinateKeyway + 'Y = ' + workCoordinateTopOut + 'Y)\n'
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
            'G40 G80 (cancel correction)\n'
            'S35 (low gear)\n'
            'M19 (Spindle orientation)\n'
            'G43 ' + f"H{toolIDTouchSensor:02d}" + ' (tool length correction ' + f"#{toolIDTouchSensor:02d}" + ')\n'
            '\n'
        )

        SN_dimple_Me = next(SN_dimple_measurement)
        SN_dimple_Me_before_rotate = SN_dimple_Me + 1
        f.write(
            f"N{SN_dimple_Me:04d}\n"
            '' + workCoordinateTopIn + '\n'
            'IF[#5004EQ[' + topSideParallelAngle + ']]' + f"GOTO{SN_dimple_Me_before_rotate:04d}" + '\n'
            'M11 (B-axis unclamp)\n'
            'G90 ' + workCoordinateTopIn + ' G00 B' + topSideParallelAngle + '\n'
            'M10 (B-axis clamp)\n'
            '(' + workCoordinateTopIn + ' B parallel angle ' + topSideParallelAngle + ')\n'
            '\n'
        )

        SN_dimple_Me = next(SN_dimple_measurement)
        f.write(
            f"N{SN_dimple_Me:04d}\n"
            'G90 ' + workCoordinateTopIn + ' G01 X0 Y0 F#652\n'
            'G90 ' + workCoordinateTopIn + ' G01 Z[' + topReAlocationLength + '+#600] F#652\n'
            '(' + workCoordinateTopIn + 'XY Top Inside Center)\n'
            '(Z= TopReAlocation +#600)\n'
            '\n'
        )

        f.write(
            '' + workCoordinateTopIn + ' G65 P' + prgDimpleOne + ' T' + mekkiThickness + ' Z' + topReAlocationLength + ' W' + topAlocationLength + ' F' + dimpleFirstRowLength + ' S' + dimpleSecondRowLength + ' Q' + dimpleFirstRowDistanceFromEndface + ' I' + dimpleHorizontalPitch + ' K' + dimpleVerticalPitch + ' M' + dimpleRowNum + ' U' + dimpleDepth + ' R' + centralCurvature + ' A' + topSideParallelAngle + ' B' + dimpleAngle + '\n'
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
            'G49 G40 (cancel correction)\n'
            'G90 G53 G01 Z0 F#650\n'
            '\n'
        )

        SN_D_tool_exchange = SN_dimple_Mi + 1
        SN_D_tool_correction = SN_dimple_Mi + 2
        f.write(
            'IF[#4120EQ31]' + f"GOTO{SN_D_tool_correction:04d}\n"
            'IF[#4120NE50]' + f"GOTO{SN_D_tool_exchange:04d}\n"
            'G90 G53 G01 X-5.501 Y-258.624 F#652\n'
            '\n'
        )

        SN_dimple_Mi = next(SN_dimple_milling)
        f.write(
            f"N{SN_dimple_Mi:04d}\n"
            f"T{toolIDTslot[dimpleSmallRadius]:02d}" + ' (Tslot R' + dimpleSmallRadius + ')\n'
            'M06 (tool exchange)\n'
            '\n'
        )

        SN_dimple_Mi = next(SN_dimple_milling)
        f.write(
            f"N{SN_dimple_Mi:04d}\n"
            'G43 H#4120 (tool length correction: T#)\n'
            '\n'
        )

        SN_dimple_Mi = next(SN_dimple_milling)
        SN_D_approach = SN_dimple_Mi + 1
        f.write(
            f"N{SN_dimple_Mi:04d}\n"
            'IF[#5004EQ[' + topSideParallelAngle + dimpleAngle + ']]' + f"GOTO{SN_D_approach:04d}\n"
            'M11 (B-axis unclamp)\n'
            'G90 ' + workCoordinateTopIn + ' G00 B' + topSideParallelAngle + '\n'
            'M10 (B-axis clamp)\n'
            '(' + workCoordinateTopIn + ' B parallel angle ' + topSideParallelAngle + ')\n'
            '\n'
        )

        SN_dimple_Mi = next(SN_dimple_milling)
        f.write(
            f"N{SN_dimple_Mi:04d}\n"
            'G90 ' + workCoordinateTopIn + ' G00 X0 Y0\n'
            'G90 ' + workCoordinateTopIn + ' Z[' + topReAlocationLength + '+#600] F#650\n'
            '(' + workCoordinateTopIn + 'XY Top Inside Center)\n'
            '(Z= TopReAlocation +#600)\n'
            '\n'
        )

        SN_dimple_Mi = next(SN_dimple_milling)
        f.write(
            f"N{SN_dimple_Mi:04d}\n"
            '' + workCoordinateTopIn + ' G65 P' + prgDimpleOne + ' T' + mekkiThickness + ' Z' + topReAlocationLength + ' W' + topAlocationLength + ' F' + dimpleFirstRowLength + ' S' + dimpleSecondRowLength + ' Q' + dimpleFirstRowDistanceFromEndface + ' I' + dimpleHorizontalPitch + ' K' + dimpleVerticalPitch + ' M' + dimpleRowNum + ' U' + dimpleDepth + ' R' + centralCurvature + ' A' + topSideParallelAngle + ' B' + dimpleAngle + '\n'
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

    # Top endface milling
    f.write(
        '\n'
        f"N{SN_top_EF:04d}\n"
        '(*** Top Tanmen start ***)\n'
        '\n'
        '\n'
    )

    f.write(
        'G49 G40 (cancel correction)\n'
        'G90 G53 G01 Z0 F#650\n'
        f"T{toolIDFacemill:02d}" + ' (Endface)\n'
        'M06 (tool exchange)\n'
        'G43 H#4120 (tool length correction: T#)\n'
        '\n'
    )

    SN_top_EF = next(SN_top_endface)
    SN_top_endface_setting = SN_top_EF + 1
    f.write(
        f"N{SN_top_EF:04d}\n"
        '' + workCoordinateTopIn + '\n'
        'IF[#5004EQ[' + topSideParallelAngle + ']]' + f"GOTO{SN_top_endface_setting:04d}\n"
        'M11 (B-axis unclamp)\n'
        'G90 ' + workCoordinateTopIn + ' G00 B' + topSideParallelAngle + '\n'
        'M10 (B-axis clamp)\n'
        '(' + workCoordinateTopIn + ' B parallel angle ' + topSideParallelAngle + ')\n'
        '\n'
    )

    SN_top_EF = next(SN_top_endface)
    f.write(
        f"N{SN_top_EF:04d}\n"
        'M28 (chip conveyor on)\n'
        '' + workCoordinateTopIn + ' G65 P' + prgEndface + ' Z' + topReAlocationLength + ' R' + topInsideCornerR + '\n'
        '(O' + prgEndface + ': XY ID outside-#608 Coner R, ar MigiMawari)\n'
        '(Z: Top re_alocation)\n'
        '(R: Top inside corner R)\n'
        '\n'
    )

    SN_top_EF_pause = SN_top_EF + 1
    SN_top_EF_pause_check = SN_top_EF_pause + 1
    SN_top_EF_end = SN_top_EF_pause_check + 1
    f.write(
        '(pause and check)\n'
        'IF[#179EQ0]' + f"GOTO{SN_top_EF_pause:04d}\n"
        'IF[#179EQ2]' + f"GOTO{SN_top_EF_pause_check:04d}\n"
    )
    if TopOutcutExistsFlag == 1 or EndfaceBoringExistsFlag == 1 or IncutBoringExistsFlag == 1:
        f.write(
            f"GOTO{SN_top_EF_end:04d}\n"
        )
    elif TopOutcutExistsFlag == 0 and EndfaceBoringExistsFlag == 0 and IncutBoringExistsFlag == 0:
        f.write(
            f"GOTO{SN_top_EF_end:04d}\n"
        )
    f.write(
        '\n'
    )

    SN_top_EF = next(SN_top_endface)
    f.write(
        f"N{SN_top_EF:04d}\n"
        'M00 (if #179=0)\n'
    )
    if TopOutcutExistsFlag == 1 or EndfaceBoringExistsFlag == 1 or IncutBoringExistsFlag == 1:
        f.write(
            f"GOTO{SN_top_EF_end:04d}\n"
        )
    elif TopOutcutExistsFlag == 0 and EndfaceBoringExistsFlag == 0 and IncutBoringExistsFlag == 0:
        f.write(
            f"GOTO{SN_top_EF_end:04d}\n"
        )
    f.write(
        '\n'
    )

    SN_top_EF = next(SN_top_endface)
    f.write(
        f"N{SN_top_EF:04d}\n"
        'G65 P' + prgPauseCheck + ' (if #179=2)\n'
    )
    if TopOutcutExistsFlag == 1 or EndfaceBoringExistsFlag == 1 or IncutBoringExistsFlag == 1:
        f.write(
            f"N{SN_top_EF_end:04d} (Top endface end)\n"
        )
    elif TopOutcutExistsFlag == 0 and EndfaceBoringExistsFlag == 0 and IncutBoringExistsFlag == 0:
        f.write(
            f"N{SN_top_EF_end:04d} (Top endface end)\n"
        )
    f.write(
        '\n'
    )

    if TopOutcutExistsFlag == 1:
        # Top outcut milling
        f.write(
            '\n'
            f"N{SN_top_OC:04d}\n"
            '(*** Top Gaisaku start ***)\n'
            '\n'
            '\n'
        )

        f.write(
            'G49 G40 (cancel correction)\n'
            'G90 G53 G01 Z0 F#650\n'
            f"T{toolIDSquareendmill:02d}" + ' (outcut)\n'
            'M06 (tool exchange)\n'
            'G43 H#4120 (tool length correction: T#)\n'
            '\n'
        )

        SN_top_OC = next(SN_top_outcut)
        SN_top_outcut_setting = SN_top_OC + 1
        f.write(
            f"N{SN_top_OC:04d}\n"
            '' + workCoordinateTopOut + '\n'
            'IF[#5004EQ[' + topSideParallelAngle + ']]' + f"GOTO{SN_top_outcut_setting:04d}\n"
            'M11 (B-axis unclamp)\n'
            'G90 ' + workCoordinateTopOut + ' G00 B' + topSideParallelAngle + '\n'
            'M10 (B-axis clamp)\n'
            '(' + workCoordinateTopOut + ' B parallel angle ' + topSideParallelAngle + ')\n'
            '\n'
        )

        SN_top_OC = next(SN_top_outcut)
        f.write(
            f"N{SN_top_OC:04d}\n"
            'M28 (chip conveyor on)\n'
            '' + workCoordinateTopOut + ' G65 P' + prgOutcut + ' X' + topOutcutACOD + ' Y' + topOutcutBDOD + ' U' + ACOD + ' V' + BDOD + ' Z' + topReAlocationLength + ' R' + topOutcutCornerR + ' K' + topOutcutLength + ' M' + keywayPos + ' W' + keywayWidth + '\n'
            '(O' + prgOutcut + ': Outcut Corner R, ar left)\n'
            '(default: M=0, W=0)\n'
            '(X: Top outcut AC OD)\n'
            '(Y: Top outcut BD OD)\n'
            '(U: AC OD)\n'
            '(V: BD OD)\n'
            '(Z: Top re_alocation)\n'
            '(R: Top outcut corner R)\n'
            '(K: Top outcut length)\n'
            '(M*: keyway position)\n'
            '(W*: keyway width)\n'
            '\n'
        )

        SN_top_OC_pause = SN_top_OC + 1
        SN_top_OC_pause_check = SN_top_OC_pause + 1
        SN_top_OC_end = SN_top_OC_pause_check + 1
        f.write(
            '(pause and check)\n'
            'IF[#417EQ0]' + f"GOTO{SN_top_OC_pause:04d}\n"
            'IF[#417EQ2]' + f"GOTO{SN_top_OC_pause_check:04d}\n"
            f"GOTO{SN_top_OC_end:04d}\n"
            '\n'
        )

        SN_top_OC = next(SN_top_outcut)
        f.write(
            f"N{SN_top_OC:04d}\n"
            'M00 (if #417=0)\n'
            f"GOTO{SN_top_OC_end:04d}\n"
            '\n'
        )

        SN_top_OC = next(SN_top_outcut)
        f.write(
            f"N{SN_top_OC:04d}\n"
            'G65 P' + prgPauseCheck + ' (if #417=2)\n'
            f"N{SN_top_OC_end:04d} (Top outcut end)\n"
            '\n'
        )

    if EndfaceBoringExistsFlag == 1:
        # Endface boring milling
        f.write(
            '\n'
            f"N{SN_EBoring:04d}\n"
            '(*** Zaguri start ***)\n'
            '\n'
            '\n'
        )

        f.write(
            'G49 G40 (cancel correction)\n'
            'G90 G53 G01 Z0 F#650\n'
            f"T{toolIDSquareendmill:02d}" + ' (endface boring)\n'
            'M06 (tool exchange)\n'
            'G43 H#4120 (tool length correction: T#)\n'
            '\n'
        )

        SN_EBoring = next(SN_Endface_Boring)
        SN_endface_boring_setting = SN_EBoring + 1
        f.write(
            f"N{SN_EBoring:04d}\n"
            '' + workCoordinateTopOut + '\n'
            'IF[#5004EQ[' + topSideParallelAngle + ']]' + f"GOTO{SN_endface_boring_setting:04d}\n"
            'M11 (B-axis unclamp)\n'
            'G90 ' + workCoordinateTopOut + ' G00 B' + topSideParallelAngle + '\n'
            'M10 (B-axis clamp)\n'
            '(' + workCoordinateTopOut + ' B parallel angle ' + topSideParallelAngle + ')\n'
            '\n'
        )

        SN_EBoring = next(SN_Endface_Boring)
        f.write(
            f"N{SN_EBoring:04d}\n"
            'M28 (chip conveyor on)\n'
            '' + workCoordinateTopOut + ' G65 P' + prgEndFaceBoring + ' I' + EnfaceBoringDistanceFromA + ' U' + EnfaceBoringWidth + ' V' + EnfaceBoringDepth + ' W' + EnfaceBoringLength + ' R' + EnfaceBoringCornerR + ' Z' + topReAlocationLength + '\n'
            '(O' + prgEndFaceBoring + ': Endface Boring, r left)\n'
            '(I: distance from A-face)\n'
            '(U: endface boring width)\n'
            '(V: endface boring depth)\n'
            '(W: endface boring length)\n'
            '(R: endface boring corner R)\n'
            '(Z: Top re_alocation)\n'
            '\n'
        )

        SN_endface_boring_pause = SN_EBoring + 1
        SN_endface_boring_pause_check = SN_endface_boring_pause + 1
        SN_endface_boring_end = SN_endface_boring_pause_check + 1
        f.write(
            '(pause and check)\n'
            'IF[#482EQ0]' + f"GOTO{SN_endface_boring_pause:04d}\n"
            'IF[#482EQ2]' + f"GOTO{SN_endface_boring_pause_check:04d}\n"
            f"GOTO{SN_endface_boring_end:04d}\n"
            '\n'
        )

        SN_EBoring = next(SN_Endface_Boring)
        f.write(
            f"N{SN_EBoring:04d}\n"
            'M00 (if #482=0)\n'
            f"GOTO{SN_endface_boring_end:04d}\n"
            '\n'
        )

        SN_EBoring = next(SN_Endface_Boring)
        f.write(
            f"N{SN_EBoring:04d}\n"
            'G65 P' + prgPauseCheck + ' (if #482=2)\n'
            f"N{SN_endface_boring_end:04d} (Endface Boring end)\n"
            '\n'
        )

    # Keyway milling
    f.write(
        '\n'
        f"N{SN_KW:04d}\n"
        '(*** Mizo start ***)\n'
        '\n'
        '\n'
    )

    f.write(
        'G49 G40 (cancel correction)\n'
        'G90 G53 G01 Z0 F#650\n'
        f"T{toolIDSidecutter:02d}" + ' (keyway)\n'
        'M06 (tool exchange)\n'
        'G43 H#4120 (tool length correction: T#)\n'
        '\n'
    )

    SN_KW = next(SN_keyway)
    SN_keyway_setting = SN_KW + 1
    f.write(
        f"N{SN_KW:04d}\n"
        '' + workCoordinateKeyway + '\n'
        'IF[#5004EQ[' + topSideParallelAngle + ']]' + f"GOTO{SN_keyway_setting:04d}\n"
        'M11 (B-axis unclamp)\n'
        'G90 ' + workCoordinateKeyway + ' G00 B' + topSideParallelAngle + '\n'
        'M10 (B-axis clamp)\n'
        '(' + workCoordinateKeyway + ' B parallel angle ' + topSideParallelAngle + ')\n'
        '\n'
    )

    SN_KW = next(SN_keyway)
    f.write(
        f"N{SN_KW:04d}\n"
        'M28 (chip conveyor on)\n'
        '' + workCoordinateKeyway + ' G65 P' + prgKeyway + ' A' + topOutcutExists + ' B' + keywayAsideDepthToleranceExists + ' K' + keywayType + ' C' + keywayCornerC + ' R' + keywayCornerR + ' X' + keywayACOD + ' Y' + keywayBDOD + ' U' + keywayOutsideACOD + ' V' + keywayOutsideBDOD + ' Z' + topReAlocationLength + ' W' + topAlocationLength + ' Q' + centralCurvature + ' M' + keywayPos + ' H' + keywayWidth + '\n'
        '(O' + prgKeyway + ': Keyway, ar left)\n'
        '(A: Top outcut: 0:none, 1:exists)\n'
        '(B: depth tolerance: 0:none, 1:exists)\n'
        '(K: key type: 1:R, 2:C, 3:rec, 4:BDonly, 5:oct R)\n'
        '(C: keyway corner C)\n'
        '(R: keyway corner R)\n'
        '(X: keyway AC OD)\n'
        '(Y: keyway BD OD)\n'
        '(U: AC OD)\n'
        '(V: BD OD)\n'
        '(Z: Top re_alocation)\n'
        '(W: Top alocation)\n'
        '(Q: central curvature)\n'
        '(M: keyway position)\n'
        '(H: keyway width)\n'
        '\n'
    )

    SN_top_keyway_pause = SN_KW + 1
    SN_top_keyway_pause_check = SN_top_keyway_pause + 1
    SN_top_keyway_end = SN_top_keyway_pause_check + 1
    f.write(
        '(pause and check)\n'
        'IF[#424EQ0]' + f"GOTO{SN_top_keyway_pause:04d}\n"
        'IF[#424EQ2]' + f"GOTO{SN_top_keyway_pause_check:04d}\n"
        f"GOTO{SN_top_keyway_end:04d}\n"
        '\n'
    )

    SN_KW = next(SN_keyway)
    f.write(
        f"N{SN_KW:04d}\n"
        'M00 (if #424=0)\n'
        f"GOTO{SN_top_keyway_end:04d}\n"
        '\n'
    )

    SN_KW = next(SN_keyway)
    f.write(
        f"N{SN_KW:04d}\n"
        'G65 P' + prgPauseCheck + ' (if #424=2)\n'
        f"N{SN_top_keyway_end:04d} (keyway end)\n"
        '\n'
    )

    # Top endface outer chamfer milling
    f.write(
        '\n'
        f"N{SN_top_OCh:04d}\n"
        '(*** Top SotoMentori start ***)\n'
        '\n'
        '\n'
    )

    f.write(
        'G49 G40 (cancel correction)\n'
        'G90 G53 G01 Z0 F#650\n'
        f"T{toolIDTaperendmill[topOutChamferAngle]:02d}" + ' (chamfer ' + topOutChamferAngle + ')\n'
        'M06 (tool exchange)\n'
        'G43 H#4120 (tool length correction: T#)\n'
        '\n'
    )

    SN_top_OCh = next(SN_top_out_chamfer)
    SN_top_OCh_setting = SN_top_OCh + 1
    f.write(
        f"N{SN_top_OCh:04d}\n"
        '' + workCoordinateTopOut + '\n'
        'IF[#5004EQ[' + topSideParallelAngle + ']]' + f"GOTO{SN_top_OCh_setting:04d}\n"
        'M11 (B-axis unclamp)\n'
        'G90 ' + workCoordinateTopOut + ' G00 B' + topSideParallelAngle + '\n'
        'M10 (B-axis clamp)\n'
        '(' + workCoordinateTopOut + ' B parallel angle ' + topSideParallelAngle + ')\n'
        '\n'
    )

    SN_top_OCh = next(SN_top_out_chamfer)
    f.write(
        f"N{SN_top_OCh:04d}\n"
        'M28 (chip conveyor on)\n'
        '' + workCoordinateTopOut + ' G65 P' + prgOutChamfer + ' A' + topOutcutExists + ' B' + topOutChamferType + ' X' + topOutcutACOD + ' Y' + topOutcutBDOD + ' Z' + topReAlocationLength + ' W' + topAlocationLength + ' Q' + centralCurvature + ' K' + topOutChamferLength + ' R' + topOutChamferCornerR + '\n'
        '(O' + prgOutChamfer + ': Outside Chamfer Corner R, ar left)\n'
        '(A: Top outcut: 0:none, 1:exists)\n'
        '(B: chamfer type: 0:C, 1:R)\n'
        '(X*: Top outcut AC OD)\n'
        '(Y*: Top outcut BD OD)\n'
        '(Z: Top re_alocation)\n'
        '(W: Top alocation)\n'
        '(Q: central curvature)\n'
        '(K: Top outside chamfer C or R length)\n'
        '(R: Top outside corner R)\n'
        '\n'
    )

    SN_top_OCh_pause = SN_top_OCh + 1
    SN_top_OCh_pause_check = SN_top_OCh_pause + 1
    SN_top_OCh_end = SN_top_OCh_pause_check + 1
    f.write(
        '(pause and check)\n'
        'IF[#428EQ0]' + f"GOTO{SN_top_OCh_pause:04d}\n"
        'IF[#428EQ2]' + f"GOTO{SN_top_OCh_pause_check:04d}\n"
        f"GOTO{SN_top_OCh_end:04d}\n"
        '\n'
    )

    SN_top_OCh = next(SN_top_out_chamfer)
    f.write(
        f"N{SN_top_OCh:04d}\n"
        'M00 (if #428=0)\n'
        f"GOTO{SN_top_OCh_end:04d}\n"
        '\n'
    )

    SN_top_OCh = next(SN_top_out_chamfer)
    f.write(
        f"N{SN_top_OCh:04d}\n"
        'G65 P' + prgPauseCheck + ' (if #428=2)\n'
        f"N{SN_top_OCh_end:04d} (top outside chamfer end)\n"
        '\n'
    )

    # Top endface inner chamfer milling
    f.write(
        '\n'
        f"N{SN_top_ICh:04d}\n"
        '(*** Top UchiMentori start ***)\n'
        '\n'
        '\n'
    )

    f.write(
        'G49 G40 (cancel correction)\n'
        'G90 G53 G01 Z0 F#650\n'
        '\n'
    )

    SN_top_ICh = next(SN_top_in_chamfer)
    SN_top_ICh_correction = SN_top_ICh + 1
    f.write(
        f"N{SN_top_ICh:04d}\n"
        'IF[#4120EQ' + f"{toolIDTaperendmill[topInChamferAngle]}" ']' + f"GOTO{SN_top_ICh_correction:04d}\n"
        f"T{toolIDTaperendmill[topOutChamferAngle]:02d}" + ' (chamfer ' + topOutChamferAngle + ')\n'
        'M06 (tool exchange)\n'
        '\n'
    )

    SN_top_ICh = next(SN_top_in_chamfer)
    f.write(
        f"N{SN_top_ICh:04d}\n"
        'G43 H#4120 (tool length correction: T#)\n'
        '\n'
    )

    SN_top_ICh = next(SN_top_in_chamfer)
    SN_top_ICh_setting = SN_top_ICh + 1
    f.write(
        f"N{SN_top_ICh:04d}\n"
        '' + workCoordinateTopIn + '\n'
        'IF[#5004EQ[' + topSideParallelAngle + ']]' + f"GOTO{SN_top_ICh_setting:04d}\n"
        'M11 (B-axis unclamp)\n'
        'G90 ' + workCoordinateTopIn + ' G00 B' + topSideParallelAngle + '\n'
        'M10 (B-axis clamp)\n'
        '(' + workCoordinateTopIn + ' B parallel angle ' + topSideParallelAngle + ')\n'
        '\n'
    )

    SN_top_ICh = next(SN_top_in_chamfer)
    f.write(
        f"N{SN_top_ICh:04d}\n"
        'M28 (chip conveyor on)\n'
        '' + workCoordinateTopIn + ' G65 P' + prgInChamfer + ' A' + IncutExists + ' B' + topInChamferType + ' X' + IncutACOD + ' Y' + IncutBDOD + ' Z' + topReAlocationLength + ' W' + topAlocationLength + ' Q' + centralCurvature + ' K' + topInChamferLength + ' R' + topInChamferCornerR + ' M' + mekkiThickness + '\n'
        '(O' + prgInChamfer + ': Inside Chamfer Corner R, ar left)\n'
        '(A: incut: 0:none, 1:exists)\n'
        '(B: chamfer type: 0:C, 1:R)\n'
        '(X*: incut AC OD)\n'
        '(Y*: incut BD OD)\n'
        '(Z: Top re_alocation)\n'
        '(W: Top alocation)\n'
        '(Q: central curvature)\n'
        '(K: Top inside chamfer C or R length)\n'
        '(R: Top inside corner R)\n'
        '(M: mekki thickness mm)\n'
        '\n'
    )

    SN_top_ICh_pause = SN_top_ICh + 1
    SN_top_ICh_pause_check = SN_top_ICh_pause + 1
    SN_top_ICh_end = SN_top_ICh_pause_check + 1
    f.write(
        '(pause and check)\n'
        'IF[#433EQ0]' + f"GOTO{SN_top_ICh_pause:04d}\n"
        'IF[#433EQ2]' + f"GOTO{SN_top_ICh_pause_check:04d}\n"
        f"GOTO{SN_top_ICh_end:04d}\n"
        '\n'
    )

    SN_top_ICh = next(SN_top_in_chamfer)
    f.write(
        f"N{SN_top_ICh:04d}\n"
        'M00 (if #433=0)\n'
        f"GOTO{SN_top_ICh_end:04d}\n"
        '\n'
    )

    SN_top_ICh = next(SN_top_in_chamfer)
    f.write(
        f"N{SN_top_ICh:04d}\n"
        'G65 P' + prgPauseCheck + ' (if #433=2)\n'
        f"N{SN_top_ICh_end:04d} (top inside chamfer end)\n"
        '\n'
    )

    # Bottom endface milling
    f.write(
        '\n'
        f"N{SN_bot_EF:04d}\n"
        '(*** Bottom Tanmen start ***)\n'
        '\n'
        '\n'
    )

    f.write(
        'G49 G40 (cancel correction)\n'
        'G90 G53 G01 Z0 F#650\n'
        f"T{toolIDFacemill:02d}" + ' (Endface)\n'
        'M06 (tool exchange)\n'
        'G43 H#4120 (tool length correction: T#)\n'
        '\n'
    )

    SN_bot_EF = next(SN_bot_endface)
    SN_bot_endface_setting = SN_bot_EF + 1
    f.write(
        f"N{SN_bot_EF:04d}\n"
        '' + workCoordinateBotIn + '\n'
        'IF[#5004EQ[' + botSideParallelAngle + ']]' + f"GOTO{SN_bot_endface_setting:04d}\n"
        'M11 (B-axis unclamp)\n'
        'G90 ' + workCoordinateBotIn + ' G00 B' + botSideParallelAngle + '\n'
        'M10 (B-axis clamp)\n'
        '(' + workCoordinateBotIn + ' B parallel angle ' + botSideParallelAngle + ')\n'
        '\n'
    )

    SN_bot_EF = next(SN_bot_endface)
    f.write(
        f"N{SN_bot_EF:04d}\n"
        'M28 (chip conveyor on)\n'
        '' + workCoordinateBotIn + ' G65 P' + prgEndface + ' Z' + botReAlocationLength + ' R' + botInsideCornerR + '\n'
        '(O' + prgEndface + ': XY ID outside-#608 Corner R, ar MigiMawari)\n'
        '(Z: Bot re_alocation)\n'
        '(R: Bot inside corner R)\n'
        '\n'
    )

    SN_bot_EF_pause = SN_bot_EF + 1
    SN_bot_EF_pause_check = SN_bot_EF_pause + 1
    SN_bot_EF_end = SN_bot_EF_pause_check + 1
    f.write(
        '(pause and check)\n'
        'IF[#180EQ0]' + f"GOTO{SN_bot_EF_pause:04d}\n"
        'IF[#180EQ2]' + f"GOTO{SN_bot_EF_pause_check:04d}\n"
    )
    if BotOutcutExistsFlag == 1:
        f.write(
            f"GOTO{SN_bot_EF_end:04d}\n"
        )
    elif BotOutcutExistsFlag == 0:
        f.write(
            f"GOTO{SN_bot_EF_end:04d}\n"
        )
    f.write(
        '\n'
    )

    SN_bot_EF = next(SN_bot_endface)
    f.write(
        f"N{SN_bot_EF:04d}\n"
        'M00 (if #180=0)\n'
    )
    if BotOutcutExistsFlag == 1:
        f.write(
            f"GOTO{SN_bot_EF_end:04d}\n"
        )
    elif BotOutcutExistsFlag == 0:
        f.write(
            f"GOTO{SN_bot_EF_end:04d}\n"
        )
    f.write(
        '\n'
    )

    SN_bot_EF = next(SN_bot_endface)
    f.write(
        f"N{SN_bot_EF:04d}\n"
        'G65 P' + prgPauseCheck + ' (if #180=2)\n'
    )
    if BotOutcutExistsFlag == 1:
        f.write(
            f"N{SN_bot_EF_end:04d} (Bot endface end)\n"
        )
    elif BotOutcutExistsFlag == 0:
        f.write(
            f"N{SN_bot_EF_end:04d} (Bot endface end)\n"
        )
    f.write(
        '\n'
    )

    if BotOutcutExistsFlag == 1:
        # Botoom outcut milling
        f.write(
            '\n'
            f"N{SN_bot_OC:04d}\n"
            '(*** Bottom Gaisaku start ***)\n'
            '\n'
            '\n'
        )

        f.write(
            'G49 G40 (cancel correction)\n'
            'G90 G53 G01 Z0 F#650\n'
            f"T{toolIDSquareendmill:02d}" + ' (outcut)\n'
            'M06 (tool exchange)\n'
            'G43 H#4120 (tool length correction: T#)\n'
            '\n'
        )

        SN_bot_OC = next(SN_bot_outcut)
        SN_bot_outcut_setting = SN_bot_OC + 1
        f.write(
            f"N{SN_bot_OC:04d}\n"
            '' + workCoordinateBotOut + '\n'
            'IF[#5004EQ[' + botSideParallelAngle + ']]' + f"GOTO{SN_bot_outcut_setting:04d}\n"
            'M11 (B-axis unclamp)\n'
            'G90 ' + workCoordinateBotOut + ' G00 B' + botSideParallelAngle + '\n'
            'M10 (B-axis clamp)\n'
            '(' + workCoordinateBotOut + ' B parallel angle ' + botSideParallelAngle + ')\n'
            '\n'
        )

        SN_bot_OC = next(SN_bot_outcut)
        if BotCurvedOutcutExistsFlag == 0:
            f.write(
                f"N{SN_bot_OC:04d}\n"
                'M28 (chip conveyor on)\n'
                '' + workCoordinateBotOut + ' G65 P' + prgOutcut + ' X' + botOutcutACOD + ' Y' + botOutcutBDOD + ' U' + ACOD + ' V' + BDOD + ' Z' + botReAlocationLength + ' R' + botOutcutCornerR + ' K' + botOutcutLength + ' M#0 W#0\n'
                '(O' + prgOutcut + ': Outside Corner R, ar left)\n'
                '(default: M=#0, W=#0)\n'
                '(X: Bot outcut AC OD)\n'
                '(Y: Bot outcut BD OD)\n'
                '(U: AC OD)\n'
                '(V: BD OD)\n'
                '(Z: Bot re_alocation)\n'
                '(R: Bot outcut corner R)\n'
                '(K: Bot outcut length)\n'
                '(M*: keyway position)\n'
                '(W*: keyway wiidth)\n'
                '\n'
            )

        if BotCurvedOutcutExistsFlag == 1:
            f.write(
                f"N{SN_bot_OC:04d}\n"
                'M28 (chip conveyor on)\n'
                '' + workCoordinateBotOut + ' G65 P' + prgCurvedOutcut + ' X' + botOutcutACOD + ' Y' + botOutcutBDOD + ' U' + ACOD + ' V' + BDOD + ' Z' + botReAlocationLength + ' Q' + centralCurvature + ' C#0 R' + botOutcutCornerR + ' K' + botOutcutLength + ' M#0 W#0\n'
                '(O' + prgOutcut + ': Outside Corner R, ar left)\n'
                '(default: M=#0, W=#0)\n'
                '(X: Bot outcut AC OD)\n'
                '(Y: Bot outcut BD OD)\n'
                '(U: AC OD)\n'
                '(V: BD OD)\n'
                '(Z: Bot re_alocation)\n'
                '(Q: central curvature)\n'
                '(C: Bot outcut corner C)\n'
                '(R: Bot outcut corner R)\n'
                '(K: Bot outcut length)\n'
                '(M*: keyway position)\n'
                '(W*: keyway wiidth)\n'
                '\n'
            )

        SN_bot_OC_pause = SN_bot_OC + 1
        SN_bot_OC_pause_check = SN_bot_OC_pause + 1
        SN_bot_OC_end = SN_bot_OC_pause_check + 1
        f.write(
            '(pause and check)\n'
            'IF[#439EQ0]' + f"GOTO{SN_bot_OC_pause:04d}\n"
            'IF[#439EQ2]' + f"GOTO{SN_bot_OC_pause_check:04d}\n"
            f"GOTO{SN_bot_OC_end:04d}\n"
            '\n'
        )

        SN_bot_OC = next(SN_bot_outcut)
        f.write(
            f"N{SN_bot_OC:04d}\n"
            'M00 (if #439=0)\n'
            f"GOTO{SN_bot_OC_end:04d}\n"
            '\n'
        )

        SN_bot_OC = next(SN_bot_outcut)
        f.write(
            f"N{SN_bot_OC:04d}\n"
            'G65 P' + prgPauseCheck + ' (if #439=2)\n'
            f"N{SN_bot_OC_end:04d} (Bot outcut end)\n"
            '\n'
        )

    # Bottom endface outer chamfer milling
    f.write(
        '\n'
        f"N{SN_bot_OCh:04d}\n"
        '(*** Bottom SotoMentori start ***)\n'
        '\n'
        '\n'
    )

    f.write(
        'G49 G40 (cancel correction)\n'
        'G90 G53 G01 Z0 F#650\n'
        f"T{toolIDTaperendmill[botOutChamferAngle]:02d}" + ' (chamfer ' + botOutChamferAngle + ')\n'
        'M06 (tool exchange)\n'
        'G43 H#4120 (tool length correction: T#)\n'
        '\n'
    )

    SN_bot_OCh = next(SN_bot_out_chamfer)
    SN_bot_OCh_setting = SN_bot_OCh + 1
    f.write(
        f"N{SN_bot_OCh:04d}\n"
        '' + workCoordinateBotOut + '\n'
        'IF[#5004EQ[' + botSideParallelAngle + ']]' + f"GOTO{SN_bot_OCh_setting:04d}\n"
        'M11 (B-axis unclamp)\n'
        'G90 ' + workCoordinateBotOut + ' G00 B' + botSideParallelAngle + '\n'
        'M10 (B-axis clamp)\n'
        '(' + workCoordinateBotOut + ' B parallel angle ' + botSideParallelAngle + ')\n'
        '\n'
    )

    SN_bot_OCh = next(SN_bot_out_chamfer)
    if BotCurvedOutcutExistsFlag != 1:
        f.write(
            f"N{SN_bot_OCh:04d}\n"
            'M28 (chip conveyor on)\n'
            '' + workCoordinateBotOut + ' G65 P' + prgOutChamfer + ' A' + botOutcutExists + ' B' + botOutChamferType + ' X' + botOutcutACOD + ' Y' + botOutcutBDOD + ' Z' + botReAlocationLength + ' W' + botAlocationLength + ' Q' + centralCurvature + ' K' + botOutChamferLength + ' R' + botOutChamferCornerR + '\n'
            '(O' + prgOutChamfer + ': Outside Chamfer Corner R, ar left)\n'
            '(A: Bot outcut: 0:none, 1:exists)\n'
            '(B: chamfer type: 0:C, 1:R)\n'
            '(X*: Bot outcut AC OD)\n'
            '(Y*: Bot outcut BD OD)\n'
            '(Z: Bot re_alocation)\n'
            '(W: Bot alocation)\n'
            '(Q: central curvature)\n'
            '(K: Bot outside chamfer C or R length)\n'
            '(R: Bot outside corner R)\n'
            '\n'
        )
    else:
        f.write(
            f"N{SN_bot_OCh:04d}\n"
            'M28 (chip conveyor on)\n'
            '' + workCoordinateBotOut + ' G65 P' + prgCurvedOutChamfer + ' B' + botOutChamferType + ' X' + botOutcutACOD + ' Y' + botOutcutBDOD + ' Z' + botReAlocationLength+ ' K' + botOutChamferLength + ' R' + botOutChamferCornerR + '\n'
            '(O' + prgCurvedOutChamfer + ': Outside Chamfer Corner R, ar left)\n'
            '(B: chamfer type: 0:C, 1:R)\n'
            '(X: Bot outcut AC OD)\n'
            '(Y: Bot outcut BD OD)\n'
            '(Z: Bot re_alocation)\n'
            '(K: Bot outside chamfer C or R length)\n'
            '(R: Bot outside corner R)\n'
            '\n'
        )

    SN_bot_OCh_pause = SN_bot_OCh + 1
    SN_bot_OCh_pause_check = SN_bot_OCh_pause + 1
    SN_bot_OCh_end = SN_bot_OCh_pause_check + 1
    f.write(
        '(pause and check)\n'
        'IF[#444EQ0]' + f"GOTO{SN_bot_OCh_pause:04d}\n"
        'IF[#444EQ2]' + f"GOTO{SN_bot_OCh_pause_check:04d}\n"
        f"GOTO{SN_bot_OCh_end:04d}\n"
        '\n'
    )

    SN_bot_OCh = next(SN_bot_out_chamfer)
    f.write(
        f"N{SN_bot_OCh:04d}\n"
        'M00 (if #444=0)\n'
        f"GOTO{SN_bot_OCh_end:04d}\n"
        '\n'
    )

    SN_bot_OCh = next(SN_bot_out_chamfer)
    f.write(
        f"N{SN_bot_OCh:04d}\n"
        'G65 P' + prgPauseCheck + ' (if #444=2)\n'
        f"N{SN_bot_OCh_end:04d} (Bot outside chamfer end)\n"
        '\n'
    )

    # Bottom endface inner chamfer milling
    f.write(
        '\n'
        f"N{SN_bot_ICh:04d}\n"
        '(*** Bottom UchiMentori start ***)\n'
        '\n'
        '\n'
    )

    f.write(
        'G49 G40 (cancel correction)\n'
        'G90 G53 G01 Z0 F#650\n'
        '\n'
    )

    SN_bot_ICh = next(SN_bot_in_chamfer)
    SN_bot_ICh_correction = SN_bot_ICh + 1
    f.write(
        f"N{SN_bot_ICh:04d}\n"
        'IF[#4120EQ' + f"{toolIDTaperendmill[botInChamferAngle]}" ']' + f"GOTO{SN_bot_ICh_correction:04d}\n"
        f"T{toolIDTaperendmill[botInChamferAngle]:02d}" + ' (chamfer ' + botInChamferAngle + ')\n'
        'M06 (tool exchange)\n'
        '\n'
    )

    SN_bot_ICh = next(SN_bot_in_chamfer)
    f.write(
        f"N{SN_bot_ICh:04d}\n"
        'G43 H#4120 (tool length correction: T#)\n'
        '\n'
    )

    SN_bot_ICh = next(SN_bot_in_chamfer)
    SN_bot_ICh_setting = SN_bot_ICh + 1
    f.write(
        f"N{SN_bot_ICh:04d}\n"
        '' + workCoordinateBotIn + '\n'
        'IF[#5004EQ[' + botSideParallelAngle + ']]' + f"GOTO{SN_bot_ICh_setting:04d}\n"
        'M11 (B-axis unclamp)\n'
        'G90 ' + workCoordinateBotIn + ' G00 B' + botSideParallelAngle + '\n'
        'M10 (B-axis clamp)\n'
        '(' + workCoordinateBotIn + ' B parallel angle ' + botSideParallelAngle + ')\n'
        '\n'
    )

    SN_bot_ICh = next(SN_bot_in_chamfer)
    f.write(
        f"N{SN_bot_ICh:04d}\n"
        'M28 (chip conveyor on)\n'
        '' + workCoordinateBotIn + ' G65 P' + prgInChamfer + ' B' + botInChamferType + ' Z' + botReAlocationLength + ' W' + botAlocationLength + ' Q' + centralCurvature + ' K' + botInChamferLength + ' R' + botInChamferCornerR + ' M' + mekkiThickness + '\n'
        '(O' + prgInChamfer + ': Inside Chamfer Corner R, ar left)\n'
        '(B: chamfer type: 0:C, 1:R)\n'
        '(Z: Bot re_alocation)\n'
        '(W: Bot alocation)\n'
        '(Q: central curvature)\n'
        '(K: Bot inside chamfer C or R length)\n'
        '(R: Bot inside corner R)\n'
        '(M: mekki thickness mm)\n'
        '\n'
    )

    SN_bot_ICh_pause = SN_bot_ICh + 1
    SN_bot_ICh_pause_check = SN_bot_ICh_pause + 1
    SN_bot_ICh_end = SN_bot_ICh_pause_check + 1
    f.write(
        '(pause and check)\n'
        'IF[#449EQ0]' + f"GOTO{SN_bot_ICh_pause:04d}\n"
        'IF[#449EQ2]' + f"GOTO{SN_bot_ICh_pause_check:04d}\n"
        f"GOTO{SN_bot_ICh_end:04d}\n"
        '\n'
    )

    SN_bot_ICh = next(SN_bot_in_chamfer)
    f.write(
        f"N{SN_bot_ICh:04d}\n"
        'M00 (if #449=0)\n'
        f"GOTO{SN_bot_ICh_end:04d}\n"
        '\n'
    )

    SN_bot_ICh = next(SN_bot_in_chamfer)
    f.write(
        f"N{SN_bot_ICh:04d}\n"
        'G65 P' + prgPauseCheck + ' (if #449=2)\n'
        f"N{SN_bot_ICh_end:04d} (Bot inside chamfer end)\n"
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
            'G49 G40 (cancel corrections)\n'
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
        'G49 G40 (cancel corrections)\n'
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
