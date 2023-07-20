extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():	
	$FireKnight/PlayerIDLabel.hide()
	$FireKnight2/PlayerIDLabel.hide()
	$MainMenuOptions/VBoxContainer/VSHuman.grab_focus()

func _on_quit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	$MainMenuOptions.hide()
	$CreditsMenu.show()	

func _on_controls_pressed():
	$MainMenuOptions.hide()
	$ControlsMenu.show()	

func _on_vs_computer_pressed():
	Globals.vs_computer = true
	Scene.change_scene(Scene.GAME)

func _on_vs_human_pressed():
	Globals.vs_computer = false
	Scene.change_scene(Scene.GAME)


func _on_credits_menu_back():
	$MainMenuOptions.show()

func _on_controls_menu_back():
	$MainMenuOptions.show()
