class_name StatBuff
extends Resource

enum BuffType{
	MULTIPLY,
	ADD
}

@export var stat        : StatsResource.BuffableStats
@export var buff_amount : float
@export var buff_type  : BuffType


# Called when a new statbuff is instantiated. I.E. you could call StatBuff.new() in another script.
func _init(_stat: StatsResource.BuffableStats = StatsResource.BuffableStats.MAX_HEALTH,
		_buff_amount: float = 1.0, _buff_type: BuffType = BuffType.ADD) -> void:
		
		stat = _stat
		buff_amount = _buff_amount
		buff_type = _buff_type
