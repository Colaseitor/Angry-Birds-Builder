extends Node2D
var theme
var screen = 0
# 0 - Editor | 1, 2  & 3 - Asset Selector  | 4 - Exit/Settings | 5 - Theme Selector
var type_select = 0
var star2
var star3
var ambience

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(load("res://Assets/Graphics/Other/Cursor 4.png"), Input.CURSOR_DRAG)
	if Global.opening_file:
		var file = Global.file
		while file.get_position() < file.get_length():
			var json_string = file.get_line()
			var json = JSON.new()
			var parse_result = json.parse(json_string)
			if not parse_result == OK:
				print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
				continue
			var node_data = json.data
			if node_data["type"] == "main":
				theme = node_data["theme"]
				$Slingshot.position = Vector2(node_data["sling x"], node_data["sling y"])
				star2 = node_data["star2"]
				
				star3 = node_data["star3"]
				ambience = node_data["ambience"]
			elif node_data["type"] == "block":
				var block
				if node_data["name"] == "Wood Square":
					block = load("res://EditorAssets/editor_square_wood.tscn").instantiate()
				elif node_data["name"] == "Wood Triangle":
					block = load("res://EditorAssets/editor_wood_triangle.tscn").instantiate()
				elif node_data["name"] == "Dog Piggen":
					block = load("res://EditorAssets/editor_dog_piggen.tscn").instantiate()
				elif node_data["name"] == "TNT":
					block = load("res://EditorAssets/editor_tnt.tscn").instantiate()
				elif node_data["name"] == "Old Pig":
					block = load("res://EditorAssets/editor_old_pig.tscn").instantiate()
				elif node_data["name"] == "Long Wood":
					block = load("res://EditorAssets/editor_long_wood.tscn").instantiate()
				elif node_data["name"] == "Big Rock":
					block = load("res://EditorAssets/editor_stone_big_rock.tscn").instantiate()
				elif node_data["name"] == "Glass Brick":
					block = load("res://EditorAssets/editor_glass_brick.tscn").instantiate()
				elif node_data["name"] == "Glass Square":
					block = load("res://EditorAssets/editor_glass_square.tscn").instantiate()
				elif node_data["name"] == "Longer Stone":
					block = load("res://EditorAssets/editor_longer_stone.tscn").instantiate()
				elif node_data["name"] == "Old Small Pig":
					block = load("res://EditorAssets/editor_old_small_pig.tscn").instantiate()
				elif node_data["name"] == "Pig":
					block = load("res://EditorAssets/editor_pig.tscn").instantiate()
				elif node_data["name"] == "Corporal Pig":
					block = load("res://EditorAssets/editor_corporal_pig.tscn").instantiate()
				block.position = Vector2(node_data["position x"],node_data["position y"])
				block.rotation_degrees = node_data["rotation"]
				block.life = node_data["life"]
				block.moving = false
				block.floating = node_data["floating"]
				$Blocks.add_child(block)
			elif node_data["type"] == "bird":
				var bird
				if node_data["name"] == "Red":
					bird = load("res://EditorAssets/editor_red.tscn").instantiate()
				elif node_data["name"] == "Chuck":
					bird = load("res://EditorAssets/editor_chuck.tscn").instantiate()
				elif node_data["name"] == "Lazer Bird":
					bird = load("res://EditorAssets/editor_lazer_bird.tscn").instantiate()
				elif node_data["name"] == "The Blues":
					bird = load("res://EditorAssets/editor_the_blues.tscn").instantiate()
				elif node_data["name"] == "Terence":
					bird = load("res://EditorAssets/editor_terence.tscn").instantiate()
				elif node_data["name"] == "Red Fuji TV":
					bird = load("res://EditorAssets/editor_red_fuji_tv.tscn").instantiate()
				elif node_data["name"] == "Terence Rio 2":
					bird = load("res://EditorAssets/editor_terence_rio_2.tscn").instantiate()
				elif node_data["name"] == "Shakira":
					bird = load("res://EditorAssets/editor_shakira.tscn").instantiate()
				elif node_data["name"] == "Tony":
					bird = load("res://EditorAssets/editor_tony.tscn").instantiate()
				elif node_data["name"] == "Hockey Bird":
					bird = load("res://EditorAssets/editor_hockey_bird.tscn").instantiate()
				elif node_data["name"] == "Chuck Pikachu":
					bird = load("res://EditorAssets/editor_chuck_pikachu.tscn").instantiate()
				elif node_data["name"] == "Bomb":
					bird = load("res://EditorAssets/editor_bomb.tscn").instantiate()
				elif node_data["name"] == "Matilda":
					bird = load("res://EditorAssets/editor_matilda.tscn").instantiate()
				bird.position = Vector2(node_data["position x"],node_data["position y"])
				bird.rotation_degrees = node_data["rotation"]
				bird.moving = false
				$Birds.add_child(bird)
			elif node_data["type"] == "ground":
				var ground
				if node_data["name"] == "Ground Square":
					ground = load("res://EditorAssets/editor_ground_square.tscn").instantiate()
				elif node_data["name"] == "Ground Triangle":
					ground = load("res://EditorAssets/editor_ground_triangle.tscn").instantiate()
				elif node_data["name"] == "Ground Circle":
					ground = load("res://EditorAssets/editor_ground_circle.tscn").instantiate()
				ground.position = Vector2(node_data["position x"],node_data["position y"])
				ground.rotation_degrees = node_data["rotation"]
				ground.moving = false
				ground.scale = Vector2(node_data["width"],node_data["heigth"])
				$Ground.add_child(ground)
	else:
		theme = Global.theme
		star2 = 20000
		star3 = 40000
		ambience = 0
	$EditorUI/Settings/Star2.text = str(star2)
	$EditorUI/Settings/Star3.text = str(star3)
	apply_theme()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var spots = get_tree().get_nodes_in_group("Spots").size()
	if spots > 0:
		get_tree().get_nodes_in_group("Spots")[-1].position.x = 285
	if spots > 1:
		get_tree().get_nodes_in_group("Spots")[-2].position.x = 542
	if spots > 2:
		get_tree().get_nodes_in_group("Spots")[-3].position.x = 799
	if spots > 3:
		get_tree().get_nodes_in_group("Spots")[-4].position.x = 1057
	if spots > 4:
		get_tree().get_nodes_in_group("Spots")[-5].position.x = 1313
	if spots > 5:
		get_tree().get_nodes_in_group("Spots")[-6].position.x = 1570
	if spots > 6:
		get_tree().get_nodes_in_group("Spots")[-7].position.x = 1827
	if spots > 7:
		get_tree().get_nodes_in_group("Spots")[-8].position.x = 2084
	if spots > 8:
		get_tree().get_nodes_in_group("Spots")[-9].position.x = 2341
	if spots > 9:
		get_tree().get_nodes_in_group("Spots")[-10].position.x = 2598
	if spots > 10:
		get_tree().get_nodes_in_group("Spots")[-11].position.x = 2855
	if spots > 11:
		get_tree().get_nodes_in_group("Spots")[-12].queue_free()
	if Input.is_action_just_pressed("Re-add item"):
		if Global.last_item != "None":
			add_asset(Global.last_item)
	if Input.is_action_just_pressed("Re-add specific"):
		if Global.last_item_edit.get("name") != "None":
			add_asset(Global.last_item_edit.get("name"))
			get_tree().get_nodes_in_group("Editable Thing")[-1].floating = Global.last_item_edit.get("floating")
			get_tree().get_nodes_in_group("Editable Thing")[-1].rotation_degrees = Global.last_item_edit.get("rotation")
			get_tree().get_nodes_in_group("Editable Thing")[-1].moving = false
			get_tree().get_nodes_in_group("Editable Thing")[-1].adjust_settings()
			get_tree().get_nodes_in_group("Editable Thing")[-1].global_position = get_global_mouse_position()


