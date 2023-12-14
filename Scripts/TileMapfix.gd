extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	collision_animatable = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_transform = get_parent().global_transform
	
