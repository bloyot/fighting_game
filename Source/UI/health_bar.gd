extends CenterContainer

func _ready():
	$Over.value = 100
	$Under.value = 100

func set_health(value: float):
	var tween = create_tween()
	tween.tween_property($Over, "value", value, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Under, "value", value, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