func _on_exit_button_down() -> void:
	if screen == 0:
		$EditorUI/ExitCofirm.show()
		$ButtonSound.play()
		screen = 4


func _on_add_button_down() -> void:
	if screen == 0:
		for select in $AssetSelector.get_children():
			select.hide()
		$AssetSelector/BackButton.show()
		$AssetSelector/TypeSelect.show()
		$AssetSelector.show()
		screen = 1
		$ButtonSound.play()

func _on_type_select_item_activated(index: int) -> void:
	screen = 2
	if index == 4:
		$AssetSelector/TypeSelect.hide()
		$ButtonSound.play()
		$AssetSelector/GroundList.show()
	else:
		type_select = index
		$AssetSelector/TypeSelect.hide()
		$ButtonSound.play()
		show_available_games()
		$AssetSelector/GameSelect.show()

func show_available_games():
	if type_select == 0:
		$AssetSelector/GameSelect.set_item_disabled(0, false)
		$AssetSelector/GameSelect.set_item_disabled(1, true)
		$AssetSelector/GameSelect.set_item_disabled(2, true)
		$AssetSelector/GameSelect.set_item_disabled(3, true)
		$AssetSelector/GameSelect.set_item_disabled(4, true)
		$AssetSelector/GameSelect.set_item_disabled(5, true)
		$AssetSelector/GameSelect.set_item_disabled(6, true)
		$AssetSelector/GameSelect.set_item_disabled(7, true)
		$AssetSelector/GameSelect.set_item_disabled(8, true)
		$AssetSelector/GameSelect.set_item_disabled(9, true)
		$AssetSelector/GameSelect.set_item_disabled(10, true)
		$AssetSelector/GameSelect.set_item_disabled(11, true)
	if type_select == 1:
		$AssetSelector/GameSelect.set_item_disabled(0, false)
		$AssetSelector/GameSelect.set_item_disabled(1, true)
		$AssetSelector/GameSelect.set_item_disabled(2, true)
		$AssetSelector/GameSelect.set_item_disabled(3, true)
		$AssetSelector/GameSelect.set_item_disabled(4, true)
		$AssetSelector/GameSelect.set_item_disabled(5, true)
		$AssetSelector/GameSelect.set_item_disabled(6, true)
		$AssetSelector/GameSelect.set_item_disabled(7, true)
		$AssetSelector/GameSelect.set_item_disabled(8, true)
		$AssetSelector/GameSelect.set_item_disabled(9, true)
		$AssetSelector/GameSelect.set_item_disabled(10, true)
		$AssetSelector/GameSelect.set_item_disabled(11, true)
	if type_select == 2:
		$AssetSelector/GameSelect.set_item_disabled(0, false)
		$AssetSelector/GameSelect.set_item_disabled(1, true)
		$AssetSelector/GameSelect.set_item_disabled(2, true)
		$AssetSelector/GameSelect.set_item_disabled(3, true)
		$AssetSelector/GameSelect.set_item_disabled(4, true)
		$AssetSelector/GameSelect.set_item_disabled(5, true)
		$AssetSelector/GameSelect.set_item_disabled(6, true)
		$AssetSelector/GameSelect.set_item_disabled(7, true)
		$AssetSelector/GameSelect.set_item_disabled(8, true)
		$AssetSelector/GameSelect.set_item_disabled(9, true)
		$AssetSelector/GameSelect.set_item_disabled(10, true)
		$AssetSelector/GameSelect.set_item_disabled(11, false)
	if type_select == 3:
		$AssetSelector/GameSelect.set_item_disabled(0, false)
		$AssetSelector/GameSelect.set_item_disabled(1, false)
		$AssetSelector/GameSelect.set_item_disabled(2, true)
		$AssetSelector/GameSelect.set_item_disabled(3, false)
		$AssetSelector/GameSelect.set_item_disabled(4, true)
		$AssetSelector/GameSelect.set_item_disabled(5, true)
		$AssetSelector/GameSelect.set_item_disabled(6, true)
		$AssetSelector/GameSelect.set_item_disabled(7, true)
		$AssetSelector/GameSelect.set_item_disabled(8, true)
		$AssetSelector/GameSelect.set_item_disabled(9, true)
		$AssetSelector/GameSelect.set_item_disabled(10, true)
		$AssetSelector/GameSelect.set_item_disabled(11, true)


