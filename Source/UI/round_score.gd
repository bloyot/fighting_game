extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Fill.hide()

func add_win():
	$Fill.show()
