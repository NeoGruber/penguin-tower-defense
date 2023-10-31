extends CharacterBody2D

@onready var input_system = get_node("/root/Main/InputSystem")
@onready var enemy_detection_area = $EnemyDetectionArea
@onready var enemy_detection_shape_circle = $EnemyDetectionArea/EnemyDetectionShapeCircle
@onready var tower_range = $TowerRange
@onready var tower_attack_handler = $TowerAttackHandler
@onready var enemy_handler = $EnemyHandler

@export_category("tower stats")
@export_enum("small:100","medium:150", "large:200", "very large:300", "full screen: 2000") var tower_radius: int = 200
@export var attack_speed: float = 1.0

var show_tower_range: bool = false
var is_hovered: bool = false
var enemies_inside_range: Array[Node2D] = []
var tower_mode: TowerMode.TowerMode = TowerMode.TowerMode.first

var tower_mode_sequence = [
	TowerMode.TowerMode.first,
	TowerMode.TowerMode.last,
	TowerMode.TowerMode.nearest,
	TowerMode.TowerMode.furthest,
	TowerMode.TowerMode.strongest,
]

signal show_tower_information(tower)

func _ready():
	tower_attack_handler.attack.connect(handle_attack)
	tower_attack_handler.rotate.connect(handle_rotate)
	
	enemy_handler.enemy_entered_tower_range.connect(handle_enemy_entered_tower_range)
	enemy_handler.no_enemies_in_tower_range.connect(handle_no_enemies_in_tower_range)
	
	input_system.left_mouse_button_click.connect(handle_left_mouse_button_click)
	setup_tower_range()

func _process(_delta):
	look_at_enemy()

func setup_tower_range():
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = tower_radius
	enemy_detection_shape_circle.shape = circle_shape
	tower_range.scale.x = float(tower_radius) / 100
	tower_range.scale.y = float(tower_radius) / 100

func look_at_enemy():
	var look_enemy;
	if tower_mode == TowerMode.TowerMode.first:
		look_enemy = enemy_handler.get_first_enemy()
	if tower_mode == TowerMode.TowerMode.last:
		look_enemy = enemy_handler.get_last_enemy()
	if tower_mode == TowerMode.TowerMode.nearest:
		look_enemy = enemy_handler.get_closest_enemy()
	if tower_mode == TowerMode.TowerMode.furthest:
		look_enemy = enemy_handler.get_furthest_enemy()
	if tower_mode == TowerMode.TowerMode.strongest:
		look_enemy = enemy_handler.get_last_enemy()
	
	if look_enemy == null: return
	
	look_at(look_enemy.position)

func handle_left_mouse_button_click():
	if !is_hovered: return
	show_tower_information.emit(self)

func inc_tower_mode_sequence():
	var tower_mode_index = int(tower_mode)
	if tower_mode_index == 4:
		tower_mode_index = 0
	else:
		tower_mode_index += 1
	
	tower_mode = tower_mode_sequence[tower_mode_index]

func dec_tower_mode_sequence():
	var tower_mode_index = int(tower_mode)
	if tower_mode_index == 0:
		tower_mode_index = 4
	else:
		tower_mode_index -= 1
	
	tower_mode = tower_mode_sequence[tower_mode_index]

func toggle_show_tower_range():
	show_tower_range = !show_tower_range
	tower_range.visible = show_tower_range

func hide_tower_range():
	show_tower_range = false
	tower_range.visible = false

func _on_mouse_entered():
	is_hovered = true

func _on_mouse_exited():
	is_hovered = false

func handle_attack(attack_time: float):
	print("attack: ", attack_time)

func handle_rotate(rotate_time: float):
	print("rotate: ", rotate_time)
	
func handle_enemy_entered_tower_range():
	tower_attack_handler.start_attacking()

func handle_no_enemies_in_tower_range():
	tower_attack_handler.stop_attacking()