func _on_game_select_item_activated(index: int) -> void:
	screen = 3
	$ButtonSound.play()
	$AssetSelector/GameSelect.hide()
	if type_select == 0:
		if index == 0:
			$AssetSelector/ABCBlockList.show()
	elif type_select == 1:
		if index == 0:
			$AssetSelector/ABCItemList.show()
	elif type_select == 2:
		if index == 0:
			$AssetSelector/ABCPigList.show()
		elif index == 11:
			$AssetSelector/FanPigList.show()
	elif type_select == 3:
		if index == 0:
			$AssetSelector/ABCBirdList.show()
		if index == 1:
			$AssetSelector/ABSeBirdList.show()
		if index == 3:
			$AssetSelector/ABSpBirdList.show()


func _on_back_button_button_down() -> void:
	$ButtonBack.play()
	if screen == 1:
		screen = 0
		$AssetSelector.hide()
	elif screen == 2:
		screen = 1
		for select in $AssetSelector.get_children():
			select.hide()
		$AssetSelector/BackButton.show()
		$AssetSelector/TypeSelect.show()
	elif screen == 3:
		screen = 2
		for select in $AssetSelector.get_children():
			select.hide()
		show_available_games()
		$AssetSelector/BackButton.show()
		$AssetSelector/GameSelect.show()


