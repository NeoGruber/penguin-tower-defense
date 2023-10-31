extends Node

var menu_scene = preload("res://scenes/game_scenes/menu_scene.tscn").instantiate()
var game_scene = preload("res://scenes/game_scenes/game_scene.tscn").instantiate()

var current_scene = null;

var active_scenes = []

func _ready():
	switch_scene("menu_scene");

func switch_scene(scene_name):
	var main = get_tree().root.get_node("Main")
	
	if active_scenes.find(scene_name) != -1:
		return;
	
	if current_scene != null:
		main.remove_child(current_scene)
	
	if scene_name == "menu_scene":
		print("foooo")
		main.add_child.call_deferred(menu_scene)
		current_scene = menu_scene
	
	if scene_name == "game_scene":
		main.add_child.call_deferred(game_scene)
		current_scene = game_scene;
