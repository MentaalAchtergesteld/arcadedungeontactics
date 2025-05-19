class_name EffectDispatcher
extends Node2D

signal turn_started;

@export var hurtbox: HurtboxComponent;

@export var actor: Unit;

@export_group("Components")
@export var position_component: PositionComponent;
@export var health_component: HealthComponent;

var managers: Array[EffectManager] = [];

func _on_hurtbox_hurt(attacker: Node, effects: Array[EntityEffect]) -> void:
	for effect in effects:
		for manager in managers:
			if manager.try_apply(attacker, effect):
				break;

func _on_turn_start() -> void:
	turn_started.emit();

func setup_managers():
	for child in get_children():
		if child is EffectManager:
			managers.append(child);
			child.setup(self);

func _ready() -> void:
	hurtbox.hurt.connect(_on_hurtbox_hurt);
	actor.turn_started.connect(_on_turn_start);
	
	setup_managers();
