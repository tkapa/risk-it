extends Node

signal player_died
signal player_health_updated(new_current_health: int, new_max_health: int)
signal player_cash_in
signal player_grant_power_up(power_up: ChipStrategy)

signal drop_chip_pickup(position: Vector2, chip_stats: ChipStats)

signal pause_game(show_menu: Control)
signal unpause_game

signal start_game
