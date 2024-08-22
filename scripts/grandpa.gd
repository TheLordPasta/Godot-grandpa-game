extends CharacterBody2D
@onready var sprite_2d = $Sprite2D


const SPEED = 300.0
const JUMP_VELOCITY = -80.0
@export var faceDir := true


signal trampoline(pos)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var itemSpawnPoint = $ItemSpawnPoint.global_position
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("move-left", "move-right")

	
	if direction > 0:
		sprite_2d.flip_h = false
		faceDir = true
	elif direction < 0:
		sprite_2d.flip_h = true
		faceDir = false

	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("PlaceItem"):
		if faceDir:
			trampoline.emit(itemSpawnPoint)
		else:
			trampoline.emit(Vector2(itemSpawnPoint.x * (-1), itemSpawnPoint.y))
		print(faceDir)

	move_and_slide()
