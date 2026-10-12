extends Node


## Takes a screenshot of the current viewport and stores it in the user data file. 
## (Project -> Open User data file)
func screenshot() -> void:
	var img = get_viewport().get_texture().get_image()
	img.save_png("user://please.png")


## Center the pivot offset of a control node. Useful for animating UI elements.
func center_control(control_node: Control) -> void:
	control_node.pivot_offset_ratio = Vector2(0.5,0.5)


## Violently remove all children of a node.
func kill_children(parent: Node) -> void:
	for c in parent.get_children():
		c.queue_free()


func capture_mouse() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func free_mouse() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
