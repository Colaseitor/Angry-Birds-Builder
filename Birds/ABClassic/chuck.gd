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
var glass = 1
var rock = 1
var type = "bird"
var dead = false
var pointing = false
@export var yell_frame = 1
@export var blink_frame = 2
@export var corpse_frame = 3
@export var ability_frame = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	freeze = true
	$ScreamTimer/BlinkTimer.wait_time = randf_range(1,10)
	$ScreamTimer.wait_time = randf_range(1,15)
	$ScreamTimer/BlinkTimer.start()
	$ScreamTimer.start()

func _process(delta):
	if Input.is_action_pressed("Left_Mouse"):
		if state == BirdState.Shot:
			state = BirdState.Used
			$"415_Sfx-SpecialBoost".play()
			apply_impulse(linear_velocity.normalized() * 1300)
			$CPUParticles2D.global_position = position + get_parent().position
			$CPUParticles2D.emitting = true
	if state == BirdState.Shot || state == BirdState.Used:
		rotation = atan2(linear_velocity[1],linear_velocity[0])
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

func ThrowBird():
	freeze = false
	$Throw.play()
	state = BirdState.Shot
	$Sprite2D.frame = ability_frame
	$ScreamTimer.stop()
	$ScreamTimer/UnYellTimer.stop()
	$ScreamTimer/BlinkTimer.stop()
	$ScreamTimer/BlinkTimer/UnBlinkTimer.stop()
	add_to_group("ThrownBird")

func pull_sound():
	$Pulling.play()


func _on_body_entered(body: Node) -> void:
	if state == BirdState.Shot || state == BirdState.Used:
		state = BirdState.Corpse
		$Sprite2D.frame = corpse_frame
	if gemidoespera == false:
		var gemidos = randi_range(1,5)
		gemidoespera = true
		if gemidos == 1:
			$"Sfx-Bird01CollisionA1".play()
		elif gemidos == 2:
			$"Sfx-Bird01CollisionA2".play()
		elif gemidos == 3:
			$"Sfx-Bird01CollisionA3".play()
		elif gemidos == 4:
			$"Sfx-Bird01CollisionA4".play()
		else:
			$"Sfx-Bird03CollisionA5".play()
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
				point_text.appear(body.life)
			else:
				point_text.appear(damage)
			add_child(point_text)


func _on_gemido_timer_timeout() -> void:
	gemidoespera = false
	gemidoespera2 = false


func _on__sfx_bird_destroyed_finished() -> void:
	queue_free()


func _on_scream_timer_timeout() -> void:
	$ScreamTimer.wait_time = randf_range(1,15)
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
	$ScreamTimer/UnYellTimer.start()


func _on_un_yell_timer_timeout() -> void:
	$Sprite2D.frame = 0


func _on_point_timer_timeout() -> void:
	add_child(load("res://Other main gameplay thinggies/point_text/chuck_point_text.tscn").instantiate())
	get_parent().get_parent().points += 10000

func unselected():
	if randi_range(1,10) == 10:
		$"90_Sfx-BirdMiscA4".play()

func ready_sound():
	if randi_range(1,10) == 10:
		$"86_Sfx-BirdMiscA11".play()


func _on_blink_timer_timeout() -> void:
	$ScreamTimer/BlinkTimer/UnBlinkTimer.start()
	$Sprite2D.frame = blink_frame


func _on_un_blink_timer_timeout() -> void:
	$Sprite2D.frame = 0
