@icon("res://addons/yet_another_behavior_tree/src/Assets/Icons/btcondition.png")
class_name ConditionShouldBlock
extends BTCondition

@export var random_block_chance: float = 0.5

func tick(actor:Node, _blackboard:BTBlackboard):
	var player := actor as AIController	
	var other_player = player.other_player
	
	var attack_incoming = "attack" in other_player.curr_state.state_name

	# if no attack incoming, don't block
	if !attack_incoming:		
		#blackboard.data["input"]["block"] = false
		return BTTickResult.FAILURE
	
	# if already in block start or block state continue blocking, or if attack incoming randomly block
	if player.curr_state in ["block", "block_start"] or (attack_incoming and player.stamina > 0 and randf() > random_block_chance):		
		return BTTickResult.SUCCESS		