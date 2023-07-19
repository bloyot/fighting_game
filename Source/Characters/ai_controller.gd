# controller for ai behavior
extends PlayerController

class_name AIController

var bt: BehaviorTree

func _ready():
	super._ready()
	# setup behavior tree
	bt = load("res://Source/Characters/AI/behavior_tree.tscn").instantiate()
	bt.set_actor_path("../..")
	add_child(bt)

func get_input(): 	
	if input_wait:
		return {}
	return bt.get_input()	
