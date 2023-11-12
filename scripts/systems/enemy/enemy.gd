class_name Enemy
extends PathFollow2D

signal path_index_changed(node, index)
signal hp_changed(hp)
signal enemy_died(enemy_drops)
signal enemy_passed_end(enemy: Enemy)

@onready var hurtbox: Hurtbox = $hurtbox
@onready var lifebar = $EnemyUI/EnemyLifeBar

@export var _move_speed = 1
@export var _hp = 1
@export var _max_hp = 1
@export var enemy_drops: EnemyDrops

var current_progress_ratio = 0
var next_progress_ratio = 0
var progress_ration_jump_amount = 2

func _ready():
	lifebar.setup_lifebar(0, _max_hp)
	hp_changed.emit(_hp)
	hurtbox.got_hurt.connect(handle_got_hurt)
	

func _physics_process(_delta):
	if progress_ratio < 100:
		progress += _move_speed
		handle_progress()
	else:
		enemy_passed_end.emit(self)
		handle_enemy_destruction()

func handle_progress():
	if current_progress_ratio == 100: return
	if progress_ratio >= next_progress_ratio:
		current_progress_ratio = next_progress_ratio
		next_progress_ratio += progress_ration_jump_amount
		path_index_changed.emit(self, current_progress_ratio)

func handle_enemy_destruction():
	queue_free()

func handle_got_hurt(hitbox: Hitbox):
	_hp -= hitbox._damage
	hp_changed.emit(_hp)
	if _hp <= 0:
		handle_death()

func handle_death():
	enemy_died.emit(enemy_drops)
	handle_enemy_destruction()
