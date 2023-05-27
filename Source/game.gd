extends Node2D

func _ready():
	# todo eventually using this to spawn the characters maybe?
	$Player1.other_player = $Player2
	$Player2.other_player = $Player1