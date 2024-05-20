extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -600.0
@export var nextLevel : String
@export var thisLevel : String
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumps = 0
var cooldown = 10
var startpos : Vector2
var nextlevel = false

func _ready():
	velocity = Vector2(0,0)
	startpos = position
	nextlevel = false

func _physics_process(delta):
	# Add the gravity.
	if not nextlevel:
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle Jump.
		if is_on_floor():
			jumps = 0
		
		if Input.is_action_just_pressed("jump") and jumps < 2:
			velocity.y = JUMP_VELOCITY
			jumps += 1

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		if Input.is_action_just_pressed("exit"):
			get_tree().quit()
		
		if Input.is_action_just_pressed("next"):
			next_level()
		
		move_and_slide()
		cooldown -= 1
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision.get_collider().name.contains("spike") and cooldown < 1:
				respawn()
			if collision.get_collider().get_name().contains("next"):
				next_level()
			
func next_level():
	if get_tree() != null:
		var root = get_tree().get_root()
		nextlevel = true
		velocity = Vector2(0,0)

		#get_tree().root.get_child(0).set_deffered()

		var lofdoasf = load("res://levels/" + nextLevel)
		
		var level = get_tree().get_current_scene()
		level.add_child(lofdoasf.instantiate())
		level.remove_child(get_parent())
	

func respawn():
	if get_tree() != null:
		var root = get_tree().get_root()
		nextlevel = true
		velocity = Vector2(0,0)

		#get_tree().root.get_child(0).set_deffered()

		var lofdoasf = load("res://levels/" + thisLevel)
		
		var level = get_tree().get_current_scene()
		level.add_child(lofdoasf.instantiate())
		level.remove_child(get_parent())


