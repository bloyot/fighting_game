extends BaseCharacterState

class_name RunState

@export var state_name: StringName = "run"
@export var animation_name: StringName = "run"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func update() -> String:
    super.update()
    var maybe_next_state = ""
    
    if has_buffered_input("jump"):
        return "jump"

    if has_buffered_input("attack"):
        return "attack_1"

    if has_buffered_input("attack_special"):
        return "attack_special"

    move_left_right() 
    
    if character.velocity.x == 0:    
        maybe_next_state = "idle"
    
    return maybe_next_state