extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func is_touching_hazard():
	return ($Bottom.is_colliding() or $Top.is_colliding() or $Right.is_colliding() or $Left.is_colliding())
