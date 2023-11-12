extends Panel

@onready var scene_system = get_node("/root/Main/SceneSystem")

func _on_restart_button_pressed():
	get_tree().paused = false
	scene_system.switch_scene("game_scene")

func _on_menu_button_pressed():
	get_tree().paused = false
	scene_system.switch_scene("menu_scene")
