extends Node2D

@onready var FSM = $"../FSM"


func is_crushed():
	if FSM.current_state == FSM.get_node("LedgeMount"): return false
	return (($Top.is_colliding() and $Bottom.is_colliding()) or 
		($Left.is_colliding() and $Right.is_colliding()))
