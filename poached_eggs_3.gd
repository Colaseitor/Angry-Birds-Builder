extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mateonoseasasí = randi_range(1,40)
	if mateonoseasasí == 1:
		$SsvsabRemix.play() #Mighty League
	elif mateonoseasasí == 2:
		$FunkyTheme.play() #Original theme
	elif mateonoseasasí == 4:
		$AngryBirdsKakaoMainTheme.play() #The Kakao version has different menu music
	elif mateonoseasasí == 5:
		$"037_CherryTheme".play() #Music for Angry Birds Fuji TV
	elif mateonoseasasí == 3:
		$FriendsMainTheme.play() #Poached Eggs was originally available in Angry Birds Friends
	else:
		$MenuMusic.play()
#Angry Birds Coca-Cola does not feature the second or third Poached Eggs parts.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Paste"):
		$MenuMusic.stop()
		$SsvsabRemix.stop()
		$FunkyTheme.stop()
		$AngryBirdsKakaoMainTheme.stop()
		$"037_CherryTheme".stop()
		$FriendsMainTheme.stop()
		$ConvirtiendoElTemaDeAngryBirdsEnPerreo.play()
