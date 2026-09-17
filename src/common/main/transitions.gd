extends Control


signal fade_in_finished
signal fade_out_finished

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func fade_in():
	animation_player.play("fade_in")

func fade_out():
	animation_player.play("fade_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		fade_in_finished.emit()
	else:
		fade_out_finished.emit()