func add_asset(asset) -> void:
	if asset == "Wood Square":
		$Blocks.add_child(load("res://EditorAssets/editor_square_wood.tscn").instantiate())
	elif asset == "Wood Triangle":
		$Blocks.add_child(load("res://EditorAssets/editor_wood_triangle.tscn").instantiate())
	elif asset == "Dog Piggen":
		$Blocks.add_child(load("res://EditorAssets/editor_dog_piggen.tscn").instantiate())
	elif asset == "TNT":
		$Blocks.add_child(load("res://EditorAssets/editor_tnt.tscn").instantiate())
	elif asset == "Old Pig":
		$Blocks.add_child(load("res://EditorAssets/editor_old_pig.tscn").instantiate())
	elif asset == "Red":
		$Birds.add_child(load("res://EditorAssets/editor_red.tscn").instantiate())
	elif asset == "Chuck":
		$Birds.add_child(load("res://EditorAssets/editor_chuck.tscn").instantiate())
	elif asset == "Ground Square":
		$Ground.add_child(load("res://EditorAssets/editor_ground_square.tscn").instantiate())
	elif asset == "Ground Triangle":
		$Ground.add_child(load("res://EditorAssets/editor_ground_triangle.tscn").instantiate())
	elif asset == "Ground Circle":
		$Ground.add_child(load("res://EditorAssets/editor_ground_circle.tscn").instantiate())
	elif asset == "Lazer Bird":
		$Birds.add_child(load("res://EditorAssets/editor_lazer_bird.tscn").instantiate())
	elif asset == "The Blues":
		$Birds.add_child(load("res://EditorAssets/editor_the_blues.tscn").instantiate())
	elif asset == "Long Wood":
		$Blocks.add_child(load("res://EditorAssets/editor_long_wood.tscn").instantiate())
	elif asset == "Big Rock":
		$Blocks.add_child(load("res://EditorAssets/editor_stone_big_rock.tscn").instantiate())
	elif asset == "Glass Brick":
		$Blocks.add_child(load("res://EditorAssets/editor_glass_brick.tscn").instantiate())
	elif asset == "Glass Square":
		$Blocks.add_child(load("res://EditorAssets/editor_glass_square.tscn").instantiate())
	elif asset == "Longer Stone":
		$Blocks.add_child(load("res://EditorAssets/editor_longer_stone.tscn").instantiate())
	elif asset == "Terence":
		$Birds.add_child(load("res://EditorAssets/editor_terence.tscn").instantiate())
	elif asset == "Red Fuji TV":
		$Birds.add_child(load("res://EditorAssets/editor_red_fuji_tv.tscn").instantiate())
	elif asset == "Terence Rio 2":
		$Birds.add_child(load("res://EditorAssets/editor_terence_rio_2.tscn").instantiate())
	elif asset == "Shakira":
		$Birds.add_child(load("res://EditorAssets/editor_shakira.tscn").instantiate())
	elif asset == "Tony":
		$Birds.add_child(load("res://EditorAssets/editor_tony.tscn").instantiate())
	elif asset == "Hockey Bird":
		$Birds.add_child(load("res://EditorAssets/editor_hockey_bird.tscn").instantiate())
	elif asset == "Chuck Pikachu":
		$Birds.add_child(load("res://EditorAssets/editor_chuck_pikachu.tscn").instantiate())
	elif asset == "Bomb":
		$Birds.add_child(load("res://EditorAssets/editor_bomb.tscn").instantiate())
	elif asset == "Old Small Pig":
		$Blocks.add_child(load("res://EditorAssets/editor_old_small_pig.tscn").instantiate())
	elif asset == "Pig":
		$Blocks.add_child(load("res://EditorAssets/editor_pig.tscn").instantiate())
	elif asset == "Corporal Pig":
		$Blocks.add_child(load("res://EditorAssets/editor_corporal_pig.tscn").instantiate())
	elif asset == "Matilda":
		$Birds.add_child(load("res://EditorAssets/editor_matilda.tscn").instantiate())


func _on_texture_button_button_down() -> void:
	$EditorUI/Save/FileDialog.show()


