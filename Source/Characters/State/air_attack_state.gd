extends BaseCharacterState

class_name AirAttackState

@export var state_name: StringName = "air_attack"
@export var animation_name: StringName = "air_attack"

func get_state_name():
    return state_name

func get_animation_name():
    return animation_name

func update() -> String:
    super.update()
    var maybe_next_state = ""
    if (animation_player.current_animation_position >= animation_length):
        maybe_next_state = "falling"	

    # lock our velocity for the duration of the attack
    character.velocity = Vector2.ZERO;

    return maybe_next_state

func on_enter():
   super.on_enter()
   character.apply_gravity = false
   
func on_exit():
    super.on_exit()
    character.apply_gravity = true