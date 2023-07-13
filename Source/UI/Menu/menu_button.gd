extends Button

@export var confirm = false

func _on_mouse_entered():	
	$Hover.play()
	grab_focus()

func _on_pressed():
	if confirm:
		$Confirm.play()
	else:
		$Click.play()	
	
