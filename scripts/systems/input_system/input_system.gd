class_name InputSystem
extends Node

signal left_mouse_button_pressed()
signal left_mouse_button_released()
signal right_mouse_button_pressed()
signal ui_escape()

func _input(event):
	if event.is_action_pressed("mouse_click_left"):
		left_mouse_button_pressed.emit()
	if event.is_action_released("mouse_click_left"):
		left_mouse_button_released.emit()
	if event.is_action_pressed("mouse_click_right"):
		right_mouse_button_pressed.emit()
	if event.is_action_released("ui_escape"):
		ui_escape.emit()
