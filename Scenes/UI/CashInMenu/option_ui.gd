class_name OptionUI extends VBoxContainer

@onready var option_name : Label = $OptionName
@onready var option_icon : TextureRect = $OptionIcon
@onready var description : Label = $Description
@onready var button : Button = $AcceptButton

var option : ChipStrategy

func _ready():
	button.pressed.connect(_on_accept_pressed)

func init(_option: ChipStrategy):
	option = _option
	option_name.text = option.name
	option_icon.texture = option.icon
	description.text = option.description

func _on_accept_pressed():
	SignalBus.player_grant_power_up.emit(option)
