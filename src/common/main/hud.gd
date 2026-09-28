class_name HUD
extends Control

@onready var stat_screen: StatScreen = $StatScreen
@onready var selected_mission: Control = $SelectedMission


func _ready() -> void:
	MissionLog.mission_selected.connect(show_selected_mission)


func show_selected_mission() -> void:
	var tween: Tween = self.create_tween()
	selected_mission.show()
	tween.tween_property(selected_mission,"scale", Vector2.ONE, 0.1)
	
