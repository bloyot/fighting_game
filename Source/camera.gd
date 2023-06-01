extends Camera2D

var player_1: PlayerController
var player_2: PlayerController

@export var bounds_threshold: int = 100
@export var min_x: int
@export var max_x: int
@export var camera_speed: int = 300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	var left_bounds = position.x - get_viewport_rect().size.x / 2
	var right_bounds = position.x + get_viewport_rect().size.x / 2

	var is_player1_near_left = player_1.position.x < left_bounds + bounds_threshold
	var is_player2_near_left = player_2.position.x < left_bounds + bounds_threshold
	var is_player1_near_right = player_1.position.x > right_bounds - bounds_threshold 
	var is_player2_near_right = player_2.position.x > right_bounds - bounds_threshold

	# if both players are not at the edge
	if (!((is_player1_near_left and is_player2_near_right) or (is_player2_near_left and is_player1_near_right))):			
		
		# if either player is at the left side move left
		if (is_player1_near_left or is_player2_near_left):
			position.x = clamp(position.x - camera_speed * delta, min_x, max_x)

		
		# if either player is at the right, move right
		if (is_player1_near_right or is_player2_near_right):
			position.x = clamp(position.x + camera_speed * delta, min_x, max_x)			

	# update the player camera state 
	player_1.camera_lock_state = [is_player1_near_left, is_player1_near_right]
	player_2.camera_lock_state = [is_player2_near_left, is_player2_near_right]	
	
