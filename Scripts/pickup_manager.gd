extends Node

var _chip_pickup : PackedScene = preload("res://Entities/Pickups/Chip/chip_pickup.tscn")

func _init():
	SignalBus.drop_chip_pickup.connect(_on_drop_chip_pickup)

func _on_drop_chip_pickup(position: Vector2, chip_stats: ChipStats):
	var pickup : ChipPickup = _chip_pickup.instantiate()
	pickup.chip_stats = chip_stats
	pickup.position = position
	GameManager.game_node.add_child(pickup)
