class_name ChipPickup extends PickupBase

@export var chip_stats : ChipStats

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	animation.sprite_frames = chip_stats.sprite_frames
	animation.play("default")

func _on_pickup(player: Player):
	var attack := Attack.new()
	attack.damage = -chip_stats.value
	player.health.take_damage(attack)
