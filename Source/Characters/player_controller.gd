extends CharacterBody2D

class_name PlayerController

signal state_change(old_state: BaseCharacterState, new_state: BaseCharacterState)

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

########################################
########## Engine Overrides ############
########################################
func _ready():
	# TODO it's likely this is affecting the dummy controller also by setting the same states
	var states_group = $States.get_children()	
	for state in states_group:
		assert(state.get_state_name() != "")
		state.setup($AnimationPlayer, self)
		states[state.get_state_name()] = state
	curr_state = states["idle"]
	change_state("idle")

func _physics_process(delta):
	curr_state.set_input(get_input())
	var maybe_new_state = curr_state.update()
	if (maybe_new_state != ""):
		change_state(maybe_new_state)

	# determine facing based on where the opposing character is relative to us		
	if (!freeze_facing):
		$Sprite2D.flip_h = other_player.position.x < position.x
		
	# determine movement based on state
	move(delta)
		

########################################
############# Callbacks ################
########################################

func _on_sword_hurtbox_area_entered(area):	
	if (area.get_parent() == other_player && other_player.curr_state.get_state_name() != "block"):
		other_player.take_hit()

########################################
########## Class Functions #############
########################################

# this function handles movement of the player given the input velocity (which should be computed by the specific state)
func move(delta: float):	
	if not is_on_floor() and apply_gravity:	
		velocity.y += gravity * delta		

	move_and_slide()

func get_input(): 	
	return {
		"direction": Input.get_axis("move_left", "move_right"),
		"attack": Input.is_action_just_pressed("attack"),
		"attack_special": Input.is_action_pressed("attack_special"),
		"jump": Input.is_action_just_pressed("jump"),
		"block": Input.is_action_pressed("block"),
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

func take_hit():
	change_state("take_hit")
