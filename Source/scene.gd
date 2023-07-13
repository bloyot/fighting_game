# Auto load for scene management
extends Node

const MAIN_MENU = "main_menu"
const GAME = "game"

var scenes = {
	GAME: "res://Source/game.tscn",
	MAIN_MENU: "res://Source/UI/Menu/main_menu.tscn"
}

func change_scene(scene_name):
	if scene_name in scenes:
		get_tree().change_scene_to_file(scenes[scene_name])
	else:
		printerr("Invalid scene name " + scene_name)
