extends CharacterBody3D


@export var TURN_SPEED = 0.025
@export var MOVEMENT_SPEED = 5.0
@export var ELEVATION_SPEED = 5.0
@export var PRESET_PATHS_MODE : bool = false

var DronePathFollow: PathFollow3D
var Paths: Path3D
var PresetPathUIControls: Control
func _ready() -> void:
	$Camera_Controller.position = position
	$Camera_Controller.rotation = rotation
	
	var UIController = get_tree().get_first_node_in_group("UIController")
	UIController.toggle_drone_mode.connect(toggle_drone_mode)
	
	DronePathFollow = get_tree().get_first_node_in_group("DronePath")
	Paths = get_tree().get_first_node_in_group("Paths")
	PresetPathUIControls = get_tree().get_first_node_in_group("PresetPathControls")
	
	toggle_drone_mode(PRESET_PATHS_MODE)

func toggle_drone_mode(mode: bool) -> void:
	PRESET_PATHS_MODE = mode
	
	if PRESET_PATHS_MODE:
		#Parent the Drone to the drone path and move the drone to that position
		self.position = DronePathFollow.position
		self.rotation = DronePathFollow.rotation
		self.reparent(DronePathFollow, true)
	else:
		#Remove the parent of the drone back to the root
		self.reparent(get_tree().current_scene)
	
	#Toggle the paths
	Paths.visible = mode
	PresetPathUIControls.visible = mode
	$Camera_Controller.top_level = !mode

'''
DRONE CONTROL METHOD:
	Left Axis Up & Down: Drone Goes Up & Down the world, VERTICALLY
	Left Axis Left & Right: Drone ROTATES, TURNING to the left or the right.
	Right Axis Up & Down: Forward, Backward
	Right Axis Left & Right: Left, Right
'''
func _physics_process(_delta: float) -> void:
	
	#Handle Left Stick Movement
	var input_left_stick := Input.get_vector("drone_turn_right", "drone_turn_left", "drone_fly_down", "drone_fly_up")
	
	# Drone Turning
	var turn_direction := input_left_stick.x
	print(turn_direction)
	if turn_direction:
		rotate_y(turn_direction * TURN_SPEED)

	if not PRESET_PATHS_MODE:
		get_elevation_input(input_left_stick.y)
		get_movement_input()
		move_and_slide()
		#Move Camera Controller according to Drone Position AND Rotation
		$Camera_Controller.position = lerp($Camera_Controller.position, position, 0.8)
		$Camera_Controller.rotation = rotation

func get_elevation_input(elevation: float) -> void:
	if elevation:
		velocity.y = elevation * ELEVATION_SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, ELEVATION_SPEED)

func get_movement_input() -> void:
	# Handle Right Stick Movement
	var input_right_stick := Input.get_vector("drone_left", "drone_right", "drone_forward", "drone_backward")
	var direction := (transform.basis * Vector3(input_right_stick.x, 0, input_right_stick.y)).normalized()
	if direction:
		velocity.x = direction.x * MOVEMENT_SPEED
		velocity.z = direction.z * MOVEMENT_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVEMENT_SPEED)
		velocity.z = move_toward(velocity.z, 0, MOVEMENT_SPEED)
