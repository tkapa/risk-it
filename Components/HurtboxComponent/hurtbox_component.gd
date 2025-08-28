class_name HurtboxComponent extends Area2D

var health_component: HealthComponent

func init(_health_component: HealthComponent):
	health_component = _health_component

func _on_area_entered(area: HitboxComponent):
	var attack = Attack.new()
	attack.damage = area.damage
	area.hit.emit()

	health_component.take_damage(attack)
