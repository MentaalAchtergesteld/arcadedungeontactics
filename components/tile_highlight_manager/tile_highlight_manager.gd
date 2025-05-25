class_name  TileHighlighter
extends Node2D

@export var area_texture: Texture2D;
@export var primary_texture: Texture2D;

@export_group("Colors")

static var NEUTRAL: Color = Color.ROYAL_BLUE;
static var POSITIVE: Color = Color.LIME_GREEN;
static var NEGATIVE: Color = Color.BROWN;
static var RANGE: Color = Color.DIM_GRAY;

static func action_effect_to_color(effect: Action.Effect) -> Color:
	match effect:
		Action.Effect.Neutral: return NEUTRAL;
		Action.Effect.Positive: return POSITIVE;
		Action.Effect.Negative: return NEGATIVE;
		_: return NEUTRAL;

var highlights: Dictionary[Vector2i, Sprite2D] = {};

func create_highlight(pos: Vector2i, color: Color, is_primary: bool = false) -> Sprite2D:
	var sprite = Sprite2D.new()
	sprite.texture = primary_texture if is_primary else area_texture;
	sprite.self_modulate = color;
	
	sprite.global_position = Navigation.map_to_world(pos);
	
	return sprite;

func remove_highlight(pos: Vector2i) -> void:
	if highlights.has(pos):
		var highlight = highlights.get(pos);
		highlight.queue_free()
		highlights.erase(pos);

func add_highlight(pos: Vector2i, color: Color, is_primary: bool = false) -> void:
	remove_highlight(pos);
	var highlight = create_highlight(pos, color, is_primary);
	highlights.set(pos, highlight);
	add_child(highlight);

func clear_all_highlights() -> void:
	for pos in highlights.keys():
		remove_highlight(pos);

func clear_area_highlights(area: Array[Vector2i]) -> void:
	for pos in area:
		remove_highlight(pos);

func clear_radius_highlights(center: Vector2i, radius: int, color: Color) -> void:
	remove_highlight(center);
	
	for dx in range(-radius, radius+1):
		for dy in range(-radius, radius+1):
			var pos = Vector2i(dx, dy);
			if pos.length() <= radius:
				remove_highlight(center + pos);

func highlight_area(area: Array[Vector2i], color: Color) -> void:
	for pos in area:
		add_highlight(pos, color);

func highlight_radius(center: Vector2i, radius: int, color: Color) -> void:
	for dx in range(-radius, radius+1):
		for dy in range(-radius, radius+1):
			var pos = Vector2i(dx, dy);
			if pos.length() <= radius:
				add_highlight(center + pos, color);

func _ready() -> void:
	EventBus.highlight_area.connect(highlight_area);
	EventBus.highlight_radius.connect(highlight_radius);
	
	EventBus.clear_area_highlights.connect(clear_area_highlights);
	EventBus.clear_radius_highlights.connect(clear_radius_highlights);
	EventBus.clear_all_highlights.connect(clear_all_highlights);
