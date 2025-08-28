class_name OptionUI extends VBoxContainer

@onready var option_name : Label = $OptionName
@onready var description : Label = $Description
@onready var button : Button = $AcceptButton

var option : ChipStrategy

func init(_option: ChipStrategy):
	option = _option
	option_name.text = option.name
	description.text = option.description
	button.pressed.connect(_on_accept_pressed)

func _on_accept_pressed():
	SignalBus.player_grant_power_up.emit(option)
