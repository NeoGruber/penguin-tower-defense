extends Node

var enemies_in_range = {}
var enemies_in_range_counter = 0

signal enemy_entered_tower_range()

signal no_enemies_in_tower_range()

func get_first_enemy(): # get the enemy who is closest to map end
	if enemies_in_range.is_empty():
		return null;
	
	var keys = enemies_in_range.keys()
	keys.reverse()
	
	for key in keys:
		if enemies_in_range[key] == []: continue
		var max_index = enemies_in_range[key].size()
		return enemies_in_range[key][max_index -1]
	return null

func get_last_enemy():  # get the enemy who is furthest to map end
	if enemies_in_range.is_empty():
		return null;
	for key in enemies_in_range:
		if enemies_in_range[key] == []: continue
		return enemies_in_range[key][0]
	return null

func get_closest_enemy():
	var tower = get_parent()
	var closest_enemy = null
	for key in enemies_in_range:
		if enemies_in_range[key] == []: continue
		for enemy in enemies_in_range[key]:
			if closest_enemy == null:
				closest_enemy = enemy
				continue
			
			if tower.position.distance_to(closest_enemy.position) > tower.position.distance_to(enemy.position):
				closest_enemy = enemy
	
	return closest_enemy

func get_furthest_enemy():
	var tower = get_parent()
	var furthest_enemy = null
	for key in enemies_in_range:
		if enemies_in_range[key] == []: continue
		for enemy in enemies_in_range[key]:
			if furthest_enemy == null:
				furthest_enemy = enemy
				continue
			
			if tower.position.distance_to(furthest_enemy.position) < tower.position.distance_to(enemy.position):
				furthest_enemy = enemy
	
	return furthest_enemy

func get_strongest_enemy():
	#todo: implement after enemies are stronger or weaker.
	return get_first_enemy()

func handle_enemy_path_index_changed(enemy: Node2D, index):
	get_first_enemy()
	var old_index = enemy.path_index -1
	enemies_in_range[old_index].erase(enemy)
	
	if !enemies_in_range.has(index):
		enemies_in_range[index] = []
	enemies_in_range[index].append(enemy)

func _on_enemy_detection_area_body_entered(enemy: Node2D):
	if enemy == get_parent(): return
	if !enemy.is_in_group("enemy"): return
	
	if enemies_in_range_counter == 0:
		enemy_entered_tower_range.emit()

	enemies_in_range_counter += 1
	
	if !enemies_in_range.has(enemy.path_index):
		enemies_in_range[enemy.path_index] = []
	
	enemies_in_range[enemy.path_index].append(enemy)
	enemy.path_index_changed.connect(handle_enemy_path_index_changed)

func _on_enemy_detection_area_body_exited(enemy: Node2D):
	if enemy == get_parent(): return
	if !enemy.is_in_group("enemy"): return
	
	enemies_in_range_counter -= 1
	
	if enemies_in_range_counter == 0:
		enemy_entered_tower_range.emit()

	enemy.path_index_changed.disconnect(handle_enemy_path_index_changed)
	enemies_in_range[enemy.path_index].erase(enemy)
