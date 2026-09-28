extends Node
## Mission Log Manager

signal mission_selected

var available_missions : Array[MissionData]
var completed_missions : Array[MissionData]
var selected_mission   : MissionData


func select_mission(_mission: MissionData) -> void:
	if selected_mission != _mission:
		selected_mission = _mission
		mission_selected.emit()
		print("Selected mission: %s" % _mission.mission_title)
