extends Node2D

func set_round_time(time: int):
	$Time.text = format_time(time)

func format_time(time: int) -> String:
	var minutes = time / 60
	var seconds = time % 60
	return str(minutes) + ":" + str(seconds)