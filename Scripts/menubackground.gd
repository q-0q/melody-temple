extends Sprite2D

var noise : FastNoiseLite
var speed : float = 8
var shake : float = 20.0
var timer : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	noise = FastNoiseLite.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	offset = Vector2(noise.get_noise_1d(timer * speed), noise.get_noise_1d(timer*speed + 100.0)) * shake
