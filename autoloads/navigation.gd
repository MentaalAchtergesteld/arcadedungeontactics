extends Node

signal tilemap_changed;

var tilemap: TileMapLayer;
var cell_size: Vector2 = Vector2.ONE;

func setup_level(_tilemap: TileMapLayer) -> void:
	tilemap = _tilemap;
	cell_size = tilemap.tile_set.tile_size;
	
	tilemap_changed.emit();

func map_to_world(grid_pos: Vector2i) -> Vector2:
	if not tilemap:
		push_warning("Tilemap is not set!");
		return Vector2.ZERO;
	var world = tilemap.map_to_local(grid_pos);
	return world;

func world_to_map(world_pos: Vector2) -> Vector2i:
	if not tilemap:
		push_warning("Tilemap is not set!");
		return Vector2i.ZERO;
	return tilemap.local_to_map(world_pos);
