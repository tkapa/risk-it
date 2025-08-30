class_name CashInComponent extends Node

signal try_cash_in(cost: int)

func _process(delta):
	if InputManager.wants_cash_in() && GameManager.cash_in_ready:
		try_cash_in.emit(GameManager.cash_in_cost)
