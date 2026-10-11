@icon("res://addons/at-icons/node/book.svg")
class_name MissionLog
extends Node
## Mission Log Manager

signal mission_selected

@export var available_missions : Array[MissionData]
@export var completed_missions : Array[MissionData]
@export var selected_mission   : MissionData


func select_mission(_mission: MissionData) -> void:
	if selected_mission != _mission:
		selected_mission = _mission
		mission_selected.emit()
		print("Selected mission: %s" % _mission.mission_title)
