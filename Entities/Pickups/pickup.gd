class_name PickupBase extends Area2D

func _init():
	self.body_entered.connect(_on_player_enter)

func _on_player_enter(body: Player):
	_on_pickup(body)
	queue_free()
	pass

func _on_pickup(player: Player):
	print("Player Picked Me Up!")
	pass
