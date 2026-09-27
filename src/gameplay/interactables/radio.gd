extends Node3D

@onready var audio_player: AudioStreamPlayer3D = %Audio



func _ready() -> void:
	add_to_group("entities")


func _on_power_switch_interacted() -> void:
	audio_player.stop()
