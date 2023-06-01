extends BaseCharacterState

class_name BlockState

@export var state_name: StringName = "block"
@export var animation_name: StringName = "block"
@export var max_block_time: float = 1.0

# track how long we've been holding block and cap it at some point
var elapsed_time: float = 0.0

func on_enter():
	super.on_enter()
	elapsed_time = 0.0

func get_state_name():
	return state_name

func get_animation_name():
	return animation_name

func should_freeze_facing(): 
	return true

func update(delta) -> String:
	super.update(delta)
	elapsed_time += delta
	if (!has_buffered_input("block") or elapsed_time > max_block_time):
		return "block_end"
	return ""
