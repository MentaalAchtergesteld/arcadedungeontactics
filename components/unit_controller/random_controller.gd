class_name RandomController
extends UnitController

func start(caster: Unit, origin: Vector2i) -> void:
	
	if actions.is_empty(): return finish();
	var action: Action = actions.pick_random();
	
	action.execute(caster, origin, Vector2i(0, 0));
	await action.finished;
	
	finish();
