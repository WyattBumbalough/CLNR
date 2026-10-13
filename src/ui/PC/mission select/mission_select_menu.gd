extends Control

@export var default_missions : Array[MissionData]

@onready var mission_list: VBoxContainer = %MissionList
@onready var mission_description: RichTextLabel = %MissionDescription
@onready var select_button: Button = %SelectButton

var mission_log: MissionLog
var mission_tile : PackedScene = preload(Constants.SCENE_PATHS_UI.mission_slot)
var _selected_mission : MissionData


func _ready() -> void:
	if Game.current:
		_setup()
	else:
		_load_default_missions.call_deferred()

func _setup() -> void:
	mission_log = Game.current.mission_log
	
	for m in default_missions:
		if not mission_log.available_missions.has(m):
			mission_log.available_missions.append(m)
	await get_tree().process_frame
	update_mission_list()


func _load_default_missions():
	Util.kill_children(mission_list)
	for m in default_missions:
		var tile: MissionSelectTile = mission_tile.instantiate()
		mission_list.add_child(tile)
		tile.setup(m)


func update_mission_list() -> void:
	Util.kill_children(mission_list) #Delete all mission slots.
	
	if mission_log.available_missions.is_empty():
		printerr("No available missions in mission log. Can't do much right now...")
		return
	
	for m in mission_log.available_missions:
		var tile: MissionSelectTile = mission_tile.instantiate()
		mission_list.add_child(tile)
		tile.mission_selected.connect(_on_mission_tile_pressed)
		tile.setup(m)


func _on_mission_tile_pressed(_mission: MissionData) -> void:
	if mission_log.selected_mission != _mission:
		select_button.disabled = false
	else:
		select_button.disabled = true
	
	_selected_mission = _mission
	mission_description.text = _mission.mission_description


func _on_select_button_pressed() -> void:
	if _selected_mission != null:
		select_button.disabled = true
		mission_log.select_mission(_selected_mission)
