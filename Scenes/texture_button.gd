extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = get_viewport_rect().size.x - 220
	position.y = get_viewport_rect().size.y - 220


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position.x = get_viewport_rect().size.x - 220
	position.y = get_viewport_rect().size.y - 220
