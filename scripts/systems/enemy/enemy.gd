extends CharacterBody2D

class_name Enemy

@export var move_speed = 3

@onready var enemy_walk_path = get_node("/root/Main/GameScene/Game/EnemyWalkPath")

signal path_index_changed(node, index)

var path_index = 0

func _physics_process(delta):
	if path_index < enemy_walk_path.marker_amount - 1:
		handle_path_finding()
		handle_rotation()
	else:
		handle_enemy_destruction()

func handle_path_finding():
	if path_index < enemy_walk_path.marker_amount:
		self.global_position = self.global_position.move_toward(enemy_walk_path.markers[path_index].position, move_speed)
		
		if self.global_position.distance_to(enemy_walk_path.markers[path_index].position) < 1:
			path_index += 1
			path_index_changed.emit(self, path_index)
			

func handle_rotation():
	look_at(enemy_walk_path.markers[path_index].position)

func handle_enemy_destruction():
	queue_free()
