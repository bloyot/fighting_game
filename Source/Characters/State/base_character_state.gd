extends Node2D

class_name BaseCharacterState

var animation_player: AnimationPlayer
var character: CharacterBody2D
var animation_frames: float = 0

func setup(_animation_player: AnimationPlayer, _character: CharacterBody2D):
	self.animation_player = _animation_player
	self.character = _character
	self.animation_frames = animation_player.get_animation(get_animation_name()).length	

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

func get_direction_input():
	return Input.get_axis("move_left", "move_right")

func get_attack_input():
	return Input.is_action_just_pressed("attack")

func get_jump_input():
	return Input.is_action_just_pressed("jump")