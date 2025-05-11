class_name TileInfo
extends RefCounted

enum RoleType { Clickable, Affected };
enum EffectType { Neutral, Positive, Negative };

var position: Vector2i;
var role: RoleType;
var effect: EffectType;

@warning_ignore("shadowed_variable")
static func create(position: Vector2i, role: RoleType, effect: EffectType) -> TileInfo:
	var tile_info = TileInfo.new();
	tile_info.position = position;
	tile_info.role = role;
	tile_info.effect = effect;
	return tile_info;
