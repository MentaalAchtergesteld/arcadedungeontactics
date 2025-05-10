class_name MoveAction
extends Action

@export var range: int = 3;

func get_tile_info(origin: Vector2i) -> Array[TileInfo]:
	var result: Array[TileInfo] = [];
	
	for x in range(-range, range+1):
		for y in range(-range, range+1):
			if abs(x) + abs(y) > range: continue;
			var position = origin + Vector2i(x, y);
			if !Navigation.can_move_to(origin, position): continue;
			
			result.append(TileInfo.create(position, TileInfo.RoleType.Clickable, TileInfo.EffectType.Neutal));
			result.append(TileInfo.create(position, TileInfo.RoleType.Affected, TileInfo.EffectType.Neutal));
	
	return result;


func execute(
	caster: Unit,
	origin: Vector2i,
	target: Vector2i,
	units: UnitTeamContainer,
	tilemap: TileMapLayer,
) -> void:
	if units.get_unit_at_position(target): return;
	
	finished.emit();
