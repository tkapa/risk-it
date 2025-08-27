class_name HealthComponent extends Node

signal on_death
signal health_updated(new_current_health: int, previous_health: int)

var current_health : int

func init(_starting_health: int):
	current_health = _starting_health
	health_updated.emit(current_health, current_health)

func take_damage(attack: Attack):
	var previous : int = current_health
	current_health -= attack.damage
		
	if current_health <= 0:
		on_death.emit()

	health_updated.emit(current_health, previous)
