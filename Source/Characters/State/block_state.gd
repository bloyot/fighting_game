extends BaseCharacterState

class_name BlockState

@export var state_name: StringName = "block"
@export var animation_name: StringName = "block"

func get_state_name():
	return state_name

func get_animation_name():
	return animation_name

func should_freeze_facing(): 
	return true

func update() -> String:
	super.update()
	if (!has_buffered_input("block")):
		return "block_end"
	return ""