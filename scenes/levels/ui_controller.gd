extends Control

@export var is_drone: bool = false

signal toggle_drone_mode(mode)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Main_Menu.visible = false
	$PresetPathsControls.visible = false
	$StartPanel.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_main_menu_button_pressed() -> void:
	if not $Main_Menu.visible:
		$Main_Menu.visible = true
		if is_drone:
			$Main_Menu/Panel/HFlowContainer/PresetPathsCheckButton.visible = false
			$Main_Menu/Panel/HFlowContainer/ResetButton.visible = false

func _on_close_main_menu_button_pressed() -> void:
	if $Main_Menu.visible:
		$Main_Menu.visible = false

func _on_preset_paths_check_button_toggled(toggled_on: bool) -> void:
	$PresetPathsControls.visible = toggled_on && is_drone
	print("Is Drone?", is_drone, "Show paths?", toggled_on && is_drone)
	emit_signal("toggle_drone_mode", toggled_on)

func _on_reset_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
