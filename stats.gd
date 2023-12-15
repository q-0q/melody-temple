extends Node

var time : float = 0.0
var total_coins : int = 0
var got_coins : int = 0
var deaths: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	
	if Input.is_key_pressed(KEY_J): print(get_time_as_string())
	
func get_time_as_string():
	var msec = fmod(time, 1) * 100
	var sec = fmod(time, 60)
	var min = fmod(time, 3600) / 60
	
	var msec_text = "%03d" % msec
	var sec_text = "%02d." % sec
	var min_text = "%02d:" % min
	
	return min_text + sec_text + msec_text
	
func add_total_coin():
	total_coins += 1
	
func get_coin():
	got_coins += 1
	
func add_death():
	deaths += 1
	
func reset():
	time = 0.0
	total_coins = 0
	got_coins = 0
	deaths = 0

