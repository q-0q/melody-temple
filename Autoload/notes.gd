extends Node

@onready var bools = [false, false, false, false, false]
@export var colors = [Color(1, 0, 0, 1), Color(0, 1, 0.08235294117, 1),Color(0, 0.41960784313, 1, 1),Color(1, 0, 0.91764705882, 1),Color(1, 0.58431372549, 0, 1)]

func start_note(idx):
	bools[idx] = true
	# stuff with sound...
	
func stop_note(idx):
	bools[idx] = false
	# stuff with sound...
	
func note_is_played(idx):
	return bools[idx]
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
