extends RigidBody2D
var type = "pig"
@export var life = 50
var dead = false
var jumpsoink = false
var laughing = false
var blink = false
var time = 0.0
var max_life: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$OinkTimer.wait_time = randf_range(5, 15)
	$OinkTimer.start()
	max_life = life


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(max_life)
	if life > max_life / 3 * 2:
		$Sprite2D.frame = 0
	elif life > max_life / 3:
		if $Sprite2D.frame < 3:
			random_damage()
		$Sprite2D.frame = 3
	elif life > 0:
		if $Sprite2D.frame < 6:
			random_damage()
		$Sprite2D.frame = 6
	else:
		if dead == false:
			$"328_Sfx-PigletteDestroyed".play()
			$CollisionShape2D.queue_free()
			dead = true
			add_child(load("res://Other main gameplay thinggies/point_text/pig_point_text.tscn").instantiate())
			get_parent().get_parent().points += 5000
			$Sprite2D.hide()
			$AnimatedSprite2D.show()
			$AnimatedSprite2D.play("default")
	if laughing:
		if life > max_life / 3 * 2:
			$Sprite2D.frame = 2
		elif life > max_life / 3:
			$Sprite2D.frame = 5
		else:
			$Sprite2D.frame = 8
	if blink:
		if life > max_life / 3 * 2:
			$Sprite2D.frame = 1
		elif life > max_life / 3:
			$Sprite2D.frame = 4
		else:
			$Sprite2D.frame = 7
	if time < 1:
		time += 1 * delta
	if dead == false:
		if position.x + get_parent().position.x > 3500:
			get_parent().get_parent().points += 5000
			queue_free()
		elif position.x + get_parent().position.x < -1500:
			get_parent().get_parent().points += 5000
			queue_free()
		if position.y + get_parent().position.y > 300:
			get_parent().get_parent().points += 5000
			queue_free()
		elif position.y + get_parent().position.y < -5500:
			get_parent().get_parent().points += 5000
			queue_free()


func _on_body_entered(body: Node) -> void:
	var damage
	if body.type == "bird":
		damage = (abs(linear_velocity[0]) + abs(linear_velocity[1])) / 3 * body.mass
	elif body.type == "ground":
		damage = (abs(linear_velocity[0]) + abs(linear_velocity[1])) / 3
	else:
		damage = (abs(linear_velocity[0]) + abs(linear_velocity[1])) / 3 + (abs(body.linear_velocity[0]) + abs(body.linear_velocity[1])) / 3 * body.mass
	life -= damage
	if jumpsoink == false:
		jumpsoink = true
		$OinkaTimer.start()
		var oink = randi_range(1,8)
		if oink == 1:
			$"312_Sfx-PigletteCollisionA1".play()
		elif oink == 2:
			$"313_Sfx-PigletteCollisionA2".play()
		elif oink == 3:
			$"314_Sfx-PigletteCollisionA3".play()
		elif oink == 4:
			$"315_Sfx-PigletteCollisionA4".play()
		elif oink == 5:
			$"316_Sfx-PigletteCollisionA5".play()
		elif oink == 6:
			$"317_Sfx-PigletteCollisionA6".play()
		elif oink == 7:
			$"318_Sfx-PigletteCollisionA7".play()
		else:
			$"319_Sfx-PigletteCollisionA8".play()

func random_damage():
	var oinka = randi_range(1,8)
	if oinka == 1:
		$"320_Sfx-PigletteDamageA1".play()
	elif oinka == 2:
		$"321_Sfx-PigletteDamageA2".play()
	elif oinka == 3:
		$"322_Sfx-PigletteDamageA3".play()
	elif oinka == 4:
		$"323_Sfx-PigletteDamageA4".play()
	elif oinka == 5:
		$"324_Sfx-PigletteDamageA5".play()
	elif oinka == 6:
		$"325_Sfx-PigletteDamageA6".play()
	elif oinka == 7:
		$"326_Sfx-PigletteDamageA7".play()
	else:
		$"327_Sfx-PigletteDamageA8".play()


func _on__sfx_piglette_destroyed_finished() -> void:
	queue_free()


func _on_oinka_timer_timeout() -> void:
	jumpsoink = false


func _on_oink_timer_timeout() -> void:
	$OinkTimer.wait_time = randf_range(5, 15)
	if randi_range(1,2) == 1:
		var oinkselector = randi_range(1,10)
		if oinkselector == 1:
			$"329_Sfx-PigletteOinkA1".play()
		elif oinkselector == 2:
			$"333_Sfx-PigletteOinkA2".play()
		elif oinkselector == 3:
			$"334_Sfx-PigletteOinkA3".play()
		elif oinkselector == 4:
			$"335_Sfx-PigletteOinkA4".play()
		elif oinkselector == 5:
			$"336_Sfx-PigletteOinkA5".play()
		elif oinkselector == 6:
			$"337_Sfx-PigletteOinkA8".play()
		elif oinkselector == 7:
			$"338_Sfx-PigletteOinkA9".play()
		elif oinkselector == 8:
			$"330_Sfx-PigletteOinkA10".play()
		elif oinkselector == 9:
			$"331_Sfx-PigletteOinkA11".play()
		else:
			$"332_Sfx-PigletteOinkA12".play()
		laughing = true
		$UnlaughTimer.start()
	else:
		blink = true
		$BlinkTimer.start()


func _on_unlaugh_timer_timeout() -> void:
	laughing = false


func _on_blink_timer_timeout() -> void:
	blink = false


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.hide()

func _on_sleeping_state_changed() -> void:
	if time >= 1:
		if sleeping == false:
			gravity_scale = 1
