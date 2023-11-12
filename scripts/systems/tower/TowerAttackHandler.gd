extends Node

var _projectile = preload("res://scenes/entity_scenes/tower_scenes/projectile.tscn")
var _sweap = preload("res://scenes/entity_scenes/tower_scenes/sweap.tscn")

@onready var tower: Tower = get_parent()
@onready var spawned_projectiles = get_tree().get_first_node_in_group("SpawnedProjectiles")

var speed = 2000;
var damage = 1;

func attack(target_position):
	if tower.tower_weapon == TowerEnums.TowerWeapon.Bow:
		handle_projectile_attack(target_position)
	if tower.tower_weapon == TowerEnums.TowerWeapon.Sword:
		handle_sweap_attack(target_position)

func handle_projectile_attack(target_position):
	var projectile = _projectile.instantiate()
	projectile.setup_projectile(speed, damage, target_position)
	projectile.position = tower.position
	spawned_projectiles.add_child(projectile)

func handle_sweap_attack(target_position):
	var sweap = _sweap.instantiate()
	sweap.setup_sweap(target_position, 40, tower.attack_speed, 1)
	sweap.position = tower.position
	spawned_projectiles.add_child(sweap)
