class_name MissionData
extends Resource

enum TYPES{ASSASSINATION, RETRIEVAL}

@export var level_uid                       : String = ""
@export var thumbnail                       : CompressedTexture2D
@export var mission_type                    : TYPES
@export var mission_title                   : String
@export_multiline() var mission_description : String
