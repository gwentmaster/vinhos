extends Panel


signal pressed


var disabled = true setget set_disabled
export var SHADOW_COLOR = Color(12, 138, 187)


func set_disabled(flag: bool) -> void:
	"""设置按钮禁用状态, 非禁用时显示光晕"""

	disabled = flag
	if disabled:
		self.mouse_default_cursor_shape = Control.CURSOR_ARROW
		self.mouse_filter = Control.MOUSE_FILTER_IGNORE
		get_stylebox("panel", "").shadow_size = 0
	else:
		self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		self.mouse_filter = Control.MOUSE_FILTER_STOP
		get_stylebox("panel", "").shadow_size = 20
		get_stylebox("panel", "").shadow_color = SHADOW_COLOR


func _on_Button_gui_input(event: InputEvent) -> void:

	if (
		self.disabled == false
		and event is InputEventMouse
		and event.button_mask == BUTTON_LEFT
		and event.is_pressed()
	):
		emit_signal("pressed")
