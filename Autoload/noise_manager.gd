extends Node

var cam : Camera2D
var noise : FastNoiseLite

var shake : float = 0.0
var speed : float = 0.0
var curve : Curve
var timer : float = 0.0
var total : float = 0.0

func do_shake(_shake, _speed, _curve, _time):
	print("doshake called")
	shake = _shake
	speed = _speed
	curve = _curve
	timer = _time
	total = _time
	
# Called when the node enters the scene tree for the first time.
func _ready():
	noise = FastNoiseLite.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	
	if cam == null: return
	
	if timer < 0:
		cam.offset = Vector2.ZERO
		return
		
	
	var noise_offset = Vector2(noise.get_noise_1d(timer * speed),
		noise.get_noise_1d(timer * speed + 100)) * shake * curve.sample(timer / total)
	cam.offset = noise_offset
