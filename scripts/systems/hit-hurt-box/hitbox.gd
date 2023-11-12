class_name Hitbox
extends Area2D

signal hit(hurtbox: Area2D)

var _damage: int = 0
var destroy_on_hit: bool = false
var hitted_hurtboxes: Array[Area2D] = []

func setup_hitbox(damage):
	_damage = damage

func _on_area_entered(area: Area2D):
	if !area.is_in_group("hurtbox"): return
	if hitted_hurtboxes.has(area): return
	
	hitted_hurtboxes.append(area)
	area.call_hurtbox_hit(self)
	hit.emit(area)
