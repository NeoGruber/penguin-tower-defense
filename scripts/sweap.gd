class_name Sweap
extends Node2D

@onready var hitbox = $Hitbox

var _sweap_angle: float = 60
var _attack_speed: float = 1
var _hitbox_damage: int = 0
var _t = 0
var _target_position: Vector2
var _start_transform: Transform2D
var _target_transform: Transform2D

func _ready():
	rotation = self.position.angle_to_point(_target_position)
	hitbox.setup_hitbox(_hitbox_damage)
	hitbox.hit.connect(handle_hit)
	start_sweap()

func _physics_process(delta):
	_t += delta * _attack_speed
	transform = transform.interpolate_with(_target_transform, _t)
	if _t >= 0.3:
		print("done")
		queue_free()

func handle_hit(hurtbox: Area2D):
	pass

func start_sweap():
	var direction = get_sweep_direction()
	var start_angle = deg_to_rad(direction * _sweap_angle) + rotation
	var target_angle = deg_to_rad(-direction * _sweap_angle) + rotation
	_start_transform = Transform2D(start_angle, position)
	_target_transform = Transform2D(target_angle, position)
	transform = _start_transform

func get_sweep_direction():
	randomize()
	var direction = 0
	var random_number = randi() % 2
	if random_number == 0:
		direction = -1
	else:
		direction = 1
	return direction

func setup_sweap(target_position: Vector2, sweap_angle: int, attack_speed: float, hitbox_damage: int):
	_target_position = target_position
	_sweap_angle = sweap_angle
	_attack_speed = attack_speed
	_hitbox_damage = hitbox_damage
