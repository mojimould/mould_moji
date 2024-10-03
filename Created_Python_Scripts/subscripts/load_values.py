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
taperID = format_taperID(WS['C20'].value)

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
jigOuterHalfWidth      = WS['C112'].value
ReceiverPlateWidth     = WS['C113'].value
ReceiverPlateRadius    = WS['C114'].value
BetweenTableJigCenters = WS['C115'].value

# sub-program number
prgOutsideCenterX   = f"{WS['C147'].value:06d}"
prgOutsideCenterY   = f"{WS['C148'].value:06d}"
prgKeywayCenterX    = f"{WS['C149'].value:06d}"
prgInsideCenterX    = f"{WS['C150'].value:06d}"
prgInsideCenterY    = f"{WS['C151'].value:06d}"
prgOutcutCenterX    = f"{WS['C152'].value:06d}"
prgCenterlineDif    = f"{WS['C153'].value:06d}"
prgEndfaceSlope     = f"{WS['C154'].value:06d}"
prgDimpleOne        = f"{WS['C155'].value:06d}"
prgEndface          = f"{WS['C156'].value:06d}"
prgOutcut           = f"{WS['C157'].value:06d}"
prgCurvedOutcut     = f"{WS['C158'].value:06d}"
prgKeyway           = f"{WS['C159'].value:06d}"
prgOutChamfer       = f"{WS['C160'].value:06d}"
prgCurvedOutChamfer = f"{WS['C161'].value:06d}"
prgInChamfer        = f"{WS['C162'].value:06d}"
prgEndFaceBoring    = f"{WS['C163'].value:06d}"
prgIncutBoring      = f"{WS['C164'].value:06d}"
prgPauseCheck       = f"{WS['C165'].value:06d}"
prgSensorOn         = f"{WS['C166'].value:06d}"
prgSensorOff        = f"{WS['C167'].value:06d}"

# tool number
toolIDEmpty         = WS['C125'].value
toolIDFacemill      = WS['C126'].value
toolIDSidecutter    = WS['C127'].value
toolIDTaperendmill  = {
    "15": WS['C129'].value,
    "30": WS['C130'].value,
    "45": WS['C131'].value
}
toolIDSquareendmill = WS['C132'].value
toolIDTslot         = {
    "20.0": WS['C134'].value,
    "6.6" : WS['C135'].value,
    "15.0": WS['C136'].value
}
toolIDTouchSensor   = WS['C139'].value

# flag
CenterCurvatureExistsFlag          = WS['C5'].value
BotAlocationBracketDimExistsFlag   = WS['C10'].value
DimpleExistsFlag                   = WS['C60'].value
BotOutcutExistsFlag                = WS['C23'].value
BotCurvedOutcutExistsFlag          = WS['C25'].value
TopOutcutExistsFlag                = WS['C32'].value
TopCurvedOutcutExistsFlag          = WS['C34'].value
TopOutcutLengthNEKeywayFlag        = WS['C35'].value
OutcutCenterlineBasementFlag       = WS['C43'].value
TopEndfaceOutCChamferExistsFlag    = WS['C84'].value
TopEndfaceOutRChamferExistsFlag    = WS['C88'].value
TopEndfaceInCChamferExistsFlag     = WS['C91'].value
TopEndfaceInRChamferExistsFlag     = WS['C95'].value
BotEndfaceOutCChamferExistsFlag    = WS['C70'].value
BotEndfaceOutRChamferExistsFlag    = WS['C74'].value
BotEndfaceInCChamferExistsFlag     = WS['C77'].value
BotEndfaceInRChamferExistsFlag     = WS['C81'].value
KeywayTypeFlag                     = WS['C46'].value
KeywayAsideDepthToleranceExitsFlag = WS['C47'].value
EndfaceBoringExistsFlag            = WS['C98'].value
IncutBoringExistsFlag              = WS['C105'].value

# drawing number
DrawingIDNum = WS['C2'].value
MainPrgID    = f"{DrawingIDNum:04d}"
CustomerName = WS['C3'].value

# date
now = datetime.now()
date_string = now.strftime('%Y%m%d')

# curvature, alocation
centralCurvatureDim = WS['C7'].value
centralCurvature    = f"{centralCurvatureDim:.3f}"
totalLengthDim            = WS['C8'].value
totalLengthPlusTolerance  = WS['D8'].value
totalLengthMinusTolerance = WS['E8'].value
totalLengthAve = totalLengthDim + (totalLengthPlusTolerance + totalLengthMinusTolerance) / 2
topAlocationLengthDim     = WS['C9'].value
if BotAlocationBracketDimExistsFlag == 0:
    topAlocationLengthAve = topAlocationLengthDim + (totalLengthPlusTolerance + totalLengthMinusTolerance) / 4
