@tool
class_name Spawner
extends Node3D

func _ready() -> void:
	add_to_group("spawners")
	$MeshInstance3D.hide()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		$MeshInstance3D.visible = true
