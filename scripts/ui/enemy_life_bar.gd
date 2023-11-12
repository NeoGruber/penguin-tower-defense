class_name EnemyLifeBar
extends ProgressBar

func _process(delta):
	rotation_degrees = 0

func setup_lifebar(min_val, max_val):
	min_value = min_val
	max_value = max_val

func _on_enemy_hp_changed(hp):
	value = hp
