class_name MoveAction
extends Action

@export var range: int = 3;

func name() -> String: return "Move";
func effect() -> Effect: return Effect.Neutral;

func get_tile_info(origin: Vector2i, target: Vector2i) -> Array[Vector2i]:
	var path: PackedVector2Array = Navigation.calculate_path(origin, target, range)
	var result: Array[Vector2i] = [];
	for v in path:
		result.append(v as Vector2i)
	return result

func is_in_range(origin: Vector2i, pos: Vector2i) -> bool:
	return origin.distance_to(pos) <= range;

func execute(
	caster: Unit,
	origin: Vector2i,
	target: Vector2i,
) -> void:
	var path = Navigation.calculate_path(origin, target, range);
	if path.is_empty(): push_warning("No path found to: " + str(target) + ", from: " + str(origin)); 
	caster.position_component.move_along_absolute_path(path);
	finish();
