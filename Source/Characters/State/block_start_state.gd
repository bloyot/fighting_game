extends BaseCharacterState

class_name BlockStartState

@export var state_name: StringName = "block_start"
@export var animation_name: StringName = "block_start"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func should_freeze_facing(): 
    return true

func update(_delta) -> String:
    super.update(_delta)
    if (animation_player.current_animation_position >= animation_length):
        return "block"
    return ""

func on_enter():
    super.on_enter()
    character.velocity = Vector2.ZERO
    animation_player.speed_scale = 2.0

func on_exit():
    super.on_exit()
    animation_player.speed_scale = 1.0