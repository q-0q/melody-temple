extends Node

class_name FSM

# tunables
@export var ground_stop_factor : float = 18
@export var air_stop_factor : float = 5
@export var coyote_time : float = 0.25
@export var input_buffer_length = 0.2
@export var cast_distance : float = 15

# references
@onready var BottomCast : RayCast2D = $"../BottomCast"
@onready var TopCast : RayCast2D = $"../TopCast"
@onready var HazardCast : RayCast2D = $"../HazardCast"

@onready var anim : AnimationPlayer = $"../AnimationPlayer"
@onready var PlayerSprite : Sprite2D = $"../PlayerSprite"
@onready var default_state : State = $Idle
@onready var Player : CharacterBody2D = $".."

# input
var input_dir : Vector2 = Vector2.ZERO
var input_jump : bool = false
var time_since_last_jump : float = input_buffer_length * 2

# bookkeeping
var current_state : State
var time_in_current_state : float = 0
var is_facing_right : bool = true

func _ready():
	_set_face_dir_from_input()
	
	for child in get_children():
		child.Player = Player
		child.FSM = self
		
	current_state = default_state
		
func _process(delta):
	
	_read_input(delta)
	
	
	
	var new_state = _determine_new_state()
	if new_state != current_state:
		current_state.on_exit()
		current_state = new_state
		current_state.on_enter()
		time_in_current_state = 0
		
	current_state.on_update(delta)
	time_in_current_state += delta
	
	if current_state == $Run or current_state == $Idle:
		Player.speed_cache.insert(Player.get_position_delta())
	else:
		Player.speed_cache.insert(Vector2.ZERO)
		
	if current_state != $Dead and current_state != $Transition:
		if Notes.is_any_played():
			anim.play("on")
			pass
		else:
			anim.play("off")
			pass
		
	
func _read_input(delta):
	
	# movement
	input_dir = Vector2.ZERO
	if Input.is_action_pressed("Left"):
		input_dir += Vector2.LEFT
	if Input.is_action_pressed("Right"):
		input_dir += Vector2.RIGHT
	if Input.is_action_pressed("Up"):
		input_dir += Vector2.UP
	if Input.is_action_pressed("Down"):
		input_dir += Vector2.DOWN

	# jump
	if Input.is_action_just_pressed("Jump"): time_since_last_jump = 0
	input_jump = (time_since_last_jump <= input_buffer_length)
	time_since_last_jump += delta
	
	# notes
	if Input.is_action_just_pressed("Note0"): Notes.start_note(0)
	if Input.is_action_just_pressed("Note1"): Notes.start_note(1)
	if Input.is_action_just_pressed("Note2"): Notes.start_note(2)
	if Input.is_action_just_pressed("Note3"): Notes.start_note(3)
	if Input.is_action_just_pressed("Note4"): Notes.start_note(4)
	
	if Input.is_action_just_released("Note0"): Notes.stop_note(0)
	if Input.is_action_just_released("Note1"): Notes.stop_note(1)
	if Input.is_action_just_released("Note2"): Notes.stop_note(2)
	if Input.is_action_just_released("Note3"): Notes.stop_note(3)
	if Input.is_action_just_released("Note4"): Notes.stop_note(4)
	
	
func _determine_new_state():
	
	if $Dead.condition(): return $Dead
	if $Transition.condition(): return $Transition
	
	if current_state == $Dead:
		if $Idle.condition(): return $Idle
		if $Run.condition(): return $Run
		if $Rise.condition(): return $Rise
		if $FallFromGround.condition(): return $FallFromGround
	
	if current_state == $Idle:
		if $Run.condition(): return $Run
		if $Rise.condition(): return $Rise
		if $FallFromGround.condition(): return $FallFromGround
		
	if current_state == $Run:
		if $Idle.condition(): return $Idle
		if $Rise.condition(): return $Rise
		if $FallFromGround.condition(): return $FallFromGround
		
	if current_state == $Rise:
		if $FallFromAir.condition(): return $FallFromAir
		if $LedgeMount.condition(): return $LedgeMount
		if $Idle.condition(): return $Idle
		
	if current_state == $FallFromAir:
		# if $Land.condition(): return $Land
		if $Idle.condition(): return $Idle
		if $Run.condition(): return $Run
		if $LedgeMount.condition(): return $LedgeMount
			
	if current_state == $FallFromGround:
		# if $Land.condition(): return $Land
		if $Idle.condition(): return $Idle
		if $Run.condition(): return $Run
		if time_in_current_state <= coyote_time \
			and $Rise.condition(): return $Rise
		
	if current_state == $LedgeMount:
		if current_state.state_locked: return $LedgeMount
		if $Idle.condition(): return $Idle
		if $Run.condition(): return $Run
		if $Rise.condition(): return $Rise
		if $FallFromAir.condition(): return $FallFromAir
			
	#if current_state == $Land:
		#if $Idle.condition(): return $Idle
		#if $Run.condition(): return $Run
		#if $Rise.condition(): return $Rise
		#if $FallFromGround.condition(): return $FallFromGround
		
	return current_state
	
func _set_face_dir_from_input():
	if Input.is_action_pressed("Left"):
		_set_face_dir(false)
	if Input.is_action_pressed("Right"):
		_set_face_dir(true)

func _set_face_dir(dir : bool):
	if (dir):
		is_facing_right = true
		BottomCast.target_position.x = cast_distance
		TopCast.target_position.x = cast_distance
		HazardCast.target_position.x = cast_distance
		PlayerSprite.scale.x = 1;
	else:
		is_facing_right = false
		BottomCast.target_position.x = -cast_distance
		TopCast.target_position.x = -cast_distance
		HazardCast.target_position.x = -cast_distance
		PlayerSprite.scale.x = -1;
		
func _flip_face_dir():
	_set_face_dir(false) if is_facing_right else _set_face_dir(true)
