extends Node3D

@export var mouse_sensitivity: float = 0.2
@export var Target: Node3D
@export var use_mouse_movement: bool = false

var rotation_x := 0.0  # Vertical camera rotation
var rotation_y := 0.0  # Horizontal player rotation

func _ready() -> void:
	set_mouse_mode(false)

func set_mouse_mode(mode: bool) -> void:
	use_mouse_movement = mode
	top_level = mode
	
	if use_mouse_movement:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and use_mouse_movement:		
		rotation_y -= event.relative.x * mouse_sensitivity
		rotation_x -= event.relative.y * mouse_sensitivity

		rotation_x = clamp(rotation_x, -90.0, 90.0)

		Target.rotation_degrees.y = rotation_y
		Target.rotation_degrees.x = rotation_x

	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			set_mouse_mode(false)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("use_mouse") and !use_mouse_movement:
		set_mouse_mode(true)
