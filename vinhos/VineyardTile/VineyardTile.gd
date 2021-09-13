"""葡萄园板块"""

extends Panel
class_name VineyardTile


var Model = preload("res://Model.gd").new()


var front: Texture
var back: Texture
var front_up: bool


func set_data(region: int, color: int) -> VineyardTile:
	"""设置卡图
	
	Args:
		region: 板块所属产地, 可从 `range(1, 10)` 中选择
		color: 葡萄颜色, 见 `Model.WineColor`
	
	Returns:
		板块自身
	"""

	var pic_prefix = (
		"res://Assets/image/VineyardTile/" + str(region)
		+ "_" + str(color) + "_"
	)
	self.front = load(pic_prefix + "0.jpg")
	self.back = load(pic_prefix + "1.jpg")
	$TextureRect.texture = self.front
	self.front_up = true
	
	return self
