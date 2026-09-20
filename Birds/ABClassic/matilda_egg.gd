extends RigidBody2D
var type = "egg"
var exploded = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_impulse(Vector2(0,700))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if exploded == false:
		hide()
		exploded = true
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("Explosion")
		$"416_Sfx-SpecialEggExplosion".play()
		for node: Node in get_parent().get_parent().get_child(2).get_children():
			if node is RigidBody2D:
				var direction: Vector2 = node.global_position - global_position
				var distance: float = direction.length()
				if distance < 150.0:
					if node.type != "bird" && node.type != "ground":
						node.life -= (150 - distance) * 5
	


func _on__sfx_special_egg_explosion_finished() -> void:
	queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.hide()
