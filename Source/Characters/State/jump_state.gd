extends BaseCharacterState

class_name JumpState

@export var state_name: StringName = "jump"
@export var animation_name: StringName = "jump"

var jump_start = false

func get_state_name():
	return state_name

func get_animation_name():
	return animation_name

func update():
	super.update()
	var maybe_next_state = ""	
	if (animation_player.current_animation_position >= animation_length):
		maybe_next_state = "rising"
	
	if (!jump_start):
		character.velocity.y = Globals.JUMP_VELOCITY
		jump_start = true

	move_left_right()

	return maybe_next_state

func on_exit():
	jump_start = false