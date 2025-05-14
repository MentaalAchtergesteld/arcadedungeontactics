class_name AttackAction
extends Action

@export var range: int = 3;
@export var damage: int = 1;

func name() -> String: return "Attack";

func get_tile_info(origin: Vector2i, target: Vector2i) -> Array[TileInfo]:
	var result: Array[TileInfo] = [];
	
	result.append(TileInfo.create(target, TileInfo.RoleType.Clickable, TileInfo.EffectType.Negative))
	result.append(TileInfo.create(target, TileInfo.RoleType.Affected, TileInfo.EffectType.Negative))
	
	return result;


func execute(
	caster: Unit,
	origin: Vector2i,
	target: Vector2i,
) -> void:
	var target_unit = GameManager.units.get_unit_at_position(target);
	if target_unit == null: return;
	target_unit.health_component.damage(damage);
	
	finish();
