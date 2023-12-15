extends Node2D

@export var move : bool = false
@export var flute : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name != "Player": return
	if move: $AnimationPlayer.play("open_move")
	if flute: $AnimationPlayer.play("open_flute")
	


func _on_area_2d_body_exited(body):
	if body.name != "Player": return
	if move: $AnimationPlayer.play("close_move")
	if flute: $AnimationPlayer.play("close_flute")