elif BotAlocationBracketDimExistsFlag == 1:
    topAlocationLengthAve = topAlocationLengthDim
botAlocationLengthAve = totalLengthAve - topAlocationLengthAve
topAlocationLength = f"{topAlocationLengthAve :.3f}"
botAlocationLength = f"{botAlocationLengthAve :.3f}"

# OD
ACODDim            = WS['C14'].value
ACODPlusTolerance  = WS['D14'].value
ACODMinusTolerance = WS['E14'].value
ACODAve = ACODDim + (ACODPlusTolerance + ACODMinusTolerance) / 2
ACOD    = f"{ACODAve:.3f}"
BDODDim            = WS['C15'].value
BDODPlusTolerance  = WS['D15'].value
BDODMinusTolerance = WS['E15'].value
BDODAve = BDODDim + (BDODPlusTolerance + BDODMinusTolerance) / 2
BDOD    = f"{BDODAve:.3f}"
OutsideCornerRDim = WS['C16'].value
OutsideCornerR    = f"{OutsideCornerRDim:.2f}"

# 内形
mekkiThicknessDim = WS['C19'].value
mekkiThickness    = f"{mekkiThicknessDim:.3f}"
topACIDDim = excel_lookup(WB, WS1_name, 'C21', 'B', next_row=False)
topBDIDDim = excel_lookup(WB, WS1_name, 'C21', 'C', next_row=False)
topInsideCornerRDim = excel_lookup(WB, WS1_name, 'C21', 'D', next_row=False)
topInsideCornerR    = f"{topInsideCornerRDim:.3f}"
botACIDDim = excel_lookup(WB, WS1_name, 'C8', 'B', next_row=False)
botBDIDDim = excel_lookup(WB, WS1_name, 'C8', 'C', next_row=False)
botInsideCornerRDim = excel_lookup(WB, WS1_name, 'C8', 'D', next_row=False)
botInsideCornerR    = f"{botInsideCornerRDim:.3f}"
ACIDPlusTolerance  = WS['D20'].value
ACIDMinusTolerance = WS['E20'].value
BDIDPlusTolerance  = WS['D20'].value
BDIDMinusTolerance = WS['E20'].value
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
    dimpleFirstRowDistanceFromEndfaceDim = WS['C61'].value
    dimpleFirstRowDistanceFromEndface    = f"{dimpleFirstRowDistanceFromEndfaceDim:.3f}"
    dimpleVerticalPitchDim   = WS['C62'].value
    dimpleVerticalPitch      = f"{dimpleVerticalPitchDim:.3f}"
    dimpleHorizontalPitchDim = WS['C63'].value
    dimpleHorizontalPitch    = f"{dimpleHorizontalPitchDim:.3f}"
    dimpleRowNumVal = WS['C66'].value
    dimpleRowNum    = f"{dimpleRowNumVal:.1f}"
    dimpleFirstRowLengthDim  = WS['C64'].value
    dimpleFirstRowLength     = f"{dimpleFirstRowLengthDim:.3f}"
    dimpleSecondRowLengthDim = WS['C65'].value
    dimpleSecondRowLength    = f"{dimpleSecondRowLengthDim:.3f}"
    dimpleDepthDim = WS['C67'].value
    dimpleDepth    = f"{dimpleDepthDim:.3f}"
    dimpleSmallRadiusDim = WS['C68'].value
    dimpleSmallRadius    = f"{dimpleSmallRadiusDim:.1f}"
    dimpleFirstRowTopSidePitch    = excel_lookup(WB, WS1_name, 'C61', 'A', next_row=False)
    dimpleFirstRowBottomSidePitch = excel_lookup(WB, WS1_name, 'C61', 'A', next_row=True)
    dimpleFirstRowTopSideID       = excel_lookup(WB, WS1_name, 'C61', 'B', next_row=False)
    dimpleFirstRowBottomSideID    = excel_lookup(WB, WS1_name, 'C61', 'B', next_row=True)
    dimpleLastRowDistanceFromEndfaceDim = dimpleFirstRowDistanceFromEndfaceDim + dimpleVerticalPitchDim * (dimpleRowNumVal - 1)

# キー溝
keywayACOD = "#0"
if KeywayTypeFlag != 4:
    keywayACODDim            = WS['C48'].value
    keywayACODPlusTolerance  = WS['D48'].value
    keywayACODMinusTolerance = WS['E48'].value
    keywayACODAve = keywayACODDim + (keywayACODPlusTolerance + keywayACODMinusTolerance) / 2
    keywayACOD    = f"{keywayACODAve:.3f}"
