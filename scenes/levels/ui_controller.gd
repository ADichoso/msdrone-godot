extends Control

signal toggle_drone_mode(mode)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_main_menu_button_pressed() -> void:
	if not $Main_Menu.visible:
		$Main_Menu.visible = true

func _on_close_main_menu_button_pressed() -> void:
	if $Main_Menu.visible:
		$Main_Menu.visible = false

func _on_preset_paths_check_button_toggled(toggled_on: bool) -> void:
	emit_signal("toggle_drone_mode", toggled_on)

func _on_reset_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
