extends BaseCharacterState

class_name DieState

@export var state_name: StringName = "die"
@export var animation_name: StringName = "die"

func get_state_name():
	return state_name

func get_animation_name():
	return animation_name

func should_freeze_facing():
	return true

func update(_delta) -> String:
	super.update(_delta)    

	return ""