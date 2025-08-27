extends Node

var paused : bool = false

func _init():
	SignalBus.pause_game.connect(_on_pause)

func _on_pause():
	paused = !paused
	get_tree().paused = paused
	
	if (paused):
		print("Paused")
	else:
		print("Unpaused")
