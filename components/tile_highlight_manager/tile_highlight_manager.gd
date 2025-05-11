class_name  TileHighlightManager
extends Node2D

signal tile_clicked(position: Vector2i);

var clickable_tiles: Array[Vector2i];

func highlight_tiles(tiles: Array[TileInfo]) -> void:
	for tile_info in tiles:
		if tile_info.role == TileInfo.RoleType.Clickable:
			clickable_tiles.append(tile_info.position);
		add_child(TileHighlight.create(tile_info, Navigation.tile_size));

func clear_highlights() -> void:
	clickable_tiles.clear();
	for child in get_children():
		remove_child(child);

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		var pos = Navigation.world_to_map(get_global_mouse_position());
		if clickable_tiles.has(pos):
			tile_clicked.emit(pos);
			EventBus.tile_clicked.emit(pos);

func _ready() -> void:
	EventBus.highlight_tiles.connect(highlight_tiles);
	EventBus.clear_highlights.connect(clear_highlights);
