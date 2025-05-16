class_name UnitController
extends Resource

signal finished;

var actions: Array[Action] = [];

func finish() -> void:
	finished.emit.call_deferred();

func start(caster: Unit, origin: Vector2i):
	finish();

func setup(_actions: Array[Action]) -> void:
	actions = _actions;
