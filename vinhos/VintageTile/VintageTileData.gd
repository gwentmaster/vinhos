"""年份板块数据"""

extends Node
class_name VintageTileData


var Model = preload("res://Model.gd").new()


enum DataOrder {Quality=0, Expert=1, Magnate_A=2, Magnate_B=3, Magnate_C=4}
var ExpertOrder = Model.ExpertFeature  # 红, 绿, 蓝, 黄
var WineColor = Model.WineColor


var DATA = [
	[1, [3, 1, 0, 0], 0, 8, [1, 4, 7, 8]],
	[-1, [1, 0, 0, 2], 0, 6, [1, 3, 7, 9]],
	[-2, [1, 1, 1, 1], 1, 4, [1, 2, 5, 8]],
	[2, [0, 3, 1, 0], 0, 9, [1, 5, 7, 9]],
	[2, [0, 0, 2, 3], 1, 9, [2, 3, 6, 8]],
	[-1, [2, 0, 3, 0], 1, 6, [2, 4, 5, 8]],
	[-2, [1, 1, 1, 1], 0, 4, [3, 4, 6, 9]],
	[1, [0, 2, 0, 1], 1, 8, [2, 5, 6, 9]]
]
