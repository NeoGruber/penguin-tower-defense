extends Node

@onready var enemy_walk_path = get_node("/root/Main/GameScene/Game/EnemyWalkPath")

var spawn_point: Vector2

func _ready():
	spawn_point = enemy_walk_path.markers[0].position

func spawn_enemy(enemy: Resource):
	var new_enemy = enemy.instantiate()
	new_enemy.position = spawn_point
	add_child(new_enemy)
