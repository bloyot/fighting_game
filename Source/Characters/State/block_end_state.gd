extends BaseCharacterState

class_name BlockEndState

@export var state_name: StringName = "block_end"
@export var animation_name: StringName = "block_end"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func should_freeze_facing(): 
    return true

func update() -> String:
    super.update()
    if (animation_player.current_animation_position >= animation_length):
        return "idle"
    return ""