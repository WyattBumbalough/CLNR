extends Control

signal loading_screen_ready

@export var animation_player: AnimationPlayer


func _ready() -> void:
	await animation_player.animation_finished
	loading_screen_ready.emit()


func _on_progress_changed(_new_value: float) -> void:
	# Receives a value from 0-1 from threaded resource loader that represents loading progress.
	# Can maybe do something with this later.
	pass


func _on_load_finished() -> void:
	animation_player.play_backwards("transition")
	await animation_player.animation_finished
	queue_free()
