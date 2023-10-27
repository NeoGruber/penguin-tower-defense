extends Node2D

@export var markers: Array[Marker2D] = []

var marker_amount = 0

func _ready():
	marker_amount = markers.size()
