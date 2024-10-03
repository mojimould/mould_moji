# last update: 20241003
# Copyright 2023-2024 The individual creator, not held by any corporation.
# All rights reserved.

from datetime import datetime


# ワークブックの最初のシートの読み込み
WB = load_workbook(
    "./work_Postison_Cal.xlsm", data_only=True
)
WB_sheet_names = WB.sheetnames

# 最初のワークシートを取得
WS = WB.worksheets[0]
WS1_name = WB_sheet_names[0]

# format for inside taper #
def format_taperID(value):
    if str(value).startswith('e'):
        return 'e' + str(value)[1:].zfill(5)
    else:
        return str(value).zfill(5)
taperID = format_taperID(WS['C21'].value)

WS2_name = taperID
# 余分なシートの削除
for sheet in WB.sheetnames:
    if sheet != WS.title and sheet != WS2_name:
        del WB[sheet]

# vlookup
def excel_lookup(wb, sheet_name, lookup_cell, result_col, next_row=False):
    sheet = wb[sheet_name]
    lookup_value = sheet[lookup_cell].value
    ref_sheet = wb[taperID]
    a_values = [(cell[0].value, cell[0].row) for cell in ref_sheet.iter_rows(min_row=2, max_col=1)]
    # lookup_value以下の最大の値を探す
    try:
        a_values = [(value, row) for value, row in a_values if isinstance(value, (int, float))]
        _, row = max((value, row) for value, row in a_values if value <= lookup_value)
    except ValueError:
        raise ValueError(f'No values found in column A of sheet {taperID} that are less than or equal to {lookup_value}')
    # 指定された列の値を取得
    if next_row:
        # 次の行の値を取得
        result_value = ref_sheet[result_col + str(row + 1)].value
    else:
        result_value = ref_sheet[result_col + str(row)].value
    return result_value

# jig, table
jigOuterHalfWidth      = WS['U3'].value
ReceiverPlateWidth     = WS['U4'].value
ReceiverPlateRadius    = WS['U5'].value
BetweenTableJigCenters = WS['U6'].value

# sub-program number
prgOutsideCenterX   = f"{WS['U33'].value:06d}"
prgOutsideCenterY   = f"{WS['U34'].value:06d}"
prgKeywayCenterX    = f"{WS['U35'].value:06d}"
prgInsideCenterX    = f"{WS['U36'].value:06d}"
prgInsideCenterY    = f"{WS['U37'].value:06d}"
prgOutcutCenterX    = f"{WS['U38'].value:06d}"
prgCenterlineDif    = f"{WS['U39'].value:06d}"
prgEndfaceSlope     = f"{WS['U40'].value:06d}"
prgDimpleOne        = f"{WS['U41'].value:06d}"
prgEndface          = f"{WS['U42'].value:06d}"
prgOutcut           = f"{WS['U43'].value:06d}"
prgCurvedOutcut     = f"{WS['U44'].value:06d}"
prgKeyway           = f"{WS['U45'].value:06d}"
prgOutChamfer       = f"{WS['U46'].value:06d}"
prgCurvedOutChamfer = f"{WS['U47'].value:06d}"
prgInChamfer        = f"{WS['U48'].value:06d}"
prgEndFaceBoring    = f"{WS['U49'].value:06d}"
prgIncutBoring      = f"{WS['U50'].value:06d}"
prgPauseCheck       = f"{WS['U51'].value:06d}"
prgSensorOn         = f"{WS['U52'].value:06d}"
prgSensorOff        = f"{WS['U53'].value:06d}"

# tool number
toolIDEmpty         = WS['U16'].value
toolIDFacemill      = WS['U17'].value
toolIDSidecutter    = WS['U18'].value
toolIDTaperendmill  = {
    "15": WS['U20'].value,
    "30": WS['U21'].value,
    "45": WS['U22'].value
}
toolIDSquareendmill = WS['U23'].value
toolIDTslot         = {
    "20.0": WS['U25'].value,
    "6.6" : WS['U26'].value,
    "15.0": WS['U27'].value
}
toolIDTouchSensor   = WS['U30'].value

