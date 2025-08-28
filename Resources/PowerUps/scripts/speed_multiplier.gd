class_name SpeedChipStrategy extends ChipStrategy

func apply_strategy(chip: Chip):
	chip.move_speed += value
	chip.chip_cost += cost
