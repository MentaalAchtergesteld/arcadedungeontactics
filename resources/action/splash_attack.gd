class_name SplashAttackAction
extends Action

@export var range: int = 3;
@export var damage: int = 3;
@export var splash_radius: int = 1:
	set(value): splash_radius = max(0, value);
@export var damage_falloff: Curve = Curve.new();

func name() -> String: return "Splash Attack";

func generate_splash_positions(origin: Vector2i) -> Array[Vector2i]:
	var positions: Array[Vector2i] = [];
	
	for x in range(-splash_radius, splash_radius+1):
		for y in range(-splash_radius, splash_radius+1):
			if abs(x) + abs(y) > splash_radius: continue;
			positions.append(origin + Vector2i(x, y));
	
	return positions;

func get_tile_info(origin: Vector2i, target: Vector2i) -> Array[Vector2i]:
	var result: Array[Vector2i] = [];
	
	if origin.distance_to(target) > range: return result;
	#var positions = enemies.map(func(unit): return unit.grid_position);
	
	#for position in positions:
	#	var relative = position - origin;
	#	if abs(relative.x) + abs(relative.y) > range: continue;
	#	
	#	for splash_position in generate_splash_positions(position):
	#		var role: TileInfo.RoleType;
	#		if splash_position == position:
	#			role = TileInfo.RoleType.Clickable;
	#		else:
	#			role = TileInfo.RoleType.Affected;
	#		
	#		result[splash_position] = TileInfo.create(splash_position, role, TileInfo.EffectType.Negative);
	
	for x in range(-splash_radius, splash_radius+1):
		for y in range(-splash_radius, splash_radius+1):
			result.append(Vector2i(x, y)+target);
	
	#result.append(TileInfo.create(target, TileInfo.RoleType.Clickable, TileInfo.EffectType.Negative));
	
	return result;


func execute(
	caster: Unit,
	origin: Vector2i,
	target: Vector2i,
) -> void:
	for position in generate_splash_positions(target):
		var target_unit = GameManager.units.get_unit_at_position(position);
		if target_unit == null: continue;
		
		var distance = clamp(target.distance_to(position)/splash_radius, 0, 1);
		var actual_damage = floor(damage_falloff.sample(distance) * damage);
		target_unit.health_component.damage(actual_damage);
	
	finish();
