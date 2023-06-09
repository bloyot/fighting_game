extends Node2D

class_name GameAudio

func hit():
	$HitSFX.play()

func block():
	$BlockSFX.play()

func attack():
	$AttackSFX.play()

