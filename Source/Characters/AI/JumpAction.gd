extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	blackboard.data["input"]["jump"] = true
	return BTTickResult.SUCCESS

