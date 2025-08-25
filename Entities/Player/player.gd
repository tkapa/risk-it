class_name Player extends CharacterBody2D

@export var move_speed : int = 100

func _physics_process(delta):
	var input_vector = _get_movement()
	
	velocity = input_vector * move_speed
	
	move_and_slide()

func _get_movement():
	var y = Input.get_axis("up", "down")
	var x = Input.get_axis("left", "right")
	
	return Vector2(x, y)
