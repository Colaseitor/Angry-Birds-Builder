extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent().ambience == 0:
		$AmbientWhiteDryforest.play()
	elif get_parent().ambience == 1:
		$WhiteDryForestAmbienceTrilogy.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func restart_ambience():
	$AmbientWhiteDryforest.stop()
	$WhiteDryForestAmbienceTrilogy.stop()
	if get_parent().ambience == 0:
		$AmbientWhiteDryforest.play()
	elif get_parent().ambience == 1:
		$WhiteDryForestAmbienceTrilogy.play()
