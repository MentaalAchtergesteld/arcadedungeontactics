class_name IcicleAction;
extends Action

@export var range: int = 3;
@export var damage: int = 1;

func name() -> String: return "Icicle";
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
	
	var icicle_position = Navigation.map_to_world(target) + Vector2(0, Navigation.tile_size.y / 2);
	var icicle = Icicle.create(icicle_position);
	GameManager.map_objects.add_child(icicle);
	await icicle.hit;
	
	clear_cache();
	executed.emit.call_deferred();
