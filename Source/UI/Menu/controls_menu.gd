extends Node2D

signal back

func _ready():
	hide()

func _on_back_button_pressed():
	hide()
	back.emit()
