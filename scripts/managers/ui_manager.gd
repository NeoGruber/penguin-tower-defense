extends Control

@export var default_name = "username"

@onready var save_system = get_node("/root/Main/SaveSystem")
@onready var scene_system = get_node("/root/Main/SceneSystem")

@onready var player_name_line_edit = $MarginContainer/MenuVBox/MenuRowVBox/UsernameHBox/LineEdit

@onready var confirm_dialog = preload("res://scenes/ui_scenes/confirm_dialog.tscn")

var viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var viewport_height = ProjectSettings.get_setting("display/window/size/viewport_height")

var player_name = default_name

func _ready():
	player_name_line_edit.text = player_name

func _on_button_button_down():
	var instance = confirm_dialog.instantiate()
	instance.position = Vector2(0, 0)
	instance.confirm_dialog_text = "Do you want to save the name?"
	instance.confirm.connect(handle_confirm)
	instance.cancel.connect(handle_cancel)
	add_child(instance)

func handle_confirm():
	player_name = player_name_line_edit.text
	save_system.save_player_info()

func handle_cancel():
	player_name_line_edit.text = player_name

func save():
	return {
		"player_name": player_name
	};
	
func load_data(data):
	player_name = data["player_name"]

func _on_play_button_pressed():
	scene_system.switch_scene("game_scene")

func _on_settings_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	get_tree().free()






