class_name ResourceSystem
extends Node

signal money_amount_changed(money)

@onready var spawn_system = $"../SpawnSystem"

var money = 0

func _ready():
	spawn_system.enemy_spawned.connect(handle_spawned_enemy)

func handle_spawned_enemy(spawned_enemy):
	spawned_enemy.enemy_died.connect(handle_enemy_death)
	
func handle_enemy_death(enemy_drops: EnemyDrops):
	money += enemy_drops.money
	money_amount_changed.emit(money)
