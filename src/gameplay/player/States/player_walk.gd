extends PlayerState

@export var footstep_delay: float = 1.5
var time : float = 0.0


func handle_physics(_delta) -> State:
	PLAYER.handle_movement(speed, accel, friction)
	
	if PLAYER.input_direction:
		if Input.is_action_just_pressed(PLAYER.SPRINT) and PLAYER.allow_sprint:
			return run_state
	elif PLAYER.input_direction == Vector2.ZERO:
		return idle_state
	
	return null


func handle_process(_delta) -> State:
	if time >= footstep_delay:
		$"../../AudioStreamPlayer3D".play()
		time = 0.0
	time += _delta
	
	return null


func handle_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed(PLAYER.JUMP) and PLAYER.allow_jump:
		return jump_state
	
	return null
