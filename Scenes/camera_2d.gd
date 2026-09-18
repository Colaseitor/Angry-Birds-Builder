extends Camera2D
var moved = true
var following = false
var following2 = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_parent().get_child(0).position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_parent().state == 0:
		if Input.is_action_just_released("Scroll Up"):
			if zoom.x < 2.5:
				zoom += Vector2(0.1,0.1)
		if Input.is_action_just_released("Scroll Down"):
			if zoom.x > 1:
				zoom -= Vector2(0.1,0.1)
		if get_parent().get_child(0).SlingshotState == get_parent().get_child(0).SlingState.birdThrown:
			if following == false:
				following = true
		if following && get_parent().get_parent().get_tree().get_nodes_in_group("ThrownBird").size() > 0:
			if get_parent().get_parent().get_tree().get_nodes_in_group("ThrownBird")[-1].position.x < 2500:
				position = get_parent().get_parent().get_tree().get_nodes_in_group("ThrownBird")[-1].position + get_parent().get_child(0).position
				moved = false
				if get_parent().get_parent().get_tree().get_nodes_in_group("ThrownBird")[-1].state == get_parent().get_parent().get_tree().get_nodes_in_group("ThrownBird")[-1].BirdState.Corpse:
					if following2 == false:
						$FollowTimer.start()
						following2 = true
			else:
				if moved == false:
					position = get_parent().get_child(0).position
					moved = true
		else:
			if moved == false:
				position = get_parent().get_child(0).position
				moved = true
	elif get_parent().state == 1:
		position = get_parent().get_child(0).position


func _on_follow_timer_timeout() -> void:
	following = false
	following2 = false
