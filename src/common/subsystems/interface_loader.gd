@icon("res://addons/at-icons/node/dropdown.svg")
class_name InterfaceLoader
extends Node

signal hud_opened
signal hud_closed


func load_hud_scene(_path) -> void:
	#Make sure no other HUD elements are in the tree. Might change this later.
	Util.kill_children(Game.current.hud_root) 
	
	var loaded_scene = ResourceLoader.load(_path) as PackedScene
	var new_hud =  loaded_scene.instantiate()
	Game.current.hud_root.add_child(new_hud)
	
	hud_opened.emit()
