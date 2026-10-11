@icon("res://addons/at-icons/node3d/gun.svg")
class_name WeaponManager extends Node3D

@export var weapon_resources: Array[WeaponData] ## Store all weapon weapon definitions here.

var current_weapon_stack: Array = []
var weapon_dictionary: Dictionary

var can_change_weapons: bool = true
var can_use_weapon: bool = true
var can_shoot: bool = true
var can_reload: bool = true
var can_aim: bool = true
var is_disabled: bool = false


func setup_weapons():
	if Inventory.equipped_weapons.is_empty():
		printerr("No weapons equipped.")
		return
	
	for w: WeaponData in Inventory.equipped_weapons:
		print(w.weapon_name)
