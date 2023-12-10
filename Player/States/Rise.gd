extends State

@export var jump_strength : float
@export var jump_time : float
@export var velocity_curve : Curve
@export var air_speed : float = 100.0

var time_elapsed : float = 0
var boost_timer : float = 0
var jump_held : bool = true
var enter_velocity : Vector2 = Vector2.ZERO
var boost_time : float = 0.45
var launch_threshhold : float = 0
var current_boost : Vector2 = Vector2.ZERO
var cast : RayCast2D


func _ready():
	pass

func on_enter():
	var mp = get_mp()
	if mp != null:
		enter_velocity = mp.report_speed()
	else:
		enter_velocity = Vector2.ZERO

	current_boost = enter_velocity * 30
	FSM.time_since_last_jump = FSM.input_buffer_length * 2
	jump_held = true
	time_elapsed = 0.0
	boost_timer = 0.0
		
func on_exit():
	pass
	
func on_update(delta):

	FSM._set_face_dir_from_input()
	
	if !Input.is_action_pressed("Jump"): time_elapsed = \
		max(time_elapsed, jump_time * 0.7)
	
	if current_boost.y >= -jump_strength:
		Player.velocity.y = \
						-1 * \
						jump_strength * \
						velocity_curve.sample(time_elapsed / jump_time)

		time_elapsed += delta

	else:
		current_boost.y += (delta * 1500)
		Player.velocity.y = current_boost.y
	
	if abs(current_boost.x) <= air_speed:
		if (FSM.input_dir.x != 0):
			Player.velocity.x = air_speed * FSM.input_dir.x
		else:
			Player.velocity.x = lerp(Player.velocity.x, float(0), (1/ FSM.air_stop_factor))
	else:
		var diff : float = delta * 1200
		if current_boost.x < 0:
			current_boost.x += diff
		else:
			current_boost.x -= diff
		Player.velocity.x = current_boost.x
			
	

func condition():
	return (FSM.input_jump or Player.velocity.y < 0)
	
func do_jump_animation():
	if (Player.velocity.y < -150):
		FSM.aq.force("rise1")
	elif (Player.velocity.y < -120):
		FSM.aq.play("rise2")
	else:
		FSM.aq.play("rise3")
		
func get_mp():

	for cast in Player.get_node("FloorCasts").get_children():
		if !cast.is_colliding(): continue
		var parent = cast.get_collider().get_parent()
		if parent is MPv2: return parent
	return null
