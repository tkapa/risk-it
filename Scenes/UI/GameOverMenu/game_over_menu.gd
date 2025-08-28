class_name GameOverMenu extends Control

@onready var resume_button : Button = %RestartButton
@onready var quit_button : Button = %QuitButton

func _ready(): 
	SignalBus.player_died.connect(_on_player_died)
	visibility_changed.connect(_on_visible)

func _on_player_died():
	SignalBus.pause_game.emit(self)

func _on_visible():
	resume_button.grab_focus()

func _on_restart_button_pressed():
	SignalBus.unpause_game.emit()
	SignalBus.start_game.emit()

func _on_quit_button_pressed():
	SignalBus.unpause_game.emit()
	get_tree().quit()
