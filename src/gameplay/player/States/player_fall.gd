extends PlayerState


func enter(_previous_state: State):
	speed = _previous_state.speed


func handle_physics(_delta) -> State:
	PLAYER.handle_movement(speed, accel, friction)
	
	if PLAYER.velocity.y == 0.0 and PLAYER.is_on_floor():
		return walk_state
	
	return null
