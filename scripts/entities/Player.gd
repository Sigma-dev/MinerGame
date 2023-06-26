extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -350.0
var mining = false
var facing_right = true
@onready var anim_ub = $Visuals/UpperBodyPlayer
@onready var anim_lb = $Visuals/LowerBodyPlayer
@onready var mining_cast = $MiningCast
var state = "default"
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var inventory: InventoryData = preload("res://resources/inventories/player_inventory.tres")

func updateAnimation():
	if facing_right:
		transform.x.x = 1
	else:
		transform.x.x = -1
	var ub = "idle"
	var lb = "idle"
	if abs(velocity.x) > 0:
		ub = "run"
		lb = "run"
	if state == "mining":
		ub = "mine"
	if !is_on_floor():
		ub = "jump"
	anim_ub.play(ub)
	anim_lb.play(lb)
	
func is_player():
	return true

func endMining():
	mining_cast.force_shapecast_update()
	for i in mining_cast.get_collision_count():
		var hit = mining_cast.get_collider(i)
		for child in hit.get_children():
			if child is Hittable:
				child.try_hit(10, mining_cast.get_collision_point(i))
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
		state = "default"
		velocity.y += gravity * delta
	if !Input.get_axis("run_left", "run_right") || state != "default":
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
func pickup_item(item_data):
	inventory.add_item(item_data)

func _physics_process(delta):
	handle_physics(delta)
	handle_movement()
	move_and_slide()
	
func _process(delta):
	if Input.is_action_just_pressed("click") and is_on_floor():
		state = "mining"
	updateAnimation()
