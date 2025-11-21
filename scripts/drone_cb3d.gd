extends CharacterBody3D


@export var TURN_SPEED = 0.025
@export var MOVEMENT_SPEED = 5.0
@export var ELEVATION_SPEED = 5.0


'''
DRONE CONTROL METHOD:
	Left Axis Up & Down: Drone Goes Up & Down the world, VERTICALLY
	Left Axis Left & Right: Drone ROTATES, TURNING to the left or the right.
	Right Axis Up & Down: Forward, Backward
	Right Axis Left & Right: Left, Right
'''
func _physics_process(delta: float) -> void:
	# Add the gravity (DISABLED, Drones Float).
	'''
		if not is_on_floor():
		velocity += get_gravity() * delta
	'''
	# Handle jump (DISABLED, Drones cannot jump).
	'''
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	'''
	
	#Handle Left Stick Movement
	var input_left_stick := Input.get_vector("drone_turn_right", "drone_turn_left", "drone_fly_down", "drone_fly_up")
	
	# Drone Turning
	var turn_direction := input_left_stick.x
	if turn_direction:
		rotate_y(turn_direction * TURN_SPEED)
	
	var elevation := input_left_stick.y
	if elevation:
		velocity.y = elevation * ELEVATION_SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, ELEVATION_SPEED)
		
	# Handle Right Stick Movement
	var input_right_stick := Input.get_vector("drone_left", "drone_right", "drone_forward", "drone_backward")
	var direction := (transform.basis * Vector3(input_right_stick.x, 0, input_right_stick.y)).normalized()
	if direction:
		velocity.x = direction.x * MOVEMENT_SPEED
		velocity.z = direction.z * MOVEMENT_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVEMENT_SPEED)
		velocity.z = move_toward(velocity.z, 0, MOVEMENT_SPEED)

	move_and_slide()
	
	#Move Camera Controller according to Drone Position AND Rotation
	$Camera_Controller.position = lerp($Camera_Controller.position, position, 0.8)
	$Camera_Controller.rotation = rotation
