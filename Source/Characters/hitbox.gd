extends Area2D

class_name Hitbox

func _ready():
	assert($CollisionShape2D != null, "Hitbox must have a collision shape child named $CollisionShape2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CollisionShape2D.visible = (monitoring and monitorable)
