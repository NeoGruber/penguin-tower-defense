extends Panel

@onready var tower_name_label = $MarginContainer/ContentBox/TowerName/TowerNameLabel
@onready var tower_mode_label = $MarginContainer/ContentBox/TowerMode/TowerModeLabel
@onready var toggle_tower_range_button = $MarginContainer/ContentBox/ToggleTowerRangeButton
var current_tower = null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	var towers = get_tree().get_nodes_in_group("tower")
	for tower in towers:
		tower.show_tower_information.connect(handle_show_tower_information)

func handle_show_tower_information(tower: Node2D):
	current_tower = tower
	set_tower_mode_label()
	set_toggle_tower_range_button_text()
	self.visible = true

func set_tower_mode_label():
	var tower_mode = TowerMode.TowerMode.keys()[current_tower.tower_mode]
	tower_mode_label.text = str(tower_mode)

func set_toggle_tower_range_button_text():
	var button_text = ""
	if current_tower.show_tower_range: 
		button_text = "hide"
	else:
		button_text = "show"
		
	toggle_tower_range_button.text = button_text

func add_tower_to_observe(tower):
	tower.show_tower_information.connect(handle_show_tower_information)

func _on_tower_mode_left_button_pressed():
	current_tower.dec_tower_mode_sequence()
	set_tower_mode_label()

func _on_tower_mode_right_button_pressed():
	current_tower.inc_tower_mode_sequence()
	set_tower_mode_label()

func _on_close_info_button_pressed():
	current_tower = null
	self.hide()

func _on_toggle_tower_range_button_pressed():
	current_tower.toggle_show_tower_range()
	set_toggle_tower_range_button_text()
