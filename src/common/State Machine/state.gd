@icon("res://addons/at-icons/node/arrow_double_horizontal.svg")
class_name State extends Node 

var character: Player

func enter(_previous_state: State):
	pass


func exit(_next_state: State):
	pass


func handle_physics(_delta) -> State:
	return null


func handle_process(_delta) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	return null
