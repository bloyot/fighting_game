extends CanvasLayer

func _on_player_damage_taken(player: PlayerController, damage_taken: float):	
	if (player.name == "Player1"):
		$Player1HealthBar.set_health(player.health - damage_taken)
	elif (player.name == "Player2"):
		$Player2HealthBar.set_health(player.health - damage_taken)

func set_round_time(round_time: int):
	$RoundTimer.set_round_time(round_time)