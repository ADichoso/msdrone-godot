extends PathFollow3D

signal assign_target(waypoint)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#Called when the Area3D is clicked
func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	#When this object is clicked, move the Drone's Path Follow to the location of the waypoint
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("assign_target", self)
		print("Clicked a Waypoint!")
