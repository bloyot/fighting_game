extends Node2D

@export var round_time: int = 300

var player1_score = 0
var player2_score = 0
var curr_round_time: int

func _ready():
	# todo eventually using this to spawn the characters maybe?
	$Player1.other_player = $Player2	
	$Player1.game_audio = $GameAudio	
	$Player2.other_player = $Player1
	$Player2.game_audio = $GameAudio

	$Camera2D.player_1 = $Player1
	$Camera2D.player_2 = $Player2

	curr_round_time = round_time
	$RoundTimer.start()

func _on_player_damage_taken(player: PlayerController, _damage_taken: int):	
	if (player.health <= 0):
		# tell player controller to die
		player.die()
		
		# if one player has 2 wins, end game
		# enable UI text for round 
		# incrememt score UI
		# increment score 				
		print("Game Over")

func _on_round_timer_timeout():
	curr_round_time -= 1
	$GameUI.set_round_time(curr_round_time)
