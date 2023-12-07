extends Node2D

@export var curve : Curve

# Called when the node enters the scene tree for the first time.
func open():
	NoiseManager.do_shake(5.0,500.0, curve, 1.0)	
	$AnimationPlayer.play("open")
