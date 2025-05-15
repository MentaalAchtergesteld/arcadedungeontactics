class_name  TileHighlighter
extends Node2D

@export var area_texture: Texture2D;
@export var primary_texture: Texture2D;

@export_group("Colors")

static var NEUTRAL: Color = Color.ROYAL_BLUE;
static var POSITIVE: Color = Color.LIME_GREEN;
static var NEGATIVE: Color = Color.BROWN;
static var RANGE: Color = Color.DIM_GRAY;

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

func clear_area_highlight(area: Array[Vector2i]) -> void:
	for pos in area:
		remove_highlight(pos);

func highlight_area(primary: Vector2i, area: Array[Vector2i], color: Color) -> void:
	add_highlight(primary, color, true);
	
	for pos in area:
		if pos == primary: continue;
		add_highlight(pos, color);

func _ready() -> void:
	EventBus.highlight_area.connect(highlight_area);
	EventBus.clear_area_highlight.connect(clear_area_highlight);
	EventBus.clear_highlights.connect(clear_all_highlights);
