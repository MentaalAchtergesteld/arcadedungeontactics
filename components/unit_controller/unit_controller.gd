class_name UnitController
extends Resource

signal finished;

func start(caster: Unit, origin: Vector2i, actions: Array[Action]):
	finished.emit();
