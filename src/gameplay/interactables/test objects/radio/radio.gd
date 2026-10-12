extends Node3D

@onready var audio_player: AudioStreamPlayer3D = %Audio

var radio_on : bool = true


func _ready() -> void:
	add_to_group("entities")


func _on_power_switch_interacted() -> void:
	if radio_on:
		audio_player.stream_paused = true
	else:
		audio_player.stream_paused = false
	
	radio_on = !radio_on
