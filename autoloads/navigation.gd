extends Node

signal tilemap_changed;

var astar_grid: AStarGrid2D;
var tilemap: TileMapLayer;
var cell_size: Vector2 = Vector2.ONE;
var unit_lookup: Callable;

var unit_positions: Array[Vector2i] = [];

func update_unit_grid():
	unit_positions.clear();
	var all_units: Array[Unit] = unit_lookup.call();
	for unit in all_units:
		unit_positions.append(unit.grid_position);

func update_astar_grid():
	astar_grid.clear();
	astar_grid.cell_size = Vector2.ONE;
	astar_grid.region = tilemap.get_used_rect();
	astar_grid.update();
	
	for tile in tilemap.get_used_cells():
		if tilemap.get_cell_tile_data(tile).get_custom_data("is_solid"):
			astar_grid.set_point_solid(tile, true);
	
	update_unit_grid();
	for position in unit_positions:
		astar_grid.set_point_solid(position, true);

func setup_level(_tilemap: TileMapLayer, _unit_lookup: Callable) -> void:
	tilemap = _tilemap;
	cell_size = tilemap.tile_set.tile_size;
	tilemap_changed.emit();
	
	unit_lookup = _unit_lookup;
	
	astar_grid = AStarGrid2D.new();

	update_astar_grid();

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

func calculate_path(origin: Vector2i, target: Vector2i) -> PackedVector2Array:
	var path: PackedVector2Array = [];
	var rect = tilemap.get_used_rect(); 
	if not rect.has_point(origin) or not rect.has_point(target):
		return path;
	
	if origin == target:
		return path;
	update_astar_grid();
	
	return astar_grid.get_point_path(origin, target)

func can_move_to(origin: Vector2i, target: Vector2i) -> bool:
	return !calculate_path(origin, target).is_empty();

func is_position_free(position: Vector2i) -> bool:
	if astar_grid.is_point_solid(position):
		return false;
	return true;
