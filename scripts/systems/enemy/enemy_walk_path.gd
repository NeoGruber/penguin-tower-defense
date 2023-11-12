extends Node2D

@onready var path_2d: Path2D = $Path2D

@export var markers: Array[Marker2D] = []

var marker_amount = 0

func _ready():
	marker_amount = markers.size()
