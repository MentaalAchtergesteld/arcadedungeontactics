class_name AttackAction
extends Action

@export var range: int = 3;
@export var damage: int = 1;

func name() -> String: return "Attack";
func effect() -> Effect: return Effect.Negative;


func get_tile_info(origin: Vector2i, target: Vector2i) -> Array[Vector2i]:
	var result: Array[Vector2i] = [];
	result.append(target);
	return result;

func is_in_range(origin: Vector2i, pos: Vector2i) -> bool:
	return origin.distance_to(pos) <= range;

func execute(
	caster: Unit,
	origin: Vector2i,
	target: Vector2i,
) -> void:
	if !is_in_range(origin, target): return;
	var target_unit = GameManager.units.get_unit_at_position(target);
	if target_unit == null: return;
	target_unit.health_component.damage(damage);
	
	finish();
