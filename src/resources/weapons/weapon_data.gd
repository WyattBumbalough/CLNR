class_name WeaponData extends Node

@export_group("General Settings")
@export var weapon_name: String
@export var weapon_id: int ## Must match ID of weapon slot in weapon manager.

@export_group("Attack Settings")
#var is_shooting: bool = false
@export var weapon_damage: float
@export var auto: bool = false
@export var rate_of_fire: float = 0.3
@export var headshot_damage_multiplier: float = 2.0
@export var projectiles_per_shot: int = 1
@export var min_spread: float
@export var max_spread: float

@export_group("Aiming Settings")
#var is_aiming: bool = false
@export var zoom_amount: float = 1.25

@export_group("Ammo Settings")
@export var max_ammo_capacity: int
@export var ammo_type: String = ""
@export var current_ammo: int
@export var current_reserve_ammo: int

@export_group("Reload Settings")
#var is_reloading: bool = false
@export var auto_reload: bool = false
@export var rounds_reload: bool = true
@export var reload_parts_needed: int = 1
@export var time_per_reload_part: float = 0.3

@export_group("Animation Settings")
@export var equip_anim_name: String
@export var equip_anim_speed: float = 1.0
@export var shoot_anim_name: String
@export var shoot_anim_speed: float = 1.0
@export var reload_anim_name: String
@export var reload_anim_speed: float = 1.

@export_group("Muzzle Flash")
@export var muzzle_flash_ref: PackedScene
@export var muzzle_flash_scale:= Vector3(1.0, 1.0, 1.0)
