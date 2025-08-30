class_name ThrowerComponent extends Node2D

signal process_chip_cost(cost : int)

@onready var aim_component : Node2D = $AimComponent

@export_category("Combat Variables")
@export var base_chip : PackedScene
@export var base_throw_strength : int = 200

var _cursor_dir : Vector2
var _parent : CharacterBody2D

func init(parent: CharacterBody2D):
	_parent = parent

func _process(_delta):
	if InputManager.using_controller:
		_cursor_dir = InputManager.look_vector()
	else:
		var _cursor_pos = InputManager.cursor_position()
		_cursor_dir = global_position.direction_to(_cursor_pos)
	
	rotation = _cursor_dir.angle()

func throw(strategies: Array[ChipStrategy]):
	var chip : Chip = _setup_chip(strategies)
	process_chip_cost.emit(chip.chip_cost)
	_parent.add_sibling(chip)
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.PLAYER_THROW)

func _setup_chip(strategies: Array[ChipStrategy]) -> Chip:
	var chip : Chip = base_chip.instantiate()
	chip.position = _parent.position
	chip.scale = Vector2(0.75,0.75)
	chip.init(base_throw_strength, _cursor_dir)
	
	for strat in strategies:
		strat.apply_strategy(chip)
	return chip
