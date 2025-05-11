class_name RandomController
extends UnitController

func start(caster: Unit, origin: Vector2i, actions: Array[Action]) -> void:
	var action: Action = actions.pick_random();
	if action == null:
		finished.emit();
		return; 
	print("Action chosen: " + str(action.script.get_path()));
	
	var tiles = action.get_tile_info(caster, origin);
	var clickables = tiles.filter(func(tile: TileInfo): return tile.role == TileInfo.RoleType.Clickable);
	if clickables.is_empty():
		finished.emit();
		return;
	var random_clickable = clickables.pick_random();
	action.execute(caster, origin, random_clickable.position);
	
	finished.emit();