# flag
CenterCurvatureExistsFlag          = WS['C6'].value
BotAlocationBracketDimExistsFlag   = WS['C11'].value
DimpleExistsFlag                   = WS['O2'].value
BotOutcutExistsFlag                = WS['I2'].value
BotCurvedOutcutExistsFlag          = WS['I4'].value
TopOutcutExistsFlag                = WS['I11'].value
TopCurvedOutcutExistsFlag          = WS['I13'].value
TopOutcutLengthNEKeywayFlag        = WS['I14'].value
OutcutCenterlineBasementFlag       = WS['I22'].value
TopEndfaceOutChamferExistsFlag     = WS['I51'].value
TopEndfaceInChamferExistsFlag      = WS['I56'].value
BotEndfaceOutChamferExistsFlag     = WS['I41'].value
BotEndfaceInChamferExistsFlag      = WS['I46'].value
KeywayTypeFlag                     = WS['I26'].value
KeywayAsideDepthToleranceExitsFlag = WS['I27'].value
EndfaceBoringExistsFlag            = WS['O15'].value
IncutBoringExistsFlag              = WS['O22'].value

# drawing number
DrawingIDNum = WS['C2'].value
MainPrgID    = f"{DrawingIDNum:04d}"
CustomerName = WS['C3'].value

# date
now = datetime.now()
date_string = now.strftime('%Y%m%d')

# curvature, alocation
centralCurvatureDim = WS['C8'].value
centralCurvature    = f"{centralCurvatureDim:.3f}"
totalLengthDim            = WS['C9'].value
totalLengthPlusTolerance  = WS['D9'].value
totalLengthMinusTolerance = WS['E9'].value
totalLengthAve = totalLengthDim + (totalLengthPlusTolerance + totalLengthMinusTolerance) / 2
topAlocationLengthDim     = WS['C10'].value
if BotAlocationBracketDimExistsFlag == 0:
    topAlocationLengthAve = topAlocationLengthDim + (totalLengthPlusTolerance + totalLengthMinusTolerance) / 4
elif BotAlocationBracketDimExistsFlag == 1:
    topAlocationLengthAve = topAlocationLengthDim
botAlocationLengthAve = totalLengthAve - topAlocationLengthAve
topAlocationLength = f"{topAlocationLengthAve :.3f}"
botAlocationLength = f"{botAlocationLengthAve :.3f}"

# OD
ACODDim            = WS['C15'].value
ACODPlusTolerance  = WS['D15'].value
ACODMinusTolerance = WS['E15'].value
ACODAve = ACODDim + (ACODPlusTolerance + ACODMinusTolerance) / 2
ACOD    = f"{ACODAve:.3f}"
BDODDim            = WS['C16'].value
BDODPlusTolerance  = WS['D16'].value
BDODMinusTolerance = WS['E16'].value
BDODAve = BDODDim + (BDODPlusTolerance + BDODMinusTolerance) / 2
BDOD    = f"{BDODAve:.3f}"
OutsideCornerRDim = WS['C17'].value
OutsideCornerR    = f"{OutsideCornerRDim:.2f}"

# 内形
mekkiThicknessDim = WS['C20'].value
mekkiThickness    = f"{mekkiThicknessDim:.3f}"
topACIDDim = excel_lookup(WB, WS1_name, 'C22', 'B', next_row=False)
topBDIDDim = excel_lookup(WB, WS1_name, 'C22', 'C', next_row=False)
topInsideCornerRDim = excel_lookup(WB, WS1_name, 'C22', 'D', next_row=False)
topInsideCornerR    = f"{topInsideCornerRDim:.3f}"
botACIDDim = excel_lookup(WB, WS1_name, 'C9', 'B', next_row=False)
botBDIDDim = excel_lookup(WB, WS1_name, 'C9', 'C', next_row=False)
botInsideCornerRDim = excel_lookup(WB, WS1_name, 'C9', 'D', next_row=False)
botInsideCornerR    = f"{botInsideCornerRDim:.3f}"
ACIDPlusTolerance  = WS['D21'].value
ACIDMinusTolerance = WS['E21'].value
BDIDPlusTolerance  = WS['D21'].value
BDIDMinusTolerance = WS['E21'].value
topACIDAve = topACIDDim + (ACIDPlusTolerance + ACIDMinusTolerance) / 2
topBDIDAve = topBDIDDim + (BDIDPlusTolerance + BDIDMinusTolerance) / 2
botACIDAve = botACIDDim + (ACIDPlusTolerance + ACIDMinusTolerance) / 2
botBDIDAve = botBDIDDim + (BDIDPlusTolerance + BDIDMinusTolerance) / 2
topACID = f"{topACIDAve:.3f}"
topBDID = f"{topBDIDAve:.3f}"
botACID = f"{botACIDAve:.3f}"
botBDID = f"{botBDIDAve:.3f}"

