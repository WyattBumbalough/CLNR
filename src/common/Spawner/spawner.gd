@tool
class_name Spawner
extends Node3D

@export var scene_to_spawn : PackedScene


func _ready() -> void:
	add_to_group("spawners")
	$MeshInstance3D.hide()
	#spawn()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		$MeshInstance3D.visible = true


#func spawn() -> void:
	#if scene_to_spawn == null:
		##printerr("No scene assigned to spawner.")
		#return
	#var i = scene_to_spawn.instantiate()
	#Refs.main.enitities_root.add_child(i)
	#i.global_position = global_position
