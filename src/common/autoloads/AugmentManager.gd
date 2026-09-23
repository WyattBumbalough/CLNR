#class_name AugmentManager
extends Node

@export var installed_augs : Array[AugmentResource]

func install_augment(aug: AugmentResource) -> void:
	if installed_augs.has(aug):
		print("You already have this one, dipshit.")
		return
	installed_augs.append(aug)
	print(installed_augs)
