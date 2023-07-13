extends CanvasLayer

func _ready():
	$RoundStartMessage.hide()
	$RoundEndMessage.hide()

# reset the UI between rounds
func reset():
	_ready()
	$Player1HealthBar._ready()
	$Player2HealthBar._ready()

func _on_player_damage_taken(player: PlayerController, damage_taken: float):	
	if (player.name == "Player1"):
		$Player1HealthBar.set_health(player.health - damage_taken)
	elif (player.name == "Player2"):
		$Player2HealthBar.set_health(player.health - damage_taken)

func set_round_time(round_time: int):
	$RoundTimer.set_round_time(round_time)

func round_end(winner, player1_score, player2_score, is_match_complete):
	reset()
	set_scores(player1_score, player2_score)
	show_round_end_message(winner, is_match_complete)	

func set_scores(player1_score, player2_score):
	if (player1_score == 1):
		$RoundP1G1.add_win()
	elif (player1_score == 2):
		$RoundP1G2.add_win()

	if (player2_score == 1):
		$RoundP2G1.add_win()
	elif (player2_score == 2):
		$RoundP2G2.add_win()
	
func show_round_end_message(winner, is_match_complete):
	$RoundEndMessage.text = winner.name + " Wins the " + ("Match!" if is_match_complete else "Round!")	
	$RoundEndMessage.show()

func set_pre_round_time(pre_round_time):	
	var text = str(pre_round_time - 1)
	if (pre_round_time == 4):
		$RoundStartMessage.show()
	elif (pre_round_time == 1):
		text = "Fight!"
	elif (pre_round_time == 0):
		$RoundStartMessage.hide()

	$RoundStartMessage.text = text

func pause():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$PauseMenu.show()
