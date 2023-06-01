extends PlayerController
# dummy controller that just stands around and takes no input, for testing/training purposes

func _ready():
	super._ready()
	set_facing(true)

# allow input to be set for training/testing
@export var target_input_map: Dictionary = {
	"direction": Vector2.ZERO,
	"attack": false,
	"attack_special": false,
	"jump": false,
	"block": false
}

# hardcode input to none
func get_input(): 	
	return target_input_map
