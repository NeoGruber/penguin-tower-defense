extends Control

signal round_start_button_pressed()
signal autostart_toggle_pressed(checked)

@onready var input_systen: InputSystem = get_node("/root/Main/InputSystem")
@onready var mouney_amount_label = $Panel/MarginContainer/VBoxContainer/Money/MoneyAmount
@onready var lives_amount_label = $Panel/MarginContainer/VBoxContainer/Lives/LivesAmount
@onready var game_end_panel = $GameEnd
@onready var game_paused_panel: PauseGameManager = $PauseGame

var autostart_checked: bool = false
var game_paused: bool = false

var _lives = 0

func _ready():
	input_systen.ui_escape.connect(handle_pause_game)
	game_paused_panel.continue_game.connect(handle_continue_game)
	game_end_panel.visible = false
	mouney_amount_label.text = "0"
	lives_amount_label.text = str(_lives)

func setup_lives(lives):
	_lives = lives

func handle_pause_game():
	game_paused = !game_paused
	game_paused_panel.visible = game_paused
	get_tree().paused = game_paused

func handle_continue_game():
	game_paused = false
	game_paused_panel.visible = false
	get_tree().paused = false

func _on_round_start_button_pressed():
	print("hello world")
	round_start_button_pressed.emit()

func _on_autostart_toggle_pressed():
	autostart_checked = !autostart_checked
	autostart_toggle_pressed.emit(autostart_checked)

func _on_resource_system_money_amount_changed(money):
	mouney_amount_label.text = str(money)

func _on_game_live_changed(lives):
	_lives = lives
	lives_amount_label.text = str(_lives)

func _on_game_game_end():
	game_end_panel.visible = true
