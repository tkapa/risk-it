extends Node

var using_controller := false
var last_look_vector : Vector2 = Vector2.ZERO

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func wants_throw() -> bool:
	return Focus.is_action_just_pressed("throw")

func wants_pause() -> bool:
	return Focus.is_action_just_pressed("pause")

func wants_cash_in() -> bool:
	return Focus.is_action_just_pressed("cash_in")

func movement_vector() -> Vector2:
	var x : float = Input.get_axis("left", "right")
	var y : float = Input.get_axis("up", "down")

	return Vector2(x, y)

func look_vector() -> Vector2:
	var _look_vector = Input.get_vector("look_left", "look_right", "look_up","look_down")
	
	if _look_vector.length() > 0.2:
		last_look_vector = _look_vector
		return last_look_vector
		
	return last_look_vector

func cursor_position() -> Vector2:
	var pos = Vector2.ZERO
	var camera = get_viewport().get_camera_2d()
	
	if not camera:
		return pos

	pos = camera.get_global_mouse_position()
	return pos

func _input(event):
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		_set_using_controller(true)
	else:
		_set_using_controller(false)

func _set_using_controller(value: bool):
	if using_controller == value:
		return
	
	using_controller = value
