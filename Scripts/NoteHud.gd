extends TextureRect

@export var id : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $NoteReactor.is_reacted(): modulate = Notes.colors[id]
	else: modulate = Color(1,1,1,1)
