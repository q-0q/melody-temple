extends CanvasModulate

@export var c : Color = Color.BLACK
var bottom : float = -2671.00390625
var top : float = -5871.07763671875
var diff : float
var base : Color
# Called when the node enters the scene tree for the first time.
func _ready():
	base = color
	diff = top - bottom


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var weight : float = inverse_lerp(bottom, top, Util.player_pos.y)
	weight = clampf(-1, 0, weight)
	color = lerp(base, c, weight)
	if Input.is_key_pressed(KEY_J):
		print(weight)
