# last update: 20240913
# Copyright 2023-2024 The individual creator, not held by any corporation.
# All rights reserved.

# ファイルの読込み
with open('./subscripts/load_values.py', 'r', encoding='utf-8') as file:
    load_values = file.read()
exec(load_values)

# ワーク座標系
workCoordinateBotOutNum = 54
workCoordinateBotInNum  = 55
workCoordinateTopOutNum = 56
workCoordinateTopInNum  = 57
workCoordinateKeywayNum = 58
workCoordinateBotOut = f"G{workCoordinateBotOutNum:.0f}"
workCoordinateBotIn  = f"G{workCoordinateBotInNum:.0f}"
workCoordinateTopOut = f"G{workCoordinateTopOutNum:.0f}"
workCoordinateTopIn  = f"G{workCoordinateTopInNum:.0f}"
workCoordinateKeyway = f"G{workCoordinateKeywayNum:.0f}"

# シーケンス番号用のカウンタ
SN_base               = count(1)
SN_origin_setting     = count(1000)
SN_dimple_measurement = count(2000)
SN_dimple_milling     = count(3000)
SN_top_endface        = count(4000)
if TopOutcutExistsFlag == 1 and EndfaceBoringExistsFlag == 0:
    SN_top_outcut     = count(4100)
elif TopOutcutExistsFlag == 0 and EndfaceBoringExistsFlag == 1:
    SN_Endface_Boring = count(4100)
SN_keyway             = count(4200)
SN_top_out_chamfer    = count(4300)
SN_top_in_chamfer     = count(4400)
SN_bot_endface        = count(5000)
SN_bot_outcut         = count(5100)
SN_bot_out_chamfer    = count(5300)
SN_bot_in_chamfer     = count(5400)
SN_centerline         = count(6500)
SN_alarmPallete       = count(8021)
SN_base_end           = count(9990)
SN_prg_end            = count(9999)

# R_i = R_c - w/2
CsideOutCurvature = centralCurvatureDim - ACODAve / 2
# R_o = R_c + w/2
AsideOutCurvature = centralCurvatureDim + ACODAve / 2

# \bar l = l -σ/2
ReceiverCentersDistance = jigOuterHalfWidth - ReceiverPlateWidth / 2
# R_i' = R_i - ρ
ReceiverCenter = CsideOutCurvature - ReceiverPlateRadius
# \sqrt{R_i'^2 - {\bar l}^2}
ReceiverCenterX = math.sqrt(ReceiverCenter ** 2 - ReceiverCentersDistance ** 2)

# 湾曲・テーブル両中心間距離 Δ'_x
TableCenterXFromCurvatureCenterX = ReceiverCenterX + BetweenTableJigCenters

# トップ端湾曲中心水平距離 \sqrt{R_c'^2 -f_T^2}
topCurvatureCenterX = math.sqrt(centralCurvatureDim ** 2 - topAlocationLengthAve ** 2)
# ボトム端湾曲中心水平距離 \sqrt{R_c'^2 -f_B^2}
botCurvatureCenterX = math.sqrt(centralCurvatureDim ** 2 - botAlocationLengthAve ** 2)

# f_B - f_T
AlocationDifference = (botAlocationLengthAve - topAlocationLengthAve) / 2

# 均等振分角度 θ' → θ
ParallelAngle = -1 * round(math.degrees(math.asin(AlocationDifference / TableCenterXFromCurvatureCenterX)), 3)
SinParallelAngle = math.sin(math.radians(-1 * ParallelAngle))
CosParallelAngle = math.cos(math.radians(-1 * ParallelAngle))

topSideParallelAngleVal = ParallelAngle
botSideParallelAngleVal = 180 + ParallelAngle
topSideParallelAngle = f"{topSideParallelAngleVal:.3f}"
botSideParallelAngle = f"{botSideParallelAngleVal:.3f}"

# ボトム端外面水平距離
botAsideOutfaceHorizontalX = math.sqrt(AsideOutCurvature ** 2 - botAlocationLengthAve ** 2)
botCsideOutfaceHorizontalX = math.sqrt(CsideOutCurvature ** 2 - botAlocationLengthAve ** 2)
# ボトム外径中心-O 間水平距離
botODCenterXFromCurvatureCenterX = (botAsideOutfaceHorizontalX + botCsideOutfaceHorizontalX) / 2

