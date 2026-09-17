extends CharacterBody3D
class_name  Player


const JUMP_VELOCITY = 4.5
const SENS = .002

@export_group("Controls mapping")
@export var MOVE_FORWARD : String = "up"
@export var MOVE_BACK    : String = "down"
@export var MOVE_LEFT    : String = "left"
@export var MOVE_RIGHT   : String = "right"
@export var JUMP         : String = "jump"
@export var CROUCH       : String = "crouch"
@export var SPRINT       : String = "sprint"
@export var PAUSE        : String = "pause"

@export_group("Toggles")
@export var allow_move        : bool = true
@export var allow_look        : bool = true
@export var allow_jump        : bool = true
@export var allow_double_jump : bool = false
@export var allow_crouch      : bool = true
@export var allow_sprint      : bool = true
@export var allow_interaction : bool = true

@onready var head: Node3D = %Head
@onready var camera: Camera3D = %Camera
@onready var state_machine: StateMachine = %StateMachine
@onready var interaction_raycast: RayCast3D = %InteractionRaycast

var input_direction : Vector2
var interact_ray_result


func _ready() -> void:
	state_machine.initialize(self)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	align_camera()


func _unhandled_input(event: InputEvent) -> void:
	state_machine.handle_input(event)
	if event is InputEventMouseMotion:
		head.rotate_y( -event.relative.x * SENS )
		camera.rotate_x( -event.relative.y * SENS )
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))
	
	if Input.is_action_just_released("interact"):
		interact()


func _physics_process(delta: float) -> void:
	state_machine.handle_physics(delta)
	
	if allow_move:
		if Input.get_vector(MOVE_LEFT, MOVE_RIGHT, MOVE_FORWARD, MOVE_BACK):
			input_direction = Input.get_vector(MOVE_LEFT, MOVE_RIGHT, MOVE_FORWARD, MOVE_BACK)
		else:
			input_direction = Vector2.ZERO
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	%Label.text = state_machine.current_state.name
	
	check_interactions()
	
	move_and_slide()


func handle_movement(speed: float, acceleration: float, friction: float):
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		if direction:
			velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
			velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
		else:
			velocity.x = lerp(velocity.x, 0.0, friction)
			velocity.z = lerp(velocity.z, 0.0, friction)
	else:
		if direction:
			velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
			velocity.z = lerp(velocity.z, direction.z * speed, acceleration)


func align_camera():
	head.rotation.y = rotation.y
	rotation.y = 0.0


func check_interactions():
	if not interaction_raycast.is_colliding():
		if interact_ray_result != null and interact_ray_result is InteractionArea:
			interact_ray_result.emit_signal("looked_away")
	
	if interaction_raycast.get_collider() != interact_ray_result:
		if interact_ray_result != null and interact_ray_result is InteractionArea:
			interact_ray_result.emit_signal("looked_away")
		
		interact_ray_result = interaction_raycast.get_collider()
	
		if interact_ray_result != null and interact_ray_result is InteractionArea:
			interact_ray_result.emit_signal("looked_at")
	

func interact():
	if allow_interaction == false:
		return
	if interact_ray_result != null and interact_ray_result is InteractionArea:
		interact_ray_result.emit_signal("interacted")
