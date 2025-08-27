extends PickupBase

@export var chip_value := 1

func _on_pickup(player: Player):
	var attack := Attack.new()
	attack.damage = -chip_value
	player.health.take_damage(attack)
