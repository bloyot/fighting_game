extends BaseCharacterState

class_name RisingState

@export var state_name: StringName = "rising"
@export var animation_name: StringName = "rising"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func update():
    if (character.velocity.y >= 0):
        return "falling"

    if (get_attack_input()):
        return "air_attack"

    move_left_right() 

    return ""