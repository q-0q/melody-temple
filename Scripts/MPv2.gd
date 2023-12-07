extends Node2D

class_name MPv2

@export var note_id : int = 0
@export var end_coord : Vector2i
@export var speed_curve: Curve
@export var speed_multiplier : float = 1

var target : Vector2 = Vector2.ZERO
var curve_position : float = 0
var end_pos : Vector2
var pos_delt : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = position.x - fmod(position.x, 16) - 8
	position.y = position.y - fmod(position.y, 16) - 8
	
	
	var reactor = NoteReactor.new()
	reactor.note_indeces = [note_id]
	reactor.name = "NoteReactor"
	add_child(reactor)
	
	end_pos = end_coord * 16
	
	$TileMap.self_modulate = Notes.colors[note_id]
	$TileMap.collision_animatable = true
	
func _draw():
	print("drawing")
	draw_line(Vector2.ZERO, end_pos, Notes.colors[note_id] * Color(0.05, 0.05, 0.05, 1), 4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if $NoteReactor.is_reacted():
		curve_position += delta * speed_multiplier
	else:
		curve_position -= delta * speed_multiplier
	
	curve_position = clampf(curve_position, 0, 1)
	target = Vector2.ZERO.lerp(end_pos, speed_curve.sample(curve_position))
	pos_delt = $TileMap.position - (target + Vector2(8,8))
	$TileMap.position = target + Vector2(8,8)

	
