extends LevelBase


#func _on_exit_door_interacted() -> void:
	#if MissionLog.selected_mission != null:
		#Game.current.load_level(MissionLog.selected_mission.level_uid)
	#else:
		#printerr("Cannot leave when no mission has been selected.")
