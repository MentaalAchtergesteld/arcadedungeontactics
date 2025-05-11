class_name HealAction
extends Action

@export var range: int = 3;

func get_tile_info(caster: Unit, origin: Vector2i) -> Array[TileInfo]:
	var result: Array[TileInfo] = [];
	var friendlies = GameManager.units.get_friendles(caster);
	var positions = friendlies.map(func(unit): return unit.grid_position);
	
	for x in range(-range, range+1):
		for y in range(-range, range+1):
			if abs(x) + abs(y) > range: continue;
			var position = origin + Vector2i(x, y);
			if !positions.has(position): continue;
			
			result.append(TileInfo.create(position, TileInfo.RoleType.Clickable, TileInfo.EffectType.Negative));
			result.append(TileInfo.create(position, TileInfo.RoleType.Affected, TileInfo.EffectType.Negative));
	
	return result;


func execute(
	caster: Unit,
	origin: Vector2i,
	target: Vector2i,
) -> void:
	var target_unit = GameManager.units.get_unit_at_position(target);
	if target_unit == null: return;
	target_unit.health_component.h(1);
	
	finished.emit();
