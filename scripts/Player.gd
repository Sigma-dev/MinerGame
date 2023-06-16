extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -350.0
var mining = false
var facing_right = true
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var mining_cast = $MiningCast
var state = "default"
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func updateAnimation():
	if facing_right:
		transform.x.x = 1
	else:
		transform.x.x = -1
	var anim = "idle"
	if abs(velocity.x) > 0:
		anim = "run"
	if state == "mining":
		anim = "mine"
	if !is_on_floor():
		anim = "jump"
	animation_player.play(anim)
	
func is_player():
	return true

func endMining():
	mining_cast.force_shapecast_update()
	for i in mining_cast.get_collision_count():
		var hit = mining_cast.get_collider(i)
		
		if (hit.has_method("get_hit")):
			hit.get_hit(10, mining_cast.get_collision_point(i))
	state = "default"

func handle_movement():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("run_left", "run_right")
	if direction:
		if (direction > 0):
			facing_right = true
		else:
			facing_right = false
		velocity.x = direction * SPEED

func handle_physics(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if !Input.get_axis("run_left", "run_right") || state != "default":
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _physics_process(delta):
	handle_physics(delta)
	if state == "default":
		handle_movement()
	move_and_slide()
	
func _process(delta):
	if Input.is_action_just_pressed("click") and is_on_floor():
		state = "mining"
	updateAnimation()
