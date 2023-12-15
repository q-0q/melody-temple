extends Node2D

var is_on: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("off")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name != "Player": return
	$AnimationPlayer.play("hit")
	body.set_respawn(position + Vector2(0, -8))
	if !is_on:
		$Sound.play()
		$GPUParticles2D.emitting = true
		is_on = true
