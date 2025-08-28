class_name MagnetComponent extends Area2D

func _init():
	self.area_entered.connect(_on_pickup_enter)

func _on_pickup_enter(area: PickupBase):
	area.set_move_to_player(true)
	pass
