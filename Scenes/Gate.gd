extends Node2D

var is_open: bool = false
@export var n_curve : Curve

# Called when the node enters the scene tree for the first time.
func _ready():
	var i : int = 0
	for note in $NoteReactor.note_indeces:
		$Blocks.add_child(GateColorBlock.new(note, i, $NoteReactor.note_indeces.size()))
		i+=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if global_position.distance_squared_to(Util.player_pos) > 30000: return
	
	if $NoteReactor.is_reacted_exclusive() and !is_open:
		$AnimationPlayer.play("open")
		is_open = true
	if Input.is_key_pressed(KEY_K):
		$AnimationPlayer.play("close")
		is_open = false

func shake():
	NoiseManager.do_shake(3,500, n_curve, 3)