func _on_file_dialog_save_file_selected(path: String) -> void:
	var file = FileAccess.open(path, FileAccess.WRITE)
	var main_data = {
		"type" : "main",
		"theme" : theme,
		"sling x" : $Slingshot.position.x,
		"sling y" : $Slingshot.position.y,
		"sling rot" : $Slingshot.rotation_degrees,
		"star2" : star2,
		"star3" : star3,
		"ambience" : ambience
	}
	file.store_line(JSON.stringify(main_data))
	for block in $Blocks.get_children():
		var save_dict = {
			"type" : "block",
			"name" : block.thing_name,
			"position x" : block.position.x,
			"position y" : block.position.y,
			"rotation" : block.rotation_degrees,
			"life" : block.life,
			"floating" : block.floating
		}
		file.store_line(JSON.stringify(save_dict))
	for bird in $Birds.get_children():
		var save_dict = {
			"type" : "bird",
			"name" : bird.thing_name,
			"position x" : bird.position.x,
			"position y" : bird.position.y,
			"rotation" : bird.rotation_degrees
		}
		file.store_line(JSON.stringify(save_dict))
	for ground in $Ground.get_children():
		var save_dict = {
			"type" : "ground",
			"name" : ground.thing_name,
			"position x" : ground.position.x,
			"position y" : ground.position.y,
			"rotation" : ground.rotation_degrees,
			"heigth" : ground.scale.y,
			"width" : ground.scale.x
		}
		file.store_line(JSON.stringify(save_dict))
	file.close()

func _on_abc_block_list_item_activated(index: int) -> void:
	$ButtonSound.play()
	$AssetSelector.hide()
	screen = 0
	var selection = $AssetSelector/ABCBlockList.get_item_text(index)
	if selection == "Wood Square":
		$EditorUI.add_child(load("res://EditorSpot/spot_square_wood.tscn").instantiate())
	elif selection == "Wood Triangle":
		$EditorUI.add_child(load("res://EditorSpot/spot_wood_triangle.tscn").instantiate())
	elif selection == "Long Wood":
		$EditorUI.add_child(load("res://EditorSpot/spot_long_wood.tscn").instantiate())
	elif selection == "Big Rock":
		$EditorUI.add_child(load("res://EditorSpot/spot_big_rock.tscn").instantiate())
	elif selection == "Glass Brick":
		$EditorUI.add_child(load("res://EditorSpot/spot_glass_brick.tscn").instantiate())
	elif selection == "Glass Square":
		$EditorUI.add_child(load("res://EditorSpot/spot_square_glass.tscn").instantiate())
	elif selection == "Longer Stone":
		$EditorUI.add_child(load("res://EditorSpot/spot_longer_stone.tscn").instantiate())


func _on_fan_pig_list_item_activated(index: int) -> void:
	$ButtonSound.play()
	$AssetSelector.hide()
	screen = 0
	if index == 0:
		$EditorUI.add_child(load("res://EditorSpot/spot_dog_piggen.tscn").instantiate())


func _on_abc_item_list_item_activated(index: int) -> void:
	$ButtonSound.play()
	$AssetSelector.hide()
	screen = 0
	var selection = $AssetSelector/ABCItemList.get_item_text(index)
	if selection == "TNT":
		$EditorUI.add_child(load("res://EditorSpot/spot_tnt.tscn").instantiate())


func _on_abc_pig_list_item_activated(index: int) -> void:
	$ButtonSound.play()
	$AssetSelector.hide()
	screen = 0
	var selection = $AssetSelector/ABCPigList.get_item_text(index)
	if selection == "Old Pig":
		$EditorUI.add_child(load("res://EditorSpot/spot_old_pig.tscn").instantiate())
	elif selection == "Old Small Pig":
		$EditorUI.add_child(load("res://EditorSpot/spot_old_small_pig.tscn").instantiate())
	if selection == "Pig":
		$EditorUI.add_child(load("res://EditorSpot/spot_pig.tscn").instantiate())
	if selection == "Corporal Pig":
		$EditorUI.add_child(load("res://EditorSpot/spot_corporal_pig.tscn").instantiate())


func _on_abc_bird_list_item_activated(index: int) -> void:
	$ButtonSound.play()
	$AssetSelector.hide()
	screen = 0
	var selection = $AssetSelector/ABCBirdList.get_item_text(index)
	if selection == "Red":
		$EditorUI.add_child(load("res://EditorSpot/spot_red.tscn").instantiate())
	elif selection == "Chuck":
		$EditorUI.add_child(load("res://EditorSpot/spot_chuck.tscn").instantiate())
	elif selection == "The Blues":
		$EditorUI.add_child(load("res://EditorSpot/spot_the_blues.tscn").instantiate())
	elif selection == "Terence":
		$EditorUI.add_child(load("res://EditorSpot/spot_terence.tscn").instantiate())
	elif selection == "Bomb":
		$EditorUI.add_child(load("res://EditorSpot/spot_bomb.tscn").instantiate())
	elif selection == "Matilda":
		$EditorUI.add_child(load("res://EditorSpot/spot_matilda.tscn").instantiate())


