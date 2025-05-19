class_name EffectManager
extends Node2D

var dispatcher: EffectDispatcher;

func _on_turn_start() -> void:
	pass;

func _on_setup() -> void:
	pass;

func try_apply(attacker: Node, effect: EntityEffect) -> bool:
	if dispatcher == null: return false;
	return false;

func setup(_dispatcher: EffectDispatcher) -> void:
	dispatcher = _dispatcher;
	dispatcher.turn_started.connect(_on_turn_start);
	
	_on_setup();
