extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Add.position.x = get_viewport_rect().size.x / 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Add.position.x = get_viewport_rect().size.x / 3
