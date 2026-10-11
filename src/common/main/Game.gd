class_name Game
extends Node

const PLAYER_UID : String = ("uid://cwjomq7poa3ul")

static var current: Game

@export_group("Initial Scene")
@export var initial_scene_uid: String = "uid://b8awueo266pwo"

@export_group("Root nodes")
@export var level_root: Node3D
@export var enitities_root: Node3D
@export var hud_root: Control
@export var ui_root: Control
@export var transition_root: Control
@export var debug_root: Control

@export_group("Subsytem Nodes")
@export var mission_log: MissionLog

var player: Player
var current_level: LevelBase


func _init() -> void:
	current = self


func _ready() -> void:
	randomize()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_init_player()
	load_level(initial_scene_uid)


func _init_player() -> void:
	var player_scene : PackedScene = ResourceLoader.load(PLAYER_UID) as PackedScene
	
	if is_instance_valid(player_scene):
		player = player_scene.instantiate()
		#Refs.player = player
		#player.hud = hud # Should probably not be here. Prone to breaking.
	else: 
		push_error("Could not load player scene: " + PLAYER_UID)
	
	if is_instance_valid(player):
		enitities_root.add_child(player)
	else:
		push_error("You done fucked this up somehow.")
		return


func load_level(new_level_uid: String) -> void:
	_deferred_load_level.call_deferred(new_level_uid)


func _deferred_load_level(new_level_uid: String):
	if current_level:
		freeze_player()
		#transition.fade_out()
		#await transition.fade_out_finished
		current_level.queue_free()
		current_level = null
		
	#else:
		#transition.fade_in()
	await get_tree().process_frame
	
	var new_level_packed : PackedScene = ResourceLoader.load(new_level_uid) as PackedScene
	if is_instance_valid(new_level_packed):
		current_level = new_level_packed.instantiate() as LevelBase
	else:
		push_error("Could not load level %s as packed scene." %new_level_uid)
	
	#player.enable_player()
	
	if is_instance_valid(current_level):
		level_root.add_child(current_level)
		#current_level.MAIN = self
		current_level.setup_level(player)
		#transition.fade_in()


func freeze_player() -> void:
	if is_instance_valid(player):
		player.allow_move = false
		player.allow_look = false

func unfreeze_player() -> void:
	if is_instance_valid(player):
		player.allow_move = true
		player.allow_look = true
