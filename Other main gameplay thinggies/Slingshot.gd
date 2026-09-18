extends Node2D
enum SlingState{
	idle,
	pulling,
	birdThrown,
	reset
}

var SlingshotState
var CenterOfSlingshot
var pulling_alot
var birds: int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	SlingshotState = SlingState.birdThrown
	$LeftLine.points[1] = $CenterOfSlingshot.position
	$RightLine.points[1] = $CenterOfSlingshot.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if get_parent().state == 0:
		match SlingshotState:
			SlingState.idle:
				pass
			SlingState.pulling:
				var player = get_tree().get_nodes_in_group("Player")[0]
				if Input.is_action_pressed("Left_Mouse"):
					var distance = get_global_mouse_position() - position
					Input.set_default_cursor_shape(Input.CURSOR_DRAG)
					if distance.distance_to($CenterOfSlingshot.position) > 100:
						distance = (distance - $CenterOfSlingshot.position).normalized() * 100 + $CenterOfSlingshot.position
					player.position = distance
					player.rotation = atan2(get_global_mouse_position()[1] - CenterOfSlingshot[1],get_global_mouse_position()[0] - CenterOfSlingshot[0]) - PI
					$LeftLine.points[1] = distance
					$RightLine.points[1] = distance
					if distance.distance_to($CenterOfSlingshot.position) > 30:
						if pulling_alot == false:
							$Grab.play()
							pulling_alot = true
					else:
						pulling_alot = false
				else:
					var location = get_global_mouse_position()
					Input.set_default_cursor_shape(Input.CURSOR_ARROW)
					if location.distance_to(CenterOfSlingshot) > 100:
						location = (location - CenterOfSlingshot).normalized() * 100 + CenterOfSlingshot
					var distance = location.distance_to(CenterOfSlingshot)
					var velocity = CenterOfSlingshot - location
					if distance > 30:
						player.ThrowBird()
						#player.apply_impulse((velocity * distance / 8), Vector2())
						if player.mass > 1:
							player.apply_impulse((velocity * distance / 20) + velocity * 12 * player.gravity_scale * player.mass, Vector2())
						else:
							player.apply_impulse((velocity * distance / 20) + velocity * 10 * player.gravity_scale * player.mass * player.mass, Vector2())
						player.remove_from_group("Player")
						birds -= 1
						$NextBirdTimer.start()
						SlingshotState = SlingState.birdThrown
						$LeftLine.points[1] = $CenterOfSlingshot.position
						$RightLine.points[1] = $CenterOfSlingshot.position
						var random_sound = randi_range(1,3)
						if random_sound == 1:
							$Shot1.play()
						elif random_sound == 2:
							$Shot2.play()
						else:
							$Shot3.play()
						get_parent().level_ending_timer = 0.0
					else:
						SlingshotState = SlingState.idle
						player.position = $CenterOfSlingshot.position
						$LeftLine.points[1] = $CenterOfSlingshot.position
						$RightLine.points[1] = $CenterOfSlingshot.position
						player.rotation = atan2(0,0)
						player.unselected()
			SlingState.birdThrown:
				pass
			SlingState.reset:
				pass
	else:
		if birds > 0:
			var player = get_tree().get_nodes_in_group("Player")[0]
			player.position = $CenterOfSlingshot.position
			$LeftLine.points[1] = $CenterOfSlingshot.position
			$RightLine.points[1] = $CenterOfSlingshot.position
			player.rotation = atan2(0,0)
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_touch_area_input_event(_viewport, event, _shape_idx):
	if SlingshotState == SlingState.idle && Input.is_action_just_pressed("Left_Mouse"):
		if(event is InputEventMouseButton && event.pressed):
			SlingshotState = SlingState.pulling
			var player = get_tree().get_nodes_in_group("Player")[0]
			player.pull_sound()


func _on_next_bird_timer_timeout() -> void:
	if birds > 0:
		get_tree().get_nodes_in_group("Player")[0].position = $CenterOfSlingshot.position
		SlingshotState = SlingState.idle
		get_tree().get_nodes_in_group("Player")[0].ready_sound()


func _on_first_bird_timer_timeout() -> void:
	if get_tree().get_nodes_in_group("Player").size() > 0:
		var player = get_tree().get_nodes_in_group("Player")[0]
		player.position = $CenterOfSlingshot.position
		SlingshotState = SlingState.idle
		birds = get_tree().get_nodes_in_group("Player").size()
		get_tree().get_nodes_in_group("Player")[0].ready_sound()

func start():
	CenterOfSlingshot = $CenterOfSlingshot.position + position
