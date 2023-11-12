extends Node

@export var use_test_scene: bool = false

var _menu_scene = preload("res://scenes/game_scenes/menu_scene.tscn")
var _game_scene = preload("res://scenes/game_scenes/game_scene.tscn")
var _test_scene = preload("res://scenes/game_scenes/test_scene.tscn")

var current_scene = null;

var active_scenes = []

func _ready():
	if use_test_scene: 
		switch_scene("test_scene")
		return
	
	switch_scene("menu_scene");

func switch_scene(scene_name):
	var main = get_tree().root.get_node("Main")
	
	if active_scenes.find(scene_name) != -1:
		return;
	
	if current_scene != null:
		main.remove_child(current_scene)
	
	if scene_name == "menu_scene":
		var menu_scene = _menu_scene.instantiate()
		main.add_child.call_deferred(menu_scene)
		current_scene = menu_scene
	
	if scene_name == "game_scene":
		var game_scene = _game_scene.instantiate()
		main.add_child.call_deferred(game_scene)
		current_scene = game_scene;
		
	if scene_name == "test_scene":
		var test_scene = _test_scene.instantiate()
		main.add_child.call_deferred(test_scene)
		current_scene = test_scene
