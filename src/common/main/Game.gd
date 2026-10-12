@icon("res://addons/at-icons/node/controller.svg")
class_name Game
extends Node

const PLAYER_UID : String = ("uid://cwjomq7poa3ul")

static var current: Game

## Initial scene to load on startup. Can be a file path, but prefer UID.
@export var initial_scene: String = "uid://b8awueo266pwo"

@export_group("Root nodes")
@export var level_root: Node3D
@export var enitities_root: Node3D
@export var hud_root: Control
@export var ui_root: Control
@export var transition_root: Control
@export var debug_root: Control

@export_group("Subsytem Nodes")
@export var scene_loader: SceneLoader
@export var mission_log: MissionLog
@export var augment_manager: AugmentManager

var player: Player
#var current_level: LevelBase


func _init() -> void:
	current = self


func _ready() -> void:
	randomize()
	_init_player()
	scene_loader.load_scene(initial_scene)


func _input(_event: InputEvent) -> void:
	if OS.is_debug_build() and Input.is_action_just_pressed("screenshot"):
		Util.screenshot()


func _init_player() -> void:
	var player_scene : PackedScene = ResourceLoader.load(PLAYER_UID) as PackedScene
	if is_instance_valid(player_scene):
		player = player_scene.instantiate()
	else: 
		push_error("Could not load player scene: " + PLAYER_UID)
	
	if is_instance_valid(player):
		enitities_root.add_child(player)
	else:
		push_error("You done fucked this up somehow.")
		return


## Validates file path of request and passes it to the scene_loader subsystem.
func load_scene_request(_path: String) -> void:
	if FileAccess.file_exists(_path):
		print("Sending load_scene request to loader for: %s" %_path)
		scene_loader.load_scene(_path)
	else:
		printerr("Invalid file path at: %s" %_path)


func load_hud(_path: String) -> void:
	if FileAccess.file_exists(_path):
		print("Sending load_scene request to loader for: %s" %_path)
		scene_loader.load_scene(_path)
	else:
		printerr("Invalid file path at: %s" %_path)
