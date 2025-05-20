class_name PoisonDartAction;
extends Action

@export var range: int = 5;
@export var damage: int = 1;

func name() -> String: return "Poison Dart";
func effect() -> Effect: return Effect.Negative;

var cached_origin: Vector2i;
var cached_valid_tiles: Array[Vector2i] = [];

func get_valid_target_tiles(caster: Unit, origin: Vector2i) -> Array[Vector2i]:
	if origin != cached_origin:
		cached_origin = origin;
		var diamond = GridUtils.get_tiles_in_diamond(origin, range);
		cached_valid_tiles = diamond.filter(func(pos): return !Navigation.is_tile_solid(pos));
	
	return cached_valid_tiles;

func get_effect_tiles(caster: Unit, origin: Vector2i, target: Vector2i) -> Array[Vector2i]:
	return [target];

func clear_cache() -> void:
	cached_origin = Vector2i(-99999, -99999);
	cached_valid_tiles.clear();

func execute(caster: Unit, origin: Vector2i, target: Vector2i) -> void:
	
	var dart_position = Navigation.map_to_world(origin);
	var world_target = Navigation.map_to_world(target);
	var dart = PoisonDart.create(dart_position, world_target);
	GameManager.map_objects.add_child(dart);
	
	await dart.finished;
	
	clear_cache();
	executed.emit.call_deferred();
