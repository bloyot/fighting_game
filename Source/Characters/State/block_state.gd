extends BaseCharacterState

class_name BlockState

@export var state_name: StringName = "block"
@export var animation_name: StringName = "block"

func on_enter():
	super.on_enter()

func get_state_name():
	return state_name

func get_animation_name():
	return animation_name

func should_freeze_facing(): 
	return true

func update(delta) -> String:
	super.update(delta)
	if (!has_buffered_input("block") or character.stamina < 1):
		return "block_end"
	return ""
