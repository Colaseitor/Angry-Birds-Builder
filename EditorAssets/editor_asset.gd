extends Area2D
var moving = true
@export var thing_name: String
@export var max_life: int
var life = max_life
var floating = false
var available_right_click = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Floating/CheckBox.button_pressed = floating
	$CanvasLayer/Rotation/TextEdit.text = str(rotation_degrees)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if available_right_click == false:
		if Input.is_action_pressed("Right Mouse") == false:
			available_right_click = true


func _on_input_event(_a, _b, _c) -> void:
	if Input.is_action_just_pressed("Left_Mouse") && get_parent().get_parent().screen == 0:
		moving = true
	elif Input.is_action_just_pressed("Center Mouse") && get_parent().get_parent().screen == 0:
		queue_free()
	elif Input.is_action_just_pressed("Right Mouse") && get_parent().get_parent().screen == 0:
		if available_right_click:
			get_parent().get_parent().screen = 4
			$CanvasLayer.show()
	elif Input. is_action_just_pressed("Scroll Up") && moving:
		rotation_degrees += 10
		adjust_settings()
	elif Input. is_action_just_pressed("Scroll Down") && moving:
		rotation_degrees -= 10
		adjust_settings()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released("Left_Mouse"):
		moving = false
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if moving:
		$CollisionShape2D.position = get_global_mouse_position() - position
		Input.set_default_cursor_shape(Input.CURSOR_DRAG)
		var touching = 0
		for things in get_overlapping_bodies():
			touching += 1
		for things in get_overlapping_areas():
			touching += 1
		if touching == 0:
			position += $CollisionShape2D.position
			$CollisionShape2D.position = Vector2(0,0)
	else:
		$CollisionShape2D.position = Vector2(0,0)


func _on_check_box_button_down() -> void:
	if $CanvasLayer/Floating/CheckBox.button_pressed:
		floating = false
	else:
		floating = true
	Global.last_item_edit = {
	"name" : thing_name,
	"floating" : floating,
	"rotation" : rotation_degrees
	}


func _on_close_button_down() -> void:
	get_parent().get_parent().screen = 0
	$CanvasLayer.hide()


func _on_text_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_int():
		rotation_degrees = int(new_text)
	else:
		$CanvasLayer/Rotation/TextEdit.text = str(rotation_degrees)
	Global.last_item_edit = {
	"name" : thing_name,
	"floating" : floating,
	"rotation" : rotation_degrees
	}

func adjust_settings():
	$CanvasLayer/Rotation/TextEdit.text = str(rotation_degrees)
	$CanvasLayer/Floating/CheckBox.button_pressed = floating
