class_name HealthComponent extends Node

signal on_death
signal health_updated(new_current_health: int, new_max_health: int)

@export var starting_health : int = 3

var max_health : int = 0
var current_health : int

func _ready():
	set_max_health(starting_health)

func set_max_health(new_max_health: int):
	var max_health_diff = new_max_health - max_health
	max_health = new_max_health
	
	if max_health_diff > 0:
		current_health += max_health_diff
	
	health_updated.emit(current_health, max_health)

func take_damage(attack: Attack):
	current_health -= attack.damage
		
	if current_health <= 0:
		on_death.emit()
	
	health_updated.emit(current_health, max_health)
