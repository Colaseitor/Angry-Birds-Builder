extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var kurtis_conner = randi_range(1,10)
	if kurtis_conner == 1:
		$"2-51_WinterWonderham(wiiUVersion)".play()
	elif kurtis_conner == 2:
		$"2-52_WinterWonderham(psVitaVersion)".play()
	else:
		$MenuMusic.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
