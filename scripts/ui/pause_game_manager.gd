class_name PauseGameManager
extends Panel

signal continue_game()

@onready var scene_system = get_node("/root/Main/SceneSystem")
@onready var save_system = get_node("/root/Main/SaveSystem")

func _on_continue_button_pressed():
	continue_game.emit()
	self.visible = false

func _on_options_button_pressed():
	pass

func _on_save_menu_button_pressed():
	get_tree().paused = false
	scene_system.switch_scene("menu_scene")
	
func _on_save_exit_button_pressed():
	get_tree().quit()
