extends RigidBody2D
var pressable = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_impulse(Vector2(randf_range(500,1500),randf_range(50,-1500)))
	position = Vector2(-1885.0, randf_range(-1118,852))
	var random_scale = randf_range(1.2,3)
	$Sprite2D.scale = Vector2(random_scale,random_scale)


func _on_area_2d_input_event(_a, _b, _c) -> void:
	if Input.is_action_just_pressed("Left_Mouse") && $Sprite2D.scale.x > 2 && pressable:
		$Throw.play()
		$Sprite2D.frame = 3
		pressable = false

func _process(_delta: float) -> void:
	if position.y > 4000:
		queue_free()
