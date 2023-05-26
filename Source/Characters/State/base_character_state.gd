extends Node2D

class_name BaseCharacterState

var animation_player: AnimationPlayer
var character: CharacterBody2D
var animation_length: float = 0
# amount of frames before the end of an animation that we will store an input
var frame_buffer_frames: float = 60
# store the most recent input if we're mid animation
var frame_buffer: Array = []

func setup(_animation_player: AnimationPlayer, _character: CharacterBody2D):
	self.animation_player = _animation_player
	self.character = _character
	self.animation_length = animation_player.get_animation(get_animation_name()).length	

### Interface functions 
# these are intended to be implemented by each state
func get_state_name() -> String:	
	push_error("Uninteded interface function call get state name")
	return ""

func get_animation_name() -> String:
	push_error("Uninteded interface function call get animation name")
	return ""

### Base class functions
func update() -> String:				
	frame_buffer.push_back(get_input())	
	if (frame_buffer.size() > frame_buffer_frames):
		frame_buffer.pop_front()
	return ""

func on_enter():	
	animation_player.play(get_animation_name())	

func on_exit():
	pass

func move_left_right():	
	var direction = get_direction_input()
	if (direction):
		character.velocity.x = direction * Globals.SPEED	
	else:
		# if not holding a button, slow down towards zero
		character.velocity.x = move_toward(character.velocity.x, 0, Globals.SPEED)	

# Input functions
# return a map of the inputs that were pressed this frame
func get_input() -> Dictionary:
	return {
		"direction": get_direction_input(),
		"attack": get_attack_input(),
		"attack_special": get_attack_special_input(),
		"jump": get_jump_input(),
		"block": get_block_input(),
	}

# return true if the input exists in the last x buffered frames
func has_buffered_input(input: String, frames_back: int = 1) -> bool:
	for frame in frame_buffer.slice(-1 * frames_back):
		if (frame.has(input) and frame[input]):
			return true
	return false

func get_direction_input():
	return Input.get_axis("move_left", "move_right")

func get_attack_input():
	return Input.is_action_just_pressed("attack")

func get_jump_input():
	return Input.is_action_just_pressed("jump")

func get_block_input():
	return Input.is_action_pressed("block")

func get_attack_special_input():
	return Input.is_action_pressed("attack_special")