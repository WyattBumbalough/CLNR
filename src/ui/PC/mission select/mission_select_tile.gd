class_name MissionSelectTile
extends Control

signal mission_selected(data)

@export var mission_data : MissionData

@onready var label: Label = $PanelContainer/Label
@onready var texture_rect: TextureRect = $PanelContainer/TextureRect

#func _init(_mission_data: MissionData) -> void:
	#mission_data = _mission_data
	#label.text = mission_data.mission_title
	#texture_rect.texture = mission_data.thumbnail

func setup(_mission_data: MissionData):
	mission_data = _mission_data
	label.text = mission_data.mission_title
	texture_rect.texture = mission_data.thumbnail


func _on_button_pressed() -> void:
	mission_selected.emit(mission_data)