# トップ端外面水平距離
topAsideOutfaceHorizontalX = math.sqrt(AsideOutCurvature ** 2 - topAlocationLengthAve ** 2)
topCsideOutfaceHorizontalX = math.sqrt(CsideOutCurvature ** 2 - topAlocationLengthAve ** 2)
# トップ外径中心-O 間水平距離
topODCenterXFromCurvatureCenterX = (topAsideOutfaceHorizontalX + topCsideOutfaceHorizontalX) / 2

# 再振分け f_T', f_B'
topReAlocationLengthDim = topAlocationLengthAve + TableCenterXFromCurvatureCenterX * SinParallelAngle
botReAlocationLengthDim = totalLengthAve - topReAlocationLengthDim
topOverHangLengthDim    = topReAlocationLengthDim - jigOuterHalfWidth
botOverHangLengthDim    = botReAlocationLengthDim - jigOuterHalfWidth
topReAlocationLength = f"{topReAlocationLengthDim:.3f}"
botReAlocationLength = f"{botReAlocationLengthDim:.3f}"
topOverHangLength    = f"{topOverHangLengthDim:.3f}"
botOverHangLength    = f"{botOverHangLengthDim:.3f}"

# トップ端面内面取先端 湾曲中心-O間 水平距離
topInChamferXFromCurvatureCenterX = math.sqrt(centralCurvatureDim ** 2 - (topAlocationLengthAve - topInChamferLengthDim) ** 2)
# ボトム端面内面取先端 湾曲中心-O間 水平距離
botInChamferXFromCurvatureCenterX = math.sqrt(centralCurvatureDim ** 2 - (botAlocationLengthAve - botInChamferLengthDim) ** 2)

# キー溝位置 + キー溝幅 κ_p+κ_w
keywayPosPlusWidth = keywayPosAve + keywayWidthAve
# トップ端 溝中央 間距離 κ_p+κ_w/2
keywayPosPlusHalfWidth = keywayPosAve + keywayWidthAve / 2
# 振分中心 - 溝位置 f_T-κ_p
topSideKeywayZ = topAlocationLengthAve - keywayPosAve
# 振分中心 - 溝位置 - 溝幅 f_T-(κ_p+κ_w)
bottomSideKeywayZ = topAlocationLengthAve - keywayPosPlusWidth
# 振分中心 溝中央 間距離 f_T-(κ_p+κ_w/2)
keywayCenterZFromAlocationCenter = topAlocationLengthAve - keywayPosPlusHalfWidth
# 湾曲中心 溝中心 間距離X
keywayCenterXFromAlocationCenter = math.sqrt(centralCurvatureDim ** 2 - keywayCenterZFromAlocationCenter ** 2)
# 溝中央A側
AsideKeywayCenterX = math.sqrt(AsideOutCurvature ** 2 - keywayCenterZFromAlocationCenter ** 2)
# 測定上の溝深さを正とした図面上の溝深さ補正
keywayAsideDepthCorrection = keywayWidthAve ** 2 / (8 * AsideOutCurvature)

# ボトム端 外径中心X
BotOutCenterXVal = TableCenterXFromCurvatureCenterX * CosParallelAngle - botODCenterXFromCurvatureCenterX
# ボトム 外削中心X
if (BotOutcutExistsFlag == 1 and BotCurvedOutcutExistsFlag == 0) and (TopOutcutExistsFlag == 0 or TopOutcutExistsFlag == 1 and OutcutCenterlineBasementFlag == 1):
    BotOutcutCenterXVal = BotOutCenterXVal - (botInChamferXFromCurvatureCenterX - botCurvatureCenterX) - botACIDAve / 2 - mekkiThicknessDim - botOutcutAsideThicknessAve + botOutcutACODAve / 2
# ボトム端 湾曲中心X
BotInCenterXVal = TableCenterXFromCurvatureCenterX * CosParallelAngle - botCurvatureCenterX
# トップ端 外径中心X
TopOutCenterXVal = topODCenterXFromCurvatureCenterX - TableCenterXFromCurvatureCenterX * CosParallelAngle
# トップ端 外削中心X
if TopOutcutExistsFlag == 1 and (BotOutcutExistsFlag == 0 or BotOutcutExistsFlag == 1 and OutcutCenterlineBasementFlag == 2):
    TopOutcutCenterXVal = TopOutCenterXVal + (botInChamferXFromCurvatureCenterX - topCurvatureCenterX) + topACIDAve / 2 + mekkiThicknessDim + topOutcutAsideThicknessAve - topOutcutACODAve / 2
