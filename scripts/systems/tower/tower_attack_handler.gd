extends Node

@onready var attack_timer = $AttackTimer
@onready var rotation_timer = $RotationTimer
@onready var rotation_start_timer = $RotationStartTimer

signal attack(attack_time)
signal rotate(rotation_time)

var base_attack_time: float = 1
var tower_attack_speed: float = 1
var attack_time: float = 1

func _ready():
	attack_timer.timeout.connect(handle_attack_timer)
	rotation_timer.timeout.connect(handle_rotation_timer)
	rotation_start_timer.timeout.connect(start_rotation_timer)

func set_stats(attack_speed: float):
	tower_attack_speed = attack_speed
	

func configure_timers():
	attack_time = base_attack_time / tower_attack_speed
	attack_timer.wait_time = attack_time
	rotation_start_timer.wait_time = attack_time / 2
	rotation_timer.wait_time = attack_time / 2
	rotation_timer.one_shot = true

func start_attacking():
	attack_timer.start()
	rotation_start_timer.start()

func handle_attack_timer():
	rotation_timer.start()
	attack.emit(attack_time / 2)

func handle_rotation_timer():
	rotate.emit(attack_time / 2)

func start_rotation_timer():
	rotation_start_timer.start()
