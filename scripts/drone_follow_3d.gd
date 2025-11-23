extends PathFollow3D

@export var TRAVEL_SPEED: float = 0.5
@export var is_drone: bool = false
@export var curr_target_progress: float = -1.0

# Called when the node enters the scene tree for the first time.
func initialize_waypoints(IS_DRONE: bool) -> void:
	is_drone = IS_DRONE
	
	if !is_drone: return
	
	var waypoints = get_tree().get_nodes_in_group("Waypoints")
	for w in waypoints:
		w.assign_target.connect(_on_assign_target)

func _on_assign_target(target_progress: float) -> void:
	print("Current Target:", curr_target_progress)
	print("Is Drone?", is_drone)
	
	curr_target_progress = target_progress
	print("Assigned Target:", curr_target_progress)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if !is_drone: return
	#Move the drone towards the target. Clear the target once it is there.
	if curr_target_progress != -1.0:
		#print("From", progress, "to", curr_target_progress)
		if progress == curr_target_progress:
			print("Done Moving!")
			curr_target_progress = -1.0
		else:
			progress = lerp(progress, curr_target_progress, delta * TRAVEL_SPEED)
