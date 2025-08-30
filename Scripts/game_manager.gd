extends Node

var player : Player
var game_node: Node2D
var cash_in_ready: bool

var cash_in_cost: int = 5

func _ready():
	SignalBus.start_game.connect(_on_game_start)
	SignalBus.player_health_updated.connect(_check_cash_in)
	
func _on_game_start():
	var level_name = "main"
	var level = str("res://Scenes/", level_name, ".tscn")
	get_tree().change_scene_to_file(level)

func _check_cash_in(new_current: int, previous: int):
	cash_in_ready = new_current > cash_in_cost
