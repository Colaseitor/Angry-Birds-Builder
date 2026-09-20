extends Node2D
var birds = [
	"res://Scenes/TitleScreenBirds/title_screen_red.tscn",
	"res://Scenes/TitleScreenBirds/title_screen_chuck.tscn",
	"res://Scenes/TitleScreenBirds/title_screen_laser_bird.tscn",
	"res://Scenes/TitleScreenBirds/title_screen_the_blues.tscn",
	"res://Scenes/TitleScreenBirds/title_screen_terence.tscn",
	"res://Scenes/TitleScreenBirds/title_screen_red_fuji_tv.tscn",
	"res://Scenes/TitleScreenBirds/title_screen_terence_rio_2.tscn",
	"res://Scenes/TitleScreenBirds/title_screen_shakira.tscn",
	"res://Scenes/TitleScreenBirds/title_screen_tony.tscn",
	"res://Scenes/TitleScreenBirds/title_screen_hockey_bird.tscn",
	"res://Scenes/TitleScreenBirds/title_screen_chuck_pikachu.tscn",
	"res://Scenes/TitleScreenBirds/title_screen_matilda.tscn",
	"res://Scenes/TitleScreenBirds/title_screen_bomb.tscn"
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var theme = Global.last_theme
	if theme == "Poached Eggs":
		add_child(load("res://Scenes/TitleScreenThemes/poached_eggs.tscn").instantiate())
	elif theme == "Trick or Treat":
		add_child(load("res://Scenes/TitleScreenThemes/trick_or_treat.tscn").instantiate())
	elif theme == "South Hamerica" || theme == "South Hamerica-NG":
		add_child(load("res://Scenes/TitleScreenThemes/south_hamerica.tscn").instantiate())
	elif theme == "Coca-Cola 1":
		add_child(load("res://Scenes/TitleScreenThemes/coca-cola_1.tscn").instantiate())
	elif theme == "Cheetos 1":
		add_child(load("res://Scenes/TitleScreenThemes/cheetos_1.tscn").instantiate())
	elif theme == "Winter Wonderham":
		add_child(load("res://Scenes/TitleScreenThemes/winter_wonderham.tscn").instantiate())
	elif theme == "Poached Eggs 3":
		add_child(load("res://Scenes/TitleScreenThemes/poached_eggs_3.tscn").instantiate())
	elif theme == "Jungle Escape":
		add_child(load("res://Scenes/TitleScreenThemes/jungle_escape.tscn").instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	add_child(load(birds[randi_range(0, birds.size() - 1)]).instantiate())
	#var random_bird = randi_range(1,12)
	#if random_bird == 1:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_red.tscn").instantiate())
	#elif random_bird == 2:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_chuck.tscn").instantiate())
	#elif random_bird == 3:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_laser_bird.tscn").instantiate())
	#elif random_bird == 4:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_the_blues.tscn").instantiate())
	#elif random_bird == 5:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_terence.tscn").instantiate())
	#elif random_bird == 6:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_red_fuji_tv.tscn").instantiate())
	#elif random_bird == 7:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_terence_rio_2.tscn").instantiate())
	#elif random_bird == 8:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_shakira.tscn").instantiate())
	#elif random_bird == 9:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_tony.tscn").instantiate())
	#elif random_bird == 10:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_hockey_bird.tscn").instantiate())
	#elif random_bird == 11:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_chuck_pikachu.tscn").instantiate())
	#elif random_bird == 12:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_matilda.tscn").instantiate())
	#elif random_bird == 13:
		#add_child(load("res://Scenes/TitleScreenBirds/title_screen_bomb.tscn").instantiate())


func _on_load_button_down() -> void:
	$Edit/FileDialog.show()
	$ButtonSound.play()


func _on_file_dialog_file_selected(path: String) -> void:
	Global.file = FileAccess.open(path, FileAccess.READ)
	Global.opening_file = true
	get_tree().change_scene_to_file("res://Scenes/editor.tscn")


func _on_new_button_down() -> void:
	Global.opening_file = false
	$ThemeSelector.appear()
	$ButtonSound.play()


func _on_play_button_down() -> void:
	$Play/FileDialog.show()
	$ButtonSound.play()


func _on_play_file_dialog_file_selected(path: String) -> void:
	Global.file = path
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_cancel_button_down() -> void:
	$EditScreen.hide()
	$ButtonBack.play()


func _on_edit_button_down() -> void:
	$EditScreen.show()
	$ButtonSound.play()

func pick_theme(theme):
	Global.theme = theme
	get_tree().change_scene_to_file("res://Scenes/editor.tscn")
