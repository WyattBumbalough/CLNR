class_name Interactable
extends Node3D

@export var interaction_area : InteractionArea
@export var mesh : MeshInstance3D

@onready var mat_overlay = preload("res://src/gameplay/interactables/interact_mat_overlay.tres")


func _ready() -> void:
	add_to_group("entities")
	 
	if mesh == null:
		printerr("No mesh assigned to interactable object.")
	elif interaction_area == null:
		printerr("No interaction area assigned to interactable object.")
		
	mesh.material_overlay = null
	interaction_area.interacted.connect(_on_interacted_with)
	interaction_area.looked_at.connect(_on__looked_at)
	interaction_area.looked_away.connect(_on_looked_away)


func _on_interacted_with():
	pass
	


func _on__looked_at():
	if mesh:
		mesh.material_overlay = mat_overlay


func _on_looked_away():
	if mesh:
		mesh.material_overlay = null
