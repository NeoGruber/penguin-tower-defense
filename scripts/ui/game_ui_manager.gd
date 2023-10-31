extends Control

signal round_start_button_pressed()

signal autostart_toggle_pressed(checked)

var autostart_checked = false

func _on_round_start_button_pressed():
	print("hello world")
	round_start_button_pressed.emit()

func _on_autostart_toggle_pressed():
	autostart_checked = !autostart_checked
	autostart_toggle_pressed.emit(autostart_checked)
