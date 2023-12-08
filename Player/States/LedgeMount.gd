extends State

@export var mount_speed = 20

@onready var PlayerCollider : CollisionShape2D = $"../../CollisionShape2D"

var state_locked : bool = true

func on_enter():
	# FSM.aq.play("mount")
	state_locked = true
	PlayerCollider.set_deferred("disabled", true)
	
func on_exit():
	PlayerCollider.set_deferred("disabled", false)
	
func is_steep_enough():
	if !FSM.BottomCast.is_colliding(): return false
	var angle = FSM.BottomCast.get_collision_normal().angle()
	return (abs(angle) <= 0.5) or (abs(abs(angle)-3.14159) <= 0.5)

func is_hazard():
	if !FSM.BottomCast.is_colliding(): return false
	return (FSM.BottomCast.get_collider().get_collision_layer() == 2)
	
func on_update(delta):
	if FSM.BottomCast.is_colliding() and is_steep_enough():
		Player.velocity.y = -mount_speed
		if FSM.is_facing_right:
			Player.velocity.x = mount_speed
		else:
			Player.velocity.x = -mount_speed
	else:
		Player.velocity.y = 0
		state_locked = false
		
func condition():
	return (
	FSM.BottomCast.is_colliding() and
	!FSM.HazardCast.is_colliding() and
	is_steep_enough() and
	!FSM.TopCast.is_colliding()
	)
			
