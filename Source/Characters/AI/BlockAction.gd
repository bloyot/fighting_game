@icon("res://addons/yet_another_behavior_tree/src/Assets/Icons/btaction.png")
extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	blackboard.data["input"]["block"] = true
	return BTTickResult.SUCCESS

