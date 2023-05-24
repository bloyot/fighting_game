extends BaseCharacterState

class_name AttackOneEndState

@export var state_name: StringName = "attack_1_end"
@export var animation_name: StringName = "attack_1_end"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func update() -> String:
    var maybe_next_state = ""
    
    if (!animation_player.current_animation_length > animation_frames):
        maybe_next_state = "idle"	

    return maybe_next_state