extends Node2D

var target : Vector2
var picked_up : bool = false
var found_lock : bool = false
var lock
var opened : bool = false
var home : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	home = position
	target = position
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Util.player == null: return
	
	if Util.player.is_dead:
		target = home
		picked_up = false
		
	if found_lock and !opened and (global_position - target).length_squared() < 10:
		$AnimationPlayer.play("open")
		opened = true
		lock.open()
		
		
	if picked_up:
		target = (Util.player_pos + Vector2(20, -30))
	position = position.lerp(target, delta * 3)

func _on_area_2d_body_entered(body):
	if found_lock: return
	picked_up = true

func _on_area_2d_area_entered(area):
	if area.is_in_group("Locks"):
		lock = area.get_parent()
		found_lock = true
		picked_up = false
		target = area.global_position

func destroy():
	queue_free()
