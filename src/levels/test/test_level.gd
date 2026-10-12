extends LevelBase


func _on_exit_door_interacted() -> void:
	if Game.current.mission_log.selected_mission != null:
		Game.current.load_level_request(Game.current.mission_log.selected_mission.level_uid)
	else:
		printerr("Cannot leave when no mission has been selected.")
