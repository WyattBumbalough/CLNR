@icon("res://addons/at-icons/node3d/field_of_view.svg")
class_name WeaponVisual
extends Node3D

@export var weapon_data: WeaponData
@export var animations: AnimationPlayer
@export var audio_player: AudioStreamPlayer3D


func play_animation(anim_name: String) -> void:
	if animations.has_animation(anim_name):
		animations.play(anim_name)
	else:
		printerr("Animation: '" + anim_name + "' not found for weapon %s." %weapon_data.weapon_name)
