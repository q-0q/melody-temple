extends Node2D


func is_crushed():
	return (($Top.is_colliding() and $Bottom.is_colliding()) or 
		($Left.is_colliding() and $Right.is_colliding()))
