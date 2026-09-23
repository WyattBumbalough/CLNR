class_name LevelBase
extends Node3D

@export var default_spawner : Spawner

var PLAYER : Player
var MAIN : Main


func setup_level(_player: Player, random_spawn: bool = true):
	var _spawner: Spawner
	if random_spawn:
		var _spawns = get_tree().get_nodes_in_group("spawners")
		_spawner = _spawns[randi_range(0, _spawns.size() - 1)]
	else:
		_spawner = default_spawner
	
	if is_instance_valid(_player):
		PLAYER = _player
		PLAYER.global_position = _spawner.global_position
		PLAYER.rotation.y = _spawner.rotation.y
		PLAYER.align_camera()
	else:
		push_error("Cannot spawn player because the reference is invalid. You done messed up.")
