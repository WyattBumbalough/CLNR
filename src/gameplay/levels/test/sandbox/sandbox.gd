extends LevelBase


func _on_interactable_interacted() -> void:
	Game.current.load_scene_request("uid://b8awueo266pwo")
