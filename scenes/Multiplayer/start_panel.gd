extends Control

signal set_gamemode(is_client)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_server_button_pressed() -> void:
	NetworkHandler.start_server()
	emit_signal("set_gamemode", false)
	visible = false

func _on_client_button_pressed() -> void:
	NetworkHandler.start_client()
	emit_signal("set_gamemode", true)
	visible = false

func _on_exit_button_pressed() -> void:
	get_tree().quit()
