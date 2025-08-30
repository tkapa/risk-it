class_name PierceChipStrategy extends ChipStrategy

func apply_strategy(chip: Chip):
	chip.maximum_hits += value
	#chip.chip_cost += cost
