class_name Projectile
extends CharacterBody2D

@onready var hitbox = $Hitbox
@onready var timer = $Timer

var _speed = 2000;
var _target_position: Vector2 = Vector2.ZERO
var _hitbox_damage = 0
var _live_time = 10

func _ready():
	velocity = position.direction_to(_target_position) * _speed
	rotation = self.position.angle_to_point(_target_position)
	hitbox.setup_hitbox(_hitbox_damage) 
	hitbox.hit.connect(handle_hit)
	timer.wait_time = _live_time
	timer.start()
	timer.timeout.connect(destroy_self)

func _process(delta):
	move_and_slide()

func setup_projectile(speed, hitbox_damage, target_position):
	_speed = speed
	_hitbox_damage = hitbox_damage
	_target_position = target_position

func handle_hit(hurtbox: Area2D):
	destroy_self()

func destroy_self():
	queue_free()
