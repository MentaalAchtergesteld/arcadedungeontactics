extends Node

func grid_to_world(position: Vector2i) -> Vector2i:
	return position * 16;

func _ready() -> void:
	var area_width = 16;
	var area_height = 16;
	
	var area: Array[Vector2i] = [];
	for x in area_width:
		for y in area_height:
			area.append(grid_to_world(Vector2i(x, y)));
	
	var primary = grid_to_world(Vector2i(area_width/2, area_height/2));
	
	$TileHighlighter.highlight_area(primary, area, TileHighlighter.NEUTRAL);
	$Timer.start();
	await $Timer.timeout;
	
	$TileHighlighter.highlight_area(primary, area, TileHighlighter.POSITIVE);
	$Timer.start();
	await $Timer.timeout;
	
	$TileHighlighter.highlight_area(primary, area, TileHighlighter.NEGATIVE);
	$Timer.start();
	await $Timer.timeout;
	
	$TileHighlighter.highlight_area(primary, area, TileHighlighter.RANGE);
	$Timer.start();
	await $Timer.timeout;
	
	$TileHighlighter.clear_area_highlight(area);
	$Timer.start();
	await $Timer.timeout;
