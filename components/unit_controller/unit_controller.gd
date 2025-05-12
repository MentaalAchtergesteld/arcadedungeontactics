class_name UnitController
extends Resource

signal finished;

var actions: Array[Action] = [];

func finish() -> void:
	call_deferred("emit_signal", "finished");

func start(caster: Unit, origin: Vector2i):
	finish();

func setup(_actions: Array[Action]) -> void:
	actions = _actions;
