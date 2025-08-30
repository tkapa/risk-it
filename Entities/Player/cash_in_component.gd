class_name CashInComponent extends Node

signal try_cash_in(cost: int)

func _process(_delta):
	if InputManager.wants_cash_in() && GameManager.cash_in_ready:
		AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.PLAYER_CASH_IN)
		try_cash_in.emit(GameManager.cash_in_cost)