# ディンプル
if DimpleExistsFlag == 1:
    dimpleFirstRowDistanceFromEndfaceDim = WS['O3'].value
    dimpleFirstRowDistanceFromEndface    = f"{dimpleFirstRowDistanceFromEndfaceDim:.3f}"
    dimpleVerticalPitchDim   = WS['O4'].value
    dimpleVerticalPitch      = f"{dimpleVerticalPitchDim:.3f}"
    dimpleHorizontalPitchDim = WS['O5'].value
    dimpleHorizontalPitch    = f"{dimpleHorizontalPitchDim:.3f}"
    dimpleRowNumVal = WS['O8'].value
    dimpleRowNum    = f"{dimpleRowNumVal:.1f}"
    dimpleFirstRowLengthDim  = WS['O6'].value
    dimpleFirstRowLength     = f"{dimpleFirstRowLengthDim:.3f}"
    dimpleSecondRowLengthDim = WS['O7'].value
    dimpleSecondRowLength    = f"{dimpleSecondRowLengthDim:.3f}"
    dimpleDepthDim = WS['O9'].value
    dimpleDepth    = f"{dimpleDepthDim:.3f}"
    dimpleSmallRadiusDim = WS['O10'].value
    dimpleSmallRadius    = f"{dimpleSmallRadiusDim:.1f}"
    dimpleFirstRowTopSidePitch    = excel_lookup(WB, WS1_name, 'O3', 'A', next_row=False)
    dimpleFirstRowBottomSidePitch = excel_lookup(WB, WS1_name, 'O3', 'A', next_row=True)
    dimpleFirstRowTopSideID       = excel_lookup(WB, WS1_name, 'O3', 'B', next_row=False)
    dimpleFirstRowBottomSideID    = excel_lookup(WB, WS1_name, 'O3', 'B', next_row=True)
    dimpleLastRowDistanceFromEndfaceDim = dimpleFirstRowDistanceFromEndfaceDim + dimpleVerticalPitchDim * (dimpleRowNumVal - 1)

# キー溝
keywayACOD = "#0"
if KeywayTypeFlag != 4:
    keywayACODDim            = WS['I28'].value
    keywayACODPlusTolerance  = WS['J28'].value
    keywayACODMinusTolerance = WS['K28'].value
    keywayACODAve = keywayACODDim + (keywayACODPlusTolerance + keywayACODMinusTolerance) / 2
    keywayACOD    = f"{keywayACODAve:.3f}"
keywayBDODDim            = WS['I29'].value
keywayBDODPlusTolerance  = WS['J29'].value
keywayBDODMinusTolerance = WS['K29'].value
keywayBDODAve = keywayBDODDim + (keywayBDODPlusTolerance + keywayBDODMinusTolerance) / 2
keywayBDOD    = f"{keywayBDODAve:.3f}"
keywayPosDim            = WS['I30'].value
keywayPosPlusTolerance  = WS['J30'].value
keywayPosMinusTolerance = WS['K30'].value
keywayPosAve = keywayPosDim + (keywayPosPlusTolerance + keywayPosMinusTolerance) / 2
keywayPos    = f"{keywayPosAve:.3f}"
keywayWidthDim            = WS['I31'].value
keywayWidthPlusTolerance  = WS['J31'].value
keywayWidthMinusTolerance = WS['K31'].value
keywayWidthAve = keywayWidthDim + (keywayWidthPlusTolerance + keywayWidthMinusTolerance) / 2
keywayWidth    = f"{keywayWidthAve:.3f}"
keywayAsideDepthToleranceExists = f"{KeywayAsideDepthToleranceExitsFlag:.1f}"
if KeywayAsideDepthToleranceExitsFlag == 0:
    keywayAsideDepthDim = WS['I33'].value
    keywayAsideDepth    = f"{keywayAsideDepthDim:.3f}"
