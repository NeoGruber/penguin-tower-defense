extends Sprite2D

@onready var input_system: InputSystem = get_node("/root/Main/InputSystem")
@onready var build_button = $Control/HBoxContainer/BuildButton
@onready var cancel_button = $Control/HBoxContainer/CancelButton
@onready var controll = $Control

var tower_to_build: Resource

var mouse_hovered: bool = false
var mouse_dragging: bool = false
var building_blocked: bool = false

var position_lerp_weight = 0.0

func _ready():
	build_button.pressed.connect(handle_build_button_pressed)
	cancel_button.pressed.connect(handle_cancel_button_pressed)
	input_system.left_mouse_button_pressed.connect(handle_left_mouse_button_pressed)
	input_system.left_mouse_button_released.connect(handle_left_mouse_button_released)

func _process(delta):
	handle_mouse_drag(delta)
	handle_building_blocked()

func handle_mouse_drag(delta):
	if !mouse_dragging:
		return
	
	var mouse_position = get_viewport().get_mouse_position()
	var distance = global_position.distance_to(mouse_position)
	
	if distance > 1 && position_lerp_weight < 1:
		position_lerp_weight += delta * 3
		global_position = global_position.lerp(mouse_position, position_lerp_weight)
	else:
		position_lerp_weight = 0

func handle_building_blocked():
	if building_blocked: 
		build_button.disabled = true
		self.self_modulate = Color(255, 0, 0, 255)
	else:
		self.self_modulate = Color(255, 255, 255, 255)
		build_button.disabled = false

func handle_left_mouse_button_pressed():
	if mouse_hovered:
		mouse_dragging = true
	
func handle_left_mouse_button_released():
	mouse_dragging = false

func _on_area_2d_mouse_entered():
	mouse_hovered = true

func _on_area_2d_mouse_exited():
	mouse_hovered = false

func _on_area_2d_area_entered(area):
	if !area.is_in_group("blocked_build_area"): return
	building_blocked = true

func _on_area_2d_area_exited(area):
	if !area.is_in_group("blocked_build_area"): return
	building_blocked = false

func handle_build_button_pressed():
	print("build")
	pass

func handle_cancel_button_pressed():
	queue_free()

