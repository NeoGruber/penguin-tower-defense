class_name MyGameManager
extends Node2D

signal live_changed(lives)
signal game_end()

@onready var _spawn_system = $SpawnSystem

@onready var game_ui = $"../GameUI"

var _lives = 1

func _ready():
	_spawn_system.enemy_spawned.connect(handle_enemy_spawned)
	game_ui.setup_lives(_lives)

func handle_enemy_spawned(enemy):
	enemy.enemy_passed_end.connect(handle_enemy_passed_end)

func handle_enemy_passed_end(enemy: Enemy):
	_lives -= enemy._hp
	if _lives <= 0:
		handle_game_end()
	live_changed.emit(_lives)

func handle_game_end():
	game_end.emit()
	get_tree().paused = true

	
