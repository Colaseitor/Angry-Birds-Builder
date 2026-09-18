extends CanvasLayer
var points
var points_shown = 0
var star = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"184_Sfx-GamescorescreenScoreCountLoop".play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if points > points_shown:
		points_shown += 15000 * delta
	else:
		points_shown = points
		$"184_Sfx-GamescorescreenScoreCountLoop".stop()
	$Points.text = str(int(points_shown))


func _on_star_timer_timeout() -> void:
	if star == 0:
		$StarSpot1/Star1.show()
		$Star1Sound.play()
		star = 1
	elif star == 1:
		if points >= get_parent().get_child(0).star2:
			$StarSpot2/Star2.show()
			$Star2Sound.play()
			star = 2
		else:
			$StarTimer.stop()
	elif star == 2:
		if points >= get_parent().get_child(0).star3:
			$StarSpot3/Star3.show()
			$Star3Sound.play()
			star = 3
		$StarTimer.stop()


func _on_restart_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_menu_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
