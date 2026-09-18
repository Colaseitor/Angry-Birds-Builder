extends Control
var phase = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_parent().position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if phase == 1:
		#$Label.font_size += 200 * delta #Empieza con 10 y termina con 50
		scale += Vector2(3,3) * delta
		$Sprite2D.position.y -= 500 * delta
	elif phase == 3:
		scale -= Vector2(3,3) * delta
		$Sprite2D.position.y += 500 * delta
	elif phase == 4:
		queue_free()


func _on_timer_timeout() -> void:
	phase += 1
