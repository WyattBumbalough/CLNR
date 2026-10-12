@icon("res://addons/at-icons/node/file_arrow_down.svg")
class_name SceneLoader
extends Node
## Handles multi-threaded loading/changing of scenes.
##
## Useful for loading large scenes without bogging down the main process thread

# Emitted every tick as a resource is being loaded. Progress represented
# as a float value from 0-1.
signal progress_changed(progress)
# Emitted after the level has been loaded, instantied, and setup.
signal load_finished

var scene_path: String
var loading_screen: PackedScene = preload("uid://b0ejma3wf55sl")
var loaded_resource: PackedScene
var progress: Array = []
var use_sub_threads: bool = true

var current_level: LevelBase

func _ready() -> void:
	set_process(false)


func _process(_delta: float) -> void:
	# Resource loader returns load status in a 1D array with a float from 0-1.
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	progress_changed.emit(progress[0])
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE or ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_resource = ResourceLoader.load_threaded_get(scene_path) as PackedScene
			deferred_load_level.call_deferred()
			set_process(false)


func load_scene(_path: String) -> void:
	scene_path = _path
	
	var new_load_screen = loading_screen.instantiate()
	Game.current.transition_root.add_child(new_load_screen)
	progress_changed.connect(new_load_screen._on_progress_changed)
	load_finished.connect(new_load_screen._on_load_finished)
	
	await new_load_screen.loading_screen_ready
	start_load()


func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)


func deferred_load_level() -> void:
	if current_level:
		Game.current.player.freeze()
		current_level.queue_free()
		current_level = null
	await get_tree().process_frame
	
	if is_instance_valid(loaded_resource):
		current_level = loaded_resource.instantiate() as LevelBase
	else:
		push_error("Could not load level %s as packed scene." %loaded_resource)
	
	if is_instance_valid(current_level):
		Game.current.level_root.add_child(current_level)
		Game.current.player.unfreeze()
		
		current_level.setup_level(Game.current.player)
		load_finished.emit()
