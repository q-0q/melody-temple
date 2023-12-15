extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_pressed():
	Stats.reset()
	SceneManager.load_level("res://levels/lvl1.tscn")


func options_pressed():
	pass # Replace with function body.
