extends HudElement

@export var animation_player: AnimationPlayer


func _ready() -> void:
	await animation_player.animation_finished
	hud_element_opened.emit()


func open_hud_element() -> void:
	pass


func close_hud_element() -> void:
	animation_player.play_backwards("open")
	await animation_player.animation_finished
	hud_element_closed.emit()
	queue_free()
