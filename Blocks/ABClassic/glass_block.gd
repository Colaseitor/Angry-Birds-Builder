extends RigidBody2D
var type = "glass"
var life = 600
var dead = false
var time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if life > 450:
		$Sprite2D.frame = 0
	elif life > 300:
		if $Sprite2D.frame == 0:
			var randomloquesea = randi_range(1,3)
			if randomloquesea == 1:
				$"484_Sfx-WoodDamageA1".play()
			elif randomloquesea == 2:
				$"485_Sfx-WoodDamageA2".play()
			else:
				$"486_Sfx-WoodDamageA3".play()
		$Sprite2D.frame = 1
	elif life > 150:
		if $Sprite2D.frame != 2:
			var randomloquesea = randi_range(1,3)
			if randomloquesea == 1:
				$"484_Sfx-WoodDamageA1".play()
			elif randomloquesea == 2:
				$"485_Sfx-WoodDamageA2".play()
			else:
				$"486_Sfx-WoodDamageA3".play()
		$Sprite2D.frame = 2
	elif life > 0:
		if $Sprite2D.frame != 3:
			var randomloquesea = randi_range(1,3)
			if randomloquesea == 1:
				$"484_Sfx-WoodDamageA1".play()
			elif randomloquesea == 2:
				$"485_Sfx-WoodDamageA2".play()
			else:
				$"486_Sfx-WoodDamageA3".play()
		$Sprite2D.frame = 3
	else:
		if dead == false:
			var randomloquesea = randi_range(1,3)
			if randomloquesea == 1:
				$"487_Sfx-WoodDestroyedA1".play()
			elif randomloquesea == 2:
				$"488_Sfx-WoodDestroyedA2".play()
			else:
				$"489_Sfx-WoodDestroyedA3".play()
			$CPUParticles2D.global_position = position
			$CPUParticles2D.emitting = true
			$CollisionShape2D.queue_free()
			dead = true
			var point_text = load("res://Other main gameplay thinggies/point_text.tscn").instantiate()
			point_text.appear(500)
			add_child(point_text)
			get_parent().get_parent().points += 500
			$Sprite2D.hide()
	if time < 1:
		time += 1 * delta
	if dead == false:
		if position.x + get_parent().position.x > 3500:
			get_parent().get_parent().points += 500 + life
			queue_free()
		elif position.x + get_parent().position.x < -1500:
			get_parent().get_parent().points += 500 + life
			queue_free()
		if position.y + get_parent().position.y > 300:
			get_parent().get_parent().points += 500 + life
			queue_free()
		elif position.y + get_parent().position.y < -5500:
			get_parent().get_parent().points += 500 + life
			queue_free()


func _on_body_entered(body: Node) -> void:
	var damage
	if body.type == "bird":
		damage = body.glass * (abs(body.linear_velocity[0]) + abs(body.linear_velocity[1])) / 3 * body.mass
	elif body.type != "ground":
		damage = (abs(linear_velocity[0]) + abs(linear_velocity[1])) / 3 + (abs(body.linear_velocity[0]) + abs(body.linear_velocity[1])) / 3 * body.mass
	else:
		damage = (abs(linear_velocity[0]) + abs(linear_velocity[1])) / 3
	if damage > life:
		if life > 0:
			get_parent().get_parent().points += life
	else:
		get_parent().get_parent().points += damage
	life -= damage
	var random_col = randi_range(1,5)
	if random_col == 1:
		$"478_Sfx-WoodCollisionA1".play()
	elif random_col == 2:
		$"479_Sfx-WoodCollisionA2".play()
	elif random_col == 3:
		$"480_Sfx-WoodCollisionA3".play()
	elif random_col == 4:
		$"481_Sfx-WoodCollisionA4".play()
	elif random_col == 5:
		$"212_Sfx-IceLightCollisionA6".play()
	elif random_col == 6:
		$"213_Sfx-IceLightCollisionA7".play()
	elif random_col == 8:
		$"214_Sfx-IceLightCollisionA8".play()
	else:
		$"482_Sfx-WoodCollisionA5".play()


func _on__sfx_wood_destroyed_a_1_finished() -> void:
	queue_free()


func _on__sfx_wood_destroyed_a_2_finished() -> void:
	queue_free()


func _on__sfx_wood_destroyed_a_3_finished() -> void:
	queue_free()


func _on_sleeping_state_changed() -> void:
	if time >= 1:
		if sleeping == false:
			gravity_scale = 1
