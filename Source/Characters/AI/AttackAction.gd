extends BTAction

@export var special_chance: float = 0.3

func tick(actor:Node, blackboard:BTBlackboard):
	var state = "attack_special" if randf() < special_chance else "attack"
	blackboard.data["input"][state] = true
	return BTTickResult.SUCCESS

