class_name TileHighlight
extends Node2D

@onready var sprite: Sprite2D = $Sprite2D;

@export var neutral_texture: Texture2D;
@export var negative_texture: Texture2D;
@export var positive_texture: Texture2D;

var size: Vector2 = Vector2(16, 16);
var info: TileInfo;

func set_sprite() -> void:
	if info == null:
		sprite.texture = null;
		return;
	
	match info.effect:
		TileInfo.EffectType.Neutral:
			sprite.texture = neutral_texture;
		TileInfo.EffectType.Negative:
			sprite.texture = negative_texture;
		TileInfo.EffectType.Positive:
			sprite.texture = positive_texture;
	
	sprite.scale = size / sprite.texture.get_size()
	
	match info.role:
		TileInfo.RoleType.Clickable:
			sprite.self_modulate.v = .75;
			z_index = 1;
		TileInfo.RoleType.Affected:
			sprite.self_modulate.v = 1;
			z_index = 0;

func _ready() -> void:
	if info == null: return;
	set_sprite();
	global_position = Navigation.map_to_world(info.position);

const TILE_HIGHLIGHT = preload("res://entities/tile_highlight/tile_highlight.tscn")
static func create(tile_info: TileInfo, tile_size: Vector2) -> TileHighlight:
	var tile_highlight: TileHighlight = TILE_HIGHLIGHT.instantiate();
	tile_highlight.size = tile_size;
	tile_highlight.info = tile_info;
	return tile_highlight;
