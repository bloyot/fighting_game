extends PlayerController
# dummy controller that just stands around and takes no input, for testing/training purposes

# lock the facing in one direction
@export var lock_facing: = false

# allow input to be set for training/testing
@export var target_input_map: Dictionary = {
	"direction": 0.0,
	"attack": false,
	"attack_special": false,
	"jump": false,
	"block": false
}

# hardcode input to none
func get_input(): 	
	return target_input_map


func set_facing():	
	if (!lock_facing):
		super.set_facing()