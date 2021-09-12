"""年份板块"""

extends Panel
class_name VintageTile


var TileData = preload("res://VintageTile/VintageTileData.gd").new()


var serial_number: int
var quality: int
var expert: Array
var magnate_a: int
var magnate_b: int
var magnate_c: Array


func set_serial_number(number: int) -> VintageTile:
	"""根据序号设置卡图及数据
	
	Args:
		number: 板块序号, `-1`表示卡背
		
	Returns:
		年份板块对象自身
	"""

	self.serial_number = number

	if number == -1:
		$TextureRect.texture = load("res://Assets/image/VintageTile/-1.jpg")
		return self

	$TextureRect.texture = load("res://Assets/image/VintageTile/" + str(number) + ".jpg")
	self.quality = TileData.DATA[number][TileData.DataOrder.Quality]
	self.expert = TileData.DATA[number][TileData.DataOrder.Expert]
	self.magnate_a = TileData.DATA[number][TileData.DataOrder.Magnate_A]
	self.magnate_b = TileData.DATA[number][TileData.DataOrder.Magnate_B]
	self.magnate_c = TileData.DATA[number][TileData.DataOrder.Magnate_C]
	
	return self

