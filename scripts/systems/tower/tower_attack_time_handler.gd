extends Node

@onready var attack_timer = $AttackTimer

signal attack(attack_time)

var base_attack_time: float = 1
var tower_attack_speed: float = 1
var attack_time: float = 1

func _ready():
	attack_timer.timeout.connect(handle_attack_timer)
	configure_timer()

func set_stats(attack_speed: float):
	tower_attack_speed = attack_speed
	configure_timer()

func configure_timer():
	attack_time = base_attack_time / tower_attack_speed
	attack_timer.wait_time = attack_time

func start_attacking():
	attack_timer.start()

func stop_attacking():
	attack_timer.stop()

func handle_attack_timer():
	attack.emit(attack_time)
