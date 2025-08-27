class_name ChipPickup extends PickupBase

@export var chip_stats : ChipStats

@onready var sprite : Sprite2D = $Sprite2D

func _ready():
	sprite.texture = chip_stats.sprite

func _on_pickup(player: Player):
	var attack := Attack.new()
	attack.damage = -chip_stats.value
	player.health.take_damage(attack)