elif KeywayAsideDepthToleranceExitsFlag == 1:
    keywayAsideDepthDim            = WS['I32'].value
    keywayAsideDepthPlusTolerance  = WS['J32'].value
    keywayAsideDepthMinusTolerance = WS['K32'].value
    keywayAsideDepthAve = keywayAsideDepthDim + (keywayAsideDepthPlusTolerance + keywayAsideDepthMinusTolerance) / 2
    keywayAsideDepth    = f"{keywayAsideDepthAve:.3f}"
keywayBsideDepthDim = WS['I34'].value
keywayBsideDepth    = f"{keywayBsideDepthDim:.3f}"
keywayCsideDepthDim = WS['I35'].value
keywayCsideDepth    = f"{keywayCsideDepthDim:.3f}"
keywayDsideDepthDim = WS['I36'].value
keywayDsideDepth    = f"{keywayDsideDepthDim:.3f}"
keywayCornerR = "#0"
keywayCornerC = "#0"
keywayType = f"{KeywayTypeFlag:.1f}"
if KeywayTypeFlag == 1:
    keywayCornerRDim = WS['I37'].value
    keywayCornerR    = f"{keywayCornerRDim:.2f}"
if KeywayTypeFlag == 2:
    keywayCornerCDim = WS['I38'].value
    keywayCornerC    = f"{keywayCornerCDim:.2f}"
if KeywayTypeFlag == 3:
    keywayCornerR = "#0"
    keywayCornerC = "#0"
if KeywayTypeFlag == 4:
    keywayACOD = "#0"
    keywayCornerR = "#0"
    keywayCornerC = "#0"
if KeywayTypeFlag == 5:
    keywayCornerRDim = WS['I37'].value
    keywayCornerR    = f"{keywayCornerRDim:.2f}"
    keywayCornerCDim = WS['I38'].value
    keywayCornerC    = f"{keywayCornerCDim:.2f}"

# トップ外削
topOutcutExists = f"{TopOutcutExistsFlag:.1f}"
topOutcutACOD = "#0"
topOutcutBDOD = "#0"
if TopOutcutExistsFlag == 1:
    topOutcutACODDim            = WS['I16'].value
    topOutcutACODPlusTolerance  = WS['J16'].value
    topOutcutACODMinusTolerance = WS['K16'].value
    topOutcutACODAve = topOutcutACODDim + (topOutcutACODPlusTolerance + topOutcutACODMinusTolerance) / 2
    topOutcutACOD    = f"{topOutcutACODAve:.3f}"
    topOutcutBDODDim            = WS['I17'].value
    topOutcutBDODPlusTolerance  = WS['J17'].value
    topOutcutBDODMinusTolerance = WS['K17'].value
    topOutcutBDODAve = topOutcutBDODDim + (topOutcutBDODPlusTolerance + topOutcutBDODMinusTolerance) / 2
    topOutcutBDOD    = f"{topOutcutBDODAve:.3f}"
    if TopOutcutLengthNEKeywayFlag == 0:
        topOutcutLengthAve = keywayPosAve + keywayWidthAve
    elif TopOutcutLengthNEKeywayFlag == 1:
        topOutcutLengthDim            = WS['I18'].value
        topOutcutLengthPlusTolerance  = WS['J18'].value
        topOutcutLengthMinusTolerance = WS['K18'].value
        topOutcutLengthAve = topOutcutLengthDim + (topOutcutLengthPlusTolerance + topOutcutLengthMinusTolerance) / 2
    topOutcutLength    = f"{topOutcutLengthAve:.3f}"
    topOutcutCornerRDim = WS['I19'].value
    topOutcutCornerR    = f"{topOutcutCornerRDim:.2f}"
    if BotOutcutExistsFlag == 0 or (BotOutcutExistsFlag == 1 and OutcutCenterlineBasementFlag == 2):
        topOutcutAsideThicknessDim            = WS['I15'].value
        topOutcutAsideThicknessPlusTolerance  = WS['J15'].value
        topOutcutAsideThicknessMinusTolerance = WS['K15'].value
        topOutcutAsideThicknessAve = topOutcutAsideThicknessDim + (topOutcutAsideThicknessPlusTolerance + topOutcutAsideThicknessMinusTolerance) / 2
        topOutcutAsideThickness    = f"{topOutcutAsideThicknessAve:.3f}"

