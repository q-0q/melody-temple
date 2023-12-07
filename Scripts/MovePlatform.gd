extends Node2D

class_name MovePlatform

@export var note_id : int = 0
@export var path : Curve2D
@export var speed_curve: Curve
@export var speed_multiplier : float = 1

var target : Vector2 = Vector2.ZERO
var curve_position : float = 0

var sound_on : bool = false
var pos_delt : Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	var reactor = NoteReactor.new()
	reactor.note_indeces = [note_id]
	reactor.name = "NoteReactor"
	add_child(reactor)
	
	
	$TileMap.self_modulate = Notes.colors[note_id]
	$TileMap.collision_animatable = true
	
	if path.get_point_position(0) != Vector2.ZERO:
		print("Make sure the first point of a moveplatform path is always 0,0")
		get_tree().quit()
	
func _draw():
	draw_line(path.get_point_position(0), path.get_point_position(1), Notes.colors[note_id] * Color(0.05, 0.05, 0.05, 1), 4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
		
	if $NoteReactor.is_reacted():
		curve_position += delta * speed_multiplier
	else:
		curve_position -= delta * speed_multiplier
	
	curve_position = clampf(curve_position, 0, 1)
	target = Vector2.ZERO.lerp(path.get_point_position(1), speed_curve.sample(curve_position))
	pos_delt = $TileMap.position - (target + Vector2(8,8))
	$TileMap.position = target + Vector2(8,8)

	
