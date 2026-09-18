extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_released("Scroll Up"):
			if zoom.x < 2.5:
				zoom += Vector2(0.1,0.1)
				position = get_global_mouse_position()
	if Input.is_action_just_released("Scroll Down"):
		if zoom.x > 1:
			zoom -= Vector2(0.1,0.1)
			position = get_global_mouse_position()
