extends Node

var _actions : Dictionary = {}
var _device : int
var _suffix : String

func initialize(device: int):
	if device == -1:
		push_error("Cannot set up DeviceInput for all devices")
		return
	
	_device = device
	_suffix = "_device_%d" % device
	
	# Find all controller inputs, and add new actions that are device-specific
	for base_action in InputMap.get_actions():
		_actions[base_action] = base_action + _suffix
		# Ensure the action hasn't already been added in another scene
		if not base_action.contains("_device_"):
			_duplicate_action(base_action)	

func _duplicate_action(base_action: String):
	var new_action = base_action + _suffix	
	for event in InputMap.action_get_events(base_action):
		if event is InputEventJoypadButton or event is InputEventJoypadMotion or event is InputEventKey:
			if not InputMap.has_action(new_action):
				var base_deadzone = InputMap.action_get_deadzone(base_action)
				InputMap.add_action(new_action, base_deadzone)
			
			var new_event = event.duplicate()
			new_event.device = _device
			
			InputMap.action_add_event(new_action, new_event)

func get_action_strength(action: String) -> float:
	return Input.get_action_strength(_actions[action])

func get_mapped_action(action: String) -> String:
	return _actions[action]