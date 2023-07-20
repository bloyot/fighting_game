@icon("res://addons/yet_another_behavior_tree/src/Assets/Icons/btaction.png")
extends BTAction

func tick(_actor:Node, blackboard:BTBlackboard):
	blackboard.data["input"] = {
		"direction": 0.0,
		"attack": false,
		"attack_special": false,
		"jump": false,
		"block": false
	}

	return BTTickResult.SUCCESS

