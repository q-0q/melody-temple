extends Node2D

var target : Vector2
var picked_up : bool = false
var found_lock : bool = false
var lock
var opened : bool = false
var home : Vector2
var offset : Vector2 = Vector2.ZERO

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
		offset = Vector2.ZERO
		
	if found_lock and !opened and (global_position - target).length_squared() < 10:
		$AnimationPlayer.play("open")
		opened = true
		lock.open()
		
		
	if picked_up:
		target = (Util.player_pos + Vector2(20, -30))
	position = position.lerp(target + offset, delta * 3)

func _on_area_2d_body_entered(body):
	if !body is Player: return
	if found_lock: return
	if !picked_up: $Sound.play()
	picked_up = true
	offset = Vector2(randf_range(-15,15),randf_range(-3,3))

func _on_area_2d_area_entered(area):
	if found_lock: return
	if area.is_in_group("Locks"):
		if area.get_parent().got_a_key: return
		lock = area.get_parent()
		lock.got_a_key = true
		found_lock = true
		picked_up = false
		target = area.global_position
		offset = Vector2.ZERO

func destroy():
	queue_free()
