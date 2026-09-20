extends Node2D
var level_ended = false
var points
var level_ended_screen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open(Global.file, FileAccess.READ)
	while file.get_position() < file.get_length():
		var json_string = file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var node_data = json.data
		if node_data["type"] == "main":
			$Level.ambience = node_data["ambience"]
			if node_data["theme"] == "Poached Eggs":
				$Level.add_child(load("res://Themes/ABClassic/poached_eggs.tscn").instantiate())
			elif node_data["theme"] == "Trick or Treat":
				$Level.add_child(load("res://Themes/ABSeasons/trick_or_treat.tscn").instantiate())
			elif node_data["theme"] == "South Hamerica":
				$Level.add_child(load("res://Themes/ABSeasons/south_hamerica-ground.tscn").instantiate())
			elif node_data["theme"] == "South Hamerica-NG":
				$Level.add_child(load("res://Themes/ABSeasons/south_hamerica-no_ground.tscn").instantiate())
			elif node_data["theme"] == "Coca-Cola 1":
				$Level.add_child(load("res://Themes/Other/Coca-Cola 1.tscn").instantiate())
			elif node_data["theme"] == "Cheetos 1":
				$Level.add_child(load("res://Themes/Other/Cheetos 1.tscn").instantiate())
			elif node_data["theme"] == "Winter Wonderham":
				$Level.add_child(load("res://Themes/ABSeasons/winter_wonderham.tscn").instantiate())
			if node_data["theme"] == "Poached Eggs 3":
				$Level.add_child(load("res://Themes/ABClassic/poached_eggs_3.tscn").instantiate())
			if node_data["theme"] == "Jungle Escape":
				$Level.add_child(load("res://Themes/ABRio/jungle_escape.tscn").instantiate())
			$Level/Slingshot.position = Vector2(node_data["sling x"], node_data["sling y"])
			$Level/Slingshot.rotation_degrees = node_data["sling rot"]
			$Level.star2 = node_data["star2"]
			$Level.star3 = node_data["star3"]
			Global.last_theme = node_data["theme"]
		elif node_data["type"] == "block":
			var block
			if node_data["name"] == "Wood Square":
				block = load("res://Blocks/ABClassic/SquareWood.tscn").instantiate()
			elif node_data["name"] == "Wood Triangle":
				block = load("res://Blocks/ABClassic/TriangleWood.tscn").instantiate()
			elif node_data["name"] == "Dog Piggen":
				block = load("res://Pigs/dog_piggen.tscn").instantiate()
			elif node_data["name"] == "TNT":
				block = load("res://Items/TNT.tscn").instantiate()
			elif node_data["name"] == "Old Pig":
				block = load("res://Pigs/Pig.tscn").instantiate()
			elif node_data["name"] == "Long Wood":
				block = load("res://Blocks/ABClassic/long_wood.tscn").instantiate()
			elif node_data["name"] == "Big Rock":
				block = load("res://Blocks/ABClassic/BigRockStone.tscn").instantiate()
			elif node_data["name"] == "Glass Brick":
				block = load("res://Blocks/ABClassic/GlassBrick.tscn").instantiate()
			elif node_data["name"] == "Glass Square":
				block = load("res://Blocks/ABClassic/glass_square.tscn").instantiate()
			elif node_data["name"] == "Longer Stone":
				block = load("res://Blocks/ABClassic/longer_stone.tscn").instantiate()
			elif node_data["name"] == "Old Small Pig":
				block = load("res://Pigs/small_pig.tscn").instantiate()
			elif node_data["name"] == "Pig":
				block = load("res://Pigs/modern_pig.tscn").instantiate()
			elif node_data["name"] == "Corporal Pig":
				block = load("res://Pigs/corporal_pig.tscn").instantiate()
			block.position = Vector2(node_data["position x"],node_data["position y"])
			block.rotation_degrees = node_data["rotation"]
			block.sleeping = node_data["floating"]
			if node_data["floating"]:
				block.gravity_scale = 0
			$Level/Blocks.add_child(block)
		elif node_data["type"] == "bird":
				var bird
				if node_data["name"] == "Red":
					bird = load("res://Birds/ABClassic/Red.tscn").instantiate()
				elif node_data["name"] == "Chuck":
					bird = load("res://Birds/ABClassic/Chuck.tscn").instantiate()
				elif node_data["name"] == "Lazer Bird":
					bird = load("res://Birds/ABSpace/LaserBird.tscn").instantiate()
				elif node_data["name"] == "The Blues":
					bird = load("res://Birds/ABClassic/TheBlues.tscn").instantiate()
				elif node_data["name"] == "Terence":
					bird = load("res://Birds/ABClassic/Terence.tscn").instantiate()
				elif node_data["name"] == "Red Fuji TV":
					bird = load("res://Birds/Other/red_fuji_tv.tscn").instantiate()
				elif node_data["name"] == "Terence Rio 2":
					bird = load("res://Birds/ABRio/terence_rio_2.tscn").instantiate()
				elif node_data["name"] == "Shakira":
					bird = load("res://Birds/ABFriends/shakira.tscn").instantiate()
				elif node_data["name"] == "Tony":
					bird = load("res://Birds/ABSeasons/tony.tscn").instantiate()
				elif node_data["name"] == "Hockey Bird":
					bird = load("res://Birds/ABFriends/hockey_bird.tscn").instantiate()
				elif node_data["name"] == "Chuck Pikachu":
					bird = load("res://Birds/ABSeasons/chuck_pikachu.tscn").instantiate()
				elif node_data["name"] == "Bomb":
					bird = load("res://Birds/ABClassic/bomb.tscn").instantiate()
				elif node_data["name"] == "Matilda":
					bird = load("res://Birds/ABClassic/matilda.tscn").instantiate()
				bird.position = Vector2(node_data["position x"],node_data["position y"]) - $Level/Slingshot.position
				bird.rotation_degrees = node_data["rotation"] - $Level/Slingshot.rotation
				$Level/Slingshot.add_child(bird)
		elif node_data["type"] == "ground":
			var ground
			if node_data["name"] == "Ground Square":
				ground = load("res://Other main gameplay thinggies/ground_square.tscn").instantiate()
			elif node_data["name"] == "Ground Triangle":
				ground = load("res://Other main gameplay thinggies/ground_triangle.tscn").instantiate()
			elif node_data["name"] == "Ground Circle":
				ground = load("res://Other main gameplay thinggies/ground_circle.tscn").instantiate()
			ground.position = Vector2(node_data["position x"],node_data["position y"])
			ground.rotation_degrees = node_data["rotation"]
			ground.scale = Vector2(node_data["width"],node_data["heigth"])
			$Level/Blocks.add_child(ground)
	file.close()
	$Level.start()
	$Level/Slingshot.start()
	$Level/Camera2D.position = $Level/Slingshot.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if ($Level.state == 1 || $Level.state == 2) && level_ended == false:
		level_ended = true
		$EndLevel.start()
	points = $Level.points
	if Input.is_action_just_pressed("Pause"):
		pause()


func _on_end_level_timeout() -> void:
	if level_ended_screen == false:
		$Level/CanvasLayer.hide()
		$Level.get_tree().paused = true
		level_ended_screen = true
		if $Level.state == 1:
			add_child(load("res://Other main gameplay thinggies/win_screen.tscn").instantiate())
			$WinScreen.points = points
		else:
			add_child(load("res://Other main gameplay thinggies/lose_screen.tscn").instantiate())

func pause():
	if $Level.state == 0:
		if get_tree().paused:
			get_tree().paused = false
			$Level/CanvasLayer/LevelUI.show()
			$PauseMenu.hide()
			$ButtonBack.play()
		else:
			get_tree().paused = true
			$Level/CanvasLayer/LevelUI.hide()
			$PauseMenu.show()
			$ButtonSound.play()


func _on_restart_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")



func _on_menu_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_unpause_button_down() -> void:
	pause()
