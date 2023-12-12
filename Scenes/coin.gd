extends Node2D

class_name Coin

@export var curve : Curve

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func destroy():
	queue_free()

func _on_area_2d_body_entered(body):
	if body.name != "Player": return
	Sounds.get_node("Coin").play()
	NoiseManager.do_shake(25,100,curve,2)
	$AnimationPlayer.play("get")
	
