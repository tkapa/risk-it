class_name Chip extends CharacterBody2D

@export var chip_pickup : PackedScene

var direction : Vector2 = Vector2.UP
var move_speed : int = 100

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
	var chip_pickup : PickupBase = chip_pickup.instantiate()
	chip_pickup.position = position
	add_sibling(chip_pickup)
	queue_free()
