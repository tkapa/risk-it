extends Node

var player : Player
var game_node: Node2D

func _ready():
	SignalBus.start_game.connect(_on_game_start)
	
func _on_game_start():
	var level_name = "main"
	var level = str("res://Scenes/", level_name, ".tscn")
	get_tree().change_scene_to_file(level)
