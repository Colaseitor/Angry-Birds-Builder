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
var wood = 1
var glass = 1
var rock = 3
var type = "bird"
var dead = false
var pointing = false
@export var blink_frame = 1
@export var yell_frame = 2
@export var throw_frame = 3
@export var explosion_frame_1 = 4
@export var explosion_frame_2 = 5
@export var explosion_frame_3 = 6
var exploded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	freeze = true
	$BlinkTimer.wait_time = randf_range(1,10)
	$BlinkTimer/ScreamTimer.wait_time = randf_range(1,15)
	$BlinkTimer.start()
	$BlinkTimer/ScreamTimer.start()

func _process(delta):
	if Input.is_action_pressed("Left_Mouse"):
		if state == BirdState.Shot || state == BirdState.Corpse:
			if exploded == false:
				if state == BirdState.Shot:
					state = BirdState.Used
				else:
					state = BirdState.Corpse
				birdkiller = 0
				$Scream.play()
				exploded = true
	if state == BirdState.Shot || state == BirdState.Used:
		rotation = atan2(linear_velocity[1],linear_velocity[0])
	if state == BirdState.Corpse || state == BirdState.Used:
		if birdkiller <= 0:
			if dead == false:
				$CollisionShape2D.queue_free()
				dead = true
				$Sprite2D.hide()
				freeze = true
				$Scream.play()
				$AnimatedSprite2D.show()
				$AnimatedSprite2D.play("Explosion")
				exploded = true
				for node: Node in get_parent().get_parent().get_child(2).get_children():
					if node is RigidBody2D:
						var direction: Vector2 = node.global_position - global_position
						var distance: float = direction.length()
						if distance < 300.0:
							node.apply_impulse(direction.normalized() * (650 - distance))
							if node.type != "bird" && node.type != "ground":
								node.life -= 300 - distance / 2
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
	if state == BirdState.Shot || state == BirdState.Used:
		state = BirdState.Corpse
		$Sprite2D.frame = explosion_frame_1
		$ExplosionTimer.start()
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
	$Sprite2D.frame = blink_frame


func _on_un_blink_timer_timeout() -> void:
	$Sprite2D.frame = 0


func _on_scream_timer_timeout() -> void:
	$BlinkTimer/ScreamTimer.wait_time = randf_range(1,15)
	$Sprite2D.frame = yell_frame
	var pedosdematga = randi_range(1,12)
	if pedosdematga == 1:
		$"84_Sfx-BirdMiscA1".play()
	elif pedosdematga == 2:
		$"88_Sfx-BirdMiscA2".play()
	elif pedosdematga == 3:
		$"89_Sfx-BirdMiscA3".play()
	elif pedosdematga == 4:
		$"90_Sfx-BirdMiscA4".play()
	elif pedosdematga == 5:
		$"91_Sfx-BirdMiscA5".play()
	elif pedosdematga == 6:
		$"92_Sfx-BirdMiscA6".play()
	elif pedosdematga == 7:
		$"93_Sfx-BirdMiscA7".play()
	elif pedosdematga == 8:
		$"94_Sfx-BirdMiscA8".play()
	elif pedosdematga == 9:
		$"95_Sfx-BirdMiscA9".play()
	elif pedosdematga == 10:
		$"85_Sfx-BirdMiscA10".play()
	elif pedosdematga == 11:
		$"86_Sfx-BirdMiscA11".play()
	else:
		$"87_Sfx-BirdMiscA12".play()
	$BlinkTimer/ScreamTimer/UnYellTimer.start()


func _on_point_timer_timeout() -> void:
	add_child(load("res://Other main gameplay thinggies/point_text/red_point_text.tscn").instantiate())
	get_parent().get_parent().points += 10000

func unselected():
	pass

func ready_sound():
	pass


func _on_explosion_timer_timeout() -> void:
	if $Sprite2D.frame < 6:
		$Sprite2D.frame += 1
	birdkiller -= 50


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.hide()


func _on_scream_finished() -> void:
	queue_free()
