class_name ChipStrategy extends Resource

@export_category("Details")
@export var name : String
@export var description : String
@export var icon : Texture2D

@export_category("Values")
@export var value : int = 1
@export var cost : int = 1

func apply_strategy(chip: Chip):
	pass
