class_name TileHighlight
extends Node2D

@onready var sprite: Sprite2D = $Sprite2D;

@export var neutral_affected: Texture2D;
@export var neutral_clickable: Texture2D;

@export var negative_affected: Texture2D;
@export var negative_clickable: Texture2D;

@export var positive_affected: Texture2D;
@export var positive_clickable: Texture2D;


var size: Vector2 = Vector2(16, 16);
var info: TileInfo;

func set_sprite() -> void:
	if info == null:
		sprite.texture = null;
		return;
	
	match info.effect:
		TileInfo.EffectType.Neutral:
			if info.role == TileInfo.RoleType.Clickable:
				sprite.texture = neutral_clickable;
			else:
				sprite.texture = neutral_affected;
		TileInfo.EffectType.Negative:
			if info.role == TileInfo.RoleType.Clickable:
				sprite.texture = negative_clickable;
			else:
				sprite.texture = negative_affected;
		TileInfo.EffectType.Positive:
			if info.role == TileInfo.RoleType.Clickable:
				sprite.texture = positive_clickable;
			else:
				sprite.texture = positive_affected;
	
	if info.role == TileInfo.RoleType.Clickable:
		sprite.self_modulate.a = 1.;
	else:
		sprite.self_modulate.a = .75;
	
	sprite.scale = size / sprite.texture.get_size()

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
