extends Interactable

var MAIN : Main

func _ready() -> void:
	super()
	Events.computer_closed.connect(_on_computer_closed)

func _on_interacted_with():
	interaction_area.collision_layer = 0
	Events.computer_opened.emit()
	#Refs.main.load_level("uid://bf1ufjqy1abf")

func _on_computer_closed() -> void:
	print("aaa")
	interaction_area.collision_layer = 2
