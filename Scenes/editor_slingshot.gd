extends Area2D
var moving = false
@export var thing_name: String
@export var max_life: int
var life = max_life

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_input_event(_a, _b, _c) -> void:
	if Input.is_action_just_pressed("Left_Mouse") && get_parent().screen == 0:
		moving = true
	#elif Input.is_action_just_pressed("Right Mouse") && get_parent().screen == 0:
		#get_parent().screen = 4
		#$CanvasLayer.show()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released("Left_Mouse"):
		moving = false
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if moving:
		$CollisionShape2D.position = get_global_mouse_position() - position - Vector2(-10,-99.5)
		Input.set_default_cursor_shape(Input.CURSOR_DRAG)
		var touching = 0
		for things in get_overlapping_bodies():
			touching += 1
		for things in get_overlapping_areas():
			touching += 1
		if touching == 0:
			position += $CollisionShape2D.position
			$CollisionShape2D.position = Vector2(-10,-99.5)
	else:
		$CollisionShape2D.position = Vector2(-10,-99.5)


func _on_close_button_down() -> void:
	#get_parent().screen = 0
	#$CanvasLayer.hide()
	pass


func _on_text_edit_text_changed(_new_text: String) -> void:
	#if new_text.is_valid_int():
		#rotation_degrees = int(new_text)
	#else:
		#$CanvasLayer/Rotation/TextEdit.text = str(rotation_degrees)
	pass
