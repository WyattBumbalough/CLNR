@icon("res://addons/at-icons/node/dropdown.svg")
class_name InterfaceManager
extends Node

signal hud_opened
signal hud_closed

static var current: InterfaceManager

@export_group("Root ui nodes")
@export var hud_root: Control
@export var ui_root: Control
@export var transition_root: Control
@export var debug_root: Control

@onready var hud_overlay = preload(Constants.SCENE_PATHS_UI.overlay)

var current_overlay: HudElement
var current_hud_element: HudElement


func _ready() -> void:
	current = self


func load_hud_scene(_path) -> void:
	#Make sure no other HUD elements are in the tree. Might change this later.
	Util.kill_children(Game.current.hud_root) 
	
	_open_hud()
	await current_overlay.hud_element_opened
	
	var _loaded_scene = ResourceLoader.load(_path) as PackedScene
	var _new_hud: HudElement =  _loaded_scene.instantiate() as HudElement
	if is_instance_valid(_new_hud):
		current_hud_element = _new_hud
		hud_root.add_child(_new_hud)
		hud_root.move_child(current_hud_element, 0)
	else:
		push_error("Could not load hud element. Make sure it inherits from HudElement class.")


func _open_hud() -> void:
	var _overlay: HudElement = hud_overlay.instantiate() as HudElement
	current_overlay = _overlay
	hud_root.add_child(_overlay)
	hud_opened.emit()


func close_hud() -> void:
	current_overlay.close_hud_element()
	current_hud_element.close_hud_element()
	await current_overlay.hud_element_closed
	
	hud_closed.emit()
	current_hud_element = null
	current_overlay = null
