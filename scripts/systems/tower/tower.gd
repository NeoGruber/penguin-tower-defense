class_name Tower
extends CharacterBody2D

@onready var input_system: InputSystem = get_node("/root/Main/InputSystem")
@onready var enemy_detection_area = $EnemyDetectionArea
@onready var enemy_detection_shape_circle = $EnemyDetectionArea/EnemyDetectionShapeCircle
@onready var tower_range = $TowerRange
@onready var tower_attack_time_handler = $TowerAttackTimeHandler
@onready var tower_attack_handler = $TowerAttackHandler 
@onready var enemy_handler = $EnemyHandler

@export_category("tower stats")
@export_enum("small:100","medium:150", "large:200", "very large:300", "full screen: 2000") var tower_radius: int = 200
@export var tower_weapon: TowerEnums.TowerWeapon = TowerEnums.TowerWeapon.Bow
@export var attack_speed: float = 1.0

var show_tower_range: bool = false
var is_hovered: bool = false
var enemies_inside_range: Array[Node2D] = []
var target_enemy: Node2D

signal show_tower_information(tower)

func _ready():
	tower_attack_time_handler.set_stats(attack_speed)
	tower_attack_time_handler.attack.connect(handle_attack)
	
	enemy_handler.enemy_entered_tower_range.connect(handle_enemy_entered_tower_range)
	enemy_handler.no_enemies_in_tower_range.connect(handle_no_enemies_in_tower_range)
	
	input_system.left_mouse_button_pressed.connect(handle_left_mouse_button_pressed)
	setup_tower_range()

func _process(_delta):
	handle_lookat_enemy()

func setup_tower_range():
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = tower_radius
	enemy_detection_shape_circle.shape = circle_shape
	tower_range.scale.x = float(tower_radius) / 100
	tower_range.scale.y = float(tower_radius) / 100

func handle_left_mouse_button_pressed():
	if !is_hovered: return
	show_tower_information.emit(self)

func handle_lookat_enemy():
	target_enemy = enemy_handler.get_target_enemy()

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
	if target_enemy == null: return
	look_at(target_enemy.position)
	tower_attack_handler.attack(target_enemy.position)
	
func handle_enemy_entered_tower_range():
	tower_attack_time_handler.start_attacking()

func handle_no_enemies_in_tower_range():
	tower_attack_time_handler.stop_attacking()