if TopOutcutExistsFlag == 0 or TopOutcutExistsFlag == 1 and TopOutcutLengthNEKeywayFlag == 0:
    keywayOutsideACOD = ACOD
    keywayOutsideBDOD = BDOD
elif TopOutcutExistsFlag == 1 and TopOutcutLengthNEKeywayFlag == 1:
    keywayOutsideACOD = topOutcutACOD
    keywayOutsideBDOD = topOutcutBDOD


# ボトム外削
botOutcutExists = f"{BotOutcutExistsFlag:.1f}"
botOutcutACOD = "#0"
botOutcutBDOD = "#0"
if BotOutcutExistsFlag == 1:
    botOutcutACODDim            = WS['I6'].value
    botOutcutACODPlusTolerance  = WS['J6'].value
    botOutcutACODMinusTolerance = WS['K6'].value
    botOutcutACODAve = botOutcutACODDim + (botOutcutACODPlusTolerance + botOutcutACODMinusTolerance) / 2
    botOutcutACOD    = f"{botOutcutACODAve:.3f}"
    botOutcutBDODDim            = WS['I7'].value
    botOutcutBDODPlusTolerance  = WS['J7'].value
    botOutcutBDODMinusTolerance = WS['K7'].value
    botOutcutBDODAve = botOutcutBDODDim + (botOutcutBDODPlusTolerance + botOutcutBDODMinusTolerance) / 2
    botOutcutBDOD    = f"{botOutcutBDODAve:.3f}"
    botOutcutLengthDim            = WS['I8'].value
    botOutcutLengthPlusTolerance  = WS['J8'].value
    botOutcutLengthMinusTolerance = WS['K8'].value
    botOutcutLengthAve = botOutcutLengthDim + (botOutcutLengthPlusTolerance + botOutcutLengthMinusTolerance) / 2
    botOutcutLength    = f"{botOutcutLengthAve:.3f}"
    botOutcutCornerRDim = WS['I9'].value
    botOutcutCornerR    = f"{botOutcutCornerRDim:.2f}"
    if (TopOutcutExistsFlag == 0 or TopOutcutExistsFlag == 1 and OutcutCenterlineBasementFlag == 1) and BotCurvedOutcutExistsFlag == 0:
        botOutcutAsideThicknessDim            = WS['I5'].value
        botOutcutAsideThicknessPlusTolerance  = WS['J5'].value
        botOutcutAsideThicknessMinusTolerance = WS['K5'].value
        botOutcutAsideThicknessAve = botOutcutAsideThicknessDim + (botOutcutAsideThicknessPlusTolerance + botOutcutAsideThicknessMinusTolerance) / 2
        botOutcutAsideThickness    = f"{botOutcutAsideThicknessAve:.3f}"

# 通り芯
if BotOutcutExistsFlag == 1 and TopOutcutExistsFlag == 1:
    centerlineACDifDim            = WS['I23'].value
    centerlineACDifPlusTolerance  = WS['J23'].value
    centerlineACDifMinusTolerance = WS['K23'].value
    centerlineACDifAve = centerlineACDifDim + (centerlineACDifPlusTolerance + centerlineACDifMinusTolerance) / 2
    centerlineACDif    = f"{centerlineACDifAve:.3f}"

# 端面座ぐり
EndfaceBoringExists = f"{EndfaceBoringExistsFlag:.1f}"
if EndfaceBoringExistsFlag == 1:
    EnfaceBoringDistanceFromADim = WS['O16'].value
    EnfaceBoringDistanceFromA = f"{EnfaceBoringDistanceFromADim:.3f}"
    EnfaceBoringWidthDim = WS['O17'].value
    EnfaceBoringWidth = f"{EnfaceBoringWidthDim:.3f}"
    EnfaceBoringDepthDim = WS['O18'].value
    EnfaceBoringDepth = f"{EnfaceBoringDepthDim:.3f}"
    EnfaceBoringLengthDim = WS['O20'].value
    EnfaceBoringLength = f"{EnfaceBoringLengthDim:.3f}"
    EnfaceBoringCornerRDim = WS['O19'].value
    EnfaceBoringCornerR = f"{EnfaceBoringCornerRDim:.3f}"


