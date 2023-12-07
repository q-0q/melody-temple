extends State

var time_elapsed : float = 0.0
var total_time : float = 1
var rect
@export var curve : Curve
@export var n_curve : Curve
var anim_time : float
var cam : Camera2D

func _ready():
	rect = $CanvasLayer/ColorRect
	rect.position.y = -rect.size.y

func on_enter():
	$AudioStreamPlayer.play()
	Player.velocity = Vector2.ZERO
	cam = Player.get_node("Camera2D")
	FSM.anim.play("die")
	time_elapsed = 0.0
	anim_time = FSM.anim.current_animation_length
	NoiseManager.do_shake(80.0, 40.0, n_curve, 1.0)

func on_exit():
	cam.offset = Vector2.ZERO

func on_update(delta):
	print(anim_time)
	time_elapsed += delta
	
	rect.position.y = lerpf(-rect.size.y, rect.size.y, curve.sample(time_elapsed/total_time))
	
	if rect.position.y > 0:
		Player.position = Player.respawn_pos
		cam.reset_smoothing()
		FSM.anim.play("off")
	if time_elapsed > total_time:
		Player.is_dead = false
	
func condition():
	return Player.is_dead
