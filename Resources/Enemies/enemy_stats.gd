class_name EnemyStats extends Resource

@export var name : String = "Enemy"
@export var max_health : int = 1
@export var move_speed : int = 10

func move(parent: CharacterBody2D, player_position: Vector2, delta: float):
	var direction = parent.position.direction_to(player_position).normalized()
	parent.velocity = direction * move_speed
	parent.move_and_slide()
