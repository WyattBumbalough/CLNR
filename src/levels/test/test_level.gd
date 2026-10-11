extends LevelBase


func _on_exit_door_interacted() -> void:
	if MissionLog.selected_mission != null:
		var mission = MissionLog.selected_mission
		Refs.main.load_level(mission.level_uid)
	else:
		printerr("Cannot leave when no mission has been selected.")


func _on_dar_timeout() -> void:
	%ceiling.play("raise the roof")
	%Fan.visible = false
	%up.play()
