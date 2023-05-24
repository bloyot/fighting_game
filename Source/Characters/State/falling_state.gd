extends BaseCharacterState

class_name FallingState

@export var state_name: StringName = "falling"
@export var animation_name: StringName = "falling"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func update():    
    if (character.is_on_floor()):
        print("landing")
        return "landing"

    if (get_attack_input()):        
        return "air_attack"

    move_left_right() 

    return ""