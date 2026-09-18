extends Node
enum GameState {
	Start,
	Play,
	Win,
	Lose
}
var CurrentGameState = GameState.Start
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	match CurrentGameState:
		GameState.Start:
			pass
		GameState.Play:
			pass
		GameState.Win:
			print("¡Chachi piruli, ganaste!")
		GameState.Lose:
			print("Meh, vuelve a intentalo, chato...")
	pass
