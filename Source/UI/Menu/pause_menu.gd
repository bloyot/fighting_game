extends Node2D

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	hide()

func _on_resume_button_pressed():
	print("resume")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	hide()


func _on_quit_button_pressed():
	get_tree().paused = false
	Scene.change_scene(Scene.MAIN_MENU)
