class_name PickupBase extends Area2D

var move_to_player : bool = false
var move_speed : int = 100

func _init():
	self.body_entered.connect(_on_player_enter)

func _on_player_enter(body: Player):
	_on_pickup(body)
	queue_free()
	pass

func _on_pickup(player: Player):
	print("Player Picked Me Up!")
	pass

func set_move_to_player(set_value: bool):
	move_to_player = set_value

func _process(delta):
	if !move_to_player:
		return
	
	var player_position : Vector2 = GameManager.player.position
	var dir = position.direction_to(player_position)
	
	position += dir * move_speed * delta
