class_name EnemySpawner
extends Node

var spawn_point: Vector2
var path: Path2D

func _ready():
	path = get_tree().get_first_node_in_group("Path2D")
	spawn_point = path.curve.get_baked_points()[0]

func spawn_enemy(enemy: Resource):
	var new_enemy = enemy.instantiate()
	new_enemy.position = spawn_point
	path.add_child(new_enemy)
	return new_enemy
