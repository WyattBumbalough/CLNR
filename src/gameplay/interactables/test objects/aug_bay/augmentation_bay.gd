extends Node3D

@export var open_sound: AudioStream
@export var close_sound: AudioStream

@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		anims.play("open")
		audio.stream = open_sound
		audio.play()


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		anims.play("close")
		audio.stream = close_sound
		audio.play()
