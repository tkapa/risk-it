class_name DamageChipStrategy extends ChipStrategy

func apply_strategy(chip: Chip):
	chip.damage += value
	#chip.chip_cost += cost
