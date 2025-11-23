extends Node3D

var is_client = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UI_Controller/StartPanel.connect("set_gamemode", set_is_client)

func set_is_client(mode: bool) -> void:
	is_client = mode
	$Path3D/DroneFollow3D.initialize_waypoints(mode)
	$UI_Controller.is_drone = mode

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
