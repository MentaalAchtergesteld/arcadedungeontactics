class_name MoveAction;
extends Action

@export var range: int = 3;

func name() -> String: return "Move";
func effect() -> Effect: return Effect.Neutral;

var cached_origin: Vector2i;
var cached_valid_tiles: Array[Vector2i] = [];

func get_valid_target_tiles(caster: Unit, origin: Vector2i) -> Array[Vector2i]:
	if origin != cached_origin:
		cached_origin = origin;
		var diamond = GridUtils.get_tiles_in_diamond(origin, range);
		cached_valid_tiles = diamond.filter(func(pos): return Navigation.can_move_to(origin, pos, range));
	
	return cached_valid_tiles;

var cached_paths: Dictionary = {};
 
func get_effect_tiles(caster: Unit, origin: Vector2i, target: Vector2i) -> Array[Vector2i]:
	var key = str(origin) + "|" + str(target);
	if not cached_paths.has(key):
		cached_paths[key] = Navigation.calculate_path(origin, target, range);
	return cached_paths[key];

func clear_cache() -> void:
	cached_origin = Vector2i(-99999, -99999);
	cached_valid_tiles.clear();
	cached_paths.clear();

func execute(caster: Unit, origin: Vector2i, target: Vector2i) -> void:
	var path = Navigation.calculate_path(origin, target, range);
	caster.position_component.move_along_absolute_path(path);
	await caster.position_component.movement_finished;
	
	clear_cache();
	executed.emit.call_deferred();
