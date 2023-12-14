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

@export var auto : bool = false
var auto_on : bool = true
var speed_cache = CircularQueue.new(37)

@export var rotate_mode : bool = false
@export var degrees : float = 0.0
@export var loop : bool = false
@export var deg_offset : float = 0.0



# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = position.x - fmod(position.x, 16) - 8
	position.y = position.y - fmod(position.y, 16) - 8
	
	
	var reactor = NoteReactor.new()
	reactor.note_indeces = [note_id]
	reactor.name = "NoteReactor"
	add_child(reactor)
	
	end_pos = end_coord * 16
	
	if !auto: $TileMap.self_modulate = Notes.colors[note_id]
	$TileMap.collision_animatable = true
	
func _draw():
	var color : Color
	if auto: color = Color.WHITE
	else: color = Notes.colors[note_id]
	draw_line(Vector2.ZERO, end_pos, color * Color(0.05, 0.05, 0.05, 1), 4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
		
	if auto: auto_move(delta)
	else: player_move(delta)
	
	curve_position = clampf(curve_position, 0, 1)
	
	if rotate_mode:
		rot()
	else:
		move()
	
	
func player_move(delta):
	if $NoteReactor.is_reacted():
		curve_position += delta * speed_multiplier
	else:
		curve_position -= delta * speed_multiplier
	
	if loop and curve_position >= 1: curve_position = 0

func auto_move(delta):
	if auto_on and curve_position >= 1:
		auto_on = false
	if !auto_on and curve_position <= 0:
		auto_on = true
		
	if auto_on:
		curve_position += delta * speed_multiplier
	else:
		curve_position -= delta * speed_multiplier
	
	if loop and curve_position >= 1: curve_position = 0

func report_speed():
	var parent_report : Vector2 = Vector2.ZERO
	
	if get_parent().get_parent() is MPv2:
		parent_report = get_parent().get_parent().report_speed()
		
	var out = parent_report + speed_cache.get_min().rotated(global_rotation)
	print(out)
	return out
	
func move():
	target = Vector2.ZERO.lerp(end_pos, speed_curve.sample(curve_position))
	pos_delt = $TileMap.position - (target + Vector2(8,8))
	$TileMap.position = target + Vector2(8,8)
	speed_cache.insert(-pos_delt)
	
func rot():
	$TileMap.rotation_degrees = (degrees * speed_curve.sample(curve_position)) + deg_offset
