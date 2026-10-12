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
@export var interface_loader: InterfaceLoader
@export var mission_log: MissionLog
@export var augment_manager: AugmentManager

var player: Player
#var current_level: LevelBase


func _init() -> void:
	current = self


func _ready() -> void:
	randomize()
	_init_player()
	_init_subsystems()
	scene_loader.load_level_scene(initial_scene)


func _input(_event: InputEvent) -> void:
	if OS.is_debug_build() and Input.is_action_just_pressed("screenshot"):
		Util.screenshot()


## Validate the player scene and instatiate into Entities root.
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


func _init_subsystems() -> void:
	interface_loader.hud_opened.connect(_on_hud_opened)


## Validates file path of request and passes it to the scene_loader subsystem.
func load_level_request(_path: String) -> void:
	if FileAccess.file_exists(_path):
		print("Sending load_scene request to loader for: %s" %_path)
		scene_loader.load_level_scene(_path)
	else:
		printerr("Invalid file path at: %s" %_path)


## Validates the file path of 
func load_hud_request(_path: String) -> void:
	if FileAccess.file_exists(_path):
		print("Sending load_scene request to loader for: %s" %_path)
		interface_loader.load_hud_scene(_path)
	else:
		printerr("Invalid file path at: %s" %_path)


func _on_hud_opened() -> void:
	Util.free_mouse()
	player.freeze()
