extends CharacterBody2D

class_name Player

@onready var FSM : FSM = $FSM

var speed_cache = CircularQueue.new(18)

func _ready():
	pass
	#Engine.time_scale = 0.25

func _physics_process(delta):
	move_and_slide()
	
func _process(delta):
	if position.y >= 400: do_player_death()
	if $Crusher.is_crushed(): do_player_death()
	$debug_text.text = FSM.current_state.name

func do_player_death():
	position = Vector2.ZERO
