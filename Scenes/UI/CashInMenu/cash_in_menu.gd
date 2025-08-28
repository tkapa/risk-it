class_name CashInMenu extends Control

@onready var option_ui_1 : OptionUI = %Option1
@onready var option_ui_2 : OptionUI = %Option2
@onready var option_ui_3 : OptionUI = %Option3

@export var power_ups : Array[ChipStrategy] = []

func _ready():
	SignalBus.player_cash_in.connect(_on_player_cash_in)
	SignalBus.player_grant_power_up.connect(_on_grant_power_up)
	visibility_changed.connect(_on_visibility_changed)
	
func _on_player_cash_in():
	SignalBus.pause_game.emit(self)

func _on_grant_power_up(s: ChipStrategy):
	SignalBus.unpause_game.emit()

func _on_visibility_changed():
	_roll_option(option_ui_1)
	_roll_option(option_ui_2)
	_roll_option(option_ui_3)
	option_ui_1.button.grab_focus()

func _roll_option(ui: OptionUI):
	ui.init(power_ups.pick_random())
