extends Camera2D

@export var cursor_distance : int = 25
var _player : CharacterBody2D

func _process(delta):
	if not _player:
		_player = GameManager.player
		return
	
	var _cursor_dir : Vector2 = Vector2.ZERO
	
	if InputManager.using_controller:
		_cursor_dir = InputManager.look_vector()
	else:
		var _cursor_pos = InputManager.cursor_position()
		_cursor_dir = global_position.direction_to(_cursor_pos)
	
	_cursor_dir = _cursor_dir.normalized()
	
	var pos = _player.position + (_cursor_dir * cursor_distance)
	
	position = position.lerp(pos, delta)
