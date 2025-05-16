class_name RandomController
extends UnitController

func start(caster: Unit, origin: Vector2i) -> void:
	if actions.is_empty():
		finished.emit();
		return;
	
	var action: Action = actions.pick_random();
	
	var tiles = action.get_tile_info(origin, origin);
	
	
	#action.execute(caster, origin, random_clickable.position);
	await action.finished;
	
	finish();
