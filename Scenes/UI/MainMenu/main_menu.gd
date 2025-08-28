class_name MainMenu extends Control

@onready var main_buttons : VBoxContainer = $CenterContainer/MainButtons
@onready var settings : VBoxContainer = $CenterContainer/SettingsMenu
@onready var credits : VBoxContainer = $CenterContainer/CreditsMenu
@onready var fullscreen_button : Button = $CenterContainer/SettingsMenu/FullscreenButton
@onready var play_button : Button = $CenterContainer/MainButtons/PlayButton

@onready var main_vol_slider = %MainVolSlider
@onready var music_volume_slider = %MusicVolumeSlider
@onready var sfx_volume_slider = %SFXVolumeSlider

var main_game_scene : PackedScene = preload("res://Scenes/main.tscn")

func _ready():
	fullscreen_button.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	main_vol_slider.value = _get_audio_bus_volume("Master")
	music_volume_slider.value = _get_audio_bus_volume("MUSIC")
	sfx_volume_slider.value = _get_audio_bus_volume("SFX")
	play_button.grab_focus()

func _on_play_button_pressed():
	SignalBus.start_game.emit()

func _on_settings_button_pressed():
	main_buttons.visible = false
	settings.visible = true
	fullscreen_button.grab_focus()
	

func _on_credits_button_pressed():
	main_buttons.visible = false
	credits.visible = true
	$CenterContainer/CreditsMenu/BackButton.grab_focus()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_back_button_pressed():
	main_buttons.visible = true
	settings.visible = false
	credits.visible = false
	play_button.grab_focus()

func _on_fullscreen_button_toggled(toggled_on: bool):
	var window_mode = DisplayServer.WINDOW_MODE_MAXIMIZED
		
	if toggled_on:
		window_mode = DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	
	DisplayServer.window_set_mode(window_mode)

func _on_main_vol_slider_value_changed(value):
	_set_audio_bus_volume("Master", value)
		
func _on_music_volume_slider_value_changed(value):
	_set_audio_bus_volume("MUSIC", value)
	
func _on_sfx_volume_slider_value_changed(value):
	_set_audio_bus_volume("SFX", value)

func _set_audio_bus_volume(name: String, value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(name), value)

func _get_audio_bus_volume(name: String) -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(name)))
