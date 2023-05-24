extends BaseCharacterState

class_name LandingState

@export var state_name: StringName = "landing"
@export var animation_name: StringName = "landing"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func update():    
    if (animation_player.current_animation_position >= animation_frames):
        return "idle"	

    if (get_direction_input()):
        return "run"

    if (get_jump_input()):
        return "jump"

    if (get_attack_input()):
        return "attack_1"

    return ""