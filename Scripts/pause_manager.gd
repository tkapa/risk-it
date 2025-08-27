extends Node

var pause_menu : PauseMenu
var is_paused : bool = false

func _init():
	process_mode = Node.PROCESS_MODE_ALWAYS
	SignalBus.pause_game.connect(_on_pause)
	SignalBus.unpause_game.connect(_on_unpause)

func _on_pause():
	is_paused = true
	get_tree().paused = true
	
	if pause_menu:
		pause_menu.show()

func _on_unpause():
	is_paused = false
	get_tree().paused = false
	
	if pause_menu:
		pause_menu.hide()
	
