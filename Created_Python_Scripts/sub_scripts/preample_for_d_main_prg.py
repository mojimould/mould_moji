# last update: 20240726

# ファイルの読込み
with open('./sub_scripts/load_values.py', 'r', encoding='utf-8') as file:
    load_values = file.read()
exec(load_values)

# サブプログラム番号
prgOutsideCenterX   = "110001"
prgOutsideCenterY   = "110002"
prgKeywayCenterX    = "120001"
prgInsideCenterX    = "130001"
prgInsideCenterY    = "130002"
prgOutcutCenterX    = "140001"
prgCenterlineDif    = "150002"
prgDimpleOne        = "210003"
prgEndface          = "410000"
prgOutcut           = "420000"
prgCurvedOutcut     = "421000"
prgKeyway           = "430000"
prgOutChamfer       = "440000"
prgCurvedOutChamfer = "441000"
prgInChamfer        = "450000"
prgEndFaceBoring    = "460000"
prgIncutBoring      = "470000"
prgPauseCheck       = "900003"
prgSensorOn         = "910001"
prgSensorOff        = "910002"

# 工具番号
toolIDEmpty         = 1
toolIDFacemill      = 2
toolIDSidecutter    = 6
toolIDTaperendmill  = {"15": 11, "30": 12, "45": 13}
toolIDSquareendmill = 16
toolIDTslot         = {"20.0": 31, "6.6":  32, "15.0": 33}
toolIDTouchSensor   = 50

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
SN_origin_setting     = count(100)
SN_dimple_measurement = count(200)
SN_dimple_milling     = count(300)
SN_top_endface        = count(400)
SN_top_outcut         = count(410)
SN_keyway             = count(420)
SN_top_out_chamfer    = count(430)
SN_top_in_chamfer     = count(440)
SN_bot_endface        = count(500)
SN_bot_outcut         = count(510)
SN_bot_out_chamfer    = count(530)
SN_bot_in_chamfer     = count(540)
SN_centerline         = count(650)
SN_alarmPallete       = count(821)
SN_base_end           = count(9990)
SN_prg_end            = count(9999)

with open('./sub_scripts/calculated_values.py', 'r', encoding='utf-8') as file:
    calculate_variables = file.read()
exec(calculate_variables)
