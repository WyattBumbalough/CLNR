class_name Stats
extends Resource

signal health_depleted
signal health_changed(cur_health: int, max_health: int)

enum BuffableStats{
	MAX_HEALTH,
	DEFENSE,
	MOVE_SPEED,
	SPRINT_ADD
}

const STAT_CURVES: Dictionary[BuffableStats, Curve] = {
	BuffableStats.MAX_HEALTH   : preload("uid://d4nkcsp62nrwh"),
	BuffableStats.DEFENSE      : preload("uid://ccjrujai2c270"),
	BuffableStats.MOVE_SPEED   : preload("uid://6o38x4uyyg2o"),
	BuffableStats.SPRINT_ADD : preload("uid://cn543yvuo75d0")
}

const BASE_LEVEL_XP = 100.0 # Base amount of xp needed to fill a level.

@export var base_max_health : float = 100
@export var base_move_speed : float = 4.0
@export var base_sprint_add : float = 2.5
@export var base_defense    : float = 10
@export var experience      : float = 0: set = _on_experience_set

var level: float: 
	get(): return floor(max(1.0, sqrt(experience / 100.0) + 0.5))
var current_max_health : float = 100
var current_move_speed : float = 4.0
var current_sprint_add : float = 2.5
var current_defense    : float = 10

var health     : float = 0: set = _on_health_set
var stat_buffs : Array[StatBuff]


func _init() -> void:
	setup_stats.call_deferred()

func setup_stats() -> void:
	health = current_max_health
	recalculate_stats()


func add_buff(buff: StatBuff) -> void:
	stat_buffs.append(buff)
	recalculate_stats()

func remove_buff(buff: StatBuff) -> void:
	stat_buffs.erase(buff)
	recalculate_stats.call_deferred()


func recalculate_stats() -> void:
	# Take all buffs and combine them into single multipliers for each buffable stat. 
	var stat_multipliers : Dictionary = {}
	var stat_addends     : Dictionary = {}
	for buff in stat_buffs:
		var stat_name: String = BuffableStats.keys()[buff.stat].to_lower()
		match buff.buff_type:
			StatBuff.BuffType.ADD:
				if not stat_addends.has(stat_name):
					stat_addends[stat_name] = 0.0
				stat_addends[stat_name] += buff.buff_amount
			StatBuff.BuffType.MULTIPLY:
				if not stat_multipliers.has(stat_name):
					stat_multipliers[stat_name] = 1.0
				stat_multipliers[stat_name] += buff.buff_amount
	
	# Set current level of each stat before buffs.
	var curve_sample_pos: float = (float(level) / 100.0) - 0.01
	current_max_health = base_max_health * STAT_CURVES[BuffableStats.MAX_HEALTH].sample(curve_sample_pos)
	current_defense = base_max_health * STAT_CURVES[BuffableStats. DEFENSE].sample(curve_sample_pos)
	current_move_speed = base_max_health * STAT_CURVES[BuffableStats.MOVE_SPEED].sample(curve_sample_pos)
	current_sprint_add = base_max_health * STAT_CURVES[BuffableStats.SPRINT_ADD].sample(curve_sample_pos)
	
	for stat_name in stat_multipliers:
		var cur_property_name : String = str("current_" + stat_name)
		set(cur_property_name, get(cur_property_name) * stat_multipliers[stat_name])
	for stat_name in stat_addends:
		var cur_property_name : String = str("current_" + stat_name)
		set(cur_property_name, get(cur_property_name) + stat_addends[stat_name])


func _on_health_set(new_value: float) -> void:
	health = clampf(new_value, 0, current_max_health)
	health_changed.emit(health, current_max_health)
	if health <= 0:
		health_depleted.emit()

func _on_experience_set(new_value: float) -> void:
	var old_level: float = level
	experience = new_value
	if not old_level == new_value:
		recalculate_stats()
	
