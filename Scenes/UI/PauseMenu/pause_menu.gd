class_name PauseMenu extends Control

@onready var resume_button : Button = %ResumeButton
@onready var quit_button : Button = %QuitButton

func _ready():
	visibility_changed.connect(_on_show)

func _process(delta):
	if InputManager.wants_pause():
		if PauseManager.is_paused: 
			SignalBus.unpause_game.emit()
		else:
			SignalBus.pause_game.emit(self)

func _on_resume_button_pressed():
	SignalBus.unpause_game.emit()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_show():
	resume_button.grab_focus()
