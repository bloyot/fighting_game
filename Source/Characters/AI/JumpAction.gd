extends BTAction

func tick(_actor:Node, blackboard:BTBlackboard):
	blackboard.data["input"]["jump"] = true
	return BTTickResult.SUCCESS

