extends PlayerState


@export var jump_force : float = 6.0
@export var double_jump_force : float = 5.0

var can_jump_again : bool = true


func enter(_previous_state: State):
	PLAYER.velocity.y = jump_force
	speed = _previous_state.speed


func handle_physics(_delta) -> State:
	PLAYER.handle_movement(speed, accel, friction)
	
	if PLAYER.velocity.y < 0.0 and not PLAYER.is_on_floor():
		return fall_state
	
	return null
