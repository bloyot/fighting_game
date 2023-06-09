extends Node2D

func _ready():
	# todo eventually using this to spawn the characters maybe?
	$Player1.other_player = $Player2	
	$Player1.game_audio = $GameAudio	
	$Player2.other_player = $Player1
	$Player2.game_audio = $GameAudio

	$Camera2D.player_1 = $Player1
	$Camera2D.player_2 = $Player2

func _on_player_damage_taken(player: PlayerController, _damage_taken: int):
	print("Player: " + str(player) + " took damage")
	if (player.health <= 0):
		print("Game Over")
