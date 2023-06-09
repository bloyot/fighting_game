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
func get_state_name() -> String:	
	push_error("Uninteded interface function call get state name")
	return ""

func get_animation_name() -> String:
	push_error("Uninteded interface function call get animation name")
	return ""

### Base class functions
func update(_delta) -> String:				
	return ""

func get_damage() -> int:
	return 0

func on_enter():	
	character.freeze_facing = should_freeze_facing()
	animation_player.play(get_animation_name())		

func on_exit():
	pass

func on_hit_blocked():
	pass

func on_hit():
	pass

# core functions
func should_freeze_facing(): 
	return false

func move_left_right():	
	var direction = frame_buffer.back()["direction"]
	if (direction):
		character.velocity.x = direction * Globals.SPEED	
	else:
		# if not holding a button, slow down towards zero
		character.velocity.x = move_toward(character.velocity.x, 0, Globals.SPEED)	

func set_input(input: Dictionary):
	frame_buffer.push_back(input)	
	if (frame_buffer.size() > frame_buffer_frames):
		frame_buffer.pop_front()	

# return true if the input exists in the last x buffered frames
func has_buffered_input(input: String, frames_back: int = 1) -> bool:
	for frame in frame_buffer.slice(-1 * frames_back):
		if (frame.has(input) and frame[input]):
			return true
	return false