func _on_cancel_button_down() -> void:
	$EditorUI/ExitCofirm.hide()
	$ButtonBack.play()
	screen = 0


func _on_confirm_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_star_2_text_changed(new_text: String) -> void:
	if new_text.is_valid_int():
		star2 = int(new_text)
	else:
		$EditorUI/Settings/Star2.text = str(star2)


func _on_star_3_text_changed(new_text: String) -> void:
	if new_text.is_valid_int():
		star3 = int(new_text)
	else:
		$EditorUI/Settings/Star3.text = str(star3)


func _on_settings_cancel_button_down() -> void:
	$EditorUI/Settings.hide()
	screen = 0
	$ButtonBack.play()


func _on_settings_button_button_down() -> void:
	if screen == 0:
		$EditorUI/Settings.show()
		screen = 4
		$ButtonSound.play()


func _on_option_button_item_selected(index: int) -> void:
	ambience = index
	if $EditorUI/Settings/OptionButton.item_count > 1:
		for pingases in get_tree().get_nodes_in_group("Theme"):
			pingases.restart_ambience()
		


func _on_ground_list_item_activated(index: int) -> void:
	$ButtonSound.play()
	$AssetSelector.hide()
	screen = 0
	if index == 0:
		$EditorUI.add_child(load("res://EditorSpot/spot_ground_square.tscn").instantiate())
	elif index == 2:
		$EditorUI.add_child(load("res://EditorSpot/spot_ground_triangle.tscn").instantiate())
	if index == 1:
		$EditorUI.add_child(load("res://EditorSpot/spot_ground_circle.tscn").instantiate())


func _on_abs_bird_list_item_activated(index: int) -> void:
	$ButtonSound.play()
	$AssetSelector.hide()
	screen = 0
	var selection = $AssetSelector/ABSpBirdList.get_item_text(index)
	if selection == "Lazer Bird":
		$EditorUI.add_child(load("res://EditorSpot/spot_lazer_bird.tscn").instantiate())

func apply_theme():
	$EditorUI/Settings/OptionButton.clear()
	$EditorUI/Settings/OptionButton.add_item("Regular Ambience")
	Global.last_theme = theme
	if theme == "Poached Eggs":
		add_child(load("res://Themes/ABClassic/poached_eggs.tscn").instantiate())
		$EditorUI/Settings/OptionButton.add_item("Trilogy Ambience")
	elif theme == "Poached Eggs 3":
		add_child(load("res://Themes/ABClassic/poached_eggs_3.tscn").instantiate())
		$EditorUI/Settings/OptionButton.add_item("Trilogy Ambience")
	elif theme == "Trick or Treat":
		add_child(load("res://Themes/ABSeasons/trick_or_treat.tscn").instantiate())
	elif theme == "South Hamerica":
		add_child(load("res://Themes/ABSeasons/south_hamerica-ground.tscn").instantiate())
	elif theme == "South Hamerica-NG":
		add_child(load("res://Themes/ABSeasons/south_hamerica-no_ground.tscn").instantiate())
	elif theme == "Coca-Cola 1":
		add_child(load("res://Themes/Other/Coca-Cola 1.tscn").instantiate())
	elif theme == "Cheetos 1":
		add_child(load("res://Themes/Other/Cheetos 1.tscn").instantiate())
	elif theme == "Winter Wonderham":
		add_child(load("res://Themes/ABSeasons/winter_wonderham.tscn").instantiate())
	elif theme == "Jungle Escape":
		add_child(load("res://Themes/ABRio/jungle_escape.tscn").instantiate())


func _on_select_theme_button_down() -> void:
	$ThemeSelector.appear()
	screen = 5

func pick_theme(this_pibby):
	for pingases in get_tree().get_nodes_in_group("Theme"):
		pingases.queue_free()
	theme = this_pibby
	apply_theme()


func _on_ab_se_bird_list_item_activated(index: int) -> void:
	$ButtonSound.play()
	$AssetSelector.hide()
	screen = 0
	var selection = $AssetSelector/ABSeBirdList.get_item_text(index)
	if selection == "Tony":
		$EditorUI.add_child(load("res://EditorSpot/spot_tony.tscn").instantiate())
