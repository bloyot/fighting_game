extends BaseCharacterState

class_name IdleState

@export var state_name: StringName = "idle"
@export var animation_name: StringName = "idle"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func update() -> String:
    super.update()
    var maybe_next_state = ""
    
    if get_jump_input():
        return "jump"

    if (get_block_input()):        
        return "block_start"

    if get_attack_input():
        return "attack_1"

    if has_buffered_input("attack_special"):        
        return "attack_special"

    var direction = get_direction_input()
    if (direction):        
        maybe_next_state = "run"
    
    return maybe_next_state