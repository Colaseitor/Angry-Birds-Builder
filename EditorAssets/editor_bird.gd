extends Area2D
var moving = true
@export var thing_name: String
var number: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var current_number = 0
	for bird in get_tree().get_nodes_in_group("Birds"):
		current_number += 1
		if bird == self:
			number = current_number
	$Label.text = str(number)


func _on_input_event(_a, _b, _c) -> void:
	if Input.is_action_just_pressed("Left_Mouse") && get_parent().get_parent().screen == 0:
		moving = true
	elif Input.is_action_just_pressed("Center Mouse") && get_parent().get_parent().screen == 0:
		queue_free()
	elif Input.is_action_just_pressed("Right Mouse") && get_parent().get_parent().screen == 0:
		get_parent().get_parent().screen = 4
		$CanvasLayer.show()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released("Left_Mouse"):
		moving = false
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if moving:
		$CollisionShape2D.position = get_global_mouse_position() - position
		Input.set_default_cursor_shape(Input.CURSOR_DRAG)
		var touching = 0
		for things in get_overlapping_bodies():
			touching += 1
		for things in get_overlapping_areas():
			touching += 1
		if touching == 0:
			position += $CollisionShape2D.position
			$CollisionShape2D.position = Vector2(0,0)
	else:
		$CollisionShape2D.position = Vector2(0,0)


func _on_text_edit_text_changed(new_text: String) -> void:
	if new_text.is_valid_int():
		rotation_degrees = int(new_text)
	else:
		$CanvasLayer/Rotation/TextEdit.text = str(rotation_degrees)


func _on_close_button_down() -> void:
	get_parent().get_parent().screen = 0
	$CanvasLayer.hide()


func _on_skin_select_item_activated(index: int) -> void:
	var skin
	if $CanvasLayer/SkinSelect.get_item_text(index) == "Classic":
		if thing_name == "Red Fuji TV":
			skin = load("res://EditorAssets/editor_red.tscn").instantiate()
		elif thing_name == "Terence Rio 2":
			skin = load("res://EditorAssets/editor_terence.tscn").instantiate()
		elif thing_name == "Shakira" || thing_name == "Hockey Bird" || thing_name == "Chuck Pikachu":
			skin = load("res://EditorAssets/editor_chuck.tscn").instantiate()
	elif $CanvasLayer/SkinSelect.get_item_text(index) == "Fuji TV":
		if thing_name == "Red":
			skin = load("res://EditorAssets/editor_red_fuji_tv.tscn").instantiate()
			get_parent().get_parent().get_child(3).add_child(load("res://EditorSpot/spot_red_fuji_tv.tscn").instantiate())
	elif $CanvasLayer/SkinSelect.get_item_text(index) == "Rio 2":
		if thing_name == "Terence":
			skin = load("res://EditorAssets/editor_terence_rio_2.tscn").instantiate()
			get_parent().get_parent().get_child(3).add_child(load("res://EditorSpot/spot_terence_rio_2.tscn").instantiate())
	elif $CanvasLayer/SkinSelect.get_item_text(index) == "Shakira":
		if thing_name == "Chuck" || thing_name == "Hockey Bird" || thing_name == "Chuck Pikachu":
			skin = load("res://EditorAssets/editor_shakira.tscn").instantiate()
			get_parent().get_parent().get_child(3).add_child(load("res://EditorSpot/spot_shakira.tscn").instantiate())
	elif $CanvasLayer/SkinSelect.get_item_text(index) == "Hockey Bird":
		skin = load("res://EditorAssets/editor_hockey_bird.tscn").instantiate()
		get_parent().get_parent().get_child(3).add_child(load("res://EditorSpot/spot_hockey_bird.tscn").instantiate())
	elif $CanvasLayer/SkinSelect.get_item_text(index) == "Pikachu Bird Wear":
		skin = load("res://EditorAssets/editor_chuck_pikachu.tscn").instantiate()
		get_parent().get_parent().get_child(3).add_child(load("res://EditorSpot/spot_chuck_pikachu.tscn").instantiate())
	skin.position = position
	skin.moving = false
	skin.rotation_degrees = rotation_degrees
	get_parent().add_child(skin)
	queue_free()
	get_parent().get_parent().screen = 0


func _on_skins_button_down() -> void:
	$CanvasLayer/SkinSelect.show()
	$ButtonSound.play()


func _on_back_button_button_down() -> void:
	$ButtonBack.play()
	$CanvasLayer/SkinSelect.hide()
