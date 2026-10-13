class_name AugmentResource
extends Resource

enum AugmentType{
	HEAD,
	ARMS,
	LEGS,
	TORSO,
	EYES
}

@export var name                    : String = ""
@export_multiline() var description : String
@export var augment_type            : AugmentType
@export var stat_buffs              : Array[StatBuff]
