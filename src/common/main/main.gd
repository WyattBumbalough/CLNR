class_name Main
extends Node

const PLAYER_UID : String = ("uid://cwjomq7poa3ul")

var player        : Player
var current_level : LevelBase
 
# World3d root nodes.
@onready var level_root     : Node3D = $World/Level
@onready var enitities_root : Node3D = $World/Enitities
@onready var transition     : Control = $TransitionLayer/Transition



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Refs.main = self
	randomize()
	init_player()
	load_level("uid://b8awueo266pwo") # Loads Test Level 1 by default.


func init_player():
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


func load_level(new_level_uid: String):
	_deferred_load_level.call_deferred(new_level_uid)


func _deferred_load_level(new_level_uid: String):
	if current_level:
		freeze_player()
		transition.fade_out()
		await transition.fade_out_finished
		current_level.queue_free()
		current_level = null
		
	else:
		transition.fade_in()
	
	await get_tree().process_frame
	
	var new_level_packed : PackedScene = ResourceLoader.load(new_level_uid) as PackedScene
	if is_instance_valid(new_level_packed):
		current_level = new_level_packed.instantiate() as LevelBase
	else:
		push_error("Could not load level %s as packed scene." %new_level_uid)
	
	player.enable_player()
	
	if is_instance_valid(current_level):
		level_root.add_child(current_level)
		current_level.setup_level(player)
		transition.fade_in()


func freeze_player():
	if is_instance_valid(player):
		player.allow_move = false

func unfreeze_player():
	if is_instance_valid(player):
		player.allow_move = true


#region signals

func _on_transition_fade_out_finished() -> void:
	unfreeze_player()




#endregion
