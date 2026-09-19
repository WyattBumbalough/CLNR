class_name InteractionArea
extends Area3D

signal looked_at
signal looked_away
signal interacted

func _ready() -> void:
	collision_layer = 2
