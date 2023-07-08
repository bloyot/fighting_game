extends BaseCharacterState

class_name IdleState

@export var state_name: StringName = "idle"
@export var animation_name: StringName = "idle"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func update(_delta) -> String:
    super.update(_delta)    
    
    if has_buffered_input("jump"):
        return "jump"

    if block():
        return "block_start"

    if has_buffered_input("attack"):
        return "attack_1"

    if has_buffered_input("attack_special"):        
        return "attack_special"

    if has_buffered_input("direction"):       
        return "run"
    
    return ""

func on_enter():
    super.on_enter()
    character.velocity = Vector2.ZERO