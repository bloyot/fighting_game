extends BaseCharacterState

class_name LandingState

@export var state_name: StringName = "landing"
@export var animation_name: StringName = "landing"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func update():    
    super.update()
    if (animation_player.current_animation_position >= animation_length):
        return "idle"	

    if has_buffered_input("direction"):        
        return "run"

    if has_buffered_input("block"):
        return "block_start"

    if has_buffered_input("jump"):
        return "jump"

    if has_buffered_input("attack"):
        return "attack_1"

    if has_buffered_input("attack_special"):
        return "attack_special"

    return ""