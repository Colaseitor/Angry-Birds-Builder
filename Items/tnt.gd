extends RigidBody2D
var type = "wood"
var life = 100
var dead = false
var time = 0.0

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if life <= 0:
		if dead == false:
			$CollisionShape2D.queue_free()
			dead = true
			$Sprite2D.hide()
			$"457_Sfx-TntBoxExplodes".play()
			var point_text = load("res://Other main gameplay thinggies/point_text.tscn").instantiate()
			point_text.appear(500)
			add_child(point_text)
			get_parent().get_parent().points += 500
			$AnimatedSprite2D.show()
			$AnimatedSprite2D.play("Explosion")
			for node: Node in get_parent().get_children():
				if node is RigidBody2D:
					var direction: Vector2 = node.global_position - position
					var distance: float = direction.length()
					if distance < 300.0:
						node.apply_impulse(direction.normalized() * (500 - distance))
						if node.type != "bird" && node.type != "ground":
							node.life -= 150 - distance / 2
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
		damage = body.wood * (abs(body.linear_velocity[0]) + abs(body.linear_velocity[1])) / 3
	elif body.type != "ground":
		damage = (abs(linear_velocity[0]) + abs(linear_velocity[1])) / 3 + (abs(body.linear_velocity[0]) + abs(body.linear_velocity[1])) / 3
	else:
		damage = (abs(linear_velocity[0]) + abs(linear_velocity[1])) / 3
	if damage > life:
		if life > 0:
			get_parent().get_parent().points += life
	else:
		get_parent().get_parent().points += damage
	life -= damage
	var random_col = randi_range(1,6)
	if random_col == 1:
		$"478_Sfx-WoodCollisionA1".play()
	elif random_col == 2:
		$"479_Sfx-WoodCollisionA2".play()
	elif random_col == 3:
		$"480_Sfx-WoodCollisionA3".play()
	elif random_col == 4:
		$"481_Sfx-WoodCollisionA4".play()
	elif random_col == 5:
		$"482_Sfx-WoodCollisionA5".play()
	else:
		$"483_Sfx-WoodCollisionA6".play()


func _on__sfx_tnt_box_explodes_finished() -> void:
	queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.hide()

func _on_sleeping_state_changed() -> void:
	if time >= 1:
		if sleeping == false:
			gravity_scale = 1
