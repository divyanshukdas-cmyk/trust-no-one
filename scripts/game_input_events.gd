class_name GameInputEvents

static func movement_input() -> Vector2:
	var dir:Vector2
	dir =Input.get_vector("left","right","down","up")
	return dir
