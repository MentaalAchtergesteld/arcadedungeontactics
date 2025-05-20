class_name HealthComponent
extends Node

signal max_health_changed(new_max_health: int, amount: int);
signal health_changed(new_health: int, amount: int);
signal healed(new_health: int, amount: int);
signal damaged(new_health: int, amount: int);
signal health_depleted;

@export var current_health: int = 3: set = set_health;
@export var max_health: float = 3: set = set_max_health;

func set_health(new_health: int) -> void:
	new_health = clamp(new_health, 0, max_health);
	if new_health == current_health: return;
	
	var change_amount = abs(new_health - current_health);
	current_health = new_health;
	
	health_changed.emit(current_health, change_amount);
	if new_health > current_health:
		healed.emit(current_health, change_amount);
	elif new_health < current_health:
		damaged.emit(current_health, change_amount);
	
	if current_health == 0:
		health_depleted.emit();

func set_max_health(new_max_health: int) -> void:
	new_max_health = max(1, new_max_health);
	if new_max_health == max_health: return;
	
	var change_amount = abs(new_max_health - max_health);
	max_health = new_max_health;
	
	max_health_changed.emit(max_health, change_amount);
	
	if current_health > max_health:
		current_health = max_health;

func heal(amount: int) -> void:
	current_health += amount;

func damage(amount: int) -> void:
	current_health -= amount;
