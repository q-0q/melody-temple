extends Node2D

class_name GateColorBlock

var target : Vector2
var timer : float = 0
var rect : ColorRect
var reactor : NoteReactor
var ORBIT_RADIUS = 10
var ORBIT_SPEED = -2
var ORBIT_OFFSET = 0
var SCALE = 1
var BASE_SIZE = Vector2(5,5)

func _init(note_id:int, order_id:float, total_ct:float):
	
	position.y = -93
	
	ORBIT_RADIUS *= randf_range(0.9, 1.1)

	timer = (float(order_id) / float(total_ct)) * 5.0
	print(timer)

	rect = ColorRect.new()
	rect.color = Notes.colors[note_id]
	rect.size = BASE_SIZE
	add_child(rect)
	
	reactor = NoteReactor.new()
	reactor.note_indeces = [note_id]
	reactor.name = "reactor"
	add_child(reactor)
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rad = ORBIT_RADIUS
	if $reactor.is_reacted() and !get_parent().get_parent().get_node("NoteReactor").has_bad_note():
		rect.size = BASE_SIZE * 0.75
		rad /= 4
	else:
		rect.size = BASE_SIZE
	
	timer += (delta * ORBIT_SPEED)
	target = Vector2(cos(timer), sin(timer)) * rad
	rect.position = rect.position.lerp(target, delta * 5)
