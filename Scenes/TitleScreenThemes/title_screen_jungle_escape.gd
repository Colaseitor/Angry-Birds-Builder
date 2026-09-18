extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mateonoseasasí = randi_range(1,2)
	if mateonoseasasí == 1:
		$MenuMusic.play()
	else:
		$"15_AngryBirdsRio2Theme".play()
