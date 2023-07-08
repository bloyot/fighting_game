extends CharacterBody2D

class_name PlayerController

signal state_change(old_state: BaseCharacterState, new_state: BaseCharacterState)
signal damage_taken(player: PlayerController, damage_taken: int)
signal stamina_changed(player: PlayerController, stamina: float)

@export var player_color: Color
@export var recharge_rate: float = 1
@export var drain_rate: float = 1

# Plays non character specific sounds like music and hit/block
var game_audio: GameAudio
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# track all states here for reference
var states = {}
# track our current state here
var curr_state = null
# some states want to hang in the air like the arial attack
var apply_gravity = true
# use this to avoid flipping our facing during the middle of an attack or other animation
var freeze_facing = false
# keep a reference to the other player to determine facing
var other_player: PlayerController
# our current facing 
var curr_facing_left: bool = false
# store the camera lock information relevant to the player to determine if we need to lock the movement left/right
# array[0] = is_left_locked, array[1] = is_right_locked 
var camera_lock_state: Array = [false, false]
var max_health: int = 100
# player health
var health: int
# set our starting position so we can reset to it
var starting_position: Vector2
# are we waiting for control for some reason
var input_wait = true
# which controller device this player is listening too
var device_id: int
# is our attack on cooldown
var air_attack_cooldown: bool = false
# how much stamina is left on our block bar
var stamina: float = 100
########################################
########## Engine Overrides ############
########################################
func _ready():
	starting_position = position
	health = max_health
	# setup the states
	var states_group = $States.get_children()	
	for state in states_group:
		assert(state.get_state_name() != "")
		state.setup($AnimationPlayer, self)
		states[state.get_state_name()] = state
	curr_state = states["idle"]
	change_state("idle")

	$PlayerIDLabel.text = name
	$PlayerIDLabel.add_theme_color_override("font_color", player_color)
	
func _physics_process(delta):
	curr_state.set_input(get_input())
	var maybe_new_state = curr_state.update(delta)
	if (maybe_new_state != ""):
		change_state(maybe_new_state)

	# determine facing based on where the opposing character is relative to us		
	if (!freeze_facing):
		set_facing(other_player.position.x < position.x)
		
	update_stamina(delta)
	print(stamina)
	# determine movement based on state
	move(delta)		

########################################
############# Callbacks ################
########################################
func _on_sword_hitbox_body_entered(body):
	if (body != other_player):
		return

	if (other_player.curr_state.get_state_name() != "block"):		
		other_player.on_hit(curr_state.get_damage())	
	else:
		on_hit_blocked()
		other_player.on_blocked_hit()

########################################
########## Class Functions #############
########################################

# this function handles movement of the player given the input velocity (which should be computed by the specific state)
func move(delta: float):	
	if not is_on_floor() and apply_gravity:	
		velocity.y += gravity * delta		

	# if we are moving right, and the camera is locked on the right side, set velocity 0
	if (velocity.x > 0 and camera_lock_state[1]):
		velocity.x = 0
	# same for left
	if (velocity.x < 0 and camera_lock_state[0]):
		velocity.x = 0
	move_and_slide()

func get_input(): 	
	if input_wait:
		return {}
	return {
		"direction": get_axis("move_left", "move_right"),
		"attack": get_input_just_pressed("attack"),
		"attack_special": get_input_pressed("attack_special"),
		"jump": get_input_just_pressed("jump"),
		"block": get_input_pressed("block"),
	}

func change_state(new_state_name: String):
	assert(new_state_name != "", "Invalid state change")
	assert(states.has(new_state_name), "Invalid state change")
	var old_state = curr_state
	var new_state = states[new_state_name]		

	old_state.on_exit()	
	new_state.on_enter()

	curr_state = new_state		
	state_change.emit(old_state, new_state)

func on_hit(damage: int):	
	change_state("take_hit")
	curr_state.on_hit()
	game_audio.hit()	
	health -= damage
	damage_taken.emit(self, damage)

# our hit was blocked by the other player
func on_hit_blocked():		
	curr_state.on_hit_blocked()
	game_audio.block()

# we blocked a hit from the other player
func on_blocked_hit():
	# decrease stamina on block
	stamina = clamp(stamina - 20, 0, 100)
	stamina_changed.emit(self, stamina)

func set_facing(should_face_left: bool):	
	if (should_face_left and !curr_facing_left):
		curr_facing_left = true
		flip_facing()

	if (!should_face_left and curr_facing_left):
		curr_facing_left = false
		flip_facing()

func flip_facing():
	scale.x = scale.x * -1
	$PlayerIDLabel.scale.x *= -1
	$PlayerIDLabel.position.x *= -1

func die():
	change_state("die")
	$CharacterAudio.die()

func reset():
	position = starting_position
	health = max_health
	change_state("idle")

# modify the input to account for our specific device id
func input_name(input: String, id: int):
	return input + "_device_" + str(id)	

func get_axis(input_left: String, input_right: String):
	if (device_id == 0):
		var keyboard_input = Input.get_axis(input_name(input_left, 100), input_name(input_right, 100))
		var controller_input = Input.get_axis(input_name(input_left, device_id), input_name(input_right, device_id))
		return keyboard_input if keyboard_input != 0.0 else controller_input		
	else:
		return Input.get_axis(input_name(input_left, device_id), input_name(input_right, device_id))

func get_input_pressed(input: String):
	if (device_id == 0):		
		var keyboard_input = Input.is_action_pressed(input_name(input, 100))
		var controller_input = Input.is_action_pressed(input_name(input, device_id))
		return keyboard_input if keyboard_input else controller_input
	else:
		return Input.is_action_pressed(input_name(input, device_id))

# could probably find a way to consolidate this with input pressed, but it's not terrible
func get_input_just_pressed(input: String):
	if (device_id == 0):
		var keyboard_input = Input.is_action_just_pressed(input_name(input, 100))
		var controller_input = Input.is_action_just_pressed(input_name(input, device_id))
		return keyboard_input if keyboard_input else controller_input
	else:
		return Input.is_action_just_pressed(input_name(input, device_id))

func update_stamina(delta):	
	if curr_state.state_name == "block" and stamina > 0:
		stamina -= (drain_rate * delta)
		stamina_changed.emit(self, stamina)
	if curr_state.state_name != "block" and stamina < 100:
		stamina += (recharge_rate * delta)
		stamina_changed.emit(self, stamina)
