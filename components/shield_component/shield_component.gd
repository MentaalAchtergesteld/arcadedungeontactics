class_name ShieldComponent
extends Node

signal max_shield_changed(new_max_shield: int, amount: int);
signal shield_changed(new_shield: int, amount: int);
signal shield_depleted;

@export var current_shield: int = 3: set = _set_shield;
@export var max_shield: int = 3: set = _set_max_shield;

func _set_shield(new_shield: int) -> void:
	var real_new_shield = clamp(new_shield, 0, max_shield);
	if real_new_shield == current_shield: return;
	
	var change_amount = abs(real_new_shield - current_shield);
	current_shield = real_new_shield;
	
	shield_changed.emit(current_shield, change_amount);
	if current_shield == 0:
		shield_depleted.emit();

func _set_max_shield(new_max_shield: int) -> void:
	var real_new_max_shield = max(1, new_max_shield);
	if  real_new_max_shield == max_shield: return;
	
	var change_amount = abs(real_new_max_shield - max_shield);
	max_shield =  real_new_max_shield;
	
	max_shield_changed.emit(max_shield, change_amount);
	
	if current_shield > max_shield:
		current_shield = max_shield;

func absorb_damage(damage: int ) -> int:
	var absorbed = min(current_shield, damage);
	current_shield -= absorbed;
	return damage - absorbed;

func add_shield(amount: int) -> void:
	current_shield += amount;
