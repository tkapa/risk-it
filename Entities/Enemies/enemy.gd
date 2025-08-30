class_name Enemy extends CharacterBody2D

@export var enemy_stats : EnemyStats

@onready var hurtbox : HurtboxComponent = $HurtboxComponent
@onready var health : HealthComponent = $HealthComponent
@onready var animation : AnimatedSprite2D = $AnimatedSprite

func _ready():
	animation.sprite_frames = enemy_stats.sprite_sheet
	animation.play("default")
	health.init(enemy_stats.max_health)
	hurtbox.init(health)
	
func _physics_process(delta):
	var player_position := GameManager.player.position
	enemy_stats.move(self, player_position, delta)

func _on_health_component_on_death():
	AudioManager.create_2d_audio_at_location(position, enemy_stats.sound_effect)
	SignalBus.drop_chip_pickup.emit(position, enemy_stats.chip_drop)
	queue_free()
