extends Control

@export var confirm_dialog_text = "placeholder text"

@onready var confirm_text = $Panel/MarginContainer/VBoxContainer/ConfirmText

signal confirm()

signal cancel()

func _ready():
	confirm_text.text = confirm_dialog_text


func _on_confirm_button_pressed():
	confirm.emit()
	self.queue_free()


func _on_cancel_button_pressed():
	cancel.emit()
	self.queue_free()
