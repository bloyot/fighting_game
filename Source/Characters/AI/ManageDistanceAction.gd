extends BTAction

# how long to perform this action for
@export var action_time: int = 1
var current_time = 0.0

func tick(actor:Node, blackboard:BTBlackboard):
	var player := actor as AIController
	var distance = player.position.x - player.other_player.position.x		

	if abs(distance) > blackboard.data["max_distance"] or abs(distance) < blackboard.data["min_distance"]:		
		current_time += blackboard.get_delta()
		#print(current_time)
		if (current_time > action_time):
			current_time = 0.0
			return BTTickResult.SUCCESS

		if abs(distance) > blackboard.data["max_distance"]:
			if distance > 0:
				blackboard.data["input"]["direction"] = -1.0
			else:
				blackboard.data["input"]["direction"] = 1.0
			return BTTickResult.RUNNING

		if abs(distance) < blackboard.data["min_distance"]:
			if distance > 0:
				blackboard.data["input"]["direction"] = 1.0
			else:
				blackboard.data["input"]["direction"] = -1.0
			return BTTickResult.RUNNING
	
	# no need to change distance
	blackboard.data["input"]["direction"] = 0.0
	return BTTickResult.FAILURE

