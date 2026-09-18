extends RigidBody2D
var pressable = true
@export var yell_frame = 2
var random_scale = randf_range(1.2,3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_impulse(Vector2(randf_range(500,1500),randf_range(50,-1500)))
	position = Vector2(-1885.0, randf_range(-1118,852))
	$Sprite2D.scale = $Sprite2D.scale * random_scale


func _on_area_2d_input_event(_a, _b, _c) -> void:
	if Input.is_action_just_pressed("Left_Mouse") && random_scale > 2 && pressable:
		var random_red_yell = randi_range(1,4)
		if random_red_yell == 1:
			$Throw.play()
		elif random_red_yell == 2:
			$"105_Sfx-BirdRedCharge01".play()
		elif random_red_yell == 3:
			$"106_Sfx-BirdRedCharge02".play()
		else:
			$"107_Sfx-BirdRedCharge03".play()
		$Sprite2D.frame = yell_frame
		pressable = false

func _process(_delta: float) -> void:
	if position.y > 4000:
		queue_free()
