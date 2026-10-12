extends Node3D

@export var interaction_component: Interactable


func _ready() -> void:
	interaction_component.interacted.connect(_on_interacted)


func _on_interacted():
	Game.current.load_hud_request(Constants.SCENE_PATHS_UI.pc)
