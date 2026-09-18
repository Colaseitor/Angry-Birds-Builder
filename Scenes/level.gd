extends Node2D
var points: int = 0
var shown_points = 0
var pigs: int = 0
var new_point_getter = points
var level_ending_timer = 0.0
var state = 0 # 0 - Normal game | 1 - Victory | 2 - Defeat
var star2
var star3
var ambience
var level_finished = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(load("res://Assets/Graphics/Other/Cursor 4.png"), Input.CURSOR_DRAG)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shown_points < points:
		shown_points += 100 * delta + (points - shown_points) * delta * 10
	if shown_points > points:
		shown_points = points
	$CanvasLayer/LevelUI/Score/Score2.text = str(int(shown_points))
	pigs = 0
	for pig in get_tree().get_nodes_in_group("Pigs"):
		if pig.dead == false:
			pigs += 1
	if pigs == 0 || $Slingshot.birds == 0:
		if level_ending_timer > 5:
			$CanvasLayer/LevelUI/Skip.hide()
			level_finished = true
			if pigs == 0:
				if state != 1:
					state = 1
					if randi_range(1,2) == 1:
						$Theme/Victory1.play()
					else:
						$Theme/Victory2.play()
			else:
				if state != 2:
					state = 2
		if new_point_getter != points:
			level_ending_timer = 0
		else:
			if level_finished == false:
				$CanvasLayer/LevelUI/Skip.show()
				level_ending_timer += 1 * delta
	else:
		if $CanvasLayer/LevelUI/Skip.visible:
			$CanvasLayer/LevelUI/Skip.hide()
			level_ending_timer = 0
	new_point_getter = points

func start():
	pigs = get_tree().get_nodes_in_group("Pigs").size()
	if randi_range(1,2) == 1:
		$Theme/LevelStart.play()
	else:
		$Theme/LevelStart2.play()
