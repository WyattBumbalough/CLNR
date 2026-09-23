class_name StatScreen
extends Control

@export var MAIN: Main
#@export var augment_manager : AugmentManager
@export var leg_aug : AugmentResource
@export var health_aug : AugmentResource
@export var body_aug : AugmentResource


@onready var max_health_label: Label = %MaxHealthLabel
@onready var defense_label: Label = %DefenseLabel
@onready var move_speed_label: Label = %MoveSpeedLabel


func _ready() -> void:
	hide()


func open():
	var player_stats: StatsResource = MAIN.player.stats
	max_health_label.text = str(player_stats.current_max_health)
	defense_label.text = str(player_stats.current_defense)
	move_speed_label.text = str(player_stats.current_move_speed)
	
	show()

func _on_leg_pressed() -> void:
	AugmentManager.install_augment(leg_aug)


func _on_head_pressed() -> void:
	for i in health_aug.stat_buffs:
		MAIN.player.stats.add_buff(i)
	open()
