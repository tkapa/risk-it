class_name Player extends CharacterBody2D

@onready var hurtbox : HurtboxComponent = $HurtboxComponent
@onready var health : HealthComponent = $HealthComponent

@export_category("Player Stats")
@export var base_health : int = 3
@export var move_speed : int = 100

@export_category("Combat Variables")
@export var base_chip : PackedScene
@export var base_throw_strength : int = 100

var _cursor_dir : Vector2

func _ready():
	health.init(base_health)
	hurtbox.init(health)

func _input(event):
	if event is InputEventMouseMotion:
		_cursor_dir = position.direction_to(event.position).normalized()

func _process(delta):
	if Input.is_action_just_pressed("throw"):
		_throw()

func _throw():
	var chip : Chip = base_chip.instantiate()
	chip.position = position
	chip.scale = Vector2(0.75,0.75)
	chip.init(base_throw_strength, _cursor_dir)
	add_sibling(chip)
	
	var attack : Attack = Attack.new()
	health.set_max_health(health.max_health - 1)

func _physics_process(delta):
	var input_vector = _get_movement()
	velocity = input_vector * move_speed
	move_and_slide()

func _get_movement():
	var y = Input.get_axis("up", "down")
	var x = Input.get_axis("left", "right")
	
	return Vector2(x, y)

func _on_health_component_health_updated(new_current_health: int, new_max_health: int):
	print("Health Updated: Curr: ", new_current_health, " Max: ", new_max_health)

func _on_health_component_on_death():
	print("Player Died!")
