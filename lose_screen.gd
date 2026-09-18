extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randi_range(1,2) == 1:
		$"233_Sfx-LevelFailedPigletsA1".play()
	else:
		$"234_Sfx-LevelFailedPigletsA2".play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_restart_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_menu_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
