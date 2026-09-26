extends Control

@export var default_missions : Array[MissionData]

@onready var mission_list: VBoxContainer = %MissionList
@onready var mission_description: RichTextLabel = %MissionDescription
@onready var select_button: Button = %SelectButton


var mission_tile : PackedScene = preload("res://src/gameplay/ui/PC/mission_select_tile.tscn")
var selected_mission : MissionData

func _ready() -> void:
	setup.call_deferred()


func setup():
	for m in default_missions:
		if not MissionLog.available_missions.has(m):
			MissionLog.available_missions.append(m)
	await get_tree().process_frame
	update_mission_list()


func update_mission_list():
	var list = mission_list.get_children()
	if not list.is_empty():
		for i in mission_list.get_children():
			i.queue_free()
	
	if MissionLog.available_missions.is_empty():
		printerr("No available missions in mission log.")
		return
	
	for m in MissionLog.available_missions:
		var tile : MissionSelectTile = mission_tile.instantiate()
		mission_list.add_child(tile)
		tile.mission_selected.connect(_on_mission_tile_pressed)
		tile.setup(m)


func _on_mission_tile_pressed(_mission: MissionData):
	if MissionLog.selected_mission != _mission:
		select_button.disabled = false
	else:
		select_button.disabled = true
	selected_mission = _mission
	mission_description.text = _mission.mission_description


func _on_select_button_pressed() -> void:
	if selected_mission != null:
		select_button.disabled = true
		MissionLog.selected_mission = selected_mission
