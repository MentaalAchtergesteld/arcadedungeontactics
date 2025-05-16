class_name GridUtils
extends RefCounted

static var tile_size = 16;

static func manhattan_distance(a: Vector2i, b: Vector2i) -> int:
	return abs(a.x - b.x) + abs(a.y - b.y);

static func chebyshev_distance(a: Vector2i, b: Vector2i) -> int:
	return max(abs(a.x - b.x), abs(a.y - b.y));

static func get_tiles_in_circle(center: Vector2i, radius: int) -> Array[Vector2i]:
	var result: Array[Vector2i] = [];
	for dx in range(-radius, radius+1):
		for dy in range(-radius, radius+1):
			var pos = Vector2i(dx, dy);
			if pos.length() <= radius:
				result.append(center + pos);
	
	return result;

static func get_tiles_in_diamond(center: Vector2i, radius: int) -> Array[Vector2i]:
	var result: Array[Vector2i] = [];
	for dx in range(-radius, radius+1):
		var max_dy = radius - abs(dx);
		for dy in range(-max_dy, max_dy+1):
			result.append(center + Vector2i(dx, dy));
	
	return result;

static func get_tiles_in_rect(center: Vector2i, width: int, height: int) -> Array[Vector2i]:
	var result: Array[Vector2i] = [];
	
	var start_x = center.x - int(width/2);
	var start_y = center.y - int(height/2);
	for dx in range(start_x, start_x + width):
		for dy in range(start_y, start_y + height):
			result.append(Vector2i(dx, dy));
		
	return result;