# トップ端 湾曲中心X
TopInCenterXVal = topCurvatureCenterX - TableCenterXFromCurvatureCenterX * CosParallelAngle

if (BotOutcutExistsFlag == 0 or BotOutcutExistsFlag == 1 and BotCurvedOutcutExistsFlag == 1) and TopOutcutExistsFlag == 0:
    originBotOut = f"{BotOutCenterXVal:.3f}"
    originTopOut = f"{TopOutCenterXVal:.3f}"
elif (BotOutcutExistsFlag == 1 and BotCurvedOutcutExistsFlag == 0) and TopOutcutExistsFlag == 0:
    originBotOut = f"{BotOutcutCenterXVal:.3f}"
    originTopOut = f"{TopOutCenterXVal:.3f}"
elif BotOutcutExistsFlag == 0 and TopOutcutExistsFlag == 1:
    originBotOut = f"{BotOutCenterXVal:.3f}"
    originTopOut = f"{TopOutcutCenterXVal:.3f}"
elif BotOutcutExistsFlag == 1 and TopOutcutExistsFlag == 1:
    if OutcutCenterlineBasementFlag == 1:
        originBotOutVal = BotOutcutCenterXVal
        originTopOutVal = centerlineACDifAve - BotOutcutCenterXVal
    elif OutcutCenterlineBasementFlag == 2:
        originBotOutVal = TopOutcutCenterXVal + centerlineACDifAve
        originTopOutVal = TopOutcutCenterXVal
    originBotOut = f"{originBotOutVal:.3f}"
    originTopOut = f"{originTopOutVal:.3f}"
originBotIn = f"{BotInCenterXVal:.3f}"
originTopIn = f"{TopInCenterXVal:.3f}"

if KeywayAsideDepthToleranceExitsFlag == 1 and TopOutcutExistsFlag == 0:
    originKeywayVal = AsideKeywayCenterX - keywayAsideDepthCorrection - keywayACODAve / 2 - TableCenterXFromCurvatureCenterX * CosParallelAngle
elif KeywayAsideDepthToleranceExitsFlag == 0 and TopOutcutExistsFlag == 0:
    originKeywayVal = TopInCenterXVal + (keywayCenterXFromAlocationCenter - topCurvatureCenterX) 
elif BotOutcutExistsFlag == 0 and TopOutcutExistsFlag == 1:
    originKeywayVal = TopOutcutCenterXVal
elif BotOutcutExistsFlag == 1 and TopOutcutExistsFlag == 1:
    originKeywayVal = originTopOutVal
originKeyway = f"{originKeywayVal:.3f}"

# ディンプル用傾き角
if DimpleExistsFlag == 1:
    dimpleFirstRowIDNumerator = (dimpleFirstRowDistanceFromEndfaceDim - dimpleFirstRowTopSidePitch) * dimpleFirstRowBottomSideID + (dimpleFirstRowBottomSidePitch - dimpleFirstRowDistanceFromEndfaceDim) * dimpleFirstRowTopSideID
    dimpleFirstRowIDDenominator = dimpleFirstRowBottomSidePitch - dimpleFirstRowTopSidePitch
    dimpleFirstRowID = dimpleFirstRowIDNumerator / dimpleFirstRowIDDenominator
    # R_c + w'_{A0} / 2
    TopAsideInsideCurvature = centralCurvatureDim + (topACIDDim + 2 * mekkiThicknessDim) / 2
    # R_c + w'_{Aq} / 2
    dimpleFirstRowAsideInsideCurvature = centralCurvatureDim + (dimpleFirstRowID + 2 * mekkiThicknessDim) / 2
    # \sqrt{(R_c + w'_{A0}/2)^2-f_T^2}
    dimpleAngleFirstTerm = math.sqrt(dimpleFirstRowAsideInsideCurvature ** 2 - (topAlocationLengthAve - dimpleFirstRowDistanceFromEndfaceDim) ** 2)
    dimpleAngleSecondTerm = math.sqrt(TopAsideInsideCurvature ** 2 - topAlocationLengthAve ** 2)
    if dimpleAngleFirstTerm > dimpleAngleSecondTerm:
        TandimpleAngle = (dimpleAngleFirstTerm - dimpleAngleSecondTerm) / dimpleFirstRowDistanceFromEndfaceDim
    else:
        TandimpleAngle = 0
    dimpleAngleVal = -1 * round(math.degrees(math.atan(TandimpleAngle)), 3)
    dimpleAngle = f"{dimpleAngleVal:.3f}"
