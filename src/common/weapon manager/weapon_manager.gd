@icon("res://addons/at-icons/node3d/gun.svg")
class_name WeaponManager extends Node3D


@export var weapon_definitions: Array[WeaponData] ## Store all weapon weapon definitions here.

var can_change_weapons: bool = true
var can_use_weapon: bool = true
var can_shoot: bool = true
var can_reload: bool = true
var can_aim: bool = true
var is_disabled: bool = false
