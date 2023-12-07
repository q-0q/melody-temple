extends AudioStreamPlayer2D

class_name MPSound

var tilemap : Node2D
var sound_on : bool
var pos_delt : Vector2
var thresh : float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap = get_parent().get_node("TileMap")
	sound_on = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pos_delt = get_parent().pos_delt
	
	if pos_delt.length_squared() > thresh and !sound_on:
		sound_on = true
		play()
	elif pos_delt.length_squared() <= thresh:
		sound_on = false
		stop()
