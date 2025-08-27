class_name PlayerHPUI extends HBoxContainer

@onready var hp_label : Label = $Label

func _init():
	SignalBus.player_health_updated.connect(_on_player_health_updated)
	
func _on_player_health_updated(new_current: int, previous_health : int):
	hp_label.text = str(new_current)