keywayBDODDim            = WS['C49'].value
keywayBDODPlusTolerance  = WS['D49'].value
keywayBDODMinusTolerance = WS['E49'].value
keywayBDODAve = keywayBDODDim + (keywayBDODPlusTolerance + keywayBDODMinusTolerance) / 2
keywayBDOD    = f"{keywayBDODAve:.3f}"
keywayPosDim            = WS['C50'].value
keywayPosPlusTolerance  = WS['D50'].value
keywayPosMinusTolerance = WS['E50'].value
keywayPosAve = keywayPosDim + (keywayPosPlusTolerance + keywayPosMinusTolerance) / 2
keywayPos    = f"{keywayPosAve:.3f}"
keywayWidthDim            = WS['C51'].value
keywayWidthPlusTolerance  = WS['D51'].value
keywayWidthMinusTolerance = WS['E51'].value
keywayWidthAve = keywayWidthDim + (keywayWidthPlusTolerance + keywayWidthMinusTolerance) / 2
keywayWidth    = f"{keywayWidthAve:.3f}"
keywayAsideDepthToleranceExists = f"{KeywayAsideDepthToleranceExitsFlag:.1f}"
if KeywayAsideDepthToleranceExitsFlag == 0:
    keywayAsideDepthDim = WS['C53'].value
    keywayAsideDepth    = f"{keywayAsideDepthDim:.3f}"
elif KeywayAsideDepthToleranceExitsFlag == 1:
    keywayAsideDepthDim            = WS['C52'].value
    keywayAsideDepthPlusTolerance  = WS['D52'].value
    keywayAsideDepthMinusTolerance = WS['E52'].value
    keywayAsideDepthAve = keywayAsideDepthDim + (keywayAsideDepthPlusTolerance + keywayAsideDepthMinusTolerance) / 2
    keywayAsideDepth    = f"{keywayAsideDepthAve:.3f}"
keywayBsideDepthDim = WS['C54'].value
keywayBsideDepth    = f"{keywayBsideDepthDim:.3f}"
keywayCsideDepthDim = WS['C55'].value
keywayCsideDepth    = f"{keywayCsideDepthDim:.3f}"
keywayDsideDepthDim = WS['C56'].value
keywayDsideDepth    = f"{keywayDsideDepthDim:.3f}"
keywayCornerR = "#0"
keywayCornerC = "#0"
keywayType = f"{KeywayTypeFlag:.1f}"
if KeywayTypeFlag == 1:
    keywayCornerRDim = WS['C57'].value
    keywayCornerR    = f"{keywayCornerRDim:.2f}"
if KeywayTypeFlag == 2:
    keywayCornerCDim = WS['C58'].value
    keywayCornerC    = f"{keywayCornerCDim:.2f}"
if KeywayTypeFlag == 3:
    keywayCornerR = "#0"
    keywayCornerC = "#0"
if KeywayTypeFlag == 4:
    keywayACOD = "#0"
    keywayCornerR = "#0"
    keywayCornerC = "#0"
if KeywayTypeFlag == 5:
    keywayCornerRDim = WS['C57'].value
    keywayCornerR    = f"{keywayCornerRDim:.2f}"
    keywayCornerCDim = WS['C58'].value
    keywayCornerC    = f"{keywayCornerCDim:.2f}"

