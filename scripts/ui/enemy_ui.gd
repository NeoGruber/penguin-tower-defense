extends Control

var parent_node: Node2D
var position_offset = Vector2(-50, -60)

func _ready():
	parent_node = get_parent()

func _physics_process(delta):
	position = Vector2.ZERO
	rotation_degrees = -parent_node.rotation_degrees

