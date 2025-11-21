extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_turn_right_button_button_down() -> void:
	print("Pressing Right!")
	Input.action_press("drone_turn_right", 1)


func _on_turn_left_button_button_down() -> void:
	print("Pressing Left!")
	Input.action_press("drone_turn_left", 1)


func _on_turn_right_button_button_up() -> void:
	Input.action_release("drone_turn_right")


func _on_turn_left_button_button_up() -> void:
	Input.action_release("drone_turn_left")
