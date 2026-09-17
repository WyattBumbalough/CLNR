extends PlayerState


func handle_physics(_delta) -> State:
	PLAYER.handle_movement(speed, accel, friction)
	if PLAYER.input_direction:
		return walk_state
	
	return null


func handle_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed(PLAYER.JUMP) and PLAYER.allow_jump:
		return jump_state
	
	return null
