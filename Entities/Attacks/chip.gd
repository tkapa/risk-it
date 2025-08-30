class_name Chip extends Area2D

var direction : Vector2 = Vector2.UP

@export var move_speed : int = 100
@export var maximum_hits : int = 1
@export var damage : int = 1
@export var chip_drop : ChipStats
@export var speed_decay : int = 5
@export var chip_cost : int = 1

@onready var hitbox : HitboxComponent = $HitboxComponent

func init(_move_speed: int, _direction: Vector2):
	direction = _direction
	move_speed = _move_speed

func _ready():
	hitbox.damage = damage

func _physics_process(delta):
	position += direction * move_speed * delta
	
	move_speed -= speed_decay
	if move_speed < 0:
		_on_cleanup()

func _on_cleanup():
	SignalBus.drop_chip_pickup.emit(position, chip_drop)
	queue_free()

func _on_hitbox_component_hit():
	maximum_hits -= 1
	
	print("Hits: ", maximum_hits)

	if maximum_hits <= 0:
		print("Chip no hits")
		_on_cleanup()
