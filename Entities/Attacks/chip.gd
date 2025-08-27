class_name Chip extends CharacterBody2D

var direction : Vector2 = Vector2.UP
var move_speed : int = 100

@export var chip_drop : ChipStats
@export var speed_decay : int = 5

func init(_move_speed: int, _direction: Vector2):
	direction = _direction
	move_speed = _move_speed

func _physics_process(delta):
	velocity = direction * move_speed	
	move_and_slide()
	
	move_speed -= speed_decay
	if move_speed < 0:
		_on_cleanup()

func _on_cleanup():
	SignalBus.drop_chip_pickup.emit(position, chip_drop)
	queue_free()
