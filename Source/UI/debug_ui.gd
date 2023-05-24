extends CanvasLayer

func _on_character_state_change(_old_state: BaseCharacterState, new_state: BaseCharacterState):	
	$State.text = "State: " + new_state.name
