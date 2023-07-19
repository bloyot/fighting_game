extends Node2D

class_name BehaviorTree

func get_input():
	
	var direction = $Blackboard.data["input"]["direction"]
	var attack = $Blackboard.data["input"]["attack"]
	var attack_special = $Blackboard.data["input"]["attack_special"]
	var jump = $Blackboard.data["input"]["jump"]
	var block = $Blackboard.data["input"]["block"]

	return {
		"direction": direction if direction != null else 0.0,
		"attack": attack if attack != null else false,
		"attack_special": attack_special if attack_special != null else false,
		"jump": jump if jump != null else false,
		"block": block if block != null else false
	}

func set_actor_path(actor_path):	
	$Root.actor_path = actor_path
