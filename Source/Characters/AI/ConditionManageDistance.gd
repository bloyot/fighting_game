@icon("res://addons/yet_another_behavior_tree/src/Assets/Icons/btcondition.png")
class_name ConditionManageDistance
extends BTCondition

func tick(actor:Node, blackboard:BTBlackboard) -> int:	
	var player := actor as AIController
	var distance = abs(player.position.x - player.other_player.position.x)	
	if (distance > blackboard.data["max_distance"] || distance < blackboard.data["min_distance"]):		
		return BTTickResult.SUCCESS
	
	return BTTickResult.FAILURE
		
