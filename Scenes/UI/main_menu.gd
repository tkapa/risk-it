class_name MainMenu extends Control

@onready var main_buttons : VBoxContainer = $CenterContainer/MainButtons
@onready var settings : VBoxContainer = $CenterContainer/SettingsMenu
@onready var credits : VBoxContainer = $CenterContainer/CreditsMenu

var main_game_scene : PackedScene = preload("res://Scenes/main.tscn")

func _on_play_button_pressed():
	var level_name = "main"
	var level = str("res://Scenes/", level_name, ".tscn")
	get_tree().change_scene_to_file(level)

func _on_settings_button_pressed():
	main_buttons.visible = false
	settings.visible = true

func _on_credits_button_pressed():
	main_buttons.visible = false
	credits.visible = true

func _on_quit_button_pressed():
	get_tree().quit()

func _on_back_button_pressed():
	main_buttons.visible = true
	settings.visible = false
	credits.visible = false
