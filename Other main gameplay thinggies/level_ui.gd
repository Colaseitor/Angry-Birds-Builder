extends Control
func _ready() -> void:
	position.y = -get_viewport_rect().size.y / 1.2
	$Score.position.x = get_viewport_rect().size.x / 3
	$Skip.position = Vector2(get_viewport_rect().size.x / 3, get_viewport_rect().size.y / 3.15)
	#scale = Vector2(1 / get_parent().zoom.x * 3, 1 / get_parent().zoom.y * 3)
	pass

func _on_restart_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _process(_delta: float) -> void:
	position.y = -get_viewport_rect().size.y  / get_viewport_rect().size.x
	$Score.position.x = get_viewport_rect().size.x / 2.75
	$Skip.position = Vector2(get_viewport_rect().size.x / 3, get_viewport_rect().size.y / 3.15)
	#scale = Vector2(1 / get_parent().zoom.x * 3, 1 / get_parent().zoom.y * 3)
	#if get_parent().position.x > 600:
		#position.x - -692.0 - 600
	#else:
		#position.x = -692.0 - get_parent().position.x


func _on_pause_button_down() -> void:
	get_parent().get_parent().get_parent().pause()


func _on_skip_button_down() -> void:
	get_parent().get_parent().get_parent().points += get_parent().get_parent().get_child(0).birds * 10000
	if get_parent().get_parent().pigs == 0:
		get_parent().get_parent().state = 1
	get_parent().get_parent().get_parent()._on_end_level_timeout()
