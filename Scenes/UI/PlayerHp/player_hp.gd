class_name PlayerHPUI extends HBoxContainer

@onready var hp_label : RichTextLabel = $Label
@onready var hp_icon : AnimatedSprite2D = $HPIcon

const RAINBOW : String = "[rainbow]"
const SHAKE : String = "[shake]"

var _hp_value : String

func _init():
	SignalBus.player_cash_in.connect(_cash_in_not_ready)
	SignalBus.player_health_updated.connect(_on_player_health_updated)
	
func _on_player_health_updated(new_current: int, previous_health : int):
	_hp_value = str(new_current)
	var val = _hp_value
	
	if GameManager.cash_in_ready:
		val = str(RAINBOW, SHAKE, _hp_value)
		hp_icon.play("ready")
	else:
		_cash_in_not_ready()
	
	hp_label.text = val

func _cash_in_not_ready():
	hp_label.text = _hp_value
	hp_icon.play("default")