# トップ外削
topOutcutExists = f"{TopOutcutExistsFlag:.1f}"
topOutcutACOD = "#0"
topOutcutBDOD = "#0"
if TopOutcutExistsFlag == 1:
    topOutcutACODDim            = WS['C37'].value
    topOutcutACODPlusTolerance  = WS['D37'].value
    topOutcutACODMinusTolerance = WS['E37'].value
    topOutcutACODAve = topOutcutACODDim + (topOutcutACODPlusTolerance + topOutcutACODMinusTolerance) / 2
    topOutcutACOD    = f"{topOutcutACODAve:.3f}"
    topOutcutBDODDim            = WS['C38'].value
    topOutcutBDODPlusTolerance  = WS['D38'].value
    topOutcutBDODMinusTolerance = WS['E38'].value
    topOutcutBDODAve = topOutcutBDODDim + (topOutcutBDODPlusTolerance + topOutcutBDODMinusTolerance) / 2
    topOutcutBDOD    = f"{topOutcutBDODAve:.3f}"
    if TopOutcutLengthNEKeywayFlag == 0:
        topOutcutLengthAve = keywayPosAve + keywayWidthAve
    elif TopOutcutLengthNEKeywayFlag == 1:
        topOutcutLengthDim            = WS['C39'].value
        topOutcutLengthPlusTolerance  = WS['D39'].value
        topOutcutLengthMinusTolerance = WS['E39'].value
        topOutcutLengthAve = topOutcutLengthDim + (topOutcutLengthPlusTolerance + topOutcutLengthMinusTolerance) / 2
    topOutcutLength    = f"{topOutcutLengthAve:.3f}"
    topOutcutCornerRDim = WS['C40'].value
    topOutcutCornerR    = f"{topOutcutCornerRDim:.2f}"
    if BotOutcutExistsFlag == 0 or (BotOutcutExistsFlag == 1 and OutcutCenterlineBasementFlag == 2):
        topOutcutAsideThicknessDim            = WS['C36'].value
        topOutcutAsideThicknessPlusTolerance  = WS['D36'].value
        topOutcutAsideThicknessMinusTolerance = WS['E36'].value
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
    botOutcutACODDim            = WS['C27'].value
    botOutcutACODPlusTolerance  = WS['D27'].value
    botOutcutACODMinusTolerance = WS['E27'].value
    botOutcutACODAve = botOutcutACODDim + (botOutcutACODPlusTolerance + botOutcutACODMinusTolerance) / 2
    botOutcutACOD    = f"{botOutcutACODAve:.3f}"
    botOutcutBDODDim            = WS['C28'].value
    botOutcutBDODPlusTolerance  = WS['D28'].value
    botOutcutBDODMinusTolerance = WS['E28'].value
    botOutcutBDODAve = botOutcutBDODDim + (botOutcutBDODPlusTolerance + botOutcutBDODMinusTolerance) / 2
    botOutcutBDOD    = f"{botOutcutBDODAve:.3f}"
    botOutcutLengthDim            = WS['C29'].value
    botOutcutLengthPlusTolerance  = WS['D29'].value
    botOutcutLengthMinusTolerance = WS['E29'].value
    botOutcutLengthAve = botOutcutLengthDim + (botOutcutLengthPlusTolerance + botOutcutLengthMinusTolerance) / 2
    botOutcutLength    = f"{botOutcutLengthAve:.3f}"
    botOutcutCornerRDim = WS['C30'].value
    botOutcutCornerR    = f"{botOutcutCornerRDim:.2f}"
    if (TopOutcutExistsFlag == 0 or TopOutcutExistsFlag == 1 and OutcutCenterlineBasementFlag == 1) and BotCurvedOutcutExistsFlag == 0:
        botOutcutAsideThicknessDim            = WS['C26'].value
        botOutcutAsideThicknessPlusTolerance  = WS['D26'].value
        botOutcutAsideThicknessMinusTolerance = WS['E26'].value
        botOutcutAsideThicknessAve = botOutcutAsideThicknessDim + (botOutcutAsideThicknessPlusTolerance + botOutcutAsideThicknessMinusTolerance) / 2
        botOutcutAsideThickness    = f"{botOutcutAsideThicknessAve:.3f}"

# 通り芯
if BotOutcutExistsFlag == 1 and TopOutcutExistsFlag == 1:
    centerlineACDifDim            = WS['C44'].value
    centerlineACDifPlusTolerance  = WS['D44'].value
    centerlineACDifMinusTolerance = WS['E44'].value
    centerlineACDifAve = centerlineACDifDim + (centerlineACDifPlusTolerance + centerlineACDifMinusTolerance) / 2
    centerlineACDif    = f"{centerlineACDifAve:.3f}"

# 端面座ぐり
EndfaceBoringExists = f"{EndfaceBoringExistsFlag:.1f}"
if EndfaceBoringExistsFlag == 1:
    EnfaceBoringDistanceFromADim = WS['C99'].value
    EnfaceBoringDistanceFromA = f"{EnfaceBoringDistanceFromADim:.3f}"
    EnfaceBoringWidthDim = WS['C100'].value
    EnfaceBoringWidth = f"{EnfaceBoringWidthDim:.3f}"
    EnfaceBoringDepthDim = WS['C101'].value
    EnfaceBoringDepth = f"{EnfaceBoringDepthDim:.3f}"
    EnfaceBoringLengthDim = WS['C103'].value
    EnfaceBoringLength = f"{EnfaceBoringLengthDim:.3f}"
    EnfaceBoringCornerRDim = WS['C102'].value
    EnfaceBoringCornerR = f"{EnfaceBoringCornerRDim:.3f}"


