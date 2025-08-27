extends Node

signal player_died
signal player_health_updated(new_current_health: int, new_max_health: int)

signal drop_chip_pickup(position: Vector2, chip_stats: ChipStats)

signal pause_game
