extends Node2D

@export var next_level_path : String
@export var is_entrance : bool = false
@export var n_curve :Curve

func _on_area_2d_body_entered(body):
	if is_entrance: return
	NoiseManager.do_shake(10,70, n_curve, 3)
	body.next_level = true
	SceneManager.load_level(next_level_path)
	

