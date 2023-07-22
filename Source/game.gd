extends Node2D

@export var round_time: int = 300
@export var ai_player_controller_script: GDScript
@export var player_scene: PackedScene

@export var player1_color: Color
@export var player2_color: Color

var player1_score = 0
var player2_score = 0
var curr_round_time: int
var pre_round_time: int = 4

func _ready():		
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	spawn_player("Player1", false, Vector2(0, 45), player1_color)
	spawn_player("Player2", Globals.vs_computer, Vector2(250, 45), player2_color)
	
	$Camera2D.player_1 = $Player1
	$Camera2D.player_2 = $Player2

	$Player1.other_player = $Player2	
	$Player2.other_player = $Player1	

	curr_round_time = round_time	
	$RoundStartTimer.start()	

	register_devices()

func _process(_delta):
	# toggle the pause state and tell the game ui we are paused
	# game ui is responsible for unpausing us
	if Input.is_action_pressed("pause"):				
		get_tree().paused = true		
		$GameUI.pause()


func _on_player_damage_taken(player: PlayerController, damage_taken: int):	
	$GameUI._on_player_damage_taken(player, damage_taken)
	if (player.health <= 0):
		# tell player controller to die
		player.die()
		
		var winner
		if (player.name == "Player1"):
			winner = $Player2
			player2_score += 1			
		else:
			winner = $Player1
			player1_score += 1
		
		if is_match_complete():
			match_end(winner)
		else:
			round_end(winner)						
		
	

func _on_round_timer_timeout():
	curr_round_time -= 1
	$GameUI.set_round_time(curr_round_time)
	if (curr_round_time == 0):
		# technically player 1 wins if tied after timeout but... eh		
		round_end($Player1 if $Player1.health >= $Player2.health else $Player2)

func _on_round_reset_timer_timeout():
	curr_round_time = round_time
	$Player1.reset()
	$Player2.reset()	
	$GameUI.reset()
	pre_round_time = 4
	$RoundStartTimer.start()

func _on_input_joypad_connection_changed(device: int, connected: bool):
	# don't worry about disconnecting now for the sake of this prototype
	if (connected):
		$DeviceInput.initialize(device)

func start_round():	
	$Player1.input_wait = false
	$Player2.input_wait = false

func _on_round_start_timer_timeout():			
	$GameUI.set_pre_round_time(pre_round_time)
	if (pre_round_time == 1):		
		start_round()
	if (pre_round_time == 0):
		$RoundStartTimer.stop()
	pre_round_time -= 1

func round_end(winner):
	$GameUI.round_end(winner, player1_score, player2_score, is_match_complete())
	$RoundResetTimer.start()
	$Player1.input_wait = true
	$Player2.input_wait = true

func match_end(winner):
	$GameUI.round_end(winner, player1_score, player2_score, is_match_complete())
	$MatchResetTimer.start()
	$Player1.input_wait = true
	$Player2.input_wait = true

func is_match_complete():
	return true if player1_score == 2 or player2_score == 2 else false

func _on_player_stamina_changed(player: PlayerController, stamina: float):
	if (player.name == "Player1"):
		$GameUI/Player1StaminaBar/Stamina.value = stamina	
	if (player.name == "Player2"):
		$GameUI/Player2StaminaBar/Stamina.value = stamina	

func spawn_player(player_name, is_computer, player_position, player_color):	
	var player: PlayerController = player_scene.instantiate()		
	if is_computer:
		player.set_script(ai_player_controller_script)		
	player.game_audio = $GameAudio			
	player.position = player_position
	player.name = player_name
	player.scale = Vector2(2, 2)
	player.player_color = player_color
	
	# todo wire up signals, maybe needs to happen after adding child? 
	player.stamina_changed.connect(_on_player_stamina_changed)
	player.damage_taken.connect(_on_player_damage_taken)
	add_child(player)
	
func register_devices():
	# register the controller devices and associate the ids with the players
	# player 1 always gets the first device + keyboard
	# player 2 get the second device		
	$DeviceInput.initialize(0)
	$DeviceInput.initialize(1)
	# use 100 for keyboard
	$DeviceInput.initialize(100)
	$Player1.device_id = 0
	$Player2.device_id = 1

	# setup a notification for game pad changed
	Input.joy_connection_changed.connect(_on_input_joypad_connection_changed)

func _on_match_reset_timer_timeout():
	Scene.change_scene(Scene.MAIN_MENU)
