extends PlayerController
# dummy controller that just stands around and takes no input, for testing/training purposes

# hardcode input to none
func get_input(): 	
	return {
		"direction": Vector2.ZERO,
		"attack": false,
		"attack_special": false,
		"jump": false,
		"block": false
	}