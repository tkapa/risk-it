class_name Chip extends CharacterBody2D

var direction : Vector2 = Vector2.UP
var move_speed : int = 100

var _speed_decay : int = 5

func init(_move_speed: int, _direction: Vector2):
	direction = _direction
	move_speed = _move_speed

func _physics_process(delta):
	velocity = direction * move_speed	
	move_and_slide()
	
	move_speed -= _speed_decay
	if move_speed < 0:
		queue_free()
