extends CharacterBody2D
@onready var sprite_2d = $Sprite2D

const ACCELERATION_SMOOTHING_FOR_MOVEMENT = 6
const JUMP_VELOCITY = -80.0
const MAX_SPEED = 500.0
@export var faceDir := true


signal trampoline(pos)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var itemSpawnPoint = $ItemSpawnPoint.global_position
	var momvement_vector = get_movement_vector()
	var direction = momvement_vector.normalized()
	var target_velocity = direction * MAX_SPEED 
	

	# Handle jump.
	jump()
		
	# Handle movement 
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING_FOR_MOVEMENT))
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if direction.x > 0:
		sprite_2d.flip_h = false
		faceDir = true
	elif direction.x < 0:
		sprite_2d.flip_h = true
		faceDir = false
		
	if Input.is_action_just_pressed("PlaceItem"):
		if faceDir:
			trampoline.emit(itemSpawnPoint)
		else:
			trampoline.emit(Vector2(itemSpawnPoint.x - (2 * $ItemSpawnPoint.position.x), itemSpawnPoint.y))
		print(faceDir)

	move_and_slide()


func get_movement_vector():
	var x_movement = Input.get_action_strength("move-right") - Input.get_action_strength("move-left")
	return Vector2(x_movement, 0)


func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
