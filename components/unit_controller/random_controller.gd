class_name RandomController
extends UnitController

func start(caster: Unit, origin: Vector2i) -> void:
	if actions.is_empty():
		finished.emit();
		return;
	
	var action: Action = actions.pick_random();
	
	var tiles = action.get_tile_info(caster, origin);
	
	var clickables = tiles.filter(func(tile: TileInfo): return tile.role == TileInfo.RoleType.Clickable);
	if clickables.is_empty():
		finish();
		return;
	
	var random_clickable = clickables.pick_random();
	
	action.execute(caster, origin, random_clickable.position);
	await action.finished;
	
	finish();
