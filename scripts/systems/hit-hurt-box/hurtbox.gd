class_name Hurtbox
extends Area2D

signal got_hurt(hitbox: Hitbox)

func call_hurtbox_hit(hitbox: Hitbox):
	got_hurt.emit(hitbox)
