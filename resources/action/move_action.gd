class_name MoveAction
extends Action

@export var range: int = 3;

func name() -> String: return "Move";

func get_tile_info(origin: Vector2i, target: Vector2i) -> Array[TileInfo]:
	var result: Array[TileInfo] = [];
	
	#for x in range(-range, range+1):
	#	for y in range(-range, range+1):
	#		if abs(x) + abs(y) > range: continue;
	#		var position = origin + Vector2i(x, y);
	#		if !Navigation.can_move_to(origin, position, range): continue;
	#		
	#		result.append(TileInfo.create(position, TileInfo.RoleType.Clickable, TileInfo.EffectType.Neutral));
	#		result.append(TileInfo.create(position, TileInfo.RoleType.Affected, TileInfo.EffectType.Neutral));
	#
	#return result;
	
	var path = Navigation.calculate_path(origin, target, range);
	if path.is_empty(): return result;
	
	for pos in path:
		result.append(TileInfo.create(pos, TileInfo.RoleType.Affected, TileInfo.EffectType.Neutral));
	
	result.append(TileInfo.create(origin, TileInfo.RoleType.Clickable, TileInfo.EffectType.Neutral));
	return result;

func execute(
	caster: Unit,
	origin: Vector2i,
	target: Vector2i,
) -> void:
	var path = Navigation.calculate_path(origin, target, range);
	if path.is_empty(): push_warning("No path found to: " + str(target) + ", from: " + str(origin)); 
	caster.position_component.move_along_absolute_path(path);
	finish();
