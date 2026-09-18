extends RigidBody2D
enum BirdState{
	Wait,
	Ready,
	Shot,
	Used,
	Corpse
}
var state = BirdState.Wait
var gemidoespera = false
var gemidoespera2 = false
var birdkiller = 150.0
var wood = 3
var glass = 2
var rock = 3
var type = "bird"
var dead = false
var pointing = false
var falling = false
var fall_hit = false
var falling_2 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	freeze = true
	$BlinkTimer.wait_time = randf_range(1,10)
	$BlinkTimer/ScreamTimer.wait_time = randf_range(1,15)
	$BlinkTimer.start()
	$BlinkTimer/ScreamTimer.start()

func _process(delta):
	if Input.is_action_pressed("Left_Mouse"):
		if state == BirdState.Shot:
			state = BirdState.Used
			$Scream.play()
			falling = true
			gravity_scale = 0
			linear_velocity = Vector2(0,0)
			$AnimationPlayer.play("TonyAttack")
	if state == BirdState.Shot || state == BirdState.Used:
		if falling == false:
			rotation = atan2(linear_velocity[1],linear_velocity[0])
		else:
			rotation = 0
	elif state == BirdState.Corpse:
		birdkiller -= 100 * delta / (abs(linear_velocity[0]) + abs(linear_velocity[1])) * 2
		if birdkiller < 0:
			if dead == false:
				dead = true
				$Sprite2D.hide()
				$CPUParticles2D.global_position = position + get_parent().position
				$CPUParticles2D.emitting = true
				$"83_Sfx-BirdDestroyed".play()
				$CollisionShape2D.queue_free()
	elif (state == BirdState.Wait || state == BirdState.Ready) && get_parent().get_parent().state == 1:
		if pointing == false:
			pointing = true
			$PointTimer.start()
	if position.x + get_parent().position.x > 3500:
		queue_free()
	elif position.x + get_parent().position.x < -1500:
		queue_free()
	if position.y + get_parent().position.y > 300:
		queue_free()
	elif position.y + get_parent().position.y < -5500:
		queue_free()
	if falling_2:
		linear_velocity = Vector2(0,1300)
		rotation = 0

func ThrowBird():
	freeze = false
	$Throw.play()
	state = BirdState.Shot
	$Sprite2D.frame = 0
	$BlinkTimer.stop()
	$BlinkTimer/UnBlinkTimer.stop()
	$BlinkTimer/ScreamTimer.stop()
	$BlinkTimer/ScreamTimer/UnYellTimer.stop()
	add_to_group("ThrownBird")

func pull_sound():
	$Pulling.play()


func _on_body_entered(body: Node) -> void:
	if falling == false:
		if state == BirdState.Shot || state == BirdState.Used:
			state = BirdState.Corpse
			$Sprite2D.frame = 0
		if gemidoespera == false:
			var gemidos = randi_range(1,4)
			gemidoespera = true
			if gemidos == 1:
				$"Sfx-Bird01CollisionA1".play()
			elif gemidos == 2:
				$"Sfx-Bird01CollisionA2".play()
			elif gemidos == 3:
				$"Sfx-Bird01CollisionA3".play()
			else:
				$"Sfx-Bird01CollisionA4".play()
		else:
			if gemidoespera2 == false:
				$GemidoTimer.start()
				gemidoespera2 = true
	else:
		if body.type == "ground":
			falling = false
			falling_2 = false
			$Sprite2D.frame = 4
			gravity_scale = 0.8
			$FallingTimer.stop()
			state = BirdState.Corpse
		elif fall_hit == false:
			fall_hit = true
			$FallingTimer.start()
	if body.type == "wood" || body.type == "glass" || body.type == "rock":
		$CPUParticles2D.global_position = position + get_parent().position
		$CPUParticles2D.emitting = true
		var damage
		if body.type == "wood":
			damage = (abs(linear_velocity[0]) + abs(linear_velocity[1])) / 3
		else:
			damage = wood * (abs(linear_velocity[0]) + abs(linear_velocity[1])) / 3
		if damage >= 10 && body.life > 10:
			var point_text = load("res://Other main gameplay thinggies/point_text.tscn").instantiate()
			if damage > body.life:
				if body.life > 0:
					point_text.appear(body.life)
			else:
				point_text.appear(damage)
			add_child(point_text)


func _on_gemido_timer_timeout() -> void:
	gemidoespera = false
	gemidoespera2 = false


func _on__sfx_bird_destroyed_finished() -> void:
	queue_free()


func _on_blink_timer_timeout() -> void:
	$BlinkTimer/UnBlinkTimer.start()
	$Sprite2D.frame = 1


func _on_un_blink_timer_timeout() -> void:
	$Sprite2D.frame = 0


func _on_scream_timer_timeout() -> void:
	$BlinkTimer/ScreamTimer.wait_time = randf_range(1,15)
	$Sprite2D.frame = 2
	$BlinkTimer/ScreamTimer/UnYellTimer.start()


func _on_point_timer_timeout() -> void:
	add_child(load("res://Other main gameplay thinggies/point_text/the_blues_point_text.tscn").instantiate())
	get_parent().get_parent().points += 10000

func unselected():
	pass

func ready_sound():
	pass


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	var save_position_please = position
	gravity_scale = 0
	falling_2 = true
	freeze = false
	$"169_Sfx-BombDrop01".play()


func _on_falling_timer_timeout() -> void:
	falling = false
	falling_2 = false
	$Sprite2D.frame = 4
	gravity_scale = 0.8
	state = BirdState.Corpse
