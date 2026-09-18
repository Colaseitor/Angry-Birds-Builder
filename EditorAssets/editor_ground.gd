extends Area2D
var moving = true
var floating = false
@export var thing_name: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Rotation/TextEdit.text = str(rotation_degrees)
	$CanvasLayer/Width/TextEdit.text = str(scale.x)
	$CanvasLayer/Heigth/TextEdit.text = str(scale.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_released("Left_Mouse"):
		moving = false
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if moving:
		Input.set_default_cursor_shape(Input.CURSOR_DRAG)
		position = get_global_mouse_position()


func _on_input_event(_a, _b, _c) -> void:
	if Input.is_action_just_pressed("Left_Mouse") && get_parent().get_parent().screen == 0:
		moving = true
	elif Input.is_action_just_pressed("Center Mouse") && get_parent().get_parent().screen == 0:
		queue_free()
	elif Input.is_action_just_pressed("Right Mouse") && get_parent().get_parent().screen == 0:
		get_parent().get_parent().screen = 4
		$CanvasLayer.show()


func _on_close_button_down() -> void:
	get_parent().get_parent().screen = 0
	$CanvasLayer.hide()


func _on_text_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_int():
		rotation_degrees = int(new_text)
	else:
		$CanvasLayer/Rotation/TextEdit.text = str(rotation_degrees)


func _on_heigth_text_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_float():
		scale.y = float(new_text)
	else:
		$CanvasLayer/Heigth/TextEdit.text = str(scale.y)


func _on_width_text_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_float():
		scale.x = float(new_text)
	else:
		$CanvasLayer/Width/TextEdit.text = str(scale.x)
