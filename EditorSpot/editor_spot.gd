extends TextureButton
@export var thing_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_down() -> void:
	if get_parent().get_parent().screen == 0:
		if Input.is_action_just_pressed("Left_Mouse"):
			get_parent().get_parent().add_asset(thing_name)
			Global.last_item = thing_name
		if Input.is_action_just_pressed("Center Mouse"):
			queue_free()
