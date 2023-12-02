extends State

func on_enter():
	Player.velocity.y = 0
	# FSM.aq.play("idle")
	
func on_exit():
	pass
	
func on_update(delta):
	Player.velocity.x = lerp(Player.velocity.x, float(0), (delta * FSM.ground_stop_factor))
	pass
		
		
func condition():
	return (
		FSM.input_dir.x == 0 and
		Player.is_on_floor())
