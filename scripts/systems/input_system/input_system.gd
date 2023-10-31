extends Node

signal left_mouse_button_click()
signal right_mouse_button_click()

func _input(event):
	if event.is_action_pressed("mouse_click_left"):
		left_mouse_button_click.emit()
	if event.is_action_pressed("mouse_click_right"):
		right_mouse_button_click.emit()
