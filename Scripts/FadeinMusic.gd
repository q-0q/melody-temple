extends Node2D

class_name FadeInMusic
@export var music_layer : String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if music_layer != "":
		var vol = lerpf(Sounds.get_node(music_layer).volume_db, 0.0, delta * 5)
		Sounds.get_node(music_layer).volume_db = vol
