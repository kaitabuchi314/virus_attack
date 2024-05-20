extends Node2D

var randpos : Vector2

var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	var set_width : float = ProjectSettings.get("display/window/size/viewport_width")
	var set_height : float = ProjectSettings.get("display/window/size/viewport_height")
	
	time += delta
	
	if time > 4:
		randpos = Vector2(randf_range(0, set_width), randf_range(0, set_height))
		time = 0

	position += ( randpos - position) / 70
