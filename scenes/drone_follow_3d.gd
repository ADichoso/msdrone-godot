extends PathFollow3D

@export var TRAVEL_SPEED: float = 0.5

var curr_target: PathFollow3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var waypoints = get_tree().get_nodes_in_group("Waypoints")
	for w in waypoints:
		w.assign_target.connect(_on_assign_target)

func _on_assign_target(target: PathFollow3D) -> void:
	print("Assigned Target:", target)
	curr_target = target

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Move the drone towards the target. Clear the target once it is there.
	if curr_target:
		print("Moving...", progress)
		if progress == curr_target.progress:
			print("Done Moving!")
			curr_target = null
		else:
			progress = lerp(progress, curr_target.progress, delta * TRAVEL_SPEED)
