extends BaseCharacterState

class_name BlockState

@export var state_name: StringName = "block"
@export var animation_name: StringName = "block"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func update() -> String:
    super.update()
    if (!get_block_input()):
        return "block_end"
    return ""