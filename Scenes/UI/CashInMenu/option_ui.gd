class_name OptionUI extends VBoxContainer

@onready var option_name : RichTextLabel = $OptionName
@onready var option_icon : TextureRect = $OptionIcon
@onready var description : RichTextLabel = $Description
@onready var button : Button = $AcceptButton

@export var cycle_textures : Array[Texture2D]

var option : ChipStrategy
var _is_rolling : bool = false
var max_rolls : int = 5
var curr_rolls : int = 0
var _roll_switch_timer : Timer = Timer.new()

func _ready():
	add_child(_roll_switch_timer)

	button.pressed.connect(_on_accept_pressed)
	_roll_switch_timer.timeout.connect(_on_roll_switch)

func init():
	option_name.text = option.name
	option_icon.texture = option.icon
	description.text = option.description
	button.show()

func _on_accept_pressed():
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.PLAYER_CASH_IN)
	SignalBus.player_grant_power_up.emit(option)

func _on_roll_switch():
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.PICKUP_GET)
	option_icon.texture = cycle_textures.pick_random()
	curr_rolls += 1
	
	if curr_rolls >= max_rolls:
		curr_rolls = 0
		init()
		_roll_switch_timer.stop()
		return
	
	var new_switch_time = randf_range(0.1, 0.5)
	_roll_switch_timer.start(new_switch_time)

func roll(_option: ChipStrategy):
	option = _option
	max_rolls = randi_range(3, 6)
	_is_rolling = true
	option_name.text = "[rainbow][shake]Rolling..."
	description.text = "[rainbow][shake]Deciding your fate..."
	button.hide()
	_on_roll_switch()