# 内削座ぐり
IncutExists = f"{IncutBoringExistsFlag:.1f}"
IncutACOD = "#0"
IncutBDOD = "#0"
if IncutBoringExistsFlag == 1:
    IncutACODDim = WS['O23'].value
    IncutACOD = f"{IncutACODDim:.3f}"
    IncutBDODDim = WS['O24'].value
    IncutBDOD = f"{IncutBDODDim:.3f}"
    IncutLengthDim = WS['O25'].value
    IncutLength = f"{IncutLengthDim:.3f}"
    IncutCornerRDim = WS['O26'].value
    IncutCornerR = f"{IncutCornerRDim:.2f}"

# トップ端面外面取
if TopEndfaceOutChamferExistsFlag == 1:
    topOutChamferTypeVal = 0
    topOutChamferAngleDim = WS['I53'].value
elif TopEndfaceOutChamferExistsFlag == 2:
    topOutChamferTypeVal = 1
    topOutChamferAngleDim = 45
topOutChamferLengthDim = WS['I52'].value
topOutChamferType = f"{topOutChamferTypeVal:.1f}"
topOutChamferLength = f"{topOutChamferLengthDim:.2f}"
topOutChamferAngle = f"{topOutChamferAngleDim:.0f}"
if TopOutcutExistsFlag == 0:
    topOutChamferCornerRDim = OutsideCornerRDim
elif TopOutcutExistsFlag == 1:
    topOutChamferCornerRDim = topOutcutCornerRDim
topOutChamferCornerR = f"{topOutChamferCornerRDim:.2f}"

# ボトム端面外面取
if BotEndfaceOutChamferExistsFlag == 1:
    botOutChamferTypeVal = 0
    botOutChamferAngleDim = WS['I43'].value
elif BotEndfaceOutChamferExistsFlag == 2:
    botOutChamferTypeVal = 1
    botOutChamferAngleDim = 45
botOutChamferLengthDim = WS['I42'].value
botOutChamferType = f"{botOutChamferTypeVal:.1f}"
botOutChamferLength = f"{botOutChamferLengthDim:.2f}"
botOutChamferAngle = f"{botOutChamferAngleDim:.0f}"
if BotOutcutExistsFlag == 0:
    botOutChamferCornerRDim = OutsideCornerRDim
elif BotOutcutExistsFlag == 1:
    botOutChamferCornerRDim = botOutcutCornerRDim
botOutChamferCornerR = f"{botOutChamferCornerRDim:.2f}"

# トップ端面内面取
if TopEndfaceInChamferExistsFlag == 1:
    topInChamferTypeVal = 0
    topInChamferAngleDim = WS['I58'].value
elif TopEndfaceInChamferExistsFlag == 2:
    topInChamferTypeVal = 1
    topInChamferAngleDim = 45
topInChamferLengthDim = WS['I57'].value
topInChamferType   = f"{topInChamferTypeVal:.1f}"
topInChamferLength = f"{topInChamferLengthDim:.2f}"
topInChamferAngle  = f"{topInChamferAngleDim:.0f}"
if IncutBoringExistsFlag == 0:
    topInChamferCornerRDim = topInsideCornerRDim
elif IncutBoringExistsFlag == 1:
    topInChamferCornerRDim = IncutCornerRDim
topInChamferCornerR = f"{topInChamferCornerRDim:.2f}"

# ボトム端面内面取
if BotEndfaceInChamferExistsFlag == 1:
    botInChamferTypeVal   = 0
    botInChamferAngleVal  = WS['I48'].value
elif BotEndfaceInChamferExistsFlag == 2:
    botInChamferTypeVal   = 1
    botInChamferAngleVal  = 45
botInChamferLengthDim = WS['I47'].value
botInChamferType   = f"{botInChamferTypeVal:.1f}"
botInChamferLength = f"{botInChamferLengthDim:.2f}"
botInChamferAngle  = f"{botInChamferAngleVal:.0f}"
botInChamferCornerRDim = botInsideCornerRDim
botInChamferCornerR = f"{botInChamferCornerRDim:.2f}"
