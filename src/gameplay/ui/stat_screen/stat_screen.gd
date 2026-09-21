class_name StatScreen
extends Control

@export var MAIN: Main

@onready var max_health_label: Label = %MaxHealthLabel
@onready var defense_label: Label = %DefenseLabel
@onready var move_speed_label: Label = %MoveSpeedLabel

func _ready() -> void:
	hide()

func open():
	var player_stats: Stats = MAIN.player.stats
	max_health_label.text = str((int(ceil(player_stats.current_max_health))))
	defense_label.text = str((int(ceil(player_stats.current_defense))))
	move_speed_label.text = str((int(ceil(player_stats.current_move_speed))))
	
	show()
	
