extends State

@onready var FallFromAir = $"../FallFromAir"

func on_enter():
	FallFromAir.on_enter()
	
func on_exit():
	FallFromAir.on_exit()
	
func on_update(delta):
	FallFromAir.on_update(delta)
	
func condition():
	return FallFromAir.condition()
