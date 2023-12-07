extends State

func on_enter():
	Player.velocity = Vector2.ZERO
	FSM.anim.play("die")
	
func on_exit():
	pass
	
func on_update(delta):
	pass
	
func condition():
	return Player.next_level
