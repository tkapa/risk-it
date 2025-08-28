class_name Player extends CharacterBody2D

@onready var hurtbox : HurtboxComponent = $HurtboxComponent
@onready var health : HealthComponent = $HealthComponent

@export_category("Player Stats")
@export var base_health : int = 3
@export var move_speed : int = 100

@export_category("Combat Variables")
@export var base_chip : PackedScene
@export var base_throw_strength : int = 200

@export var chip_strategies : Array[ChipStrategy] = []
var _cursor_dir : Vector2

func _ready():
	GameManager.player = self
	health.init(base_health)
	hurtbox.init(health)
	SignalBus.player_grant_power_up.connect(_add_chip_strategy)

func _input(event):
	if event is InputEventMouseMotion:
		var camera = get_viewport().get_camera_2d()
		var cursor = camera.get_global_mouse_position()
		_cursor_dir = global_position.direction_to(cursor)

func _process(delta):
	if Input.is_action_just_pressed("throw"):
		_throw()
	if Input.is_action_just_pressed("cash_in"):
		SignalBus.player_cash_in.emit()

func _throw():
	var chip : Chip = _setup_chip()
	add_sibling(chip)
	
	var attack : Attack = Attack.new()
	attack.damage = chip.chip_cost
	health.take_damage(attack)

func _physics_process(delta):
	var input_vector = _get_movement()
	velocity = input_vector * move_speed
	move_and_slide()

func _get_movement():
	var y = Input.get_axis("up", "down")
	var x = Input.get_axis("left", "right")
	
	return Vector2(x, y)

func _on_health_component_health_updated(new_current_health: int, previous_health: int):
	print("Health Updated: Curr: ", new_current_health, " Previous: ", previous_health)
	SignalBus.player_health_updated.emit(new_current_health, previous_health)

func _on_health_component_on_death():
	print("Player Died!")
	SignalBus.player_died.emit()

func _setup_chip() -> Chip:
	var chip : Chip = base_chip.instantiate()
	chip.position = position
	chip.scale = Vector2(0.75,0.75)
	chip.init(base_throw_strength, _cursor_dir)
	
	for strat in chip_strategies:
		strat.apply_strategy(chip)
	
	return chip

func _add_chip_strategy(strategy: ChipStrategy):
	chip_strategies.append(strategy)
