extends Camera2D
class_name MapCamera


# 画面缩放
var max_zoom: float = 1
var min_zoom: float = 0.5
var target_zoom = 1
var target_position = Vector2(960, 540)
var origin_position = Vector2(960, 540)
var move_in_zoom_flag = false
var LOCATE_POINT = {
	"region_top": {"position": Vector2(544, 334), "rect": {"left": 0, "right": 512, "top": 0, "bottom": 540}},
	"region_bottom": {"position": Vector2(544, 746), "rect": {"left": 0, "right": 512, "top": 540, "bottom": 1080}},
	"vintage": {"position": Vector2(960, 334), "rect": {"left": 512, "right": 1040, "top": 0, "bottom": 352}},
	"quadrel": {"position": Vector2(960, 540), "rect": {"left": 512, "right": 1040, "top": 352, "bottom": 736}},
	"sales": {"position": Vector2(960, 746), "rect": {"left": 512, "right": 1040, "top": 736, "bottom": 1080}},
	"magnate": {"position": Vector2(1356, 334), "rect": {"left": 1040, "right": 1920, "top": 0, "bottom": 320}},
	"fair": {"position": Vector2(1356, 500), "rect": {"left": 1040, "right": 1920, "top": 320, "bottom": 680}},
	"supply": {"position": Vector2(1356, 746), "rect": {"left": 1040, "right": 1920, "top": 680, "bottom": 1080}}
}  # 当鼠标在特定区域放大画面时, 将视角移至固定位置

# 画面拖拽
var drag_flag = false
var drag_mouse_start = Vector2.ZERO
var drag_camera_start = Vector2.ZERO
var CAMERA_BOUNDARY = {
	"left": 480,
	"right": 1356,
	"top": 270,
	"bottom": 810
}  # 保证可视区域始终在版图内


func approximate_equal(a: Vector2, b: Vector2, threshold: float = 0.01) -> bool:
	"""判断两个向量在误差范围内是否相等
	
	Args:
		threshold: 误差范围, 两个向量各分量差值均小于此值时认为向量相等
	"""

	if abs(a[0] - b[0]) < threshold and abs(a[1] - b[1]) < threshold:
		return true
	return false


func _unhandled_input(event: InputEvent) -> void:
	"""处理鼠标拖动及滚轮滚动"""
	
	if event is InputEventMouseButton:

		if event.button_index == BUTTON_LEFT:
			
			# 画面未经放大或处在缩放过程中, 不允许拖动
			if approximate_equal(self.zoom, Vector2.ONE * max_zoom) or self.move_in_zoom_flag:
				return
				
			if event.is_pressed():
				self.drag_flag = true
				self.drag_mouse_start = event.position
				self.drag_camera_start = self.position
			else:
				self.drag_flag = false

		# 鼠标滚轮向上, 放大画面, 并将主视角移至定位点
		elif event.button_index == BUTTON_WHEEL_UP:
			self.target_zoom = min_zoom
			self.move_in_zoom_flag = true
			
			for dic in self.LOCATE_POINT.values():
				if (
					dic["rect"]["left"] <= event.position[0]
					and event.position[0] < dic["rect"]["right"]
					and dic["rect"]["top"] <= event.position[1]
					and event.position[1] < dic["rect"]["bottom"]
				):
					self.target_position = dic["position"]
					break

		# 鼠标滚轮向下, 复原至原始画面
		elif event.button_index == BUTTON_WHEEL_DOWN:
			self.target_zoom = max_zoom
			self.target_position = origin_position
			self.move_in_zoom_flag = true

	# 拖动画面, 但保证画面始终在版图内
	if self.drag_flag:
		var offset = event.position - self.drag_mouse_start
		var new_position = self.drag_camera_start - offset * self.zoom
		self.position = Vector2(
			clamp(new_position[0], CAMERA_BOUNDARY["left"], CAMERA_BOUNDARY["right"]),
			clamp(new_position[1], CAMERA_BOUNDARY["top"], CAMERA_BOUNDARY["bottom"])
		)

func _process(delta: float) -> void:
	"""用于平缓滚轮滚动时画面缩放及移动"""

	if self.move_in_zoom_flag:
		if approximate_equal(self.position, target_position, 1):
			self.position = target_position
			self.move_in_zoom_flag = false
		else:
			self.position = lerp(self.position, target_position, 6 * delta)
	self.zoom = lerp(self.zoom, Vector2.ONE * target_zoom, 8 * delta)