# 内削座ぐり
IncutExists = f"{IncutBoringExistsFlag:.1f}"
IncutACOD = "#0"
IncutBDOD = "#0"
if IncutBoringExistsFlag == 1:
    IncutACODDim = WS['C106'].value
    IncutACOD = f"{IncutACODDim:.3f}"
    IncutBDODDim = WS['C107'].value
    IncutBDOD = f"{IncutBDODDim:.3f}"
    IncutLengthDim = WS['C108'].value
    IncutLength = f"{IncutLengthDim:.3f}"
    IncutCornerRDim = WS['C109'].value
    IncutCornerR = f"{IncutCornerRDim:.2f}"

# トップ端面外面取
if TopEndfaceOutCChamferExistsFlag == 1 and TopEndfaceOutRChamferExistsFlag == 0:
    topOutChamferTypeVal = 0
    topOutChamferLengthDim = WS['C85'].value
    topOutChamferAngleDim = WS['C86'].value
elif TopEndfaceOutCChamferExistsFlag == 0 and TopEndfaceOutRChamferExistsFlag == 1:
    topOutChamferTypeVal = 1
    topOutChamferLengthDim = WS['C89'].value
    topOutChamferAngleDim = 45
topOutChamferType = f"{topOutChamferTypeVal:.1f}"
topOutChamferLength = f"{topOutChamferLengthDim:.2f}"
topOutChamferAngle = f"{topOutChamferAngleDim:.0f}"
if TopOutcutExistsFlag == 0:
    topOutChamferCornerRDim = OutsideCornerRDim
elif TopOutcutExistsFlag == 1:
    topOutChamferCornerRDim = topOutcutCornerRDim
topOutChamferCornerR = f"{topOutChamferCornerRDim:.2f}"

# ボトム端面外面取
if BotEndfaceOutCChamferExistsFlag == 1 and BotEndfaceOutRChamferExistsFlag == 0:
    botOutChamferTypeVal = 0
    botOutChamferLengthDim = WS['C71'].value
    botOutChamferAngleDim = WS['C72'].value
elif BotEndfaceOutCChamferExistsFlag == 0 and BotEndfaceOutRChamferExistsFlag == 1:
    botOutChamferTypeVal = 1
    botOutChamferLengthDim = WS['C75'].value
    botOutChamferAngleDim = 45
botOutChamferType = f"{botOutChamferTypeVal:.1f}"
botOutChamferLength = f"{botOutChamferLengthDim:.2f}"
botOutChamferAngle = f"{botOutChamferAngleDim:.0f}"
if BotOutcutExistsFlag == 0:
    botOutChamferCornerRDim = OutsideCornerRDim
elif BotOutcutExistsFlag == 1:
    botOutChamferCornerRDim = botOutcutCornerRDim
botOutChamferCornerR = f"{botOutChamferCornerRDim:.2f}"

# トップ端面内面取
if TopEndfaceInCChamferExistsFlag == 1 and TopEndfaceInRChamferExistsFlag == 0:
    topInChamferTypeVal = 0
    topInChamferLengthDim = WS['C92'].value
    topInChamferAngleDim = WS['C93'].value
elif TopEndfaceInCChamferExistsFlag == 0 and TopEndfaceInRChamferExistsFlag == 1:
    topInChamferTypeVal = 1
    topInChamferLengthDim = WS['C96'].value
    topInChamferAngleDim = 45
topInChamferType   = f"{topInChamferTypeVal:.1f}"
topInChamferLength = f"{topInChamferLengthDim:.2f}"
topInChamferAngle  = f"{topInChamferAngleDim:.0f}"
if IncutBoringExistsFlag == 0:
    topInChamferCornerRDim = topInsideCornerRDim
elif IncutBoringExistsFlag == 1:
    topInChamferCornerRDim = IncutCornerRDim
topInChamferCornerR = f"{topInChamferCornerRDim:.2f}"

# ボトム端面内面取
if BotEndfaceInCChamferExistsFlag == 1 and BotEndfaceInRChamferExistsFlag == 0:
    botInChamferTypeVal   = 0
    botInChamferLengthDim = WS['C78'].value
    botInChamferAngleVal  = WS['C79'].value
elif BotEndfaceInCChamferExistsFlag == 0 and BotEndfaceInRChamferExistsFlag == 1:
    botInChamferTypeVal   = 1
    botInChamferLengthDim = WS['C82'].value
    botInChamferAngleVal  = 45
botInChamferType   = f"{botInChamferTypeVal:.1f}"
botInChamferLength = f"{botInChamferLengthDim:.2f}"
botInChamferAngle  = f"{botInChamferAngleVal:.0f}"
botInChamferCornerRDim = botInsideCornerRDim
botInChamferCornerR = f"{botInChamferCornerRDim:.2f}"
