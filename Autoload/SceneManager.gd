extends Node2D

var current_scene
var current_path

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	$CanvasLayer/ColorRect.size = Vector2(500, 300)
	$CanvasLayer/ColorRect.position.x = 500
	$CanvasLayer/ColorRect.position.y = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_level(path_to_level):
	current_path = path_to_level
	$AnimationPlayer.play("transition")
	
func transition():
	call_deferred("load_deferred")	

func load_deferred():
	var s = load(current_path)
	current_scene.free()
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
