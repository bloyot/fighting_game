extends Node2D

@export var round_time: int = 300

var player1_score = 0
var player2_score = 0
var curr_round_time: int
var pre_round_time: int = 4

func _ready():
	# todo eventually using this to spawn the characters maybe?
	$Player1.other_player = $Player2	
	$Player1.game_audio = $GameAudio	
	$Player2.other_player = $Player1
	$Player2.game_audio = $GameAudio

	$Camera2D.player_1 = $Player1
	$Camera2D.player_2 = $Player2

	curr_round_time = round_time	

	# register the controller devices and associate the ids with the players
	# player 1 always gets the first device + keyboard
	# player 2 get the second device
	$RoundStartTimer.start()	
		
	$DeviceInput.initialize(0)
	$DeviceInput.initialize(1)
	# use 100 for keyboard
	$DeviceInput.initialize(100)
	$Player1.device_id = 0
	$Player2.device_id = 1

	# setup a notification for game pad changed
	Input.joy_connection_changed.connect(_on_input_joypad_connection_changed)

func _on_player_damage_taken(player: PlayerController, _damage_taken: int):	
	if (player.health <= 0):
		# tell player controller to die
		player.die()
		
		var winner
		if (player.name == "Player1"):
			winner = $Player2
			player2_score += 1			
		else:
			winner = $Player1
			player1_score += 1
		
		round_end(winner)			
	

func _on_round_timer_timeout():
	curr_round_time -= 1
	$GameUI.set_round_time(curr_round_time)
	if (curr_round_time == 0):
		# technically player 1 wins if tied after timeout but... eh		
		round_end($Player1 if $Player1.health >= $Player2.health else $Player2)

func _on_round_reset_timer_timeout():
	curr_round_time = round_time
	$Player1.reset()
	$Player2.reset()	
	$GameUI.reset()
	pre_round_time = 4
	$RoundStartTimer.start()

func _on_input_joypad_connection_changed(device: int, connected: bool):
	# don't worry about disconnecting now for the sake of this prototype
	if (connected):
		$DeviceInput.initialize(device)

func start_round():	
	$Player1.input_wait = false
	$Player2.input_wait = false

func _on_round_start_timer_timeout():			
	$GameUI.set_pre_round_time(pre_round_time)
	if (pre_round_time == 1):		
		start_round()
	if (pre_round_time == 0):
		$RoundStartTimer.stop()
	pre_round_time -= 1

func round_end(winner):
	$GameUI.round_end(winner, player1_score, player2_score, is_match_complete())
	$RoundResetTimer.start()
	$Player1.input_wait = true
	$Player2.input_wait = true

func is_match_complete():
	return true if player1_score == 2 or player2_score == 2 else false

func _on_player_block(player: PlayerController):	
	if (player.health <= 0):
		# tell player controller to die
		player.die()
		
		var winner
		if (player.name == "Player1"):
			winner = $Player2
			player2_score += 1			
		else:
			winner = $Player1
			player1_score += 1
		
		round_end(winner)	

func _on_player_stamina_changed(player: PlayerController, stamina: float):
	if (player.name == "Player1"):
		$GameUI/Player1StaminaBar/Stamina.value = stamina	
	if (player.name == "Player2"):
		$GameUI/Player2StaminaBar/Stamina.value = stamina	