extends CharacterBody2D

class_name Player

@onready var FSM : FSM = $FSM

# 18
var respawn_pos : Vector2
var is_dead : bool = false
var next_level : bool = false
@export var n_curve : Curve

func _ready():
	NoiseManager.cam = $Camera2D
	respawn_pos = position
	NoiseManager.do_shake(10,70, n_curve, 2)
	Util.player = self
	pass
	#Engine.time_scale = 0.15

func _physics_process(delta):
	move_and_slide()
	
func _process(delta):
	if position.y >= 400: do_player_death()
	if $Crusher.is_crushed(): do_player_death()
	if $Hazard.is_touching_hazard(): do_player_death()
	$debug_text.text = FSM.current_state.name
	Util.player_pos = global_position

func do_player_death():
	is_dead = true
	print("PLAYER DEATH")
	
func set_respawn(pos):
	respawn_pos = pos


func _on_area_2d_area_entered(area):
	print(area.name)
