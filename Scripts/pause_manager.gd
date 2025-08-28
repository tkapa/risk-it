extends Node

var is_paused : bool = false
var _temp_pause_menu : Control

func _init():
	process_mode = Node.PROCESS_MODE_ALWAYS
	SignalBus.pause_game.connect(_on_pause)
	SignalBus.unpause_game.connect(_on_unpause)

func _on_pause(pause_menu : Control):
	_temp_pause_menu = pause_menu
	is_paused = true
	get_tree().paused = is_paused
	
	if _temp_pause_menu:
		_temp_pause_menu.show()

func _on_unpause():
	is_paused = false
	get_tree().paused = false
	
	if _temp_pause_menu:
		_temp_pause_menu.hide()
		_temp_pause_menu = null
