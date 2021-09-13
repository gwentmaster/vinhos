extends Control
class_name Deck


var VineyardTile = preload("res://VineyardTile/VineyardTile.tscn")


var offset = Vector2(3, 3)


func add_child(node: Node, legible_unique_name: bool = false) -> void:
	"""
	添加卡片, 卡片会作为子节点在卡组最上层显示, 若前一张卡片对象含有名为"set_disabled"
	的方法, 该方法会被调用, 以禁止与下层卡片的交互
	"""

	if get_child_count() == 0:
		node.rect_position = Vector2(0, 0)
	else:
		var last_child = get_children()[-1]
		if last_child.has_method("set_disabled"):
			last_child.set_disabled()
		node.rect_position = last_child.rect_position - self.offset

	# 调用父类方法
	.add_child(node, legible_unique_name)


func draw_card(idx: int) -> Node:
	"""抽取卡片
	
	Args:
		idx: 卡片索引, 可传负数, 最下层卡片索引为0
	"""

	if idx < 0:
		idx = get_child_count() + idx

	var card = null
	var i = 0
	for child in get_children():
		if i == idx:
			remove_child(child)
			card = child
		elif i > idx:
			child.rect_position += self.offset
		i += 1
	return card
