class_name HUD
extends Control

signal hud_opened
signal hud_closed


@onready var stat_screen: StatScreen = $StatScreen
@onready var selected_mission: Control = $SelectedMission
@onready var hud_anims: AnimationPlayer = $HudAnims

var player : Player

var hud_open: bool = false

func _ready() -> void:
	MissionLog.mission_selected.connect(show_selected_mission)


func toggle_hud() -> void:
	if hud_open == false:
		Refs.main.freeze_player()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

		hud_anims.play("open_hud")
		hud_open = true
		hud_opened.emit()
		
		stat_screen.open() # FIX ME -------This is a stupid way to do this ----#
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		Refs.main.unfreeze_player()
		
		hud_anims.play_backwards("open_hud")
		hud_open = false
		hud_closed.emit()
		
		stat_screen.hide() # FIX ME ------------------#


func show_selected_mission() -> void:
	var tween: Tween = self.create_tween()
	selected_mission.show()
	tween.tween_property(selected_mission,"scale", Vector2.ONE, 0.1)
	
