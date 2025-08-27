class_name Enemy extends CharacterBody2D

@export var enemy_stats : EnemyStats

@onready var hurtbox : HurtboxComponent = $HurtboxComponent
@onready var health : HealthComponent = $HealthComponent

var chip_pickup : PackedScene = preload("res://Entities/Pickups/Chip/chip_pickup.tscn")

func _ready():
	health.init(enemy_stats.max_health)
	hurtbox.init(health)
	
func _physics_process(delta):
	var player_position := GameManager.player.position
	enemy_stats.move(self, player_position, delta)

func _on_health_component_on_death():
	var pickup : ChipPickup = chip_pickup.instantiate()
	pickup.chip_stats = enemy_stats.chip_drop
	pickup.position = position
	add_sibling(pickup)
	queue_free()
