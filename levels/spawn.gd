extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().add_child.call_deferred(load("res://prefabs/player.tscn").instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
