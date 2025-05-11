class_name UnitController
extends Resource

signal finished;

var actions: Array[Action] = [];

func start(caster: Unit, origin: Vector2i):
	finished.emit();

func setup(_actions: Array[Action]) -> void:
	actions = _actions;
