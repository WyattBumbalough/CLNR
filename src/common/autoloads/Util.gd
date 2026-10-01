class_name Utilities
extends Object

# Center the pivot offset of a control node. Useful for animating UI elements.
static func center_control(control_node: Control) -> void:
	control_node.pivot_offset_ratio = Vector2(0.5,0.5)


static func kill_children(parent: Node) -> void:
	for c in parent.get_children():
		c.queue_free()
