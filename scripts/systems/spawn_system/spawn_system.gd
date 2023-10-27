extends Node

@export var debug: bool = false
@export var autostart_rounds: bool = false
@export var spawn_rounds: Array[SpawnRound] = []

@onready var spawn_timer = $SpawnTimer
@onready var wave_break_timer = $WaveBreakTimer
@onready var game_ui_manager = get_node("../../GameUI")
@onready var enemy_spawner = $EnemySpawner

var max_round: int = 0
var current_round: int = 0
var last_wave: int = 0
var current_wave: int = 0
var current_wave_spawned_amount: int = 0
var current_wave_total_spawn_amount: int = 0
var current_spawn_wave: SpawnWave = null

func _ready():
	game_ui_manager.round_start_button_pressed.connect(handle_round_start_button_pressed)
	game_ui_manager.autostart_toggle_pressed.connect(handle_autostart_toggle_pressed)
	
	wave_break_timer.timeout.connect(handle_new_wave)
	spawn_timer.timeout.connect(handle_enemy_spawn)
	max_round = spawn_rounds.size()

func handle_round_start_button_pressed():
	handle_new_round()

func handle_autostart_toggle_pressed(is_checked):
	autostart_rounds = is_checked

func handle_new_round():
	if current_round == max_round: 
		print_debug_foo("all rounds finished!")
		return
	
	last_wave = spawn_rounds[current_round].waves.size()
	current_wave = 0
	handle_new_wave();

func handle_new_wave():
	if current_wave == last_wave:
		current_round += 1
		print("all waves are done new round startable")
		if autostart_rounds:
			handle_new_round()
		return
	
	#print("start new wave ", current_wave)
	current_spawn_wave = spawn_rounds[current_round].waves[current_wave]
	handle_spawn_wave()

func handle_spawn_wave():
	print_debug_foo("mobs are spawned")
	var spawn_time = current_spawn_wave.spawn_duration / current_spawn_wave.spawn_amount
	current_wave_total_spawn_amount = current_spawn_wave.spawn_amount
	spawn_timer.wait_time = spawn_time
	spawn_timer.autostart = true
	
	spawn_timer.start()

func handle_enemy_spawn():
	print_debug_foo(current_wave)
	var enemy = spawn_rounds[current_round].waves[current_wave].enemy
	enemy_spawner.spawn_enemy(enemy)
	
	if current_wave_spawned_amount >= current_wave_total_spawn_amount:
		current_wave_spawned_amount = 0
		spawn_timer.stop()
		handle_wave_end()
	
	current_wave_spawned_amount += 1

func handle_wave_end():
	print_debug_foo("break started")
	wave_break_timer.wait_time = current_spawn_wave.break_time
	wave_break_timer.one_shot = true
	current_wave += 1
	wave_break_timer.start()

func print_debug_foo(debug_message):
	if debug == false: return;
	print(debug_message)
