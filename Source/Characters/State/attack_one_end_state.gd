extends BaseCharacterState

class_name AttackOneEndState

@export var state_name: StringName = "attack_1_end"
@export var animation_name: StringName = "attack_1_end"

func get_state_name():
	return state_name

func get_animation_name():
	return animation_name

func should_freeze_facing(): 
	return true

func update() -> String:
	super.update()	
	
	if (!animation_player.current_animation_length > animation_length):				
			return "idle"	

	return ""
