extends Control

var spacer : String = "      "

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/clock.text = spacer + Stats.get_time_as_string()
	$VBoxContainer/coins.text = spacer + str(Stats.got_coins) + "/" + str(Stats.total_coins)
	$VBoxContainer/deaths.text = spacer + str(Stats.deaths)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	SceneManager.load_level("res://levels/menu.tscn")
