extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -350.0
var mining = false
var facing_right = true
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func updateAnimation():
	if facing_right:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	var anim = "idle"
	if abs(velocity.x) > 0:
		anim = "run"
	if mining:
		anim = "mine"
	if !is_on_floor():
		anim = "jump"
	animation_player.play(anim)

func endMining():
	mining = false

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("run_left", "run_right")
	if direction:
		if (direction > 0):
			facing_right = true
		else:
			facing_right = false
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _process(delta):
	if Input.is_action_just_pressed("click") and is_on_floor():
		mining = true
	updateAnimation()
