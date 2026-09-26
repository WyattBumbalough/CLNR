extends Interactable

var MAIN : Main

func _ready() -> void:
	super()
	Events.computer_closed.connect(_on_computer_closed)

func _on_interacted_with():
	interaction_area.collision_layer = 0
	Events.computer_opened.emit()
	

func _on_computer_closed() -> void:
	interaction_area.collision_layer = 2
