extends BaseCharacterState

class_name AttackOneState

@export var state_name: StringName = "attack_1"
@export var animation_name: StringName = "attack_1"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func update() -> String:
    var maybe_next_state = ""
    if (animation_player.current_animation_position >= animation_frames):
        maybe_next_state = "attack_1_end"	

    return maybe_next_state