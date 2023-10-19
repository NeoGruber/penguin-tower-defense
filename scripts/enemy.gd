extends CharacterBody2D

@export var move_speed = 3

@onready var enemy_walk_path = get_node("/root/Main/GameScene/Node2D/EnemyWalkPath")

var path_index = 0

func _physics_process(delta):
	if path_index < enemy_walk_path.marker_amount:
		self.global_position = self.global_position.move_toward(enemy_walk_path.markers[path_index].position, move_speed)
		
		if self.global_position.distance_to(enemy_walk_path.markers[path_index].position) < 1:
			path_index += 1
