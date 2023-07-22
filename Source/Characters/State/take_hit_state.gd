extends BaseCharacterState

class_name TakeHitState

@export var state_name: StringName = "take_hit"
@export var animation_name: StringName = "take_hit"

func get_state_name():
	return state_name

func get_animation_name():
	return animation_name

func should_freeze_facing(): 
	return true

func update(_delta) -> String:
	super.update(_delta)
	if (animation_player.current_animation_position >= animation_length):        
		return "idle"
	return ""
