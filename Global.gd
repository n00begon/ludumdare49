extends Node

func is_outside_viewport(pos):
	var viewport = get_viewport().size
	return pos.x < 0 || pos.y < 0 || pos.x > viewport.x || pos.y > viewport.y
