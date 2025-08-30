class_name Player extends CharacterBody2D

@onready var hurtbox : HurtboxComponent = $HurtboxComponent
@onready var health : HealthComponent = $HealthComponent
@onready var cash_in_component : CashInComponent = $CashInComponent
@onready var thrower_component : ThrowerComponent = $ThrowerComponent

@export_category("Player Stats")
@export var base_health : int = 3
@export var move_speed : int = 100

var chip_strategies : Array[ChipStrategy] = []

func _ready():
	GameManager.player = self
	health.init(base_health)
	hurtbox.init(health)
	thrower_component.init(self)
	SignalBus.player_grant_power_up.connect(_add_chip_strategy)

func _process(delta):
	if InputManager.wants_throw():
		thrower_component.throw(chip_strategies)

func _process_cost(damage: int):
	var attack : Attack = Attack.new()
	attack.damage = damage
	health.take_damage(attack)

func _physics_process(delta):
	var input_vector = InputManager.movement_vector()
	velocity = input_vector * move_speed
	move_and_slide()

func _on_health_component_health_updated(new_current_health: int, previous_health: int):
	SignalBus.player_health_updated.emit(new_current_health, previous_health)

func _on_health_component_on_death():
	SignalBus.player_died.emit()

func _on_cash_in_component_try_cash_in(cost: int):
	var cash_in_survived : bool = health.current_health > cost
	
	_process_cost(cost)
	
	if cash_in_survived:
		SignalBus.player_cash_in.emit()

func _add_chip_strategy(strategy: ChipStrategy):
	chip_strategies.append(strategy)

func _on_thrower_component_process_chip_cost(cost):
	_process_cost(cost)
