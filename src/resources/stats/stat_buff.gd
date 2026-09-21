class_name StatBuff
extends Resource

enum BuffType{
	MULTIPLY,
	ADD
}

@export var stat        : Stats.BuffableStats
@export var buff_amount : float
@export var buff_type  : BuffType




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
